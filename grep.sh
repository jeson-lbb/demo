功能模糊,格式模糊:日日有练习:类似工作一样全面:自制一个功能,格式全面的笔记:固定全面学习方法
通过笔记,以战养战的方式练习,英语单词:思考:命令结构:深层理解命令基本模式:体会linux最基础的知识(字符集及控制)
为什么一开始就不这样做呢:眼看:认知:熟悉:理解:细节:深度
序号:大类:描述:功能
standard input and output:标准输入输出流是整个Linux的数据通道:数据的单位字符,数据交换依靠输入输出流
file system use:文件系统的应用:目录与文件之间的关联管理
file text use:文件文本的应用:文件与文本之间的关联管理
Pattern use:样式类的应用:使用样式的方式处理文本
Regular Expression:
Regular Expression:DESCRIPTION:正则表达式:能确定字符排列规则,为字符提供(匹配)规则
Regular Expression:end

yum:
yum:SYNOPSIS:yum [options] [command] [packagepackage ...]
yum:DESCRIPTION:安装新的包，删除旧的包,针对网络安装
yum:cmd:ist:yum install package1 [package2] [...]:安装软件 ：@ command [cmd] install [ist]
yum:cmd:Ist:GNL OPT:yum install -y 不再询问，全部安装  [GNL] OPTIONS [OPT]
yun:        |[root@study ~]#yum install -y nfs-utils rpcbind

grep:
grep:SYNOPSIS:grep [OPTIONS] [-e PATTERN | -f FILE] [FILE...]
grep:DESCRIPTION:print lines matching a pattern:相配样式(多行)打印
grep:EXIT STATUS:常规下,若匹配成功$?=0,否则$?=1
grep:OPTIONS: Mch Ctr:1/7 相配过程中的控制:@ Matching [Mch] Control [Ctr] format [Fmt] sample [Spl]
grep:english word:ignore[ɪgˈnɔ:(r)]vt,忽略;match[mætʃ]vt&vi,使相配;invert[ɪnˈvɜ:t]vt,使反转
grep: Mch Ctr:1/7-1/5:grep -e PATTERN, --regexp=PATTERN:允许多个pattren
grep:        grep -e |[root@study ~]#echo -e "123\nabc" | grep -e"1"
grep:        grep -e |123
grep:        grep -e |[root@study ~]#echo -e "123\nabc" | grep -e"1" -e"a"
grep:        grep -e |123
grep:        grep -e |abc
grep: Mch Ctr:1/7-2/5:grep -i, --ignore-case:忽略PATTERN及匹配内容文本的大小写
grep:        grep -i |[root@study ~]#echo -e "ABC\nefg" | grep -i "abc\|EFG"
grep:        grep -i |ABC
grep:        grep -i |efg
grep: Mch Ctr:1/7-3/5:grep -v, --invert-match:选择没有相配的行
grep:        grep -vi |[root@study ~]#echo -e "ABC\nefg" | grep -vi "abc"    
grep:        grep -vi |efg
grep: Mch Ctr:1/7-4/5:grep -w, --word-regexp:精确相配整个单词(单词的边界具有分隔符)的行
grep:        grep -w |[root@study ~]#echo -e "abcde\nfghi" | grep -w "abc"  
grep:        grep -w |[root@study ~]#echo -e "abc de\nfghi" | grep -w "abc "     
grep:        grep -w |[root@study ~]#echo -e "abc de\nfghi" | grep -w "abc"
grep:        grep -w |abc de
grep: Mch Ctr:1/7-5/5:grep -x, --line-regexp:精确相配整行内容的行
grep:        grep -x |[root@study ~]#echo -e "abc de\nfghi" | grep -x "abc"
grep:        grep -x |[root@study ~]#echo -e "abc de\nfghi" | grep -x "abc de"
grep:        grep -x |abc de
grep: Mch Ctr:end

