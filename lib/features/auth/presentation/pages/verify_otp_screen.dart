// import 'dart:async';

// import 'package:atelier_customer/core/routing/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_radius.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_style.dart';
// import '../../cubit/auth_cubit.dart';

// class VerifyOtpScreen extends StatefulWidget {
//   const VerifyOtpScreen({super.key, this.email = 'your email'});

//   final String email;

//   @override
//   State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
// }

// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//   static const int _otpLength = 6;
//   static const int _initialCountdown = 60;

//   final List<TextEditingController> _controllers = List.generate(
//     _otpLength,
//     (_) => TextEditingController(),
//   );

//   final List<FocusNode> _focusNodes = List.generate(
//     _otpLength,
//     (_) => FocusNode(),
//   );

//   Timer? _timer;

//   int _countdown = _initialCountdown;
//   bool _isResending = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _startCountdown();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();

//     for (final controller in _controllers) {
//       controller.dispose();
//     }

//     for (final focusNode in _focusNodes) {
//       focusNode.dispose();
//     }

//     super.dispose();
//   }

//   void _startCountdown() {
//     _timer?.cancel();

//     setState(() {
//       _countdown = _initialCountdown;
//     });

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_countdown <= 1) {
//         timer.cancel();

//         if (!mounted) {
//           return;
//         }

//         setState(() {
//           _countdown = 0;
//         });

//         return;
//       }

//       if (!mounted) {
//         timer.cancel();
//         return;
//       }

//       setState(() {
//         _countdown--;
//       });
//     });
//   }

//   void _onOtpChanged(String value, int index) {
//     if (_errorMessage != null) {
//       setState(() {
//         _errorMessage = null;
//       });
//     }

//     if (value.length > 1) {
//       _handlePastedCode(value);
//       return;
//     }

//     if (value.isNotEmpty && index < _otpLength - 1) {
//       _focusNodes[index + 1].requestFocus();
//     }

//     if (_isOtpComplete) {
//       _verifyOtp();
//     }
//   }

//   void _handlePastedCode(String value) {
//     final digits = value.replaceAll(RegExp(r'\D'), '');

//     if (digits.isEmpty) {
//       return;
//     }

//     final code = digits.substring(
//       0,
//       digits.length > _otpLength ? _otpLength : digits.length,
//     );

//     for (var i = 0; i < _otpLength; i++) {
//       _controllers[i].text = i < code.length ? code[i] : '';
//     }

//     if (code.length == _otpLength) {
//       _focusNodes[_otpLength - 1].unfocus();
//       _verifyOtp();
//     }
//   }

//   void _onBackspace(int index, String value) {
//     if (value.isEmpty && index > 0) {
//       _controllers[index - 1].clear();
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   void _verifyOtp() {
//     if (!_isOtpComplete) {
//       return;
//     }

//     setState(() {
//       _errorMessage = null;
//     });

//     context.read<AuthCubit>().verifyRecoveryOtp(
//       email: widget.email,
//       token: _otp,
//     );
//   }

//   Future<void> _resendOtp() async {
//     if (_isResending || _countdown > 0) {
//       return;
//     }

//     setState(() {
//       _isResending = true;
//       _errorMessage = null;
//     });

//     context.read<AuthCubit>().sendPasswordResetEmail(email: widget.email);
//   }

//   void _handleAuthState(BuildContext context, AuthState state) {
//     if (state is AuthPasswordResetEmailSent) {
//       if (_isResending) {
//         _clearOtp();

//         setState(() {
//           _isResending = false;
//         });

//         _startCountdown();
//         _focusNodes.first.requestFocus();
//       }

//       return;
//     }

//     if (state is AuthPasswordRecoveryVerified) {
//       _focusNodes[_otpLength - 1].unfocus();
//       context.push(Routes.resetPassword);
//       return;
//     }

//     if (state is AuthFailure) {
//       setState(() {
//         _isResending = false;
//         _errorMessage = state.message;
//       });
//     }
//   }

//   void _clearOtp() {
//     for (final controller in _controllers) {
//       controller.clear();
//     }
//   }

//   void _goBack() {
//     context.pop();
//   }

//   bool get _isOtpComplete {
//     return _controllers.every((controller) => controller.text.length == 1);
//   }

//   String get _otp {
//     return _controllers.map((controller) => controller.text).join();
//   }

//   String get _formattedCountdown {
//     final seconds = _countdown.toString().padLeft(2, '0');
//     return '00:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     final backgroundColor = isDark
//         ? AppColors.darkBackground
//         : AppColors.lightBackground;

//     final primaryTextColor = isDark
//         ? AppColors.darkTextPrimary
//         : AppColors.lightTextPrimary;

//     final secondaryTextColor = isDark
//         ? AppColors.darkTextSecondary
//         : AppColors.lightTextSecondary;

//     final mutedTextColor = isDark
//         ? AppColors.darkTextMuted
//         : AppColors.lightTextMuted;

//     final surfaceColor = isDark
//         ? AppColors.darkSurfaceMuted
//         : AppColors.lightSurface;

//     final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

//     final activeBorderColor = isDark
//         ? AppColors.darkTextPrimary
//         : AppColors.black;

//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: _handleAuthState,
//       builder: (context, state) {
//         final isVerifying = state is AuthLoading && !_isResending;

//         return Scaffold(
//           backgroundColor: backgroundColor,
//           body: SafeArea(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   padding: const EdgeInsets.fromLTRB(
//                     AppSpacing.s24,
//                     AppSpacing.s28,
//                     AppSpacing.s24,
//                     AppSpacing.s24,
//                   ),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight - AppSpacing.s52,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             'ATELIER',
//                             style: AppTextStyles.labelLarge.copyWith(
//                               color: primaryTextColor,
//                               letterSpacing: 2.8,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.s40),
//                         Text(
//                           'Verify your email.',
//                           style: AppTextStyles.headingLarge.copyWith(
//                             color: primaryTextColor,
//                             fontSize: 30,
//                             fontWeight: FontWeight.w500,
//                             height: 1.2,
//                             letterSpacing: -0.6,
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.s6),
//                         Text(
//                           'Enter the 6-digit code we sent to ${widget.email}.',
//                           style: AppTextStyles.bodyMedium.copyWith(
//                             color: secondaryTextColor,
//                             fontSize: 14,
//                             height: 1.5,
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.s32),
//                         Text(
//                           'VERIFICATION CODE',
//                           style: AppTextStyles.labelMedium.copyWith(
//                             color: secondaryTextColor,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.s12),
//                         Row(
//                           children: List.generate(_otpLength, (index) {
//                             final hasValue =
//                                 _controllers[index].text.isNotEmpty;

