From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Cannot delete some empty dirs and weird sizes
Date: Fri, 3 Feb 2012 09:24:09 +0100
Message-ID: <201202030924.10732.a.ott@m-privacy.de>
References: <201201311300.20787.a.ott@m-privacy.de> <201202011802.39891.a.ott@m-privacy.de> <CAF3hT9D7dwD8rWipzTFD=CWFWwMNe++x48bOCrFd6NsE749PHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:40368 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605Ab2BCIYV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 03:24:21 -0500
In-Reply-To: <CAF3hT9D7dwD8rWipzTFD=CWFWwMNe++x48bOCrFd6NsE749PHg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Thursday 02 February 2012 wrote Gregory Farnum:
> On Wed, Feb 1, 2012 at 9:02 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > ceph should have recovered here. Might also be caused by this setti=
ng
> > that I tried for a while, it is off now:
> > mds standby replay =3D true
> > With this setting, if the active mds gets killed, no mds is able to
> > become active, so everything hangs. Had to reboot again.
>
> Hrm. That setting simply tells the non-active MDSes that they should
> follow the journal of the active MDS(es). They should still go active
> if the MDS they're following fails =97 although it does slightly
> increase the chances of them running into the same bugs in code and
> dying at the same time.

Well, in this test the following MDS did not become active, it kept stu=
ck in=20
replay mode. As waking up without that following is also fast enough fo=
r us,=20
I quickly turned it off again. Just wanted to mention that there might =
be=20
another bug lurking.

> > Then killed the active mds, another takes over and suddenly the mis=
sing
> > file appears:
> > .tmp/tiny14/.config/pcmanfm/LXDE/insgesamt 1
> > drwxr-xr-x 1 32252 users 393 =A01. Feb 15:19 .
> > drwxr-xr-x 1 32252 users =A0 0 =A01. Feb 17:21 ..
> > -rw-r--r-- 1 root =A0root =A0393 24. Jan 15:55 pcmanfm.conf
>
> So were you able to delete that file once it reappeared?

It got deleted correctly by nightly cleanup cron job.

> > Restarted the original mds, it does not appear in "ceph mds dump",
> > although it is running at 100% cpu. Same happened with other mds
> > processes after killing and starting, now I have only one left that=
 is
> > working correctly.
>
> Remind me, you do only have one active MDS, correct?
> Did you look at the logs and see what the MDS was doing with 100% cpu=
?

=46our MDS defined, but using
max mds =3D 1

> > Will leave the cluster in this state now and have another look tomo=
rrow -
> > maybe the spinning mds processes recover by some miracle.

After yet another complete reboot it seems to be stable again now. So f=
ar I=20
can say that Ceph FS runs pretty stable with the following conditions:
- 4 nodes with each 8 to 12 CPU cores, 12 GB of RAM (CPUs and RAM mostl=
y=20
unused by Ceph)
- Ceph 0.41
- 3 mon, 4 mds (max mds 1), 4 osd, all 4 nodes are both server and clie=
nt
- Kernel 3.1.10 with some hand integrated patches for Ceph fixes (3.2.2=
 was=20
unstable, need to check)
- OSD storage on normal hard drive, ext4 without journal (btrfs crashes=
 about=20
once per day)
- OSD journals on separate SSD
- MDS does not get restarted without reboot (yes, only reboot helps)

=46rom our experience, it could be a bit faster when writing into many =
different=20
files, which is our major work load. However, the last few versions alr=
eady=20
brought significant improvements on stability and speed. The main probl=
em we=20
see is the MDS takeover and recovery, which has given a lot of trouble =
so=20
far.

Thanks once more for your good work!

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
