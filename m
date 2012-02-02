From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Cannot delete some empty dirs and weird sizes
Date: Thu, 2 Feb 2012 13:09:11 -0800
Message-ID: <CAF3hT9D7dwD8rWipzTFD=CWFWwMNe++x48bOCrFd6NsE749PHg@mail.gmail.com>
References: <201201311300.20787.a.ott@m-privacy.de>
	<CAF3hT9AE9A0d_rdGN+W=wHQG1ksUJkg0H1+-eQh1n+5ZOBn2Hg@mail.gmail.com>
	<201202011802.39891.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44829 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab2BBVJM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 16:09:12 -0500
Received: by iacb35 with SMTP id b35so3646732iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 13:09:11 -0800 (PST)
In-Reply-To: <201202011802.39891.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wed, Feb 1, 2012 at 9:02 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> On Tuesday 31 January 2012 wrote Gregory Farnum:
>> On Tue, Jan 31, 2012 at 4:00 AM, Amon Ott <a.ott@m-privacy.de> wrote=
:
>> > Hi again!
>> >
>> > We are running Ceph 0.41 and kernel 3.2.2 with current for-linus c=
ode
>> > (commit 3d882ce47de80e0294a536bec771b5651885b4d3) now.
>> >
>> > After some heavy workloads we see quite a few directories that can=
not be
>> > deleted, although ls and find show that they are empty. rmdir says=
 they
>> > are not empty.
>> >
>> > Additionally, ceph reports various weird size values for some, but=
 not
>> > all of them:
>> > ls -la .tmp/tiny61/.mozilla/firefox/default.yat/
>> > insgesamt 0
>> > drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 .
>> > drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 ..
>> >
>> > Is this a known or a new bug? Can it be related to .snap pseudo di=
rs? The
>> > problem appeared without ever using snapshots, though.
>>
>> I believe this is new. Based on the odd sizes (that's a 64-bit -1
>> interpreted as unsigned, fyi), my guess is that the "recursive
>> accounting" statistics are off and that's leading the MDS to believe
>> the directory is not empty even though it is. It's unlikely to be
>> directly related to snapshots, though it's not impossible.
>>
>> Have you seen this on more than one MDS? If it's reproducible we cou=
ld
>> more easily figure out the cause; otherwise the best we can do is to
>> maybe fix up the specific instance of it.
>
> I had to recreate ceph fs several times today because of kernel probl=
ems. Now
> I have only one dir that is wrong:
> ls -la .tmp/tiny14/.config/pcmanfm/LXDE/
> insgesamt 0
> drwxr-xr-x 1 32252 users 393 =A01. Feb 15:19 .
> drwxr-xr-x 1 32252 users =A0 0 =A01. Feb 17:21 ..
>
> This is probably caused by another reboot I had to do, although I thi=
nk ceph
> should have recovered here. Might also be caused by this setting that=
 I tried
> for a while, it is off now:
> mds standby replay =3D true
> With this setting, if the active mds gets killed, no mds is able to b=
ecome
> active, so everything hangs. Had to reboot again.

Hrm. That setting simply tells the non-active MDSes that they should
follow the journal of the active MDS(es). They should still go active
if the MDS they're following fails =97 although it does slightly
increase the chances of them running into the same bugs in code and
dying at the same time.


> Found that in mds log, the reported wrong size matches the dir total:
>
> 2012-02-01 17:21:51.306561 4f830b70 mds.0.cache.dir(1000000b055) _fet=
ched
> badness: got (but i already had) [inode 100000066c9
> [2,head] /tiny14/.config/pcmanfm/
> LXDE.conf auth v4 s=3D393 n(v0 b393 1=3D1+0) (iversion lock) cr=3D{47=
11=3D0-4194304@1}
> caps=3D{5313=3DpAsLsXsFscr/-@1} | caps 0x1d13c600] mode 33188 mtime 2=
012-01-24
> 15:55:59.0000002012-02-01 17:21:51.306646 4f830b70 log [ERR] : loaded=
 dup