//                             return Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: index == _otpLength - 1
//                                       ? 0
//                                       : AppSpacing.s8,
//                                 ),
//                                 child: _OtpField(
//                                   controller: _controllers[index],
//                                   focusNode: _focusNodes[index],
//                                   backgroundColor: surfaceColor,
//                                   borderColor: borderColor,
//                                   activeBorderColor: activeBorderColor,
//                                   textColor: primaryTextColor,
//                                   hasValue: hasValue,
//                                   onChanged: (value) {
//                                     _onOtpChanged(value, index);
//                                   },
//                                   onBackspace: () {
//                                     _onBackspace(
//                                       index,
//                                       _controllers[index].text,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                         if (_errorMessage != null) ...[
//                           const SizedBox(height: AppSpacing.s12),
//                           Text(
//                             _errorMessage!,
//                             style: AppTextStyles.bodySmall.copyWith(
//                               color: AppColors.error,
//                             ),
//                           ),
//                         ],
//                         const SizedBox(height: AppSpacing.s24),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 52,
//                           child: ElevatedButton(
//                             onPressed: isVerifying || !_isOtpComplete
//                                 ? null
//                                 : _verifyOtp,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: isDark
//                                   ? AppColors.darkTextPrimary
//                                   : AppColors.black,
//                               foregroundColor: isDark
//                                   ? AppColors.black
//                                   : AppColors.white,
//                               disabledBackgroundColor: isDark
//                                   ? AppColors.darkTextPrimary.withValues(
//                                       alpha: 0.35,
//                                     )
//                                   : AppColors.black.withValues(alpha: 0.35),
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   AppRadius.r12,
//                                 ),
//                               ),
//                             ),
//                             child: isVerifying
//                                 ? SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       color: isDark
//                                           ? AppColors.black
//                                           : AppColors.white,
//                                     ),
//                                   )
//                                 : Text(
//                                     'Verify',
//                                     style: AppTextStyles.button.copyWith(
//                                       color: isDark
//                                           ? AppColors.black
//                                           : AppColors.white,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.s24),
//                         Center(
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Didn\'t receive the code?',
//                                 style: AppTextStyles.bodySmall.copyWith(
//                                   color: secondaryTextColor,
//                                 ),
//                               ),
//                               const SizedBox(height: AppSpacing.s8),
//                               if (_countdown > 0)
//                                 Text(
//                                   'Resend available in $_formattedCountdown',
//                                   style: AppTextStyles.bodySmall.copyWith(
//                                     color: mutedTextColor,
//                                   ),
//                                 )
//                               else
//                                 TextButton(
//                                   onPressed: _isResending ? null : _resendOtp,
//                                   style: TextButton.styleFrom(
//                                     foregroundColor: primaryTextColor,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: AppSpacing.s12,
//                                       vertical: AppSpacing.s8,
//                                     ),
//                                   ),
//                                   child: _isResending
//                                       ? SizedBox(
//                                           width: 18,
//                                           height: 18,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                             color: primaryTextColor,
//                                           ),
//                                         )
//                                       : Text(
//                                           'Resend OTP',
//                                           style: AppTextStyles.bodyMedium
//                                               .copyWith(
//                                                 color: primaryTextColor,
//                                                 fontWeight: FontWeight.w600,
//                                                 decoration:
//                                                     TextDecoration.underline,
//                                                 decorationThickness: 1,
//                                               ),
//                                         ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: AppSpacing.s24),
//                         Center(
//                           child: TextButton.icon(
//                             onPressed: _goBack,
//                             style: TextButton.styleFrom(
//                               foregroundColor: secondaryTextColor,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: AppSpacing.s12,
//                                 vertical: AppSpacing.s8,
//                               ),
//                             ),
//                             icon: const Icon(Icons.arrow_back, size: 16),
//                             label: Text(
//                               'Back',
//                               style: AppTextStyles.bodyMedium.copyWith(
//                                 color: secondaryTextColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _OtpField extends StatelessWidget {
//   const _OtpField({
//     required this.controller,
//     required this.focusNode,
//     required this.backgroundColor,
//     required this.borderColor,
//     required this.activeBorderColor,
//     required this.textColor,
//     required this.hasValue,
//     required this.onChanged,
//     required this.onBackspace,
//   });

//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final Color backgroundColor;
//   final Color borderColor;
//   final Color activeBorderColor;
//   final Color textColor;
//   final bool hasValue;
//   final ValueChanged<String> onChanged;
//   final VoidCallback onBackspace;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 56,
//       child: KeyboardListener(
//         focusNode: FocusNode(),
//         onKeyEvent: (event) {
//           if (event is KeyDownEvent &&
//               event.logicalKey == LogicalKeyboardKey.backspace &&
//               controller.text.isEmpty) {
//             onBackspace();
//           }
//         },
//         child: TextField(
//           controller: controller,
//           focusNode: focusNode,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           textInputAction: TextInputAction.next,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//             LengthLimitingTextInputFormatter(6),
//           ],
//           style: AppTextStyles.headingMedium.copyWith(
//             color: textColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: backgroundColor,
//             contentPadding: EdgeInsets.zero,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppRadius.r12),
//               borderSide: BorderSide(color: borderColor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppRadius.r12),
//               borderSide: BorderSide(
//                 color: hasValue ? activeBorderColor : borderColor,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppRadius.r12),
//               borderSide: BorderSide(color: activeBorderColor, width: 1.2),
//             ),
//           ),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }
