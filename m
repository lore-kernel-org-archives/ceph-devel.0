From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Thu, 2 Dec 2010 09:38:04 +0800
Message-ID: <1291253884.1757.10.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	 <1291085741.1809.25.camel@cephhost>
	 <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
	 <1291097975.1809.54.camel@cephhost>
	 <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
	 <1291167344.1809.60.camel@cephhost>	<1291186785.1809.91.camel@cephhost>
	 <AANLkTinyWUoppSj9QjL+4qBUpKG0Nk5KJZuGN3rv0Vhe@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:58015 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756695Ab0LBBg5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 20:36:57 -0500
In-Reply-To: <AANLkTinyWUoppSj9QjL+4qBUpKG0Nk5KJZuGN3rv0Vhe@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>



=E5=9C=A8 2010-12-02=E5=9B=9B=E7=9A=84 00:05 +0800=EF=BC=8CGregory Farn=
um=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Nov 30, 2010 at 10:57 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > Hi ,greg,
> >
> > With your suggestions, i add the journal config:
> > "
> > osd data =3D /opt/ceph/data/osd$id
> > osd journal =3D /home/transoft/data/osd$id/journal
> > filestore journal writeahead =3D true
> > osd journal size =3D 10000
> > "
> > to ceph.conf.  the  detail ceph.conf attached below.
> >
> > then , run six times for the commad: "$ sudo ceph osd tell 0/1 benc=
h" ,get
> > the results:
> >
> >
> > $ sudo ceph -w
> >
> > osd0 172.16.10.42:6800/17347 1 : [INF] bench: wrote 1024 MB in bloc=
ks of
> > 4096 KB in 29.818194 sec at 28201 KB/sec
> > osd0 172.16.10.42:6800/17347 2 : [INF] bench: wrote 1024 MB in bloc=
ks of
> > 4096 KB in 30.013058 sec at 34801 KB/sec
> > osd0 172.16.10.42:6800/17347 3 : [INF] bench: wrote 1024 MB in bloc=
ks of
> > 4096 KB in 30.463511 sec at 30274 KB/sec
> >
> > osd1 172.16.10.65:6800/4845 1 : [INF] bench: wrote 1024 MB in block=
s of 4096
> > KB in 165.067603 sec at 6329 KB/sec
> > osd1 172.16.10.65:6800/4845 2 : [INF] bench: wrote 1024 MB in block=
s of 4096
> > KB in 181.034333 sec at 5782 KB/sec
> > osd1 172.16.10.65:6800/4845 3 : [INF] bench: wrote 1024 MB in block=
s of 4096
> > KB in 196.055812 sec at 5334 KB/sec
> >
> > and i also use "dd" to test raw drive, get the logs:
> >
> > 1. OSD0, mkfs.btrfs format /opt
> >
> > $ sudo dd if=3D/dev/zero of=3D/opt/dd.img bs=3D2M count=3D1024
> > 1024+0 records in
> > 1024+0 records out
> > 2147483648 bytes transfered in 21.4497 secs(100 MB/sec)
> >
> > 2. OSD1 ,mkfs. btrfs format /opt
> >
> > ~$ sudo dd if=3D/dev/zero of=3D/opt/dd.img bs=3D2M count=3D1024
> > 1024+0 records in
> > 1024+0 records out
> > 2147483648 bytes transfered in 48.2037 secs(44.6 MB/sec)
> >
> > with these logs, OSD1 disk speed might limit the  test performance.
> Yes, it looks to me like your OSD1 disk isn't working properly.
> Switching it from one streaming write to two streaming writes
> shouldn't reduce it to 20% of its original performance (~45MB/s to
> 5MB/s*2). The same change in tasks doesn't impact OSD0's disk at all.
>=20
Hi greg, thank you for your detail comments.


> > and i also detect a issue ,take the following steps:
> >
> > $. mckephfs -c ceph.conf -v --mkbtrfs -a
> > $  init-ceph - ceph.conf --btrfs -v -a start
> > then execute:
> > $  init-ceph - ceph.conf --btrfs -v -a stop
> >
> > this command can't stop OSD0 and OSD1 cosd process:
> > OSD0:
> > /usr/local/bin/cosd -i 0 -c ceph.conf
> > OSD1:
> > /usr/local/bin/cosd -i 1 -c ceph.conf
> Not sure I understand what you're doing here. Also, it looks like
> you've got a malformed command there -- you don't specify the "-c"
> option, just the nonexistent "-" option. ;)

Oh,Sorry, i mean that , if i don't create folder "/var/run/ceph" at OSD
hosts manually. Execute the command : "$init-ceph -c ceph.conf --btrfs
-v -a stop " ,which can't auto-kill OSD host cosd process, like this :
OSD0 host:
$ ps -ef | grep cosd
root     13987     1  0 Dec01 ?        00:02:55 /usr/local/bin/cosd -i =
0
-c ceph.conf
OSD1 host:
$ ps -ef | grep cosd
root     14028     1  0 Dec01 ?        00:02:53 /usr/local/bin/cosd -i =
1
-c ceph.conf

I have to execute "kill -9 13987 " and "kill -9 14028" to kill cosd
process manually, or ,next time , it will fail to execute "$ init-ceph
-c ceph.conf --btrfs -v -a start " command.


jeff,wu


















--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
