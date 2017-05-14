; ModuleID = 'C:\Projects\LLVMPlayground\mbed_blinky\llvm\simple.bc'
source_filename = "simple.c"
target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-none-eabi"

@.str = private unnamed_addr constant [16 x i8] c"Declared String\00", align 1
@declaredString = global i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0), align 4, !dbg !0
@fakeFunc.words = internal constant [3 x i32] [i32 0, i32 1, i32 2], align 4, !dbg !6
@.newStr = private constant [19 x i8] c"Anonymous String 1\00", align 1
@.newStr.1 = private constant [19 x i8] c"Anonymous String 2\00", align 1
@lookup_table = constant [2 x i8*] [i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.newStr, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.newStr.1, i32 0, i32 0)], align 4

; Function Attrs: noinline nounwind
define void @addOne(i32* %i) #0 !dbg !24 {
entry:
  %i.addr = alloca i32*, align 4
  store i32* %i, i32** %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32** %i.addr, metadata !28, metadata !29), !dbg !30
  %0 = load i32*, i32** %i.addr, align 4, !dbg !31
  %1 = load i32, i32* %0, align 4, !dbg !32
  %inc = add nsw i32 %1, 1, !dbg !32
  store i32 %inc, i32* %0, align 4, !dbg !32
  ret void, !dbg !33
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind
define i8* @getConstHWString() #0 !dbg !34 {
entry:
  %0 = load i8*, i8** @declaredString, align 4, !dbg !37
  ret i8* %0, !dbg !38
}

; Function Attrs: noinline nounwind
define void @callPrint() #0 !dbg !39 {
entry:
  %strHolder = alloca [18 x i8]
  %arrayRef = getelementptr [18 x i8], [18 x i8]* %strHolder, i32 0, i32 0, !dbg !40
  call void @tableLookup(i8* %arrayRef, i32 0), !dbg !40
  call void @printStuff(i8* %arrayRef) #3, !dbg !40
  ret void, !dbg !41
}

; Function Attrs: noinline nounwind
define void @printStuff(i8* %str) #0 !dbg !42 {
entry:
  %str.addr = alloca i8*, align 4
  store i8* %str, i8** %str.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %str.addr, metadata !46, metadata !29), !dbg !47
  br label %while.cond, !dbg !48

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i8*, i8** %str.addr, align 4, !dbg !49
  %1 = load i8, i8* %0, align 1, !dbg !50
  %conv = zext i8 %1 to i32, !dbg !50
  %cmp = icmp ne i32 %conv, 0, !dbg !51
  br i1 %cmp, label %while.body, label %while.end, !dbg !48

while.body:                                       ; preds = %while.cond
  %2 = load i8*, i8** %str.addr, align 4, !dbg !52
  %3 = load i8, i8* %2, align 1, !dbg !54
  %conv2 = zext i8 %3 to i32, !dbg !54
  %add = add nsw i32 %conv2, 1, !dbg !55
  %conv3 = trunc i32 %add to i8, !dbg !54
  %4 = load i8*, i8** %str.addr, align 4, !dbg !56
  store i8 %conv3, i8* %4, align 1, !dbg !57
  %5 = load i8*, i8** %str.addr, align 4, !dbg !58
  %incdec.ptr = getelementptr inbounds i8, i8* %5, i32 1, !dbg !58
  store i8* %incdec.ptr, i8** %str.addr, align 4, !dbg !58
  br label %while.cond, !dbg !48, !llvm.loop !59

while.end:                                        ; preds = %while.cond
  ret void, !dbg !61
}

; Function Attrs: noinline nounwind
define void @callPrint2() #0 !dbg !62 {
entry:
  %strHolder = alloca [18 x i8]
  %arrayRef = getelementptr [18 x i8], [18 x i8]* %strHolder, i32 0, i32 0, !dbg !63
  call void @tableLookup(i8* %arrayRef, i32 1), !dbg !63
  call void @printStuff(i8* %arrayRef) #3, !dbg !63
  ret void, !dbg !64
}

