From: "Lomayani S. Laizer" <lomlaizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Jewel + kernel 4.4 Massive performance regression
	(-50%)
Date: Mon, 25 Jul 2016 19:07:30 +0300
Message-ID: <CAFonxSwyGOC9OGjEwBOmewhvtH_vBRKxT4eyoTkdFAxJmg6jZw@mail.gmail.com>
References: <14aea50c-f708-1d99-8d61-c79bec2029e0@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1757024726=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <14aea50c-f708-1d99-8d61-c79bec2029e0-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Yoann Moulin <yoann.moulin-p8DiymsW2f8@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1757024726==
Content-Type: multipart/alternative; boundary=001a114ba39038a580053877fbdb

--001a114ba39038a580053877fbdb
Content-Type: text/plain; charset=UTF-8

Hello,
Am running ubuntu 16 with kernel 4.4-0.31-generic and my speed are similar.

I did tests on ubuntu 14 and Ubuntu 16 and the speed is similar. I have
around 80-90MB/s of OSD speeds in both operating systems

Only issue am observing now with ubuntu 16 is sometime osd fails on
rebooting until i start them manually or adding starting commands in
rc.local.

--

Lomayani

On Mon, Jul 25, 2016 at 6:45 PM, Yoann Moulin <yoann.moulin-p8DiymsW2f8@public.gmane.org> wrote:

> Hello,
>
> (this is a repost, my previous message seems to be slipping under the
> radar)
>
> Does anyone get a similar behaviour to the one described below ?
>
> I found a big performance drop between kernel 3.13.0-88 (default kernel on
> Ubuntu Trusty 14.04) or kernel 4.2.0 and kernel 4.4.0.24.14 (default
> kernel on
> Ubuntu Xenial 16.04)
>
> - ceph version is Jewel (10.2.2).
> - All tests have been done under Ubuntu 14.04 on
> - Each cluster has 5 nodes strictly identical.
> - Each node has 10 OSDs.
> - Journals are on the disk.
>
> Kernel 4.4 has a drop of more than 50% compared to 4.2
> Kernel 4.4 has a drop of 40% compared to 3.13
>
> details below :
>
> With the 3 kernel I have the same performance on disks :
>
> Raw benchmark:
> dd if=/dev/zero of=/dev/sdX bs=1M count=1024 oflag=direct    => average
> ~230MB/s
> dd if=/dev/zero of=/dev/sdX bs=1G count=1 oflag=direct       => average
> ~220MB/s
>
> Filesystem mounted benchmark:
> dd if=/dev/zero of=/sdX1/test.img bs=1G count=1              => average
> ~205MB/s
> dd if=/dev/zero of=/sdX1/test.img bs=1G count=1 oflag=direct => average
> ~214MB/s
> dd if=/dev/zero of=/sdX1/test.img bs=1G count=1 oflag=sync   => average
> ~190MB/s
>
> Ceph osd Benchmark:
> Kernel 3.13.0-88-generic : ceph tell osd.ID bench => average  ~81MB/s
> Kernel 4.2.0-38-generic  : ceph tell osd.ID bench => average ~109MB/s
> Kernel 4.4.0-24-generic  : ceph tell osd.ID bench => average  ~50MB/s
>
> I did new benchmarks then on 3 new fresh clusters.
>
> - Each cluster has 3 nodes strictly identical.
> - Each node has 10 OSDs.
> - Journals are on the disk.
>
> bench5 : Ubuntu 14.04 / Ceph Infernalis
> bench6 : Ubuntu 14.04 / Ceph Jewel
> bench7 : Ubuntu 16.04 / Ceph jewel
>
> this is the average of 2 runs of "ceph tell osd.* bench" on each cluster
> (2 x 30
> OSDs)
>
> bench5 / 14.04 / Infernalis / kernel 3.13 :  54.35 MB/s
> bench6 / 14.04 / Jewel      / kernel 3.13 :  86.47 MB/s
>
> bench5 / 14.04 / Infernalis / kernel 4.2  :  63.38 MB/s
> bench6 / 14.04 / Jewel      / kernel 4.2  : 107.75 MB/s
> bench7 / 16.04 / Jewel      / kernel 4.2  : 101.54 MB/s
>
> bench5 / 14.04 / Infernalis / kernel 4.4  :  53.61 MB/s
> bench6 / 14.04 / Jewel      / kernel 4.4  :  65.82 MB/s
> bench7 / 16.04 / Jewel      / kernel 4.4  :  61.57 MB/s
>
> If needed, I have the raw output of "ceph tell osd.* bench"
>
> Best regards
>
> --
> Yoann Moulin
> EPFL IC-IT
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a114ba39038a580053877fbdb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:small">Hello,<br></div><div class=3D"gmail_default" st=
yle=3D"font-family:verdana,sans-serif;font-size:small">Am running ubuntu 16=
 with kernel 4.4-0.31-generic and my speed are similar.<br><br>I did tests =