grep:OPTIONS: Gnr Opt Ctr:2/7 :@ General [Gnr] Output [Opt] Control [Ctr] 
grep:english word:General[ˈdʒenrəl]n.常规
grep: Gnr Opt Ctr:2/7-1/6:grep -c, --count:只输出已匹配行的总数;配合-v,则输出未匹配行的总数
grep:        grep -c |[root@study ~]#echo -e "12\nab\ncd" | grep -c ''
grep:        grep -c |3
grep:        grep -c |[root@study ~]#echo -e "12\nab\ncd" | grep -c 'ab'
grep:        grep -c |1
grep:        grep -c |[root@study ~]#echo -e "12\nab\ncd" | grep -cv 'ab'
grep:        grep -c |2
grep: Gnr Opt Ctr:2/7-2/6:grep -L, --files-without-match:只输出没能相配内容的文件名,遇上某行能被匹配则直接退出grep
grep:        grep -L |[root@study ~]#grep '' a.txt 
grep:        grep -L |abc
grep:        grep -L |123
grep:        grep -L |[root@study ~]#grep -L 'ha' a.txt 
grep:        grep -L |a.txt
grep: Gnr Opt Ctr:2/7-3/6:grep -l, --files-with-matches:与-L相反，只输出能匹配内容的文件名,遇上某行不能匹配直接退出grep
grep:        grep -l |[root@study ~]#grep -l 'a' a.txt  
grep:        grep -l |a.txt
grep: Gnr Opt Ctr:2/7-4/6:grep -m NUM, --max-count=NUM:只匹配到NUM，就退出grep;若是标准输入，则在NUM处加标记使下一个进程能恢复该处并继续向下搜索
grep:        grep -m |[root@study ~]#echo -e "12\n34\n56\n78\n9" | grep -m 3  "34"
grep:        grep -m |34
grep: Gnr Opt Ctr:2/7-5/6:grep -o, --only-matching:每个能匹配的字符串以单独的行输出，而不是输出整行
grep:        grep -o |[root@study ~]#echo -e "12\n34\n56\n78\n9" | grep -o "3\|4\|8"
grep:        grep -o |3
grep:        grep -o |4
grep:        grep -o |8
grep: Gnr Opt Ctr:2/7-6/6:grep -q, --quiet, --silent:匹配成功则退出,退出码为0且不输出任何内容到标准输出,常与-z组合使用
grep: Gnr Opt Ctr:end

