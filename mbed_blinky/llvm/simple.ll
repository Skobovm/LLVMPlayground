; ModuleID = 'simple.bc'
source_filename = "simple.c"
target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-none-eabi"

@.str = private unnamed_addr constant [16 x i8] c"Declared String\00", align 1
@declaredString = global i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0), align 4, !dbg !0
@.str.1 = private unnamed_addr constant [19 x i8] c"Anonymous String 1\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"Test 1\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"Anonymous String 2\00", align 1
@fakeFunc.words = private unnamed_addr constant [3 x i32] [i32 0, i32 1, i32 2], align 4

; Function Attrs: noinline nounwind
define void @addOne(i32* %i) #0 !dbg !14 {
entry:
  %i.addr = alloca i32*, align 4
  store i32* %i, i32** %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32** %i.addr, metadata !19, metadata !20), !dbg !21
  %0 = load i32*, i32** %i.addr, align 4, !dbg !22
  %1 = load i32, i32* %0, align 4, !dbg !23
  %inc = add nsw i32 %1, 1, !dbg !23
  store i32 %inc, i32* %0, align 4, !dbg !23
  ret void, !dbg !24
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind
define i8* @getConstHWString() #0 !dbg !25 {
entry:
  %0 = load i8*, i8** @declaredString, align 4, !dbg !28
  ret i8* %0, !dbg !29
}

; Function Attrs: noinline nounwind
define void @callPrint() #0 !dbg !30 {
entry:
  call void @printStuff(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0)) #4, !dbg !33
  call void @printStuff(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0)) #4, !dbg !34
  ret void, !dbg !35
}

; Function Attrs: noinline nounwind
define void @printStuff(i8* %str) #0 !dbg !36 {
entry:
  %str.addr = alloca i8*, align 4
  store i8* %str, i8** %str.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %str.addr, metadata !40, metadata !20), !dbg !41
  br label %while.cond, !dbg !42

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i8*, i8** %str.addr, align 4, !dbg !43
  %1 = load i8, i8* %0, align 1, !dbg !44
  %conv = zext i8 %1 to i32, !dbg !44
  %cmp = icmp ne i32 %conv, 0, !dbg !45
  br i1 %cmp, label %while.body, label %while.end, !dbg !42

while.body:                                       ; preds = %while.cond
  %2 = load i8*, i8** %str.addr, align 4, !dbg !46
  %3 = load i8, i8* %2, align 1, !dbg !48
  %conv2 = zext i8 %3 to i32, !dbg !48
  %add = add nsw i32 %conv2, 1, !dbg !49
  %conv3 = trunc i32 %add to i8, !dbg !48
  %4 = load i8*, i8** %str.addr, align 4, !dbg !50
  store i8 %conv3, i8* %4, align 1, !dbg !51
  %5 = load i8*, i8** %str.addr, align 4, !dbg !52
  %incdec.ptr = getelementptr inbounds i8, i8* %5, i32 1, !dbg !52
  store i8* %incdec.ptr, i8** %str.addr, align 4, !dbg !52
  br label %while.cond, !dbg !42, !llvm.loop !53

while.end:                                        ; preds = %while.cond
  ret void, !dbg !55
}

; Function Attrs: noinline nounwind
define void @callPrint2() #0 !dbg !56 {
entry:
  call void @printStuff(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.3, i32 0, i32 0)) #4, !dbg !57
  ret void, !dbg !58
}

; Function Attrs: noinline nounwind
define void @fakeFunc() #0 !dbg !59 {
entry:
  %fakeString = alloca [10 x i8], align 1
  %words = alloca [3 x i32], align 4
  call void @llvm.dbg.declare(metadata [10 x i8]* %fakeString, metadata !60, metadata !20), !dbg !64
  call void @llvm.dbg.declare(metadata [3 x i32]* %words, metadata !65, metadata !20), !dbg !69
  %0 = bitcast [3 x i32]* %words to i8*, !dbg !69
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %0, i8* bitcast ([3 x i32]* @fakeFunc.words to i8*), i32 12, i32 4, i1 false), !dbg !69
  %arraydecay = getelementptr inbounds [10 x i8], [10 x i8]* %fakeString, i32 0, i32 0, !dbg !70
  %arraydecay1 = getelementptr inbounds [3 x i32], [3 x i32]* %words, i32 0, i32 0, !dbg !71
  call void @tableLookupSpace(i8* %arraydecay, i32* %arraydecay1, i32 3) #4, !dbg !72
  ret void, !dbg !73
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture writeonly, i8* nocapture readonly, i32, i32, i1) #2

; Function Attrs: noinline nounwind
define void @tableLookupSpace(i8* %fill, i32* %words, i32 %wordCount) #0 !dbg !74 {
entry:
  %fill.addr = alloca i8*, align 4
  %words.addr = alloca i32*, align 4
  %wordCount.addr = alloca i32, align 4
  store i8* %fill, i8** %fill.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %fill.addr, metadata !77, metadata !20), !dbg !78
  store i32* %words, i32** %words.addr, align 4
  call void @llvm.dbg.declare(metadata i32** %words.addr, metadata !79, metadata !20), !dbg !80
  store i32 %wordCount, i32* %wordCount.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %wordCount.addr, metadata !81, metadata !20), !dbg !82
  %0 = load i8*, i8** %fill.addr, align 4, !dbg !83
  %1 = load i32*, i32** %words.addr, align 4, !dbg !84
  %2 = load i32, i32* %wordCount.addr, align 4, !dbg !85
  call void @tableLookupSpaceImpl(i8* %0, i32* %1, i32 %2) #4, !dbg !86
  ret void, !dbg !87
}

