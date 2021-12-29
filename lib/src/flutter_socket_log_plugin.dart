part of flutter_socket_log_plugin;

abstract class FlutterSocketLogPlugin {
  static FlutterSocketLogPlugin? _instance;

  static FlutterSocketLogPlugin get instance => _instance ??= _FlutterSocketLogPluginImpl();

  /// [clientStream] stream which sends current
  /// Socket client changes.
  Stream<Socket?> get clientStream;

  /// initializes the plugin
  /// [logLevels] -> log levels used for the duration of the app
  /// if no log level is set, the defaults are used([error, debug, warning, info, success])
  /// [logTags] -> tags to be used for a log.
  /// if no log tag is set, the defaults are used([bluetooth, network])
  void init({
    required String appName,
    List<protos.LogLevel>? logLevels,
    List<protos.LogTag>? logTags,
  });

  void restart();

  Future<String?> get wifiIp;

  static void log(
    String log,
    protos.LogLevel logLevel,
    List<protos.LogTag> logTags,
  ) =>
      instance._log(log, logLevel, logTags);

  /// logs message with specific [logLevel] and [logTags]
  /// using [logTags], client app will be able to filter logTags
  void _log(
    String log,
    protos.LogLevel logLevel,
    List<protos.LogTag> logTags,
  );

  /// creates tag with given parameters
  protos.LogTag createTag(
    String name,
    int color,
    int iconData,
  ) =>
      ProtoMaker.createLogTag(name, color, iconData);

  /// creates log level with given parameters
  protos.LogLevel createLogLevel(
    String name,
    int color,
    int iconData,
  ) =>
      ProtoMaker.createLogLevel(name, color, iconData);
}
