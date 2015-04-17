From: =?UTF-8?B?67CV6re87JiB?= <bgy333-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I have a trouble using theuthology ceph test tool
Date: Fri, 17 Apr 2015 15:55:23 +0900
Message-ID: <CAHUck-hu6r4N465Xe0FyVWMsq3KAhYGQzm5LrCo7-w-T6pHvKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1901445758=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1901445758==
Content-Type: multipart/alternative; boundary=bcaec548a6ab7ba3650513e61070

--bcaec548a6ab7ba3650513e61070
Content-Type: text/plain; charset=UTF-8

Hi, Cepher!

I need help to use teuthology, the Ceph intergration test framework.



there are three nodes like below



1. paddles, pulpito server / OS: Ubuntu 14.04, IP: 11.0.0.100, user: teuth

2. target server / OS: Ubuntu 14.04, IP: 11.0.0.10, user: ubuntu

3. teuthology server / OS: Ubuntu 14.04, IP: 11.0.0.1, user: teuthology



And,  following
https://github.com/ceph/teuthology/blob/master/docs/LAB_SETUP.rst,

I deployed teuthology environment in these nodes. (editing configure file
 appropriately)



The problem occurs when I tried to add target node to paddles lock server
with edited create_nodes.py

The edited create_nodes.py add only one node of which name is "
target0.example.com".



When I executed the creat_nodes.py code(python create_nodes.py), the
process wait for someting infinitely


What can I do for going to next step?



help me please..



This is log message the process print out.

2015-04-17 22:08:20,492.492 INFO:create_nodes.py:Creating
target0.gluesys.com

2015-04-17 22:08:20,512.512
INFO:teuthology.orchestra.connection:{'username': 'ubuntu', 'hostname': '
target0.example.com', 'timeout': 30}






And this is problematic part of the "strace" dump for the process.(strace
python create_nodes.py)



              ...omitted...



open("/home/teuthology/src/teuthology_master/teuthology/provision.py",
O_RDONLY) = 4

fstat(4, {st_mode=S_IFREG|0664, st_size=8320, ...}) = 0

open("/home/teuthology/src/teuthology_master/teuthology/provision.pyc",
O_RDONLY) = 5

fstat(5, {st_mode=S_IFREG|0664, st_size=8391, ...}) = 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000

read(5, "\3\363\r\n\327\273+Uc\0\0\0\0\0\0\0\0\4\0\0\0@\0\0\0s\330\0\0\0d\0"...,
4096) = 4096

fstat(5, {st_mode=S_IFREG|0664, st_size=8391, ...}) = 0

read(5, "|\0\0j\5\0d\10\0|\6\0\203\0\2\203\1\0\1t\3\0S|\4\0j\f\0d\t\0"...,
4096) = 4096

read(5, "usR\5\0\0\0t\t\0\0\0getLoggerRg\0\0\0R.\0\0\0R"..., 4096) = 199

read(5, "", 4096)                       = 0

close(5)                                = 0

munmap(0x7fb35d52f000, 4096)            = 0

close(4)                                = 0

close(3)                                = 0

stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=396, ...}) = 0

write(2, "2015-04-17 03:06:25,649.649 INFO"..., 782015-04-17
03:06:25,649.649 INFO:create_nodes.py:Creating target0.example.com

) = 78

open("/home/teuthology/.ssh/known_hosts", O_RDONLY) = 3

fstat(3, {st_mode=S_IFREG|0644, st_size=444, ...}) = 0

fstat(3, {st_mode=S_IFREG|0644, st_size=444, ...}) = 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000

read(3, "|1|nbkibeXwSj/5+ExknLQbdVchuoQ=|"..., 8192) = 444

read(3, "", 4096)                       = 0

read(3, "", 8192)                       = 0

close(3)                                = 0

munmap(0x7fb35d52f000, 4096)            = 0

stat("/home/teuthology/.ssh/config", {st_mode=S_IFREG|0644, st_size=195,
...}) = 0

open("/home/teuthology/.ssh/config", O_RDONLY) = 3

fstat(3, {st_mode=S_IFREG|0644, st_size=195, ...}) = 0

fstat(3, {st_mode=S_IFREG|0644, st_size=195, ...}) = 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000

read(3, "Host target0\n        Hostname 11"..., 8192) = 195

read(3, "", 4096)                       = 0

read(3, "", 8192)                       = 0

close(3)                                = 0

munmap(0x7fb35d52f000, 4096)            = 0

stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=396, ...}) = 0

