import Flutter
import SwiftUI
import UIKit

public class GlassBottomNavigationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "glass_bottom_navigation",
      binaryMessenger: registrar.messenger()
    )
    let instance = GlassBottomNavigationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.register(
      NativeGlassButtonFactory(messenger: registrar.messenger()),
      withId: "glass_bottom_navigation/native_glass_button"
    )
    registrar.register(
      NativeGlassBarFactory(messenger: registrar.messenger()),
      withId: "glass_bottom_navigation/native_glass_bar"
    )
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isLiquidGlassSupported":
      if #available(iOS 26.0, *) {
        result(true)
      } else {
        result(false)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

private final class NativeGlassButtonFactory: NSObject, FlutterPlatformViewFactory {
  private let messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    NativeGlassButtonView(
      frame: frame,
      viewId: viewId,
      arguments: args,
      messenger: messenger
    )
  }
}

private final class NativeGlassButtonView: NSObject, FlutterPlatformView {
  private let host: UIHostingController<AnyView>
  private let channel: FlutterMethodChannel

  init(
    frame: CGRect,
    viewId: Int64,
    arguments args: Any?,
    messenger: FlutterBinaryMessenger
  ) {
    let methodChannel = FlutterMethodChannel(
      name: "glass_bottom_navigation/native_glass_button_\(viewId)",
      binaryMessenger: messenger
    )
    channel = methodChannel

    let params = args as? [String: Any]
    let symbol = params?["symbolName"] as? String ?? symbolName(for: params?["icon"] as? String)
    let style = params?["style"] as? String
    let accessibilityLabel = params?["label"] as? String
    let size = (params?["size"] as? NSNumber)?.doubleValue ?? Double(frame.width)

    let root = NativeGlassIconButtonView(
      symbolName: symbol,
      style: style,
      size: size,
      onTap: {
        methodChannel.invokeMethod("tap", arguments: nil)
      }
    )
    host = UIHostingController(rootView: AnyView(root))
    super.init()
    host.view.backgroundColor = .clear
    // Prevent the screen's safe-area insets (notch/home indicator) from being
    // applied to this small embedded SwiftUI view, which otherwise offsets and
    // shrinks its content.
    if #available(iOS 16.4, *) {
      host.safeAreaRegions = []
    }
    host.view.frame = frame
    host.view.isAccessibilityElement = true
    host.view.accessibilityTraits = .button
    host.view.accessibilityLabel = accessibilityLabel
  }

  func view() -> UIView {
    host.view
  }
}

private struct NativeGlassIconButtonView: View {
  let symbolName: String
  let style: String?
  let size: Double
  let onTap: () -> Void

  var body: some View {
    if #available(iOS 26.0, *) {
      Button(action: onTap) {
        Image(systemName: symbolName)
          .font(.system(size: size * 0.4, weight: .regular))
          .foregroundColor(.primary)
          .frame(width: size, height: size)
          .contentShape(Circle())
      }
      .buttonStyle(.plain)
      .glassEffect(.regular.interactive(), in: .circle)
    } else {
      Button(action: onTap) {
        Image(systemName: symbolName)
          .font(.system(size: size * 0.4, weight: .regular))
          .foregroundColor(.primary)
          .frame(width: size, height: size)
          .contentShape(Circle())
      }
      .buttonStyle(.plain)
      .background(
        Circle().fill(Color.white.opacity(0.16))
      )
    }
  }
}

private final class NativeGlassBarFactory: NSObject, FlutterPlatformViewFactory {
  private let messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    NativeGlassBarView(
      frame: frame,
      viewId: viewId,
      arguments: args,
      messenger: messenger
    )
  }
}

private final class NativeGlassBarContainerController: UIViewController {
  let embeddedTabBarController = UITabBarController()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .clear
    embeddedTabBarController.view.backgroundColor = .clear
    embeddedTabBarController.view.translatesAutoresizingMaskIntoConstraints = false

    addChild(embeddedTabBarController)
    view.addSubview(embeddedTabBarController.view)
    NSLayoutConstraint.activate([
      embeddedTabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      embeddedTabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      embeddedTabBarController.view.topAnchor.constraint(equalTo: view.topAnchor),
      embeddedTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    embeddedTabBarController.didMove(toParent: self)
  }
}

private final class NativeGlassBarView: NSObject, FlutterPlatformView {
  private let containerController: NativeGlassBarContainerController
  private let channel: FlutterMethodChannel
  private var items: [[String: Any]] = []
  private var currentIndex = 0
  private var selectedColor = UIColor.systemBlue
  private var unselectedColor = UIColor.label
  private var selectionIndicatorColor = UIColor.white
  private var selectionIndicatorOpacity = 0.06
  private var isDark = false
  private var iconSize: CGFloat = 26
  private var labelFontName = "TildaSans-Semibold"
  private var labelFontSize: CGFloat = 12

