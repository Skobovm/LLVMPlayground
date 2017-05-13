; ModuleID = 'simple.bc'
source_filename = "simple.c"
target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-none-eabi"

@.str = private unnamed_addr constant [16 x i8] c"Declared String\00", align 1
@declaredString = global i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0), align 4, !dbg !0
@.str.1 = private unnamed_addr constant [10 x i8] c"TableStr1\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"TableStr22\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"TableStr333\00", align 1
@table = global [3 x i8*] [i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0)], align 4, !dbg !6
@.str.4 = private unnamed_addr constant [19 x i8] c"Anonymous String 1\00", align 1

; Function Attrs: noinline nounwind
define void @addOne(i32* %i) #0 !dbg !19 {
entry:
  %i.addr = alloca i32*, align 4
  store i32* %i, i32** %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32** %i.addr, metadata !24, metadata !25), !dbg !26
  %0 = load i32*, i32** %i.addr, align 4, !dbg !27
  %1 = load i32, i32* %0, align 4, !dbg !28
  %inc = add nsw i32 %1, 1, !dbg !28
  store i32 %inc, i32* %0, align 4, !dbg !28
  ret void, !dbg !29
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind
define i8* @getConstHWString() #0 !dbg !30 {
entry:
  %0 = load i8*, i8** @declaredString, align 4, !dbg !33
  ret i8* %0, !dbg !34
}

; Function Attrs: noinline nounwind
define void @callPrint() #0 !dbg !35 {
entry:
  call void @fakeFunc(), !dbg !38
  call void @printStuff(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.4, i32 0, i32 0)) #2, !dbg !38
  ret void, !dbg !39
}

; Function Attrs: noinline nounwind
define void @printStuff(i8* %str) #0 !dbg !40 {
entry:
  %str.addr = alloca i8*, align 4
  store i8* %str, i8** %str.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %str.addr, metadata !44, metadata !25), !dbg !45
  br label %while.cond, !dbg !46

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i8*, i8** %str.addr, align 4, !dbg !47
  %cmp = icmp ne i8* %0, null, !dbg !48
  br i1 %cmp, label %while.body, label %while.end, !dbg !46

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %str.addr, align 4, !dbg !49
  %2 = load i8, i8* %1, align 1, !dbg !51
  %conv = zext i8 %2 to i32, !dbg !51
  %add = add nsw i32 %conv, 1, !dbg !52
  %conv1 = trunc i32 %add to i8, !dbg !51
  %3 = load i8*, i8** %str.addr, align 4, !dbg !53
  store i8 %conv1, i8* %3, align 1, !dbg !54
  %4 = load i8*, i8** %str.addr, align 4, !dbg !55
  %incdec.ptr = getelementptr inbounds i8, i8* %4, i32 1, !dbg !55
  store i8* %incdec.ptr, i8** %str.addr, align 4, !dbg !55
  br label %while.cond, !dbg !46, !llvm.loop !56

while.end:                                        ; preds = %while.cond
  ret void, !dbg !58
}

; Function Attrs: noinline nounwind
define void @fakeFunc() #0 !dbg !59 {
entry:
  %fakeString = alloca [10 x i8], align 1
  call void @llvm.dbg.declare(metadata [10 x i8]* %fakeString, metadata !60, metadata !25), !dbg !64
  %arraydecay = getelementptr inbounds [10 x i8], [10 x i8]* %fakeString, i32 0, i32 0, !dbg !65
  call void @tableLookup(i8* %arraydecay, i32 0) #2, !dbg !66
  ret void, !dbg !67
}

; Function Attrs: noinline nounwind
define void @tableLookup(i8* %fill, i32 %index) #0 !dbg !68 {
entry:
  %fill.addr = alloca i8*, align 4
  %index.addr = alloca i32, align 4
  %lookup = alloca i8*, align 4
  store i8* %fill, i8** %fill.addr, align 4
  call void @llvm.dbg.declare(metadata i8** %fill.addr, metadata !71, metadata !25), !dbg !72
  store i32 %index, i32* %index.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %index.addr, metadata !73, metadata !25), !dbg !74
  call void @llvm.dbg.declare(metadata i8** %lookup, metadata !75, metadata !25), !dbg !76
  %0 = load i32, i32* %index.addr, align 4, !dbg !77
  %arrayidx = getelementptr inbounds [3 x i8*], [3 x i8*]* @table, i32 0, i32 %0, !dbg !78
  %1 = load i8*, i8** %arrayidx, align 4, !dbg !78
  store i8* %1, i8** %lookup, align 4, !dbg !76
  br label %while.cond, !dbg !79

while.cond:                                       ; preds = %while.body, %entry
  %2 = load i8*, i8** %lookup, align 4, !dbg !80
  %cmp = icmp ne i8* %2, null, !dbg !81
  br i1 %cmp, label %while.body, label %while.end, !dbg !79

while.body:                                       ; preds = %while.cond
  %3 = load i8*, i8** %lookup, align 4, !dbg !82
  %4 = load i8, i8* %3, align 1, !dbg !84
  %5 = load i8*, i8** %fill.addr, align 4, !dbg !85
  store i8 %4, i8* %5, align 1, !dbg !86
  %6 = load i8*, i8** %fill.addr, align 4, !dbg !87
  %incdec.ptr = getelementptr inbounds i8, i8* %6, i32 1, !dbg !87
  store i8* %incdec.ptr, i8** %fill.addr, align 4, !dbg !87
  %7 = load i8*, i8** %lookup, align 4, !dbg !88
  %incdec.ptr1 = getelementptr inbounds i8, i8* %7, i32 1, !dbg !88
  store i8* %incdec.ptr1, i8** %lookup, align 4, !dbg !88
  br label %while.cond, !dbg !79, !llvm.loop !89