; Function Attrs: noinline nounwind
define void @fakeFunc() #0 !dbg !8 {
entry:
  %fakeString = alloca [10 x i8], align 1
  call void @llvm.dbg.declare(metadata [10 x i8]* %fakeString, metadata !65, metadata !29), !dbg !69
  %arraydecay = getelementptr inbounds [10 x i8], [10 x i8]* %fakeString, i32 0, i32 0, !dbg !70
  call void @tableLookupSpace(i8* %arraydecay, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @fakeFunc.words, i32 0, i32 0), i32 3) #3, !dbg !71
  ret void, !dbg !72
}

; Function Attrs: noinline nounwind
define void @tableLookupSpace(i8* %fill, i32* %words, i32 %wordCount) #0 !dbg !73 {
entry:
  %fill.addr = alloca i8*, align 4
  %words.addr = alloca i32*, align 4
  %wordCount.addr = alloca i32, align 4
  store i8* %fill, i8** %fill.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %fill.addr, metadata !76, metadata !29), !dbg !77
  store i32* %words, i32** %words.addr, align 4
  call void @llvm.dbg.declare(metadata i32** %words.addr, metadata !78, metadata !29), !dbg !79
  store i32 %wordCount, i32* %wordCount.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %wordCount.addr, metadata !80, metadata !29), !dbg !81
  %0 = load i8*, i8** %fill.addr, align 4, !dbg !82
  %1 = load i32*, i32** %words.addr, align 4, !dbg !83
  %2 = load i32, i32* %wordCount.addr, align 4, !dbg !84
  call void @tableLookupSpaceImpl(i8* %0, i32* %1, i32 %2) #3, !dbg !85
  ret void, !dbg !86
}

declare void @tableLookupSpaceImpl(i8*, i32*, i32) #2

; Function Attrs: noinline nounwind
define void @tableLookup(i8* %fill, i32 %index) #0 !dbg !87 {
entry:
  %fill.addr = alloca i8*, align 4
  %index.addr = alloca i32, align 4
  store i8* %fill, i8** %fill.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %fill.addr, metadata !90, metadata !29), !dbg !91
  store i32 %index, i32* %index.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %index.addr, metadata !92, metadata !29), !dbg !93
  %0 = load i8*, i8** %fill.addr, align 4, !dbg !94
  %1 = load i32, i32* %index.addr, align 4, !dbg !95
  call void @tableLookupImpl(i8* %0, i32 %1) #3, !dbg !96
  ret void, !dbg !97
}