grep:OPTIONS: Opt Ln Pfx Ctr:3/7 输出行时的前缀控制,前缀顺序文件名->行号->字节偏移量:@ Output [Opt] Line [Ln] Prefix [Pfx] Control [Ctr]
grep:english word:Prefix[ˈpri:fɪks]n.前缀;description[dɪˈskrɪpʃn]n.描述;synopsis[sɪˈnɒpsɪs]n.摘要
grep:english word:initial[ɪˈnɪʃl]n.首字母,adj.最初的
grep: Opt Ln Pfx Ctr:3/7-1/6:grep -n, --line-number:输出每行内容时在顶格位置附加该行的prefix(行号+冒号)
grep:        grep -n |[root@study ~]#grep -n '' /etc/passwd
grep:        grep -n |1:root:x:0:0:root:/root:/bin/bash
grep:        grep -n |2:bin:x:1:1:bin:/bin:/sbin/nologin
grep:        grep -n |3:daemon:x:2:2:daemon:/sbin:/sbin/nologin
grep: Opt Ln Pfx Ctr:3/7-2/6:grep -H, --with-filename:输出匹配的内容及其文件名,grep无-H默认多文件时触发-H
grep:        grep -H |[root@study ~]#grep -H "abc\|123" a.txt b.txt
grep:        grep -H |a.txt:abc
grep:        grep -H |a.txt:123
grep:        grep -H |b.txt:123
grep:        grep -H |b.txt:abc
grep:        grep -H |[root@study ~]#grep: "abc\|123" a.txt b.txt
grep:        grep -H |a.txt:abc
grep:        grep -H |a.txt:123
grep:        grep -H |b.txt:123
grep:        grep -H |b.txt:abc
grep:        grep -H |[root@study ~]#grep -H "abc\|123" a.txt
grep:        grep -H |a.txt:abc
grep:        grep -H |a.txt:123
grep: Opt Ln Pfx Ctr:3/7-3/6:grep -h, --no-filename:只输出匹配的内容,不输出文件名,grep无-h默认单文件触发-h
grep:        grep -h |[root@study ~]#grep -h "abc\|123" a.txt b.txt
grep:        grep -h |abc
grep:        grep -h |123
grep:        grep -h |123
grep:        grep -h |abc
grep:        grep -h |[root@study ~]#grep "abc\|123" a.txt     
grep:        grep -h |abc
grep:        grep -h |123
grep: Opt Ln Pfx Ctr:3/7-4/6:grep -Z, --null:输出文件名时,使用\0替换该文件名后原本的字符,类似find -print0,sort -z,xargs -0
grep:        grep -Z |[root@study ~]#grep -lZ "abc\|123" a.txt  
grep:        grep -Z |a.txt[root@study ~]#
grep:        grep -Z |[root@study ~]#grep -ZH "abc\|123" a.txt 
grep:        grep -Z |a.txtabc
grep:        grep -Z |a.txt123
grep: Opt Ln Pfx Ctr:3/7-5/6:grep -b, --byte-offset:相配内容行所占空间的字节偏移量
grep:        grep -b |[root@study ~]#echo -e "123\n4567\n89" | grep: -b -e "" 
grep:        grep -b |0:123
grep:        grep -b |4:4567
grep:        grep -b |9:89
grep: Opt Ln Pfx Ctr:3/7-6/6:grep -T, --initial-tab:添加一个制表符形成列，与-n,-H,-b
grep:        grep -T |[root@study ~]#grep -HnbT '' a.txt b.txt   
grep:        grep -T |a.txt:   1:     0      :abc
grep:        grep -T |a.txt:   2:     4      :123
grep:        grep -T |b.txt:   1:     0      :123
grep:        grep -T |b.txt:   2:     4      :abc
grep:        grep -T |[root@study ~]#grep -Hnb '' a.txt b.txt         
grep:        grep -T |a.txt:1:0:abc
grep:        grep -T |a.txt:2:4:123
grep:        grep -T |b.txt:1:0:123
grep:        grep -T |b.txt:2:4:abc
grep: Opt Ln Pfx Ctr:end

grep:OPTIONS: Cte Ln Ctr:4/7 :@ Context [Cte] Line [Ln] Control [Ctr]
grep:english word:Context[ˈkɒntekst]n.上下文
grep: Cte Ln Ctr:4/7-1/5:grep -A NUM, --after-context=NUM:输出匹配行及以下NUM行，若出现多组以--分隔
grep:        grep -A |[root@study ~]#echo -e "12\n33\n44\n22\n55\n66\n77\n72" | grep -A 1 '2' 
grep:        grep -A |12
grep:        grep -A |33
grep:        grep -A |--
grep:        grep -A |22
grep:        grep -A |55
grep:        grep -A |--
grep:        grep -A |72
grep:        grep -A |[root@study ~]#echo -e "12\n33\n44\n22\n55\n66\n77\n72" | grep -A 2 '2' 
grep:        grep -A |12
grep:        grep -A |33
grep:        grep -A |44
grep:        grep -A |22
grep:        grep -A |55
grep:        grep -A |66
grep:        grep -A |--
grep:        grep -A |72
grep: Cte Ln Ctr:4/7-2/5:grep -B NUM, --before-context=NUM:输出匹配行及以上NUM行，若出现多组以--分隔
grep:        grep -B |[root@study ~]#echo -e "12\n33\n44\n22\n55\n66\n77\n72" | grep -B 2 '5'  
grep:        grep -B |44
grep:        grep -B |22
grep:        grep -B |55
grep: Cte Ln Ctr:4/7-3/5:grep -C NUM, -NUM, --context=NUM:输出匹配行及上和下各NUM行，若出现多组以--分隔
grep:        grep -C |[root@study ~]#echo -e "12\n33\n44\n22\n55\n66\n77\n72" | grep -C 2 '5'  
grep:        grep -C |44
grep:        grep -C |22
grep:        grep -C |55
grep:        grep -C |66
grep:        grep -C |77
grep:        grep -C |[root@study ~]#echo -e "12\n33\n44\n22\n55\n66\n77\n72" | grep -2 '5'  
grep:        grep -C |44
grep:        grep -C |22
grep:        grep -C |55
grep:        grep -C |66
grep:        grep -C |77
grep: Cte Ln Ctr:4/7-4/5:grep --no-group-separator:使用-A,-B,-C时取消--分隔符
grep: Cte Ln Ctr:4/7-5/5:grep --group-separator=string:使用-A,-B,-C时,用string代替--分隔符
grep: Cte Ln Ctr:end

