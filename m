From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Cannot delete some empty dirs and weird sizes
Date: Wed, 1 Feb 2012 18:02:37 +0100
Message-ID: <201202011802.39891.a.ott@m-privacy.de>
References: <201201311300.20787.a.ott@m-privacy.de> <CAF3hT9AE9A0d_rdGN+W=wHQG1ksUJkg0H1+-eQh1n+5ZOBn2Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:55272 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516Ab2BARCw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 12:02:52 -0500
In-Reply-To: <CAF3hT9AE9A0d_rdGN+W=wHQG1ksUJkg0H1+-eQh1n+5ZOBn2Hg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Tuesday 31 January 2012 wrote Gregory Farnum:
> On Tue, Jan 31, 2012 at 4:00 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > Hi again!
> >
> > We are running Ceph 0.41 and kernel 3.2.2 with current for-linus co=
de
> > (commit 3d882ce47de80e0294a536bec771b5651885b4d3) now.
> >
> > After some heavy workloads we see quite a few directories that cann=
ot be
> > deleted, although ls and find show that they are empty. rmdir says =
they
> > are not empty.
> >
> > Additionally, ceph reports various weird size values for some, but =
not
> > all of them:
> > ls -la .tmp/tiny61/.mozilla/firefox/default.yat/
> > insgesamt 0
> > drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 .
> > drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 ..
> >
> > Is this a known or a new bug? Can it be related to .snap pseudo dir=
s? The
> > problem appeared without ever using snapshots, though.
>
> I believe this is new. Based on the odd sizes (that's a 64-bit -1
> interpreted as unsigned, fyi), my guess is that the "recursive
> accounting" statistics are off and that's leading the MDS to believe
> the directory is not empty even though it is. It's unlikely to be
> directly related to snapshots, though it's not impossible.
>
> Have you seen this on more than one MDS? If it's reproducible we coul=
d
> more easily figure out the cause; otherwise the best we can do is to
> maybe fix up the specific instance of it.

I had to recreate ceph fs several times today because of kernel problem=
s. Now=20
I have only one dir that is wrong:
ls -la .tmp/tiny14/.config/pcmanfm/LXDE/
insgesamt 0
drwxr-xr-x 1 32252 users 393  1. Feb 15:19 .
drwxr-xr-x 1 32252 users   0  1. Feb 17:21 ..

This is probably caused by another reboot I had to do, although I think=
 ceph=20
should have recovered here. Might also be caused by this setting that I=
 tried=20
for a while, it is off now:
mds standby replay =3D true
With this setting, if the active mds gets killed, no mds is able to bec=
ome=20
active, so everything hangs. Had to reboot again.

=46ound that in mds log, the reported wrong size matches the dir total:

2012-02-01 17:21:51.306561 4f830b70 mds.0.cache.dir(1000000b055) _fetch=
ed =20
badness: got (but i already had) [inode 100000066c9
[2,head] /tiny14/.config/pcmanfm/
LXDE.conf auth v4 s=3D393 n(v0 b393 1=3D1+0) (iversion lock) cr=3D{4711=
=3D0-4194304@1}=20
caps=3D{5313=3DpAsLsXsFscr/-@1} | caps 0x1d13c600] mode 33188 mtime 201=
2-01-24=20
15:55:59.0000002012-02-01 17:21:51.306646 4f830b70 log [ERR] : loaded d=
up=20
inode 100000066c9 [2,head] v7 at /tiny14/.config/pcmanfm/LXDE/pcmanfm.c=
onf,=20
but inode 100000066c9.head v4 already exists=20
at /tiny14/.config/pcmanfm/LXDE.conf
2012-02-01 17:21:51.349424 4f830b70 mds.0.cache.dir(100000066ae) mismat=
ch=20
between head items and fnode.fragstat! printing dentries
2012-02-01 17:21:51.349457 4f830b70 mds.0.cache.dir(100000066ae)=20
get_num_head_items() =3D 2; fnode.fragstat.nfiles=3D0 fnode.fragstat.ns=
ubdirs=3D1
2012-02-01 17:21:51.349493 4f830b70 mds.0.cache.dir(100000066ae) [dentr=
y=20
#1/tiny14/.config/pcmanfm/LXDE [2,head] auth (dversion lock) pv=3D0 v=3D=
16=20
inode=3D0x1cff3828 | inodepin 0x1b9f4de0]
2012-02-01 17:21:51.349521 4f830b70 mds.0.cache.dir(100000066ae) [dentr=
y=20
#1/tiny14/.config/pcmanfm/LXDE.conf [2,head] auth (dn xlock x=3D1 by=20
0x1ab21200) (dversion lock w=3D1 last_client=3D5313) pv=3D17 v=3D16 ap=3D=
2+2=20
inode=3D0x1d13c600 | request lock inodepin authpin 0x1b90f064]
2012-02-01 17:21:51.349552 4f830b70 mds.0.cache.dir(100000066ae) mismat=
ch=20
between child accounted_rstats and my rstats!
2012-02-01 17:21:51.349573 4f830b70 mds.0.cache.dir(100000066ae) total =
of=20
child dentrys: n(v0 rc2012-02-01 15:19:55.517733 b786 3=3D2+1)
2012-02-01 17:21:51.349591 4f830b70 mds.0.cache.dir(100000066ae) my rst=
ats:             =20
n(v3 rc2012-02-01 15:19:55.517733 b393 2=3D1+1)
2012-02-01 17:21:51.349616 4f830b70 mds.0.cache.dir(100000066ae) [dentr=
y=20
#1/tiny14/.config/pcmanfm/LXDE [2,head] auth (dversion lock) pv=3D0 v=3D=
16=20
inode=3D0x1cff3828 | inodepin 0x1b9f4de0] n(v0 rc2012-02-01 15:19:55.51=
7733=20
b393 2=3D1+1)
2012-02-01 17:21:51.349643 4f830b70 mds.0.cache.dir(100000066ae) [dentr=
y=20
#1/tiny14/.config/pcmanfm/LXDE.conf [2,head] auth (dn xlock x=3D1 by=20
0x1ab21200) (dversion lock w=3D1 last_client=3D5313) pv=3D17 v=3D16 ap=3D=
2+2=20
inode=3D0x1d13c600 | request lock inodepin authpin 0x1b90f064] n(v0 b39=
3 1=3D1+0)


Then killed the active mds, another takes over and suddenly the missing=
 file=20
appears:
=2Etmp/tiny14/.config/pcmanfm/LXDE/insgesamt 1
drwxr-xr-x 1 32252 users 393  1. Feb 15:19 .
drwxr-xr-x 1 32252 users   0  1. Feb 17:21 ..
-rw-r--r-- 1 root  root  393 24. Jan 15:55 pcmanfm.conf

Restarted the original mds, it does not appear in "ceph mds dump", alth=
ough it=20
is running at 100% cpu. Same happened with other mds processes after ki=
lling=20
and starting, now I have only one left that is working correctly.

Will leave the cluster in this state now and have another look tomorrow=
 -=20
maybe the spinning mds processes recover by some miracle.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
