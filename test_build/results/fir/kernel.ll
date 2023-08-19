; ModuleID = '../results/kernel.bc'
source_filename = "../kernels/fir/fir.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@input = dso_local local_unnamed_addr global [32 x float] zeroinitializer, align 16
@output = dso_local local_unnamed_addr global [32 x float] zeroinitializer, align 16
@coefficients = dso_local local_unnamed_addr global [32 x float] [float 2.500000e-01, float 1.500000e+00, float 3.750000e+00, float -2.250000e+00, float 5.000000e-01, float 7.500000e-01, float -3.000000e+00, float 1.250000e+00, float 2.500000e-01, float 1.500000e+00, float 3.750000e+00, float -2.250000e+00, float 5.000000e-01, float 7.500000e-01, float -3.000000e+00, float 1.250000e+00, float 2.500000e-01, float 1.500000e+00, float 3.750000e+00, float -2.250000e+00, float 5.000000e-01, float 7.500000e-01, float -3.000000e+00, float 1.250000e+00, float 2.500000e-01, float 1.500000e+00, float 3.750000e+00, float -2.250000e+00, float 5.000000e-01, float 7.500000e-01, float -3.000000e+00, float 1.250000e+00], align 16

; Function Attrs: nofree norecurse nounwind uwtable mustprogress
define dso_local i32 @main() local_unnamed_addr #0 {
  %1 = load float, float* getelementptr inbounds ([32 x float], [32 x float]* @output, i64 0, i64 0), align 16, !tbaa !2
  br label %2

2:                                                ; preds = %2, %0
  %3 = phi float [ %1, %0 ], [ %10, %2 ]
  %4 = phi i64 [ 0, %0 ], [ %11, %2 ]
  %5 = getelementptr inbounds [32 x float], [32 x float]* @input, i64 0, i64 %4
  %6 = load float, float* %5, align 4, !tbaa !2
  %7 = getelementptr inbounds [32 x float], [32 x float]* @coefficients, i64 0, i64 %4
  %8 = load float, float* %7, align 4, !tbaa !2
  %9 = fmul float %6, %8
  %10 = fadd float %3, %9
  %11 = add nuw nsw i64 %4, 1
  %12 = icmp eq i64 %11, 32
  br i1 %12, label %13, label %2, !llvm.loop !6

13:                                               ; preds = %2
  store float %10, float* getelementptr inbounds ([32 x float], [32 x float]* @output, i64 0, i64 0), align 16, !tbaa !2
  ret i32 0
}

; Function Attrs: nofree norecurse nounwind uwtable mustprogress
define dso_local void @_Z6kernelPfS_S_(float* nocapture readonly %0, float* nocapture %1, float* nocapture readonly %2) local_unnamed_addr #0 {
  %4 = load float, float* %1, align 4, !tbaa !2
  br label %5

5:                                                ; preds = %3, %5
  %6 = phi float [ %4, %3 ], [ %13, %5 ]
  %7 = phi i64 [ 0, %3 ], [ %14, %5 ]
  %8 = getelementptr inbounds float, float* %0, i64 %7
  %9 = load float, float* %8, align 4, !tbaa !2
  %10 = getelementptr inbounds float, float* %2, i64 %7
  %11 = load float, float* %10, align 4, !tbaa !2
  %12 = fmul float %9, %11
  %13 = fadd float %6, %12
  store float %13, float* %1, align 4, !tbaa !2
  %14 = add nuw nsw i64 %7, 1
  %15 = icmp eq i64 %14, 32
  br i1 %15, label %16, label %5, !llvm.loop !6

16:                                               ; preds = %5
  ret void
}

attributes #0 = { nofree norecurse nounwind uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = !{!3, !3, i64 0}
!3 = !{!"float", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = distinct !{!6, !7, !8}
!7 = !{!"llvm.loop.mustprogress"}
!8 = !{!"llvm.loop.unroll.disable"}