grep:OPTIONS: Fil and Dir Slt:5/7 :@ File [Fil] and Directory [Dir] Selection [Slt]
grep: Fil and Dir Slt:5/7-1/4:grep --exclude=GLOB:排除GLOB匹配到的文件，GLOB通配符含*?[..]
grep:        grep --exclude=GLOB |[root@study ~]#ls
grep:        grep --exclude=GLOB |a.txt  b.txt
grep:        grep --exclude=GLOB |[root@study ~]#grep --exclude=b.* -H "a" *.txt 
grep:        grep --exclude=GLOB |a.txt:abc
grep: Fil and Dir Slt:5/7-2/4:grep --exclude-from=FILE:从文件中读取排除规则，效果等同--exclude=GLOB
grep: Fil and Dir Slt:5/7-3/4:grep -R, -r, --recursive:从grep命令中给出的目录开始递归搜索每一个子目录及文件
grep:        grep -r |[root@study ~]#tree
grep:        grep -r |.
grep:        grep -r |├── a.txt
grep:        grep -r |├── b
grep:        grep -r |│   ├── a.txt
grep:        grep -r |│   ├── b.txt
grep:        grep -r |│   └── c
grep:        grep -r |│       ├── a.txt
grep:        grep -r |│       └── b.txt
grep:        grep -r |└── b.txt
grep:        grep -r |2 directories, 6 files
grep:        grep -r |[root@study ~]#grep --exclude=b.* -H -r "a"  *.* ./*/
grep:        grep -r |a.txt:abc
grep:        grep -r |./b/a.txt:abc
grep:        grep -r |./b/c/a.txt:abc
grep: Fil and Dir Slt:5/7-4/4:grep --exclude-dir=DIR:筛选出不进行递归搜索的目录
grep:        grep --exclude-dir=DIR |[root@study ~]#tree
grep:        grep --exclude-dir=DIR |.
grep:        grep --exclude-dir=DIR |├── a.txt
grep:        grep --exclude-dir=DIR |├── b
grep:        grep --exclude-dir=DIR |│   ├── a.txt
grep:        grep --exclude-dir=DIR |│   ├── b.txt
grep:        grep --exclude-dir=DIR |│   └── c
grep:        grep --exclude-dir=DIR |│       ├── a.txt
grep:        grep --exclude-dir=DIR |│       └── b.txt
grep:        grep --exclude-dir=DIR |└── b.txt
grep:        grep --exclude-dir=DIR |2 directories, 6 files
grep:        grep --exclude-dir=DIR |[root@study ~]#grep --exclude-dir=c -H -r "a" *.* ./*/
grep:        grep --exclude-dir=DIR |a.txt:abc
grep:        grep --exclude-dir=DIR |b.txt:abc
grep:        grep --exclude-dir=DIR |./b/a.txt:abc
grep:        grep --exclude-dir=DIR |./b/b.txt:abc
grep: Fil and Dir Slt:end 

grep:OPTIONS: Oth Opt:6/7 :@ Other [Oth] Options [Opt]
grep: Oth Opt:6/7-1/1:grep -z, --null-data:只在匹配时用\0替换换行符,使得多行变为一行匹配,常与-q组合使用
grep:        grep -z |[root@study ~]#echo -e "free\nis\ngood" | grep -z "free" 
grep:        grep -z |free
grep:        grep -z |is
grep:        grep -z |good
grep:        grep -z |#在以$?的视角下-z组合-q与-L或-l有相同的逻辑功能
grep: Oth Opt:end

