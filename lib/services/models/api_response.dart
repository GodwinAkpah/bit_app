
import 'dart:convert';
class APIResponse {
final String status;
final String message;
final dynamic data;
APIResponse({
required this.status,
required this.message,
this.data,
});
factory APIResponse.fromMap(Map<String, dynamic> map) {
return APIResponse(
status: map['status']?.toString() ?? map['success']?.toString() ?? 'error',
message: map['message']?.toString() ?? map['error']?.toString() ?? 'An unknown error occurred.',
data: map['data'],
);
}
factory APIResponse.fromJson(String source) => APIResponse.fromMap(json.decode(source));
}