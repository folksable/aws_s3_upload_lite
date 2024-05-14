// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'AWS_REGION')
  static String awsRegion = _Env.awsRegion;
  @EnviedField(varName: 'AWS_ACCESS_KEY_ID')
  static String awsAccessKeyId = _Env.awsAccessKeyId;
  @EnviedField(varName: 'AWS_SECRET_ACCESS_KEY')
  static String awsSecretAccessKey = _Env.awsSecretAccessKey;
  @EnviedField(varName: 'AWS_BUCKET_NAME')
  static String awsBucketName = _Env.awsBucketName;
}