From: Sage Weil <sage@newdream.net>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Wed, 1 Dec 2010 22:10:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012012209140.606@cobra.newdream.net>
References: <1291001135.1872.106.camel@cephhost>
 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
 <1291085741.1809.25.camel@cephhost> <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
 <1291097975.1809.54.camel@cephhost> <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
 <1291167344.1809.60.camel@cephhost> <1291186785.1809.91.camel@cephhost>
 <AANLkTinyWUoppSj9QjL+4qBUpKG0Nk5KJZuGN3rv0Vhe@mail.gmail.com>
 <1291253884.1757.10.camel@cephhost> <AANLkTikeuWA-MpDAgC3UEx=QsoAMHLzJem87P+X6dWRp@mail.gmail.com>
 <1291260179.1757.51.camel@cephhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1992840723-1291270215=:606"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51668 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab0LBGFg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 01:05:36 -0500
In-Reply-To: <1291260179.1757.51.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1992840723-1291270215=:606
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 2 Dec 2010, Jeff Wu wrote:
> =FF=FF 2010-12-02=FF=FF=FF=FF 10:35 +0800=FF=FFGregory Farnum=FF=FF=FF=FF=
=FF=FF
> > On Wed, Dec 1, 2010 at 5:38 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > >> > and i also detect a issue ,take the following steps:
> > >> >
> > >> > $. mckephfs -c ceph.conf -v --mkbtrfs -a
> > >> > $  init-ceph - ceph.conf --btrfs -v -a start
> > >> > then execute:
> > >> > $  init-ceph - ceph.conf --btrfs -v -a stop
> > >> >
> > >> > this command can't stop OSD0 and OSD1 cosd process:
> > >> > OSD0:
> > >> > /usr/local/bin/cosd -i 0 -c ceph.conf
> > >> > OSD1:
> > >> > /usr/local/bin/cosd -i 1 -c ceph.conf
> > >> Not sure I understand what you're doing here. Also, it looks like
> > >> you've got a malformed command there -- you don't specify the "-c"
> > >> option, just the nonexistent "-" option. ;)
> > >
> > > Oh,Sorry, i mean that , if i don't create folder "/var/run/ceph" at O=
SD
> > > hosts manually. Execute the command : "$init-ceph -c ceph.conf --btrf=
s
> > > -v -a stop " ,which can't auto-kill OSD host cosd process, like this =
:
> > > OSD0 host:
> > > $ ps -ef | grep cosd
> > > root     13987     1  0 Dec01 ?        00:02:55 /usr/local/bin/cosd -=
i 0
> > > -c ceph.conf
> > > OSD1 host:
> > > $ ps -ef | grep cosd
> > > root     14028     1  0 Dec01 ?        00:02:53 /usr/local/bin/cosd -=
i 1
> > > -c ceph.conf
> > >
> > > I have to execute "kill -9 13987 " and "kill -9 14028" to kill cosd
> > > process manually, or ,next time , it will fail to execute "$ init-cep=
h
> > > -c ceph.conf --btrfs -v -a start " command.
> > Ah. I think that /var/run/ceph is where init-ceph stores the PIDs. It
> > ought to be created automatically; if it's not we should fix that.
> > What version of Ceph are you running, and where from? I'd imagine it's
> > being packaged wrong or something.
>=20
> Hi ,
> i download ceph 0.23 from=20
> http://ceph.newdream.net/download/ceph-0.23.tar.gz
>=20
> So , maybe , should i add=20
> "
> [global]
>        pid file =3D /var/run/ceph/$name.pid

That's the default, so no...  I think the problem is that 'make install'=20
does 'mkdir -p /var/run/ceph'.  The .deb and .rpm create the dir, but an=20
install from source does not.  There is probably a similar problem with=20
the osd class tmp dir.

sage
--557981400-1992840723-1291270215=:606--
