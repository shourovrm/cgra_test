; ModuleID = '../results/kernel.bc'
source_filename = "../kernels/add.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@input1 = dso_local local_unnamed_addr global [32 x i32] zeroinitializer, align 16
@input2 = dso_local local_unnamed_addr global [32 x i32] zeroinitializer, align 16
@output = dso_local local_unnamed_addr global [32 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [30 x i8] c"input1[%d] + input2[%d] = %d\0A\00", align 1

; Function Attrs: nofree norecurse nounwind uwtable mustprogress
define dso_local void @_Z6kernelPiS_S_i(i32* nocapture readonly %0, i32* nocapture readonly %1, i32* nocapture %2, i32 %3) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %39

6:                                                ; preds = %4
  %7 = zext i32 %3 to i64
  %8 = icmp ult i32 %3, 4
  br i1 %8, label %37, label %9

9:                                                ; preds = %6
  %10 = getelementptr i32, i32* %2, i64 %7
  %11 = getelementptr i32, i32* %0, i64 %7
  %12 = getelementptr i32, i32* %1, i64 %7
  %13 = icmp ugt i32* %11, %2
  %14 = icmp ugt i32* %10, %0
  %15 = and i1 %13, %14
  %16 = icmp ugt i32* %12, %2
  %17 = icmp ugt i32* %10, %1
  %18 = and i1 %16, %17
  %19 = or i1 %15, %18
  br i1 %19, label %37, label %20

20:                                               ; preds = %9
  %21 = and i64 %7, 4294967292
  br label %22

22:                                               ; preds = %22, %20
  %23 = phi i64 [ 0, %20 ], [ %33, %22 ]
  %24 = getelementptr inbounds i32, i32* %0, i64 %23
  %25 = bitcast i32* %24 to <4 x i32>*
  %26 = load <4 x i32>, <4 x i32>* %25, align 4, !tbaa !2, !alias.scope !6
  %27 = getelementptr inbounds i32, i32* %1, i64 %23
  %28 = bitcast i32* %27 to <4 x i32>*
  %29 = load <4 x i32>, <4 x i32>* %28, align 4, !tbaa !2, !alias.scope !9
  %30 = add nsw <4 x i32> %29, %26
  %31 = getelementptr inbounds i32, i32* %2, i64 %23
  %32 = bitcast i32* %31 to <4 x i32>*
  store <4 x i32> %30, <4 x i32>* %32, align 4, !tbaa !2, !alias.scope !11, !noalias !13
  %33 = add i64 %23, 4
  %34 = icmp eq i64 %33, %21
  br i1 %34, label %35, label %22, !llvm.loop !14

35:                                               ; preds = %22
  %36 = icmp eq i64 %21, %7
  br i1 %36, label %39, label %37

37:                                               ; preds = %9, %6, %35
  %38 = phi i64 [ 0, %9 ], [ 0, %6 ], [ %21, %35 ]
  br label %40

39:                                               ; preds = %40, %35, %4
  ret void

40:                                               ; preds = %37, %40
  %41 = phi i64 [ %48, %40 ], [ %38, %37 ]
  %42 = getelementptr inbounds i32, i32* %0, i64 %41
  %43 = load i32, i32* %42, align 4, !tbaa !2
  %44 = getelementptr inbounds i32, i32* %1, i64 %41
  %45 = load i32, i32* %44, align 4, !tbaa !2
  %46 = add nsw i32 %45, %43
  %47 = getelementptr inbounds i32, i32* %2, i64 %41
  store i32 %46, i32* %47, align 4, !tbaa !2
  %48 = add nuw nsw i64 %41, 1
  %49 = icmp eq i64 %48, %7
  br i1 %49, label %39, label %40, !llvm.loop !18
}