on ubuntu 14 and Ubuntu 16 and the speed is similar. I have around 80-90MB/=
s of OSD speeds in both operating systems<br><br></div><div class=3D"gmail_=
default" style=3D"font-family:verdana,sans-serif;font-size:small">Only issu=
e am observing now with ubuntu 16 is sometime osd fails on rebooting until =
i start them manually or adding starting commands in rc.local.<br><br>--<br=
><br></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-s=
erif;font-size:small">Lomayani<br></div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Mon, Jul 25, 2016 at 6:45 PM, Yoann Moulin =
<span dir=3D"ltr">&lt;<a href=3D"mailto:yoann.moulin-p8DiymsW2f8@public.gmane.org" target=3D"_bl=
ank">yoann.moulin-p8DiymsW2f8@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">Hello,<br>
<br>
(this is a repost, my previous message seems to be slipping under the radar=
)<br>
<br>
Does anyone get a similar behaviour to the one described below ?<br>
<br>
I found a big performance drop between kernel 3.13.0-88 (default kernel on<=
br>
Ubuntu Trusty 14.04) or kernel 4.2.0 and kernel 4.4.0.24.14 (default kernel=
 on<br>
Ubuntu Xenial 16.04)<br>
<br>
- ceph version is Jewel (10.2.2).<br>
- All tests have been done under Ubuntu 14.04 on<br>
- Each cluster has 5 nodes strictly identical.<br>
- Each node has 10 OSDs.<br>
- Journals are on the disk.<br>
<br>
Kernel 4.4 has a drop of more than 50% compared to 4.2<br>
Kernel 4.4 has a drop of 40% compared to 3.13<br>
<br>
details below :<br>
<br>
With the 3 kernel I have the same performance on disks :<br>
<br>
Raw benchmark:<br>
dd if=3D/dev/zero of=3D/dev/sdX bs=3D1M count=3D1024 oflag=3Ddirect=C2=A0 =
=C2=A0 =3D&gt; average ~230MB/s<br>
dd if=3D/dev/zero of=3D/dev/sdX bs=3D1G count=3D1 oflag=3Ddirect=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D&gt; average ~220MB/s<br>
<br>
Filesystem mounted benchmark:<br>
dd if=3D/dev/zero of=3D/sdX1/test.img bs=3D1G count=3D1=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D&gt; average ~205MB/s<br>
dd if=3D/dev/zero of=3D/sdX1/test.img bs=3D1G count=3D1 oflag=3Ddirect =3D&=
gt; average ~214MB/s<br>
dd if=3D/dev/zero of=3D/sdX1/test.img bs=3D1G count=3D1 oflag=3Dsync=C2=A0 =
=C2=A0=3D&gt; average ~190MB/s<br>
<br>
Ceph osd Benchmark:<br>
Kernel 3.13.0-88-generic : ceph tell osd.ID bench =3D&gt; average=C2=A0 ~81=
MB/s<br>
Kernel 4.2.0-38-generic=C2=A0 : ceph tell osd.ID bench =3D&gt; average ~109=
MB/s<br>
Kernel 4.4.0-24-generic=C2=A0 : ceph tell osd.ID bench =3D&gt; average=C2=
=A0 ~50MB/s<br>
<br>
I did new benchmarks then on 3 new fresh clusters.<br>
<br>
- Each cluster has 3 nodes strictly identical.<br>
- Each node has 10 OSDs.<br>
- Journals are on the disk.<br>
<br>
bench5 : Ubuntu 14.04 / Ceph Infernalis<br>
bench6 : Ubuntu 14.04 / Ceph Jewel<br>
bench7 : Ubuntu 16.04 / Ceph jewel<br>
<br>
this is the average of 2 runs of &quot;ceph tell osd.* bench&quot; on each =
cluster (2 x 30<br>
OSDs)<br>
<br>
bench5 / 14.04 / Infernalis / kernel 3.13 :=C2=A0 54.35 MB/s<br>
bench6 / 14.04 / Jewel=C2=A0 =C2=A0 =C2=A0 / kernel 3.13 :=C2=A0 86.47 MB/s=
<br>
<br>
bench5 / 14.04 / Infernalis / kernel 4.2=C2=A0 :=C2=A0 63.38 MB/s<br>
bench6 / 14.04 / Jewel=C2=A0 =C2=A0 =C2=A0 / kernel 4.2=C2=A0 : 107.75 MB/s=
<br>
bench7 / 16.04 / Jewel=C2=A0 =C2=A0 =C2=A0 / kernel 4.2=C2=A0 : 101.54 MB/s=
<br>
<br>
bench5 / 14.04 / Infernalis / kernel 4.4=C2=A0 :=C2=A0 53.61 MB/s<br>
bench6 / 14.04 / Jewel=C2=A0 =C2=A0 =C2=A0 / kernel 4.4=C2=A0 :=C2=A0 65.82=
 MB/s<br>
bench7 / 16.04 / Jewel=C2=A0 =C2=A0 =C2=A0 / kernel 4.4=C2=A0 :=C2=A0 61.57=
 MB/s<br>
<br>
If needed, I have the raw output of &quot;ceph tell osd.* bench&quot;<br>
<br>
Best regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Yoann Moulin<br>
EPFL IC-IT<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</font></span></blockquote></div><br></div>

--001a114ba39038a580053877fbdb--

--===============1757024726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1757024726==--
