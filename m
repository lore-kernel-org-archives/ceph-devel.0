From: Jeffrey Zhang <zhang.lei.fly-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Is there any way for ceph-osd to control the max fds?
Date: Mon, 17 Sep 2018 20:39:32 +0800
Message-ID: <CAATxhGf8Qz8NdfgAsVgaXqumRLVPtgGu=sZqcmb7ZSSUB6N4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5303856424398110826=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============5303856424398110826==
Content-Type: multipart/alternative; boundary="00000000000039f3a0057610790a"

--00000000000039f3a0057610790a
Content-Type: text/plain; charset="UTF-8"

In one env, which is deployed through container, i found the ceph-osd always
be suicide due to "error (24) Too many open files"

Then i increased the LimitNOFILE for the container from 65k to 655k, which
could fix the issue.
But the FDs increase all the time. now the max number is around 155k. I
am afraid
it will increase forever.

I also found there is a option `max_open_files`, but it seems only used for
upstart scripts at OS level, and the default value is
16384 now[2]. whereas if you are using systemd, it will never load from the
`max_open_files` options and fixed to 1048576 in default[1].
So i guess if the ceph-osd live long enough, it will still read the OS
level strict and suicide at the end.

So here is the question
1. since almost all os distro already moved to systemd, so max_open_files
is uselss now.
2. is there any mechanism that ceph-osd could release some fds?


[0]
https://github.com/ceph/ceph/commit/16c603b26f3d7dfcf0028e17fe3c04d94a434387
[1] https://github.com/ceph/ceph/commit/8453a89
[2]
https://github.com/ceph/ceph/commit/672c56b18de3b02606e47013edfc2e8b679d8797



-- 
Regards,
Jeffrey Zhang
Blog: http://xcodest.me

--00000000000039f3a0057610790a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default">In=
 one env, which is deployed through container, i found the ceph-osd always<=
/div><div class=3D"gmail_default">be suicide due to &quot;error (24) Too ma=
ny open files<span style=3D"font-family:arial,helvetica,sans-serif;font-siz=
e:small;color:rgb(0,0,0)">&quot;</span><br></div><div class=3D"gmail_defaul=
t"><span style=3D"font-family:arial,helvetica,sans-serif;font-size:small;co=
lor:rgb(0,0,0)"><br></span></div><div class=3D"gmail_default"><font color=
=3D"#000000" face=3D"arial, helvetica, sans-serif">Then i increased the Lim=
itNOFILE for the container from 65k to 655k, which could fix the issue.</fo=
nt></div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"arial=
, helvetica, sans-serif">But the FDs increase all the time. now the max num=
ber is around 155k. I am=C2=A0afraid</font></div><div class=3D"gmail_defaul=
t"><font color=3D"#000000" face=3D"arial, helvetica, sans-serif">it will in=
crease forever.=C2=A0</font></div><div class=3D"gmail_default"><font color=
=3D"#000000" face=3D"arial, helvetica, sans-serif"><br></font></div><div cl=
ass=3D"gmail_default"><font color=3D"#000000" face=3D"arial, helvetica, san=
s-serif">I also found there is a option `max_open_files`, but it seems only=
 used for upstart scripts at OS level, and the default value is</font></div=
><div class=3D"gmail_default"><font color=3D"#000000" face=3D"arial, helvet=
ica, sans-serif">16384 now[2]. whereas if you are using systemd, it will ne=
ver load from the `max_open_files` options and fixed to 1048576 in default[=
1].</font></div><div class=3D"gmail_default"><font color=3D"#000000" face=
=3D"arial, helvetica, sans-serif">So i guess if the ceph-osd live long enou=
gh, it will still read the OS level strict and suicide at the end.</font></=
div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"arial, hel=
vetica, sans-serif"><br></font></div><div class=3D"gmail_default"><font col=
or=3D"#000000" face=3D"arial, helvetica, sans-serif">So here is the questio=
n</font></div><div class=3D"gmail_default">1. since almost all os distro al=
ready moved to systemd, so max_open_files is uselss now.</div><div class=3D=
"gmail_default">2. is there any mechanism that ceph-osd could release some =
fds?</div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"aria=
l, helvetica, sans-serif"><br></font></div><div class=3D"gmail_default"><fo=
nt color=3D"#000000" face=3D"arial, helvetica, sans-serif"><br></font></div=
><div class=3D"gmail_default"><font color=3D"#000000" face=3D"arial, helvet=
ica, sans-serif">[0]=C2=A0<a href=3D"https://github.com/ceph/ceph/commit/16=
c603b26f3d7dfcf0028e17fe3c04d94a434387">https://github.com/ceph/ceph/commit=
/16c603b26f3d7dfcf0028e17fe3c04d94a434387</a></font></div><div class=3D"gma=
il_default"><font color=3D"#000000" face=3D"arial, helvetica, sans-serif">[=
1]=C2=A0<a href=3D"https://github.com/ceph/ceph/commit/8453a89">https://git=
hub.com/ceph/ceph/commit/8453a89</a></font></div><div class=3D"gmail_defaul=
t"><font color=3D"#000000" face=3D"arial, helvetica, sans-serif">[2]=C2=A0<=
a href=3D"https://github.com/ceph/ceph/commit/672c56b18de3b02606e47013edfc2=
e8b679d8797">https://github.com/ceph/ceph/commit/672c56b18de3b02606e47013ed=
fc2e8b679d8797</a></font></div><div class=3D"gmail_default"><span style=3D"=
font-family:arial,helvetica,sans-serif;font-size:small;color:rgb(0,0,0)"><b=
r></span></div><div class=3D"gmail_default" style=3D"font-family:arial,helv=
etica,sans-serif;font-size:small">=C2=A0</div><div><br></div>-- <br><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div><span style=3D"font-size:13px;border-collapse:collapse"><font face=
=3D"arial, helvetica, sans-serif">Regards,</font></span></div><div><span st=
yle=3D"font-size:13px;border-collapse:collapse"><font face=3D"arial, helvet=
ica, sans-serif">Jeffrey Zhang</font></span></div><div><font face=3D"arial,=
 helvetica, sans-serif"><span style=3D"font-size:12.8px">Blog:=C2=A0</span>=
<a href=3D"http://xcodest.me/" style=3D"font-size:12.8px" target=3D"_blank"=
>http://xcodest.me</a></font><font face=3D"monospace, monospace"><br></font=
></div></div></div></div></div></div></div></div></div></div></div></div></=
div></div></div></div></div></div>

--00000000000039f3a0057610790a--

--===============5303856424398110826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5303856424398110826==--