; Function Attrs: nofree norecurse nounwind uwtable mustprogress
define dso_local i32 @main() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %13, %0
  %2 = phi i64 [ 0, %0 ], [ %16, %13 ]
  %3 = trunc i64 %2 to i32
  %4 = sub i32 32, %3
  %5 = insertelement <4 x i32> poison, i32 %4, i32 0
  %6 = shufflevector <4 x i32> %5, <4 x i32> poison, <4 x i32> zeroinitializer
  br label %7

7:                                                ; preds = %7, %1
  %8 = phi i64 [ 0, %1 ], [ %11, %7 ]
  %9 = getelementptr inbounds [32 x i32], [32 x i32]* @input2, i64 0, i64 %8
  %10 = bitcast i32* %9 to <4 x i32>*
  store <4 x i32> %6, <4 x i32>* %10, align 16, !tbaa !2
  %11 = add i64 %8, 4
  %12 = icmp eq i64 %11, 32
  br i1 %12, label %13, label %7, !llvm.loop !19

13:                                               ; preds = %7
  %14 = getelementptr inbounds [32 x i32], [32 x i32]* @input1, i64 0, i64 %2
  %15 = trunc i64 %2 to i32
  store i32 %15, i32* %14, align 4, !tbaa !2
  %16 = add nuw nsw i64 %2, 1
  %17 = icmp eq i64 %16, 32
  br i1 %17, label %18, label %1, !llvm.loop !20

18:                                               ; preds = %13, %18
  %19 = phi i64 [ %29, %18 ], [ 0, %13 ]
  %20 = getelementptr inbounds [32 x i32], [32 x i32]* @input1, i64 0, i64 %19
  %21 = bitcast i32* %20 to <4 x i32>*
  %22 = load <4 x i32>, <4 x i32>* %21, align 16, !tbaa !2
  %23 = getelementptr inbounds [32 x i32], [32 x i32]* @input2, i64 0, i64 %19
  %24 = bitcast i32* %23 to <4 x i32>*
  %25 = load <4 x i32>, <4 x i32>* %24, align 16, !tbaa !2
  %26 = add nsw <4 x i32> %25, %22
  %27 = getelementptr inbounds [32 x i32], [32 x i32]* @output, i64 0, i64 %19
  %28 = bitcast i32* %27 to <4 x i32>*
  store <4 x i32> %26, <4 x i32>* %28, align 16, !tbaa !2
  %29 = add i64 %19, 4
  %30 = icmp eq i64 %29, 32
  br i1 %30, label %32, label %18, !llvm.loop !21

31:                                               ; preds = %32
  ret i32 0

32:                                               ; preds = %18, %32
  %33 = phi i64 [ %38, %32 ], [ 0, %18 ]
  %34 = getelementptr inbounds [32 x i32], [32 x i32]* @output, i64 0, i64 %33
  %35 = load i32, i32* %34, align 4, !tbaa !2
  %36 = trunc i64 %33 to i32
  %37 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([30 x i8], [30 x i8]* @.str, i64 0, i64 0), i32 %36, i32 %36, i32 %35)
  %38 = add nuw nsw i64 %33, 1
  %39 = icmp eq i64 %38, 32
  br i1 %39, label %31, label %32, !llvm.loop !22
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

attributes #0 = { nofree norecurse nounwind uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!7}
!7 = distinct !{!7, !8}
!8 = distinct !{!8, !"LVerDomain"}
!9 = !{!10}
!10 = distinct !{!10, !8}
!11 = !{!12}
!12 = distinct !{!12, !8}
!13 = !{!7, !10}
!14 = distinct !{!14, !15, !16, !17}
!15 = !{!"llvm.loop.mustprogress"}
!16 = !{!"llvm.loop.unroll.disable"}
!17 = !{!"llvm.loop.isvectorized", i32 1}
!18 = distinct !{!18, !15, !16, !17}
!19 = distinct !{!19, !15, !16, !17}
!20 = distinct !{!20, !15, !16}
!21 = distinct !{!21, !15, !16, !17}
!22 = distinct !{!22, !15, !16}