while.end:                                        ; preds = %while.cond
  ret void, !dbg !91
}

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+hwdiv,+strict-align" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nobuiltin }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!14, !15, !16, !17}
!llvm.ident = !{!18}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "declaredString", scope: !2, file: !3, line: 4, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "simple.c", directory: "C:\5CProjects\5CLLVMPlayground\5Cmbed_blinky\5Cllvm")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "table", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 96, elements: !12)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 32)
!10 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!12 = !{!13}
!13 = !DISubrange(count: 3)
!14 = !{i32 2, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = !{i32 1, !"min_enum_size", i32 4}
!18 = !{!"clang version 5.0.0 (trunk)"}
!19 = distinct !DISubprogram(name: "addOne", scope: !3, file: !3, line: 7, type: !20, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!20 = !DISubroutineType(types: !21)
!21 = !{null, !22}
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 32)
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !DILocalVariable(name: "i", arg: 1, scope: !19, file: !3, line: 7, type: !22)
!25 = !DIExpression()
!26 = !DILocation(line: 7, column: 18, scope: !19)
!27 = !DILocation(line: 9, column: 4, scope: !19)
!28 = !DILocation(line: 9, column: 6, scope: !19)
!29 = !DILocation(line: 10, column: 1, scope: !19)
!30 = distinct !DISubprogram(name: "getConstHWString", scope: !3, file: !3, line: 13, type: !31, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!31 = !DISubroutineType(types: !32)
!32 = !{!9}
!33 = !DILocation(line: 15, column: 9, scope: !30)
!34 = !DILocation(line: 15, column: 2, scope: !30)
!35 = distinct !DISubprogram(name: "callPrint", scope: !3, file: !3, line: 18, type: !36, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!36 = !DISubroutineType(types: !37)
!37 = !{null}
!38 = !DILocation(line: 20, column: 2, scope: !35)
!39 = !DILocation(line: 21, column: 1, scope: !35)
!40 = distinct !DISubprogram(name: "printStuff", scope: !3, file: !3, line: 29, type: !41, isLocal: false, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!41 = !DISubroutineType(types: !42)
!42 = !{null, !43}
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 32)
!44 = !DILocalVariable(name: "str", arg: 1, scope: !40, file: !3, line: 29, type: !43)
!45 = !DILocation(line: 29, column: 23, scope: !40)
!46 = !DILocation(line: 31, column: 2, scope: !40)
!47 = !DILocation(line: 31, column: 8, scope: !40)
!48 = !DILocation(line: 31, column: 12, scope: !40)
!49 = !DILocation(line: 33, column: 11, scope: !50)
!50 = distinct !DILexicalBlock(scope: !40, file: !3, line: 32, column: 2)
!51 = !DILocation(line: 33, column: 10, scope: !50)
!52 = !DILocation(line: 33, column: 15, scope: !50)
!53 = !DILocation(line: 33, column: 4, scope: !50)
!54 = !DILocation(line: 33, column: 8, scope: !50)
!55 = !DILocation(line: 34, column: 6, scope: !50)
!56 = distinct !{!56, !46, !57}
!57 = !DILocation(line: 35, column: 2, scope: !40)
!58 = !DILocation(line: 36, column: 1, scope: !40)
!59 = distinct !DISubprogram(name: "fakeFunc", scope: !3, file: !3, line: 23, type: !36, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!60 = !DILocalVariable(name: "fakeString", scope: !59, file: !3, line: 25, type: !61)
!61 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 80, elements: !62)
!62 = !{!63}
!63 = !DISubrange(count: 10)
!64 = !DILocation(line: 25, column: 7, scope: !59)
!65 = !DILocation(line: 26, column: 14, scope: !59)
!66 = !DILocation(line: 26, column: 2, scope: !59)
!67 = !DILocation(line: 27, column: 1, scope: !59)
!68 = distinct !DISubprogram(name: "tableLookup", scope: !3, file: !3, line: 39, type: !69, isLocal: false, isDefinition: true, scopeLine: 40, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!69 = !DISubroutineType(types: !70)
!70 = !{null, !43, !23}
!71 = !DILocalVariable(name: "fill", arg: 1, scope: !68, file: !3, line: 39, type: !43)
!72 = !DILocation(line: 39, column: 24, scope: !68)
!73 = !DILocalVariable(name: "index", arg: 2, scope: !68, file: !3, line: 39, type: !23)
!74 = !DILocation(line: 39, column: 34, scope: !68)
!75 = !DILocalVariable(name: "lookup", scope: !68, file: !3, line: 41, type: !9)
!76 = !DILocation(line: 41, column: 14, scope: !68)
!77 = !DILocation(line: 41, column: 29, scope: !68)
!78 = !DILocation(line: 41, column: 23, scope: !68)
!79 = !DILocation(line: 42, column: 2, scope: !68)
!80 = !DILocation(line: 42, column: 8, scope: !68)
!81 = !DILocation(line: 42, column: 15, scope: !68)
!82 = !DILocation(line: 44, column: 12, scope: !83)
!83 = distinct !DILexicalBlock(scope: !68, file: !3, line: 43, column: 2)
!84 = !DILocation(line: 44, column: 11, scope: !83)
!85 = !DILocation(line: 44, column: 4, scope: !83)
!86 = !DILocation(line: 44, column: 9, scope: !83)
!87 = !DILocation(line: 45, column: 7, scope: !83)
!88 = !DILocation(line: 46, column: 9, scope: !83)
!89 = distinct !{!89, !79, !90}
!90 = !DILocation(line: 47, column: 2, scope: !68)
!91 = !DILocation(line: 48, column: 1, scope: !68)