  init(
    frame: CGRect,
    viewId: Int64,
    arguments args: Any?,
    messenger: FlutterBinaryMessenger
  ) {
    containerController = NativeGlassBarContainerController()
    channel = FlutterMethodChannel(
      name: "glass_bottom_navigation/native_glass_bar_\(viewId)",
      binaryMessenger: messenger
    )
    super.init()

    containerController.view.frame = frame
    tabBarController.delegate = self
    apply(arguments: args)
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else {
        result(nil)
        return
      }
      switch call.method {
      case "update":
        self.apply(arguments: call.arguments)
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  func view() -> UIView {
    containerController.view
  }

  private var tabBarController: UITabBarController {
    containerController.embeddedTabBarController
  }

  private var tabBar: UITabBar {
    tabBarController.tabBar
  }

  private func apply(arguments args: Any?) {
    let params = args as? [String: Any]
    items = params?["items"] as? [[String: Any]] ?? items
    currentIndex = (params?["currentIndex"] as? NSNumber)?.intValue ?? currentIndex
    selectedColor = uiColor(params, "selectedColor", selectedColor)
    unselectedColor = uiColor(params, "unselectedColor", unselectedColor)
    selectionIndicatorColor = uiColor(
      params,
      "selectionIndicatorColor",
      selectionIndicatorColor
    )
    selectionIndicatorOpacity = doubleValue(
      params,
      "selectionIndicatorOpacity",
      selectionIndicatorOpacity
    )
    if let value = params?["isDark"] as? Bool {
      isDark = value
    }
    iconSize = cgFloat(params, "iconSize", iconSize)
    labelFontName = params?["labelFontName"] as? String ?? labelFontName
    labelFontSize = cgFloat(params, "labelFontSize", labelFontSize)
    applyInterfaceStyle()
    applyAppearance()
    renderViewControllers()
  }

  private func applyInterfaceStyle() {
    let style: UIUserInterfaceStyle = isDark ? .dark : .light
    containerController.overrideUserInterfaceStyle = style
    containerController.view.overrideUserInterfaceStyle = style
    tabBarController.overrideUserInterfaceStyle = style
    tabBar.overrideUserInterfaceStyle = style
  }

  private func applyAppearance() {
    tabBar.tintColor = selectedColor
    tabBar.unselectedItemTintColor = unselectedColor

    if #available(iOS 26.0, *) {
      // On iOS 26 the system renders the tab bar with native Liquid Glass.
      // Keep the default appearance so the glass material is preserved and
      // do not clear the background/shadow images (doing so removes the glass).
      let appearance = UITabBarAppearance()
      appearance.configureWithDefaultBackground()
      appearance.selectionIndicatorTintColor = selectionIndicatorColor
        .withAlphaComponent(selectionIndicatorOpacity)
      configureItemAppearance(appearance)
      tabBar.standardAppearance = appearance
      tabBar.scrollEdgeAppearance = appearance
    } else if #available(iOS 15.0, *) {
      tabBar.backgroundImage = UIImage()
      tabBar.shadowImage = UIImage()
      let appearance = UITabBarAppearance()
      appearance.configureWithDefaultBackground()
      appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
      appearance.shadowColor = .clear
      configureItemAppearance(appearance)
      tabBar.standardAppearance = appearance
      tabBar.scrollEdgeAppearance = appearance
    } else {
      tabBar.backgroundImage = UIImage()
      tabBar.shadowImage = UIImage()
    }

  }

  private func configureItemAppearance(_ appearance: UITabBarAppearance) {
    let normalAttributes: [NSAttributedString.Key: Any] = [
      .font: tabFont,
      .foregroundColor: unselectedColor,
    ]
    let selectedAttributes: [NSAttributedString.Key: Any] = [
      .font: tabFont,
      .foregroundColor: selectedColor,
    ]

    for itemAppearance in [
      appearance.stackedLayoutAppearance,
      appearance.inlineLayoutAppearance,
      appearance.compactInlineLayoutAppearance,
    ] {
      itemAppearance.normal.iconColor = unselectedColor
      itemAppearance.normal.titleTextAttributes = normalAttributes
      itemAppearance.selected.iconColor = selectedColor
      itemAppearance.selected.titleTextAttributes = selectedAttributes
    }
  }