declare void @tableLookupSpaceImpl(i8*, i32*, i32) #3

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+hwdiv,+strict-align" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+hwdiv,+strict-align" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nobuiltin }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "declaredString", scope: !2, file: !3, line: 4, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "simple.c", directory: "C:\5CProjects\5CLLVMPlayground\5Cmbed_blinky\5Cllvm")
!4 = !{}
!5 = !{!0}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 32)
!7 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !8)
!8 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!9 = !{i32 2, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i32 1, !"min_enum_size", i32 4}
!13 = !{!"clang version 5.0.0 (trunk)"}
!14 = distinct !DISubprogram(name: "addOne", scope: !3, file: !3, line: 8, type: !15, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 32)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "i", arg: 1, scope: !14, file: !3, line: 8, type: !17)
!20 = !DIExpression()
!21 = !DILocation(line: 8, column: 18, scope: !14)
!22 = !DILocation(line: 10, column: 4, scope: !14)
!23 = !DILocation(line: 10, column: 6, scope: !14)
!24 = !DILocation(line: 11, column: 1, scope: !14)
!25 = distinct !DISubprogram(name: "getConstHWString", scope: !3, file: !3, line: 13, type: !26, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{!6}
!28 = !DILocation(line: 15, column: 9, scope: !25)
!29 = !DILocation(line: 15, column: 2, scope: !25)
!30 = distinct !DISubprogram(name: "callPrint", scope: !3, file: !3, line: 18, type: !31, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!31 = !DISubroutineType(types: !32)
!32 = !{null}
!33 = !DILocation(line: 20, column: 2, scope: !30)
!34 = !DILocation(line: 21, column: 2, scope: !30)
!35 = !DILocation(line: 23, column: 1, scope: !30)
!36 = distinct !DISubprogram(name: "printStuff", scope: !3, file: !3, line: 38, type: !37, isLocal: false, isDefinition: true, scopeLine: 39, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!37 = !DISubroutineType(types: !38)
!38 = !{null, !39}
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 32)
!40 = !DILocalVariable(name: "str", arg: 1, scope: !36, file: !3, line: 38, type: !39)
!41 = !DILocation(line: 38, column: 23, scope: !36)
!42 = !DILocation(line: 40, column: 2, scope: !36)
!43 = !DILocation(line: 40, column: 9, scope: !36)
!44 = !DILocation(line: 40, column: 8, scope: !36)
!45 = !DILocation(line: 40, column: 13, scope: !36)
!46 = !DILocation(line: 42, column: 11, scope: !47)
!47 = distinct !DILexicalBlock(scope: !36, file: !3, line: 41, column: 2)
!48 = !DILocation(line: 42, column: 10, scope: !47)
!49 = !DILocation(line: 42, column: 15, scope: !47)
!50 = !DILocation(line: 42, column: 4, scope: !47)
!51 = !DILocation(line: 42, column: 8, scope: !47)
!52 = !DILocation(line: 43, column: 6, scope: !47)
!53 = distinct !{!53, !42, !54}
!54 = !DILocation(line: 44, column: 2, scope: !36)
!55 = !DILocation(line: 45, column: 1, scope: !36)
!56 = distinct !DISubprogram(name: "callPrint2", scope: !3, file: !3, line: 25, type: !31, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!57 = !DILocation(line: 27, column: 2, scope: !56)
!58 = !DILocation(line: 29, column: 1, scope: !56)
!59 = distinct !DISubprogram(name: "fakeFunc", scope: !3, file: !3, line: 31, type: !31, isLocal: false, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!60 = !DILocalVariable(name: "fakeString", scope: !59, file: !3, line: 33, type: !61)
!61 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 80, elements: !62)
!62 = !{!63}
!63 = !DISubrange(count: 10)
!64 = !DILocation(line: 33, column: 7, scope: !59)
!65 = !DILocalVariable(name: "words", scope: !59, file: !3, line: 34, type: !66)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 96, elements: !67)
!67 = !{!68}
!68 = !DISubrange(count: 3)
!69 = !DILocation(line: 34, column: 6, scope: !59)
!70 = !DILocation(line: 35, column: 19, scope: !59)
!71 = !DILocation(line: 35, column: 31, scope: !59)
!72 = !DILocation(line: 35, column: 2, scope: !59)
!73 = !DILocation(line: 36, column: 1, scope: !59)
!74 = distinct !DISubprogram(name: "tableLookupSpace", scope: !3, file: !3, line: 47, type: !75, isLocal: false, isDefinition: true, scopeLine: 48, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!75 = !DISubroutineType(types: !76)
!76 = !{null, !39, !17, !18}
!77 = !DILocalVariable(name: "fill", arg: 1, scope: !74, file: !3, line: 47, type: !39)
!78 = !DILocation(line: 47, column: 29, scope: !74)
!79 = !DILocalVariable(name: "words", arg: 2, scope: !74, file: !3, line: 47, type: !17)
!80 = !DILocation(line: 47, column: 39, scope: !74)
!81 = !DILocalVariable(name: "wordCount", arg: 3, scope: !74, file: !3, line: 47, type: !18)
!82 = !DILocation(line: 47, column: 52, scope: !74)
!83 = !DILocation(line: 49, column: 23, scope: !74)
!84 = !DILocation(line: 49, column: 29, scope: !74)
!85 = !DILocation(line: 49, column: 36, scope: !74)
!86 = !DILocation(line: 49, column: 2, scope: !74)
!87 = !DILocation(line: 50, column: 1, scope: !74)
