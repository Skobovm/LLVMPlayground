; ModuleID = 'simple.bc'
source_filename = "simple.cpp"
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.0.24213"

$"\01??_C@_0BO@DLDEGCFM@I?9do?9not?9get?9linked?9correctly?$AA@" = comdat any

@retArr = global [14 x i8] c"Hello, World!\00", align 1
@"\01??_C@_0BO@DLDEGCFM@I?9do?9not?9get?9linked?9correctly?$AA@" = linkonce_odr unnamed_addr constant [30 x i8] c"I-do-not-get-linked-correctly\00", comdat, align 1

; Function Attrs: noinline nounwind uwtable
define void @addOne(i32* %i) #0 {
entry:
  %i.addr = alloca i32*, align 8
  store i32* %i, i32** %i.addr, align 8
  %0 = load i32*, i32** %i.addr, align 8
  %1 = load i32, i32* %0, align 4
  %inc = add nsw i32 %1, 1
  store i32 %inc, i32* %0, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i8* @getHWString() #0 {
entry:
  ret i8* getelementptr inbounds ([14 x i8], [14 x i8]* @retArr, i32 0, i32 0)
}

; Function Attrs: noinline nounwind uwtable
define i8* @getConstHWString() #0 {
entry:
  ret i8* getelementptr inbounds ([30 x i8], [30 x i8]* @"\01??_C@_0BO@DLDEGCFM@I?9do?9not?9get?9linked?9correctly?$AA@", i32 0, i32 0)
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !3}
!llvm.ident = !{!4}

!0 = !{i32 6, !"Linker Options", !1}
!1 = !{!2}
!2 = !{!"/FAILIFMISMATCH:\22_CRT_STDIO_ISO_WIDE_SPECIFIERS=0\22"}
!3 = !{i32 1, !"PIC Level", i32 2}
!4 = !{!"clang version 5.0.0 (trunk)"}
