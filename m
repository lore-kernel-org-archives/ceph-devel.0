From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: Problem with Ceph installation inside Amazon EC2
Date: Tue, 20 Apr 2010 17:41:57 +0200
Message-ID: <1271778117.1905.81.camel@wido-desktop>
References: <1271773294.1905.75.camel@wido-desktop>
	 <201004201718.35784.cray@unix-ag.uni-kl.de>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:51645 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab0DTPlz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Apr 2010 11:41:55 -0400
In-Reply-To: <201004201718.35784.cray@unix-ag.uni-kl.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Baun <cray@unix-ag.uni-kl.de>
Cc: ceph-devel@vger.kernel.org

Hi,

Do you have the following processes running?

- cmon
- cmds
- cosd

And you are trying to mount the Ceph filesystem which is running local
isn't it?

I also experienced some troubles with mounting a local Ceph filesystem,
so i switched to a dedicated client.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Tue, 2010-04-20 at 15:18 +0000, Christian Baun wrote:
> Hi,
>=20
> I have just these logfiles in /var/log/ceph:
>=20
> # ls -l /var/log/ceph/
> total 4
> -rw-r--r-- 1 root root 940 2010-04-20 15:12 ip-10-194-145-203.12134
> lrwxrwxrwx 1 root root  23 2010-04-20 15:12 osd1 -> ip-10-194-145-203=
=2E12134
>=20
> # cat ip-10-194-145-203.12134=20
> 10.04.20 15:12:06.702434 --- opened log /var/log/ceph/ip-10-194-145-2=
03.12134 ---
> ceph version 0.19.1 (7d7f925bcd03630778e36fe633efaf92768925c7)
> 10.04.20 15:12:06.702550 ---- renamed symlink /var/log/ceph/osd1 -> /=
var/log/ceph/osd1.0 ----
> 10.04.20 15:12:06.702573 ---- created symlink /var/log/ceph/osd1 -> i=
p-10-194-145-203.12134 ----
> 10.04.20 15:12:06.702674 7fd59e775720 -- :/12134 messenger.start
> 10.04.20 15:12:06.702726 7fd59e775720 -- :/12134 shutdown complete.
> 10.04.20 15:12:06.702788 7fd59e775720 filestore(/srv/ceph/osd) mkfs i=
n /srv/ceph/osd
> 10.04.20 15:12:06.717191 7fd59e775720 filestore(/srv/ceph/osd) mkfs d=
one in /srv/ceph/osd
> 10.04.20 15:12:06.717467 7fd59e775720 filestore(/srv/ceph/osd) mount =
btrfs TRANS_START ioctl is supported
> 10.04.20 15:12:06.717481 7fd59e775720 filestore(/srv/ceph/osd) mount =
btrfs CLONE_RANGE ioctl is supported
> 10.04.20 15:12:06.717488 7fd59e775720 filestore(/srv/ceph/osd) mount =
detected btrfs
>=20
> There is no mon0 logfile.
>=20
> "ceph -w" says the same as "ceph start"
>=20
> # ceph -w
> 10.04.20 15:14:31.755364 7fc9f7329720 -- :/12154 messenger.start
> 10.04.20 15:14:31.755598 7fc9f7329720 -- :/12154 --> mon0 10.194.145.=
203:6789/0 -- auth(proto 0 30 bytes) -- ?+0 0xc99de0
> 10.04.20 15:14:31.755777 7fc9f45aa710 -- :/12154 >> 10.194.145.203:67=
89/0 pipe(0xc9d2f0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
>=20
> # mount -t ceph 10.194.145.203:/ /mnt/ceph/
> mount: 10.194.145.203:/: can't read superblock
>=20
> Best Regards,
>    Christian=20
>=20
>=20
>=20
>=20
> Am Dienstag, 20. April 2010 schrieb Wido den Hollander:
> > Hi,
> >=20
> > What does "ceph -w" show?
> >=20
> > Do you get some "xauth" messages in your mon0 logfiles?
> >=20
>=20
>=20
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
