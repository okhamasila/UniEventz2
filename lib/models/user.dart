class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final String? phoneNumber;
  final bool isAdmin;
  final KtpVerificationStatus ktpVerificationStatus;
  final String? ktpImageUrl;
  final DateTime? ktpSubmissionDate;
  final DateTime? ktpVerificationDate;
  final String? ktpRejectionReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.phoneNumber,
    this.isAdmin = false,
    this.ktpVerificationStatus = KtpVerificationStatus.notSubmitted,
    this.ktpImageUrl,
    this.ktpSubmissionDate,
    this.ktpVerificationDate,
    this.ktpRejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImage,
    String? phoneNumber,
    bool? isAdmin,
    KtpVerificationStatus? ktpVerificationStatus,
    String? ktpImageUrl,
    DateTime? ktpSubmissionDate,
    DateTime? ktpVerificationDate,
    String? ktpRejectionReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
      ktpVerificationStatus: ktpVerificationStatus ?? this.ktpVerificationStatus,
      ktpImageUrl: ktpImageUrl ?? this.ktpImageUrl,
      ktpSubmissionDate: ktpSubmissionDate ?? this.ktpSubmissionDate,
      ktpVerificationDate: ktpVerificationDate ?? this.ktpVerificationDate,
      ktpRejectionReason: ktpRejectionReason ?? this.ktpRejectionReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
      'ktpVerificationStatus': ktpVerificationStatus.toString(),
      'ktpImageUrl': ktpImageUrl,
      'ktpSubmissionDate': ktpSubmissionDate?.toIso8601String(),
      'ktpVerificationDate': ktpVerificationDate?.toIso8601String(),
      'ktpRejectionReason': ktpRejectionReason,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
      isAdmin: json['isAdmin'] ?? false,
      ktpVerificationStatus: KtpVerificationStatus.values.firstWhere(
        (e) => e.toString() == json['ktpVerificationStatus'],
        orElse: () => KtpVerificationStatus.notSubmitted,
      ),
      ktpImageUrl: json['ktpImageUrl'],
      ktpSubmissionDate: json['ktpSubmissionDate'] != null
          ? DateTime.parse(json['ktpSubmissionDate'])
          : null,
      ktpVerificationDate: json['ktpVerificationDate'] != null
          ? DateTime.parse(json['ktpVerificationDate'])
          : null,
      ktpRejectionReason: json['ktpRejectionReason'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

enum KtpVerificationStatus {
  notSubmitted,
  pending,
  approved,
  rejected,
}

extension KtpVerificationStatusExtension on KtpVerificationStatus {
  String get displayName {
    switch (this) {
      case KtpVerificationStatus.notSubmitted:
        return 'Not Submitted';
      case KtpVerificationStatus.pending:
        return 'Pending Review';
      case KtpVerificationStatus.approved:
        return 'Approved';
      case KtpVerificationStatus.rejected:
        return 'Rejected';
    }
  }

  String get description {
    switch (this) {
      case KtpVerificationStatus.notSubmitted:
        return 'KTP verification not yet submitted';
      case KtpVerificationStatus.pending:
        return 'KTP verification is being reviewed';
      case KtpVerificationStatus.approved:
        return 'KTP verification approved';
      case KtpVerificationStatus.rejected:
        return 'KTP verification rejected';
    }
  }
} 