write(2, "2015-04-17 03:06:25,650.650 INFO"..., 1382015-04-17
03:06:25,650.650 INFO:teuthology.orchestra.connection:{'username':
'ubuntu', 'hostname': 'target0.example.com', 'timeout': 30}

) = 138

socket(PF_LOCAL, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3

connect(3, {sa_family=AF_LOCAL, sun_path="/var/run/nscd/socket"}, 110) = -1
ENOENT (No such file or directory)

close(3)                                = 0

socket(PF_LOCAL, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3

connect(3, {sa_family=AF_LOCAL, sun_path="/var/run/nscd/socket"}, 110) = -1
ENOENT (No such file or directory)

close(3)                                = 0

open("/etc/nsswitch.conf", O_RDONLY|O_CLOEXEC) = 3

fstat(3, {st_mode=S_IFREG|0644, st_size=475, ...}) = 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000

read(3, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 475

read(3, "", 4096)                       = 0

close(3)                                = 0

munmap(0x7fb35d52f000, 4096)            = 0

open("/etc/host.conf", O_RDONLY|O_CLOEXEC) = 3

fstat(3, {st_mode=S_IFREG|0644, st_size=92, ...}) = 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000

read(3, "# The \"order\" line is only used "..., 4096) = 92

read(3, "", 4096)                       = 0

close(3)                                = 0

munmap(0x7fb35d52f000, 4096)            = 0
futex(0x7fb35d0f13d0, FUTEX_WAKE_PRIVATE, 2147483647) = 0
open("/etc/resolv.conf", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=201, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000
read(3, "# Dynamic resolv.conf(5) file fo"..., 4096) = 201
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7fb35d52f000, 4096)            = 0
uname({sys="Linux", node="teuthology", ...}) = 0
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=24517, ...}) = 0
mmap(NULL, 24517, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fb35d460000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/x86_64-linux-gnu/libnss_files.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3,
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\240\"\0\0\0\0\0\0"..., 832)
= 832
fstat(3, {st_mode=S_IFREG|0644, st_size=47712, ...}) = 0
mmap(NULL, 2144392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0x7fb354f22000
mprotect(0x7fb354f2d000, 2093056, PROT_NONE) = 0
mmap(0x7fb35512c000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0x7fb35512c000
close(3)                                = 0
mprotect(0x7fb35512c000, 4096, PROT_READ) = 0
munmap(0x7fb35d460000, 24517)           = 0
open("/etc/hosts", O_RDONLY|O_CLOEXEC)  = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=261, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7fb35d52f000
read(3, "127.0.0.1\tlocalhost\n\n11.0.0.1\tte"..., 4096) = 261
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7fb35d52f000, 4096)            = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
fcntl(3, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(22),
sin_addr=inet_addr("11.0.0.10")}, 16) = -1 EINPROGRESS (Operation now in
progress)
epoll_ctl(6, EPOLL_CTL_ADD, 3, {EPOLLOUT, {u32=3, u64=3}}) = 0
rt_sigaction(SIGINT, {0x7fb35bce0a20, ~[RTMIN RT_1],
SA_RESTORER|SA_RESTART, 0x7fb35d103340}, {0x46460e, [], SA_RESTORER,
0x7fb35d103340}, 8) = 0
epoll_ctl(6, EPOLL_CTL_ADD, 8, {EPOLLIN, {u32=8, u64=8}}) = 0
epoll_wait(6, {{EPOLLOUT, {u32=3, u64=3}}}, 32, 30000) = 1
epoll_ctl(6, EPOLL_CTL_DEL, 3, {EPOLLOUT, {u32=3, u64=3}}) = 0
getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(22),
sin_addr=inet_addr("11.0.0.10")}, 16) = 0
sendto(3, "SSH-2.0-paramiko_1.7.7.2\r\n", 26, 0, NULL, 0) = 26
recvfrom(3, 0x7fb355190594, 128, 0, 0, 0) = -1 EAGAIN (Resource temporarily
unavailable)
epoll_ctl(6, EPOLL_CTL_ADD, 3, {EPOLLIN, {u32=3, u64=3}}) = 0
read(14,
"\f\363\364\265\234\362\213\23\372_\253\266prZy\227\335\212\336BoNb>\353\312!\333\0231j"...,
1024) = 1024
read(14,
"%\205\325X6K\2725:\25\215\235\26c_\v\306\336[t\24d\201\307^\260\271%\27\27\204\276"...,
1024) = 1024
select(0, NULL, NULL, NULL, {0, 1000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 2000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 4000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 8000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 16000}) = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 32000}) = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 36345}) = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 1000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 2000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 4000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 8000})  = 0 (Timeout)
select(0, NULL, NULL, NULL, {0, 16000}) = 0 (Timeout)

