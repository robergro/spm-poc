string="hello"
prefix="hello"
foo=${string#"$prefix"} # Remove prefix
foo=${foo// /} # Remove spaces

if [ -z "$foo" ];then
final="oh no"
else
final=$foo
fi

echo $final