grep:OPTIONS: sample:7/7 综合或特殊练习:@
grep:OPTIONS: END
grep: sample:7/7-1/7 |[root@study ~]#ps -ef|grep cron
grep:        7/7-1/7 |root       1714      1  0 16:56 ?        00:00:02 crond
grep:        7/7-1/7 |root       2541   1810  0 23:48 pts/1    00:00:00 grep cron
grep:        7/7-1/7 |[root@study ~]#ps -ef|grep [c]ron
grep:        7/7-1/7 |root       1714      1  0 16:56 ?        00:00:02 crond
grep: sample:7/7-2/7 强制输出文件名 |[root@study ~]#grep 'root' /etc/passwd /dev/null 
grep:        7/7-2/7 强制输出文件名 |/etc/passwd:root:x:0:0:root:/root:/bin/bash
grep:        7/7-2/7 强制输出文件名 |[root@study ~]#grep -H 'root' /etc/passwd
grep:        7/7-2/7 强制输出文件名 |/etc/passwd:root:x:0:0:root:/root:/bin/bash
grep: sample:7/7-3/7 -lv != -L |[root@study ~]#grep '' a.txt b.txt  
grep:        7/7-3/7 -lv != -L a.txt:abc
grep:        7/7-3/7 -lv != -L a.txt:123
grep:        7/7-3/7 -lv != -L b.txt:123
grep:        7/7-3/7 -lv != -L b.txt:abc
grep:        7/7-3/7 -lv != -L b.txt:def
grep:        7/7-3/7 -lv != -L [root@study ~]#grep -lv 'def' a.txt b.txt 
grep:        7/7-3/7 -lv != -L a.txt
grep:        7/7-3/7 -lv != -L b.txt
grep: sample:7/7-4/7 同时搜索文件及标准输入 |[root@study ~]#cat b.txt | grep: "def\|123" - a.txt    
grep:        7/7-4/7 同时搜索文件及标准输入 |(standard input):123
grep:        7/7-4/7 同时搜索文件及标准输入 |(standard input):def
grep:        7/7-4/7 同时搜索文件及标准输入 |a.txt:123
grep: sample:7/7-5/7 回文字 |[root@study ~]#echo 12321 okykoidi | grep --color -e "\(.\)\(.\).\2\1" 
grep:        7/7-5/7 回文字 |12321 okykoid
grep:        7/7-5/7 回文字最大19 |grep -E -e '^(.?)(.?)(.?)(.?)(.?)(.?)(.?)(.?)(.?).?\9\8\7\6\5\4\3\2\1$' file
grep: sample:7/7-6/7 正则|与反向引用 |[root@study ~]#echo 'baaca' | grep -E --color '(a)\1|c\1'
grep:        7/7-6/7 正则|与反向引用 |baaca
grep:        7/7-6/7 正则|与反向引用 |[root@study ~]#echo 'baacc' | grep -E --color '(a)\1|(c)\2'
grep:        7/7-6/7 正则|与反向引用 |baacc
grep: sample:7/7-7/7 拆分文本单词 |[root@study ~]#echo -e "linux is\ngood" | grep -o '[a-zA-Z]\+'
grep:        7/7-7/7 拆分文本单词 |linux
grep:        7/7-7/7 拆分文本单词 |is
grep:        7/7-7/7 拆分文本单词 |good
grep:        7/7-7/7 拆分文本每一个字母 |[root@study a]#echo -e "I am BOY" | grep -o '[a-zA-Z]'   
grep:        7/7-7/7 拆分文本每一个字母 |I
grep:        7/7-7/7 拆分文本每一个字母 |a
grep:        7/7-7/7 拆分文本每一个字母 |m
grep:        7/7-7/7 拆分文本每一个字母 |B
grep:        7/7-7/7 拆分文本每一个字母 |O
grep:        7/7-7/7 拆分文本每一个字母 |Y
grep: sample:end


grep:end

sed:
awk:
Pattern use:end
1.03:test use:文本应用:显示或打印
1.04:standard input:对标准输入流处理:修改