...( repeated select(0,...) = 0 (Timeout) )...

--bcaec548a6ab7ba3650513e61070
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0p=
x;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;colo=
r:rgb(32,32,32)"><span style=3D"font-size:10pt">Hi, Cepher!</span></p><p st=
yle=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt=
;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">I nee=
d help to use teuthology, the Ceph intergration test framework.</p><p style=
=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;te=
xt-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</=
p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0c=
m 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)=
">there are three nodes like below=C2=A0</p><p style=3D"font-family:&#39;Ma=
lgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-s=
ize:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</p><p style=3D"font-fami=
ly:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:just=
ify;font-size:13.3333330154419px;color:rgb(32,32,32)">1. paddles, pulpito s=
erver / OS: Ubuntu 14.04, IP: 11.0.0.100, user: teuth</p><p style=3D"font-f=
amily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:j=
ustify;font-size:13.3333330154419px;color:rgb(32,32,32)">2. target=C2=A0ser=
ver / OS: Ubuntu 14.04, IP: 11.0.0.10, user: ubuntu</p><p style=3D"font-fam=
ily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:jus=
tify;font-size:13.3333330154419px;color:rgb(32,32,32)">3. teuthology server=
 / OS: Ubuntu 14.04, IP: 11.0.0.1, user: teuthology</p><p style=3D"font-fam=
ily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:jus=
tify;font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</p><p style=
=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;te=
xt-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">And,=C2=
=A0<span style=3D"font-size:13.3333330154419px">=C2=A0</span><span style=3D=
"font-size:10pt">following=C2=A0<a href=3D"https://github.com/ceph/teutholo=
gy/blob/master/docs/LAB_SETUP.rst">https://github.com/ceph/teuthology/blob/=
master/docs/LAB_SETUP.rst</a>,</span></p><p style=3D"font-family:&#39;Malgu=
n Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size=
:13.3333330154419px;color:rgb(32,32,32)"><span style=3D"font-size:10pt">I d=
eployed teuthology environment in these nodes.=C2=A0</span><span style=3D"f=
ont-size:10pt">(editing=C2=A0</span><span style=3D"font-size:13.33333301544=
19px">configure file</span><span style=3D"font-size:10pt">=C2=A0appropriate=
ly)</span></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;m=
argin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:r=
gb(32,32,32)">=C2=A0</p><p style=3D"font-family:&#39;Malgun Gothic&#39;;pad=
ding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419=
px;color:rgb(32,32,32)">The problem occurs when I tried to add target node =
to paddles lock server with edited=C2=A0create_nodes.py</p><p style=3D"font=
-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align=
:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">The edited creat=
e_nodes.py add only one node of which=C2=A0name is &quot;<a href=3D"http://=
target0.example.com">target0.example.com</a>&quot;.</p><p style=3D"font-fam=
ily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:jus=
tify;font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</p><p style=
=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;te=
xt-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">When=C2=
=A0I executed the creat_nodes.py code(python create_nodes.py), the process =
wait=C2=A0<span style=3D"font-size:13.3333330154419px">for someting</span><=
span style=3D"font-size:10pt">=C2=A0infinitely</span></p><p style=3D"font-f=
amily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:j=
ustify;font-size:13.3333330154419px;color:rgb(32,32,32)"><span style=3D"fon=
t-size:10pt"><br></span></p><p style=3D"font-family:&#39;Malgun Gothic&#39;=
;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.333333015=
4419px;color:rgb(32,32,32)">What can I do for going to next step?</p><p sty=
le=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;=
text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0=
</p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm =
0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,3=
2)">help me please..</p><p style=3D"font-family:&#39;Malgun Gothic&#39;;pad=
ding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419=
px;color:rgb(32,32,32)">=C2=A0</p><p style=3D"font-family:&#39;Malgun Gothi=
c&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.333=
3330154419px;color:rgb(32,32,32)">This is log message the process print out=
.</p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm=
 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,=
32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, =
sans-serif">2015-04-17 22:08:20,492.492 INFO:create_nodes.py:Creating <a hr=
ef=3D"http://target0.gluesys.com">target0.gluesys.com</a></font></p><p styl=
e=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;t=
ext-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font c=
olor=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">=
2015-04-17 22:08:20,512.512 INFO:teuthology.orchestra.connection:{&#39;user=
name&#39;: &#39;ubuntu&#39;, &#39;hostname&#39;: &#39;<a href=3D"http://tar=
get0.example.com">target0.example.com</a>&#39;, &#39;timeout&#39;: 30}</fon=
t></p><div style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:=
0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,=
32,32)">=C2=A0</div><div style=3D"font-family:&#39;Malgun Gothic&#39;;paddi=
ng:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px=
;color:rgb(32,32,32)">=C2=A0</div><div style=3D"font-family:&#39;Malgun Got=
hic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3=
333330154419px;color:rgb(32,32,32)">=C2=A0</div><div style=3D"font-family:&=
#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;=
font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</div><div style=3D=
"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-=
align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</div=
><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm=
 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"=
