From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Thu, 2 Dec 2010 11:22:59 +0800
Message-ID: <1291260179.1757.51.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	 <1291085741.1809.25.camel@cephhost>
	 <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
	 <1291097975.1809.54.camel@cephhost>
	 <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
	 <1291167344.1809.60.camel@cephhost>	<1291186785.1809.91.camel@cephhost>
	 <AANLkTinyWUoppSj9QjL+4qBUpKG0Nk5KJZuGN3rv0Vhe@mail.gmail.com>
	 <1291253884.1757.10.camel@cephhost>
	 <AANLkTikeuWA-MpDAgC3UEx=QsoAMHLzJem87P+X6dWRp@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:6516 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756959Ab0LBDVw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 22:21:52 -0500
In-Reply-To: <AANLkTikeuWA-MpDAgC3UEx=QsoAMHLzJem87P+X6dWRp@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>



=E5=9C=A8 2010-12-02=E5=9B=9B=E7=9A=84 10:35 +0800=EF=BC=8CGregory Farn=
um=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Dec 1, 2010 at 5:38 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> >> > and i also detect a issue ,take the following steps:
> >> >
> >> > $. mckephfs -c ceph.conf -v --mkbtrfs -a
> >> > $  init-ceph - ceph.conf --btrfs -v -a start
> >> > then execute:
> >> > $  init-ceph - ceph.conf --btrfs -v -a stop
> >> >
> >> > this command can't stop OSD0 and OSD1 cosd process:
> >> > OSD0:
> >> > /usr/local/bin/cosd -i 0 -c ceph.conf
> >> > OSD1:
> >> > /usr/local/bin/cosd -i 1 -c ceph.conf
> >> Not sure I understand what you're doing here. Also, it looks like
> >> you've got a malformed command there -- you don't specify the "-c"
> >> option, just the nonexistent "-" option. ;)
> >
> > Oh,Sorry, i mean that , if i don't create folder "/var/run/ceph" at=
 OSD
> > hosts manually. Execute the command : "$init-ceph -c ceph.conf --bt=
rfs
> > -v -a stop " ,which can't auto-kill OSD host cosd process, like thi=
s :
> > OSD0 host:
> > $ ps -ef | grep cosd
> > root     13987     1  0 Dec01 ?        00:02:55 /usr/local/bin/cosd=
 -i 0
> > -c ceph.conf
> > OSD1 host:
> > $ ps -ef | grep cosd
> > root     14028     1  0 Dec01 ?        00:02:53 /usr/local/bin/cosd=
 -i 1
> > -c ceph.conf
> >
> > I have to execute "kill -9 13987 " and "kill -9 14028" to kill cosd
> > process manually, or ,next time , it will fail to execute "$ init-c=
eph
> > -c ceph.conf --btrfs -v -a start " command.
> Ah. I think that /var/run/ceph is where init-ceph stores the PIDs. It
> ought to be created automatically; if it's not we should fix that.
> What version of Ceph are you running, and where from? I'd imagine it'=
s
> being packaged wrong or something.

Hi ,
i download ceph 0.23 from=20
http://ceph.newdream.net/download/ceph-0.23.tar.gz

So , maybe , should i add=20
"
[global]
       pid file =3D /var/run/ceph/$name.pid
=2E.............................
"
at ceph.conf ?





> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