> inode 100000066c9 [2,head] v7 at /tiny14/.config/pcmanfm/LXDE/pcmanfm=
=2Econf,
> but inode 100000066c9.head v4 already exists
> at /tiny14/.config/pcmanfm/LXDE.conf
> 2012-02-01 17:21:51.349424 4f830b70 mds.0.cache.dir(100000066ae) mism=
atch
> between head items and fnode.fragstat! printing dentries
> 2012-02-01 17:21:51.349457 4f830b70 mds.0.cache.dir(100000066ae)
> get_num_head_items() =3D 2; fnode.fragstat.nfiles=3D0 fnode.fragstat.=
nsubdirs=3D1
> 2012-02-01 17:21:51.349493 4f830b70 mds.0.cache.dir(100000066ae) [den=
try
> #1/tiny14/.config/pcmanfm/LXDE [2,head] auth (dversion lock) pv=3D0 v=
=3D16
> inode=3D0x1cff3828 | inodepin 0x1b9f4de0]
> 2012-02-01 17:21:51.349521 4f830b70 mds.0.cache.dir(100000066ae) [den=
try
> #1/tiny14/.config/pcmanfm/LXDE.conf [2,head] auth (dn xlock x=3D1 by
> 0x1ab21200) (dversion lock w=3D1 last_client=3D5313) pv=3D17 v=3D16 a=
p=3D2+2
> inode=3D0x1d13c600 | request lock inodepin authpin 0x1b90f064]
> 2012-02-01 17:21:51.349552 4f830b70 mds.0.cache.dir(100000066ae) mism=
atch
> between child accounted_rstats and my rstats!
> 2012-02-01 17:21:51.349573 4f830b70 mds.0.cache.dir(100000066ae) tota=
l of
> child dentrys: n(v0 rc2012-02-01 15:19:55.517733 b786 3=3D2+1)
> 2012-02-01 17:21:51.349591 4f830b70 mds.0.cache.dir(100000066ae) my r=
stats:
> n(v3 rc2012-02-01 15:19:55.517733 b393 2=3D1+1)
> 2012-02-01 17:21:51.349616 4f830b70 mds.0.cache.dir(100000066ae) [den=
try
> #1/tiny14/.config/pcmanfm/LXDE [2,head] auth (dversion lock) pv=3D0 v=
=3D16
> inode=3D0x1cff3828 | inodepin 0x1b9f4de0] n(v0 rc2012-02-01 15:19:55.=
517733
> b393 2=3D1+1)
> 2012-02-01 17:21:51.349643 4f830b70 mds.0.cache.dir(100000066ae) [den=
try
> #1/tiny14/.config/pcmanfm/LXDE.conf [2,head] auth (dn xlock x=3D1 by
> 0x1ab21200) (dversion lock w=3D1 last_client=3D5313) pv=3D17 v=3D16 a=
p=3D2+2
> inode=3D0x1d13c600 | request lock inodepin authpin 0x1b90f064] n(v0 b=
393 1=3D1+0)
>
>
> Then killed the active mds, another takes over and suddenly the missi=
ng file
> appears:
> .tmp/tiny14/.config/pcmanfm/LXDE/insgesamt 1
> drwxr-xr-x 1 32252 users 393 =A01. Feb 15:19 .
> drwxr-xr-x 1 32252 users =A0 0 =A01. Feb 17:21 ..
> -rw-r--r-- 1 root =A0root =A0393 24. Jan 15:55 pcmanfm.conf

So were you able to delete that file once it reappeared?

> Restarted the original mds, it does not appear in "ceph mds dump", al=
though it
> is running at 100% cpu. Same happened with other mds processes after =
killing
> and starting, now I have only one left that is working correctly.

Remind me, you do only have one active MDS, correct?
Did you look at the logs and see what the MDS was doing with 100% cpu?

> Will leave the cluster in this state now and have another look tomorr=
ow -
> maybe the spinning mds processes recover by some miracle.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