>And this is problematic=C2=A0part of=C2=A0the &quot;strace&quot; dump for =
the process.(strace python create_nodes.py)</p><p style=3D"font-family:&#39=
;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;fon=
t-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</p><p style=3D"font-f=
amily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:j=
ustify;font-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...omitted...</p><p style=3D"font-family:&#=
39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;f=
ont-size:13.3333330154419px;color:rgb(32,32,32)">=C2=A0</p><p style=3D"font=
-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align=
:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#=
000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">open(&quo=
t;/home/teuthology/src/teuthology_master/teuthology/provision.py&quot;, O_R=
DONLY) =3D 4</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padd=
ing:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419p=
x;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim=
, Arial, Verdana, sans-serif">fstat(4, {st_mode=3DS_IFREG|0664, st_size=3D8=
320, ...}) =3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;=
padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154=
419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, G=
ulim, Arial, Verdana, sans-serif">open(&quot;/home/teuthology/src/teutholog=
y_master/teuthology/provision.pyc&quot;, O_RDONLY) =3D 5</font></p><p style=
=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;te=
xt-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font co=
lor=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">f=
stat(5, {st_mode=3DS_IFREG|0664, st_size=3D8391, ...}) =3D 0</font></p><p s=
tyle=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5p=
t;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><fon=
t color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-seri=
f">mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)=
 =3D 0x7fb35d52f000</font></p><p style=3D"font-family:&#39;Malgun Gothic&#3=
9;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330=
154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic=
, Gulim, Arial, Verdana, sans-serif">read(5, &quot;\3\363\r\n\327\273+Uc\0\=
0\0\0\0\0\0\0\4\0\0\0@\0\0\0s\330\0\0\0d\0&quot;..., 4096) =3D 4096</font><=
/p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0=
cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32=
)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sa=
ns-serif">fstat(5, {st_mode=3DS_IFREG|0664, st_size=3D8391, ...}) =3D 0</fo=
nt></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0=
cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,3=
2,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana=
, sans-serif">read(5, &quot;|\0\0j\5\0d\10\0|\6\0\203\0\2\203\1\0\1t\3\0S|\=
4\0j\f\0d\t\0&quot;..., 4096) =3D 4096</font></p><p style=3D"font-family:&#=
39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;f=
ont-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" fa=
ce=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">read(5, &quot;usR\5=
\0\0\0t\t\0\0\0getLoggerRg\0\0\0R.\0\0\0R&quot;..., 4096) =3D 199</font></p=
><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm=
 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"=
><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans=
-serif">read(5, &quot;&quot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</font></p><p style=3D"font-fam=
ily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:jus=
tify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#0000=
00" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">close(5) =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&=
#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;=
font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" f=
ace=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">munmap(0x7fb35d52f=
000, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p styl=
e=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;t=
ext-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font c=
olor=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">=
close(4) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"fo=
nt-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-ali=
gn:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D=
"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">close(3=
) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-fami=
ly:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:just=
ify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#00000=
0" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">stat(&quot;/et=
c/localtime&quot;, {st_mode=3DS_IFREG|0644, st_size=3D396, ...}) =3D 0</fon=
t></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0c=
m 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32=
,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana,=
 sans-serif">write(2, &quot;2015-04-17 03:06:25,649.649 INFO&quot;..., 7820=
15-04-17 03:06:25,649.649 INFO:create_nodes.py:Creating <a href=3D"http://t=
arget0.example.com">target0.example.com</a></font></p><p style=3D"font-fami=
ly:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:just=
ify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#00000=
0" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">) =3D 78</font=
></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm=
 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,=
32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, =
sans-serif">open(&quot;/home/teuthology/.ssh/known_hosts&quot;, O_RDONLY) =
=3D 3</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px=
;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color=
:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial=
, Verdana, sans-serif">fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D444, ...=
}) =3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:=
0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;co=
lor:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Ar=
ial, Verdana, sans-serif">fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D444, =
...}) =3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;paddi=
ng:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px=
;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim,=
 Arial, Verdana, sans-serif">mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRI=
VATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fb35d52f000</font></p><p style=3D"font-fa=
mily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:ju=
stify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000=
000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">read(3, &quo=
t;|1|nbkibeXwSj/5+ExknLQbdVchuoQ=3D|&quot;..., 8192) =3D 444</font></p><p s=
tyle=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5p=
t;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><fon=
t color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-seri=
f">read(3, &quot;&quot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</font></p><p style=3D"font-family:=
&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify=
;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" =
face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">read(3, &quot;&qu=
ot;, 8192) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#3=
9;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330=
154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic=
, Gulim, Arial, Verdana, sans-serif">close(3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;p=
adding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.33333301544=
19px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gu=
lim, Arial, Verdana, sans-serif">munmap(0x7fb35d52f000, 4096) =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&#39;Ma=
lgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-s=
ize:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D=
"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">stat(&quot;/home/teuthol=
ogy/.ssh/config&quot;, {st_mode=3DS_IFREG|0644, st_size=3D195, ...}) =3D 0<=
/font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margi=
n:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(3=
2,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verd=
ana, sans-serif">open(&quot;/home/teuthology/.ssh/config&quot;, O_RDONLY) =
=3D 3</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px=
;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color=
:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial=
, Verdana, sans-serif">fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D195, ...=
}) =3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:=
0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;co=
lor:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Ar=
ial, Verdana, sans-serif">fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D195, =
...}) =3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;paddi=
ng:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px=
;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim,=
 Arial, Verdana, sans-serif">mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRI=
VATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fb35d52f000</font></p><p style=3D"font-fa=
mily:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:ju=
stify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000=
000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">read(3, &quo=
t;Host target0\n =C2=A0 =C2=A0 =C2=A0 =C2=A0Hostname 11&quot;..., 8192) =3D=
 195</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;=
margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:=
rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial,=
 Verdana, sans-serif">read(3, &quot;&quot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</font></p><p sty=
le=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;=
text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font =
color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif"=
>read(3, &quot;&quot;, 8192) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</font></p><p style=3D"font-family:&#3=
9;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;fo=
nt-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" fac=
e=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">close(3) =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&#39;Mal=
gun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-si=
ze:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"=
Malgun Gothic, Gulim, Arial, Verdana, sans-serif">munmap(0x7fb35d52f000, 40=
96) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"fo=
nt-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-ali=
gn:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D=
"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">stat(&q=
uot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_size=3D396, ...}) =3D=
 0</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;ma=
rgin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rg=
b(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, V=
erdana, sans-serif">write(2, &quot;2015-04-17 03:06:25,650.650 INFO&quot;..=
., 1382015-04-17 03:06:25,650.650 INFO:teuthology.orchestra.connection:{&#3=
9;username&#39;: &#39;ubuntu&#39;, &#39;hostname&#39;: &#39;<a href=3D"http=
://target0.example.com">target0.example.com</a>&#39;, &#39;timeout&#39;: 30=
}</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;mar=
gin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb=
(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Ve=
rdana, sans-serif">) =3D 138</font></p><p style=3D"font-family:&#39;Malgun =
Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:1=
3.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malg=
un Gothic, Gulim, Arial, Verdana, sans-serif">socket(PF_LOCAL, SOCK_STREAM|=
SOCK_CLOEXEC|SOCK_NONBLOCK, 0) =3D 3</font></p><p style=3D"font-family:&#39=
;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;fon=
t-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=
=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">connect(3, {sa_family=
=3DAF_LOCAL, sun_path=3D&quot;/var/run/nscd/socket&quot;}, 110) =3D -1 ENOE=
NT (No such file or directory)</font></p><p style=3D"font-family:&#39;Malgu=
n Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size=
:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Ma=
lgun Gothic, Gulim, Arial, Verdana, sans-serif">close(3) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&#39;Malgun Got=
hic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3=
333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun =
Gothic, Gulim, Arial, Verdana, sans-serif">socket(PF_LOCAL, SOCK_STREAM|SOC=
K_CLOEXEC|SOCK_NONBLOCK, 0) =3D 3</font></p><p style=3D"font-family:&#39;Ma=
lgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-s=
ize:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D=
"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">connect(3, {sa_family=3D=
AF_LOCAL, sun_path=3D&quot;/var/run/nscd/socket&quot;}, 110) =3D -1 ENOENT =
(No such file or directory)</font></p><p style=3D"font-family:&#39;Malgun G=
othic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13=
.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgu=
n Gothic, Gulim, Arial, Verdana, sans-serif">close(3) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&#39;Malgun Gothic=
&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333=
330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Got=
hic, Gulim, Arial, Verdana, sans-serif">open(&quot;/etc/nsswitch.conf&quot;=
, O_RDONLY|O_CLOEXEC) =3D 3</font></p><p style=3D"font-family:&#39;Malgun G=
othic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13=
.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgu=
n Gothic, Gulim, Arial, Verdana, sans-serif">fstat(3, {st_mode=3DS_IFREG|06=
44, st_size=3D475, ...}) =3D 0</font></p><p style=3D"font-family:&#39;Malgu=
n Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size=
:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"Ma=
lgun Gothic, Gulim, Arial, Verdana, sans-serif">mmap(NULL, 4096, PROT_READ|=
PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fb35d52f000</font></p>=
<p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm =
3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)">=
<font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-=
serif">read(3, &quot;# /etc/nsswitch.conf\n#\n# Example&quot;..., 4096) =3D=
 475</font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;=
margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:=
rgb(32,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial,=
 Verdana, sans-serif">read(3, &quot;&quot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</font></p><p sty=
le=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;=
text-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font =
color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif"=
>close(3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D=
"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-=
align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font color=
=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">munm=
ap(0x7fb35d52f000, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</fo=
nt></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0=
cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,3=
2,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana=
, sans-serif">open(&quot;/etc/host.conf&quot;, O_RDONLY|O_CLOEXEC) =3D 3</f=
ont></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:=
0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(32,=
32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdan=
a, sans-serif">fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D92, ...}) =3D 0<=
/font></p><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margi=
n:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb(3=
2,32,32)"><font color=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verd=
ana, sans-serif">mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANO=
NYMOUS, -1, 0) =3D 0x7fb35d52f000</font></p><p style=3D"font-family:&#39;Ma=
lgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-s=
ize:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D=
"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">read(3, &quot;# The \&qu=
ot;order\&quot; line is only used &quot;..., 4096) =3D 92</font></p><p styl=
e=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;t=
ext-align:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><font c=
olor=3D"#000000" face=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">=
read(3, &quot;&quot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</font></p><p style=3D"font-family:&#3=
9;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;fo=
nt-size:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" fac=
e=3D"Malgun Gothic, Gulim, Arial, Verdana, sans-serif">close(3) =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><p style=3D"font-family:&#39;Mal=
gun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-si=
ze:13.3333330154419px;color:rgb(32,32,32)"><font color=3D"#000000" face=3D"=
Malgun Gothic, Gulim, Arial, Verdana, sans-serif">munmap(0x7fb35d52f000, 40=
96) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</font></p><div style=3D"=
font-family:&#39;Malgun Gothic&#39;;padding:0px;margin:0cm 0cm 3.5pt;text-a=
lign:justify;font-size:13.3333330154419px;color:rgb(32,32,32)"><div style=
=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-si=
ze:10pt">futex(0x7fb35d0f13d0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0</span>=
</div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span =
style=3D"font-size:10pt">open(&quot;/etc/resolv.conf&quot;, O_RDONLY|O_CLOE=
XEC) =3D 3</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-=
size:10pt"><span style=3D"font-size:10pt">fstat(3, {st_mode=3DS_IFREG|0644,=
 st_size=3D201, ...}) =3D 0</span></div><div style=3D"padding:0px;margin:0c=
m 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">mmap(NULL, 4096,=
 PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fb35d52f000=
</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"=
><span style=3D"font-size:10pt">read(3, &quot;# Dynamic resolv.conf(5) file=
 fo&quot;..., 4096) =3D 201</span></div><div style=3D"padding:0px;margin:0c=
m 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">read(3, &quot;&q=
uot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D 0</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.=
5pt;font-size:10pt"><span style=3D"font-size:10pt">close(3) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</span></div><div style=3D"padding:0px;margin:=
0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">munmap(0x7fb35=
d52f000, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</span></div><=
div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=
=3D"font-size:10pt">uname({sys=3D&quot;Linux&quot;, node=3D&quot;teuthology=
&quot;, ...}) =3D 0</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.=
5pt;font-size:10pt"><span style=3D"font-size:10pt">open(&quot;/etc/ld.so.ca=
che&quot;, O_RDONLY|O_CLOEXEC) =3D 3</span></div><div style=3D"padding:0px;=
margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">fstat(3=
, {st_mode=3DS_IFREG|0644, st_size=3D24517, ...}) =3D 0</span></div><div st=
yle=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font=
-size:10pt">mmap(NULL, 24517, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7fb35d460=
000</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10=
pt"><span style=3D"font-size:10pt">close(3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font=
-size:10pt"><span style=3D"font-size:10pt">access(&quot;/etc/ld.so.nohwcap&=
quot;, F_OK) =C2=A0 =C2=A0 =C2=A0=3D -1 ENOENT (No such file or directory)<=
/span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt">=
<span style=3D"font-size:10pt">open(&quot;/lib/x86_64-linux-gnu/libnss_file=
s.so.2&quot;, O_RDONLY|O_CLOEXEC) =3D 3</span></div><div style=3D"padding:0=
px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">read=
(3, &quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\240\&quot;\0\0\=
0\0\0\0&quot;..., 832) =3D 832</span></div><div style=3D"padding:0px;margin=
:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">fstat(3, {st_=
mode=3DS_IFREG|0644, st_size=3D47712, ...}) =3D 0</span></div><div style=3D=
"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:=
10pt">mmap(NULL, 2144392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3=
, 0) =3D 0x7fb354f22000</span></div><div style=3D"padding:0px;margin:0cm 0c=
m 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">mprotect(0x7fb354f2d=
000, 2093056, PROT_NONE) =3D 0</span></div><div style=3D"padding:0px;margin=
:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">mmap(0x7fb355=
12c000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3,=
 0xa000) =3D 0x7fb35512c000</span></div><div style=3D"padding:0px;margin:0c=