declare void @tableLookupImpl(i8*, i32) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+hwdiv,+strict-align" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+hwdiv,+strict-align" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!19, !20, !21, !22}
!llvm.ident = !{!23}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "declaredString", scope: !2, file: !3, line: 4, type: !16, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "simple.c", directory: "C:\5CProjects\5CLLVMPlayground\5Cmbed_blinky\5Cllvm")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "words", scope: !8, file: !3, line: 34, type: !11, isLocal: true, isDefinition: true)
!8 = distinct !DISubprogram(name: "fakeFunc", scope: !3, file: !3, line: 31, type: !9, isLocal: false, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!9 = !DISubroutineType(types: !10)
!10 = !{null}
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 96, elements: !14)
!12 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{!15}
!15 = !DISubrange(count: 3)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 32)
!17 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!19 = !{i32 2, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!21 = !{i32 1, !"wchar_size", i32 4}
!22 = !{i32 1, !"min_enum_size", i32 4}
!23 = !{!"clang version 5.0.0 (trunk)"}
!24 = distinct !DISubprogram(name: "addOne", scope: !3, file: !3, line: 10, type: !25, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!25 = !DISubroutineType(types: !26)
!26 = !{null, !27}
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 32)
!28 = !DILocalVariable(name: "i", arg: 1, scope: !24, file: !3, line: 10, type: !27)
!29 = !DIExpression()
!30 = !DILocation(line: 10, column: 18, scope: !24)
!31 = !DILocation(line: 12, column: 4, scope: !24)
!32 = !DILocation(line: 12, column: 6, scope: !24)
!33 = !DILocation(line: 13, column: 1, scope: !24)
!34 = distinct !DISubprogram(name: "getConstHWString", scope: !3, file: !3, line: 16, type: !35, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!35 = !DISubroutineType(types: !36)
!36 = !{!16}
!37 = !DILocation(line: 18, column: 9, scope: !34)
!38 = !DILocation(line: 18, column: 2, scope: !34)
!39 = distinct !DISubprogram(name: "callPrint", scope: !3, file: !3, line: 21, type: !9, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!40 = !DILocation(line: 23, column: 2, scope: !39)
!41 = !DILocation(line: 24, column: 1, scope: !39)
!42 = distinct !DISubprogram(name: "printStuff", scope: !3, file: !3, line: 38, type: !43, isLocal: false, isDefinition: true, scopeLine: 39, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!43 = !DISubroutineType(types: !44)
!44 = !{null, !45}
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 32)
!46 = !DILocalVariable(name: "str", arg: 1, scope: !42, file: !3, line: 38, type: !45)
!47 = !DILocation(line: 38, column: 23, scope: !42)
!48 = !DILocation(line: 40, column: 2, scope: !42)
!49 = !DILocation(line: 40, column: 9, scope: !42)
!50 = !DILocation(line: 40, column: 8, scope: !42)
!51 = !DILocation(line: 40, column: 13, scope: !42)
!52 = !DILocation(line: 42, column: 11, scope: !53)
!53 = distinct !DILexicalBlock(scope: !42, file: !3, line: 41, column: 2)
!54 = !DILocation(line: 42, column: 10, scope: !53)
!55 = !DILocation(line: 42, column: 15, scope: !53)
!56 = !DILocation(line: 42, column: 4, scope: !53)
!57 = !DILocation(line: 42, column: 8, scope: !53)
!58 = !DILocation(line: 43, column: 6, scope: !53)
!59 = distinct !{!59, !48, !60}
!60 = !DILocation(line: 44, column: 2, scope: !42)
!61 = !DILocation(line: 45, column: 1, scope: !42)
!62 = distinct !DISubprogram(name: "callPrint2", scope: !3, file: !3, line: 26, type: !9, isLocal: false, isDefinition: true, scopeLine: 27, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!63 = !DILocation(line: 28, column: 2, scope: !62)
!64 = !DILocation(line: 29, column: 1, scope: !62)
!65 = !DILocalVariable(name: "fakeString", scope: !8, file: !3, line: 33, type: !66)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 80, elements: !67)
!67 = !{!68}
!68 = !DISubrange(count: 10)
!69 = !DILocation(line: 33, column: 7, scope: !8)
!70 = !DILocation(line: 35, column: 19, scope: !8)
!71 = !DILocation(line: 35, column: 2, scope: !8)
!72 = !DILocation(line: 36, column: 1, scope: !8)
!73 = distinct !DISubprogram(name: "tableLookupSpace", scope: !3, file: !3, line: 47, type: !74, isLocal: false, isDefinition: true, scopeLine: 48, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!74 = !DISubroutineType(types: !75)
!75 = !{null, !45, !27, !13}
!76 = !DILocalVariable(name: "fill", arg: 1, scope: !73, file: !3, line: 47, type: !45)
!77 = !DILocation(line: 47, column: 29, scope: !73)
!78 = !DILocalVariable(name: "words", arg: 2, scope: !73, file: !3, line: 47, type: !27)
!79 = !DILocation(line: 47, column: 39, scope: !73)
!80 = !DILocalVariable(name: "wordCount", arg: 3, scope: !73, file: !3, line: 47, type: !13)
!81 = !DILocation(line: 47, column: 52, scope: !73)
!82 = !DILocation(line: 49, column: 23, scope: !73)
!83 = !DILocation(line: 49, column: 29, scope: !73)
!84 = !DILocation(line: 49, column: 36, scope: !73)
!85 = !DILocation(line: 49, column: 2, scope: !73)
!86 = !DILocation(line: 50, column: 1, scope: !73)
!87 = distinct !DISubprogram(name: "tableLookup", scope: !3, file: !3, line: 52, type: !88, isLocal: false, isDefinition: true, scopeLine: 53, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !45, !13}
!90 = !DILocalVariable(name: "fill", arg: 1, scope: !87, file: !3, line: 52, type: !45)
!91 = !DILocation(line: 52, column: 24, scope: !87)
!92 = !DILocalVariable(name: "index", arg: 2, scope: !87, file: !3, line: 52, type: !13)
!93 = !DILocation(line: 52, column: 34, scope: !87)
!94 = !DILocation(line: 54, column: 18, scope: !87)
!95 = !DILocation(line: 54, column: 24, scope: !87)
!96 = !DILocation(line: 54, column: 2, scope: !87)
!97 = !DILocation(line: 55, column: 1, scope: !87)