  private func renderViewControllers() {
    let controllers = items.enumerated().map { index, item in
      let title = item["label"] as? String
      let assetName = item["assetName"] as? String
      let symbolName = item["symbolName"] as? String
      let symbolConfig = UIImage.SymbolConfiguration(
        pointSize: iconSize,
        weight: .regular
      )
      let image: UIImage?
      if let assetName,
         let asset = UIImage(named: assetName) {
        image = resizedTemplateImage(asset, pointSize: iconSize)
      } else {
        image = UIImage(
          systemName: symbolName ?? "circle",
          withConfiguration: symbolConfig
        )?.withRenderingMode(.alwaysTemplate)
      }
      let tabItem = UITabBarItem(
        title: title,
        image: image,
        selectedImage: image
      )
      tabItem.tag = index
      tabItem.imageInsets = .zero
      tabItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 2)
      tabItem.setTitleTextAttributes(
        [.font: tabFont, .foregroundColor: unselectedColor],
        for: .normal
      )
      tabItem.setTitleTextAttributes(
        [.font: tabFont, .foregroundColor: selectedColor],
        for: .selected
      )
      let controller = UIViewController()
      controller.view.backgroundColor = .clear
      controller.view.isUserInteractionEnabled = false
      controller.tabBarItem = tabItem
      return controller
    }
    tabBarController.setViewControllers(controllers, animated: false)
    if controllers.indices.contains(currentIndex) {
      tabBarController.selectedIndex = currentIndex
    }
  }

  private var tabFont: UIFont {
    UIFont(name: labelFontName, size: labelFontSize)
      ?? UIFont.systemFont(ofSize: labelFontSize, weight: .semibold)
  }
}

extension NativeGlassBarView: UITabBarControllerDelegate {
  func tabBarController(
    _ tabBarController: UITabBarController,
    didSelect viewController: UIViewController
  ) {
    guard let index = tabBarController.viewControllers?.firstIndex(
      where: { $0 === viewController }
    ) else {
      return
    }
    currentIndex = index
    channel.invokeMethod("tap", arguments: index)
  }
}

private func symbolName(for icon: String?) -> String {
  switch icon {
  case "back":
    return "chevron.backward"
  case "close":
    return "xmark"
  case "search":
    return "magnifyingglass"
  case "more":
    return "ellipsis"
  case "add":
    return "plus"
  case "settings":
    return "gearshape"
  case "favorite":
    return "heart"
  case "share":
    return "square.and.arrow.up"
  default:
    return "circle"
  }
}

private func cgFloat(
  _ params: [String: Any]?,
  _ key: String,
  _ fallback: CGFloat
) -> CGFloat {
  guard let value = params?[key] as? NSNumber else {
    return fallback
  }
  return CGFloat(value.doubleValue)
}

private func doubleValue(
  _ params: [String: Any]?,
  _ key: String,
  _ fallback: Double
) -> Double {
  (params?[key] as? NSNumber)?.doubleValue ?? fallback
}

private func uiColor(
  _ params: [String: Any]?,
  _ key: String,
  _ fallback: UIColor
) -> UIColor {
  guard let value = params?[key] as? NSNumber else {
    return fallback
  }
  return color(fromARGB: value.intValue)
}

private func resizedTemplateImage(
  _ image: UIImage,
  pointSize: CGFloat
) -> UIImage {
  guard image.size.width > 0, image.size.height > 0, pointSize > 0 else {
    return image.withRenderingMode(.alwaysTemplate)
  }

  let scale = min(pointSize / image.size.width, pointSize / image.size.height)
  let drawSize = CGSize(
    width: image.size.width * scale,
    height: image.size.height * scale
  )
  let drawOrigin = CGPoint(
    x: (pointSize - drawSize.width) / 2,
    y: (pointSize - drawSize.height) / 2
  )
  let renderer = UIGraphicsImageRenderer(
    size: CGSize(width: pointSize, height: pointSize)
  )
  return renderer.image { _ in
    image.draw(in: CGRect(origin: drawOrigin, size: drawSize))
  }.withRenderingMode(.alwaysTemplate)
}

private func color(fromARGB value: Int) -> UIColor {
  let alpha = CGFloat((value >> 24) & 0xff) / 255.0
  let red = CGFloat((value >> 16) & 0xff) / 255.0
  let green = CGFloat((value >> 8) & 0xff) / 255.0
  let blue = CGFloat(value & 0xff) / 255.0
  return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}