m 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">close(3) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</span></div><div style=3D"padding:0px;=
margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">mprotec=
t(0x7fb35512c000, 4096, PROT_READ) =3D 0</span></div><div style=3D"padding:=
0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">mun=
map(0x7fb35d460000, 24517) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</span><=
/div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span s=
tyle=3D"font-size:10pt">open(&quot;/etc/hosts&quot;, O_RDONLY|O_CLOEXEC) =
=C2=A0=3D 3</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font=
-size:10pt"><span style=3D"font-size:10pt">fstat(3, {st_mode=3DS_IFREG|0644=
, st_size=3D261, ...}) =3D 0</span></div><div style=3D"padding:0px;margin:0=
cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">mmap(NULL, 4096=
, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fb35d52f00=
0</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt=
"><span style=3D"font-size:10pt">read(3, &quot;127.0.0.1\tlocalhost\n\n11.0=
.0.1\tte&quot;..., 4096) =3D 261</span></div><div style=3D"padding:0px;marg=
in:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">read(3, &qu=
ot;&quot;, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D 0</span></div><div style=3D"padding:0px;margin:0cm=
 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">close(3) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</span></div><div style=3D"padding:0px;=
margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">munmap(=
0x7fb35d52f000, 4096) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</span>=
</div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span =
style=3D"font-size:10pt">socket(PF_INET, SOCK_STREAM, IPPROTO_IP) =3D 3</sp=
an></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><sp=
an style=3D"font-size:10pt">fcntl(3, F_GETFL) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x2 (flags O_RDWR)</sp=
an></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><sp=
an style=3D"font-size:10pt">fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =C2=A0 =C2=
=A0=3D 0</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-si=
ze:10pt"><span style=3D"font-size:10pt">getsockopt(3, SOL_SOCKET, SO_ERROR,=
 [0], [4]) =3D 0</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt=
;font-size:10pt"><span style=3D"font-size:10pt">connect(3, {sa_family=3DAF_=
INET, sin_port=3Dhtons(22), sin_addr=3Dinet_addr(&quot;11.0.0.10&quot;)}, 1=
6) =3D -1 EINPROGRESS (Operation now in progress)</span></div><div style=3D=
"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:=
10pt">epoll_ctl(6, EPOLL_CTL_ADD, 3, {EPOLLOUT, {u32=3D3, u64=3D3}}) =3D 0<=
/span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt">=
<span style=3D"font-size:10pt">rt_sigaction(SIGINT, {0x7fb35bce0a20, ~[RTMI=
N RT_1], SA_RESTORER|SA_RESTART, 0x7fb35d103340}, {0x46460e, [], SA_RESTORE=
R, 0x7fb35d103340}, 8) =3D 0</span></div><div style=3D"padding:0px;margin:0=
cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">epoll_ctl(6, EP=
OLL_CTL_ADD, 8, {EPOLLIN, {u32=3D8, u64=3D8}}) =3D 0</span></div><div style=
=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-si=
ze:10pt">epoll_wait(6, {{EPOLLOUT, {u32=3D3, u64=3D3}}}, 32, 30000) =3D 1</=
span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><=
span style=3D"font-size:10pt">epoll_ctl(6, EPOLL_CTL_DEL, 3, {EPOLLOUT, {u3=
2=3D3, u64=3D3}}) =3D 0</span></div><div style=3D"padding:0px;margin:0cm 0c=
m 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">getsockopt(3, SOL_SO=
CKET, SO_ERROR, [0], [4]) =3D 0</span></div><div style=3D"padding:0px;margi=
n:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">connect(3, {=
sa_family=3DAF_INET, sin_port=3Dhtons(22), sin_addr=3Dinet_addr(&quot;11.0.=
0.10&quot;)}, 16) =3D 0</span></div><div style=3D"padding:0px;margin:0cm 0c=
m 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">sendto(3, &quot;SSH-=
2.0-paramiko_1.7.7.2\r\n&quot;, 26, 0, NULL, 0) =3D 26</span></div><div sty=
le=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-=
size:10pt">recvfrom(3, 0x7fb355190594, 128, 0, 0, 0) =3D -1 EAGAIN (Resourc=
e temporarily unavailable)</span></div><div style=3D"padding:0px;margin:0cm=
 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">epoll_ctl(6, EPOL=
L_CTL_ADD, 3, {EPOLLIN, {u32=3D3, u64=3D3}}) =3D 0</span></div><div style=
=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-si=
ze:10pt">read(14, &quot;\f\363\364\265\234\362\213\23\372_\253\266prZy\227\=
335\212\336BoNb&gt;\353\312!\333\0231j&quot;..., 1024) =3D 1024</span></div=
><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=
=3D"font-size:10pt">read(14, &quot;%\205\325X6K\2725:\25\215\235\26c_\v\306=
\336[t\24d\201\307^\260\271%\27\27\204\276&quot;..., 1024) =3D 1024</span><=
/div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span s=
tyle=3D"font-size:10pt">select(0, NULL, NULL, NULL, {0, 1000}) =C2=A0=3D 0 =
(Timeout)</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-s=
ize:10pt"><span style=3D"font-size:10pt">select(0, NULL, NULL, NULL, {0, 20=
00}) =C2=A0=3D 0 (Timeout)</span></div><div style=3D"padding:0px;margin:0cm=
 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">select(0, NULL, N=
ULL, NULL, {0, 4000}) =C2=A0=3D 0 (Timeout)</span></div><div style=3D"paddi=
ng:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">=
select(0, NULL, NULL, NULL, {0, 8000}) =C2=A0=3D 0 (Timeout)</span></div><d=
iv style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D=
"font-size:10pt">select(0, NULL, NULL, NULL, {0, 16000}) =3D 0 (Timeout)</s=
pan></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><s=
pan style=3D"font-size:10pt">select(0, NULL, NULL, NULL, {0, 32000}) =3D 0 =
(Timeout)</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-s=
ize:10pt"><span style=3D"font-size:10pt">select(0, NULL, NULL, NULL, {0, 36=
345}) =3D 0 (Timeout)</span></div><div style=3D"padding:0px;margin:0cm 0cm =
3.5pt;font-size:10pt"><span style=3D"font-size:10pt">select(0, NULL, NULL, =
NULL, {0, 1000}) =C2=A0=3D 0 (Timeout)</span></div><div style=3D"padding:0p=
x;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt">selec=
t(0, NULL, NULL, NULL, {0, 2000}) =C2=A0=3D 0 (Timeout)</span></div><div st=
yle=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=3D"font=
-size:10pt">select(0, NULL, NULL, NULL, {0, 4000}) =C2=A0=3D 0 (Timeout)</s=
pan></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><s=
pan style=3D"font-size:10pt">select(0, NULL, NULL, NULL, {0, 8000}) =C2=A0=
=3D 0 (Timeout)</span></div><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;=
font-size:10pt"><span style=3D"font-size:10pt">select(0, NULL, NULL, NULL, =
{0, 16000}) =3D 0 (Timeout)</span></div><div style=3D"padding:0px;margin:0c=
m 0cm 3.5pt;font-size:10pt"><span style=3D"font-size:10pt"><br></span></div=
><div style=3D"padding:0px;margin:0cm 0cm 3.5pt;font-size:10pt"><span style=
=3D"font-size:10pt">...( repeated select(0,...) =3D 0 (Timeout) )...</span>=
</div></div><p style=3D"font-family:&#39;Malgun Gothic&#39;;padding:0px;mar=
gin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px;color:rgb=
(32,32,32)">=C2=A0</p><p style=3D"font-family:&#39;Malgun Gothic&#39;;paddi=
ng:0px;margin:0cm 0cm 3.5pt;text-align:justify;font-size:13.3333330154419px=
;color:rgb(32,32,32)">=C2=A0</p></div>

--bcaec548a6ab7ba3650513e61070--

--===============1901445758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1901445758==--
