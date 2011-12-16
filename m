From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: ceph-osd not starting
Date: Fri, 16 Dec 2011 13:23:36 +0100
Message-ID: <4EEB3848.8080202@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:52345 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753639Ab1LPMX2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Dec 2011 07:23:28 -0500
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx03.smart-weblications.de (Postfix) with ESMTPA id 79CCAD6A004
	for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 12:23:26 +0000 (UTC)
Received: from [192.168.200.13] (callosum.office.smart-weblications.net [192.168.200.13])
	by office.smart-weblications.net (Postfix) with ESMTP id BBBA85A877A
	for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 13:23:25 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,


i today upgraded to current git and i am unable to start up ceph-osd:

ceph version 0.39-128-g739fd9f (commit:739fd9fee4be00b7a3912e59bf5ce717=
9b2e54ff)

node01:~# ceph-osd -i 0 --debug_ms 20 -d
2011-12-16 13:19:15.328906 7f27eaa50780 -- :/0 rank.bind :/0
2011-12-16 13:19:15.328957 7f27eaa50780 -- :/0 accepter.bind
2011-12-16 13:19:15.328978 7f27eaa50780 -- :/0 accepter.bind bound on r=
andom
port 0.0.0.0:6801/0
2011-12-16 13:19:15.328987 7f27eaa50780 -- :/0 accepter.bind bound to 0=
=2E0.0.0:6801/0
2011-12-16 13:19:15.329001 7f27eaa50780 -- 0.0.0.0:6801/15163 accepter.=
bind
ms_addr is 0.0.0.0:6801/15163 need_addr=3D1
2011-12-16 13:19:15.329009 7f27eaa50780 -- :/0 rank.bind :/0
2011-12-16 13:19:15.329037 7f27eaa50780 -- :/0 accepter.bind
2011-12-16 13:19:15.329047 7f27eaa50780 -- :/0 accepter.bind bound on r=
andom
port 0.0.0.0:6802/0
2011-12-16 13:19:15.329062 7f27eaa50780 -- :/0 accepter.bind bound to 0=
=2E0.0.0:6802/0
2011-12-16 13:19:15.329082 7f27eaa50780 -- 0.0.0.0:6802/15163 accepter.=
bind
ms_addr is 0.0.0.0:6802/15163 need_addr=3D1
2011-12-16 13:19:15.329088 7f27eaa50780 -- :/0 rank.bind :/0
2011-12-16 13:19:15.329094 7f27eaa50780 -- :/0 accepter.bind
2011-12-16 13:19:15.329106 7f27eaa50780 -- :/0 accepter.bind bound on r=
andom
port 0.0.0.0:6803/0
2011-12-16 13:19:15.329113 7f27eaa50780 -- :/0 accepter.bind bound to 0=
=2E0.0.0:6803/0
2011-12-16 13:19:15.329133 7f27eaa50780 -- 0.0.0.0:6803/15163 accepter.=
bind
ms_addr is 0.0.0.0:6803/15163 need_addr=3D1
 ** WARNING: Ceph is still under development.  Any feedback can be dire=
cted  **
 **          at ceph-devel@vger.kernel.org or http://ceph.newdream.net/=
=2E     **
2011-12-16 13:19:15.329177 7f27eaa50780 ceph version 0.39-128-g739fd9f
(commit:739fd9fee4be00b7a3912e59bf5ce7179b2e54ff), process ceph-osd, pi=
d 15163
starting osd.0 at 0.0.0.0:6801/15163 osd_data /data/ceph/osd /data/ceph=
=2Ejournal
2011-12-16 13:19:15.329197 7f27eaa50780 -- 0.0.0.0:6801/15163 register_=
entity osd.0
2011-12-16 13:19:15.329205 7f27eaa50780 -- 0.0.0.0:6801/15163 register_=
entity
osd.0 at 0.0.0.0:6801/15163
2011-12-16 13:19:15.329212 7f27eaa50780 -- 0.0.0.0:6802/15163 register_=
entity osd.0
2011-12-16 13:19:15.329219 7f27eaa50780 -- 0.0.0.0:6802/15163 register_=
entity
osd.0 at 0.0.0.0:6802/15163
2011-12-16 13:19:15.329225 7f27eaa50780 -- :/0 register_entity osd.0
2011-12-16 13:19:15.329231 7f27eaa50780 -- :/0 register_entity osd.0 at=
 :/0
2011-12-16 13:19:15.329238 7f27eaa50780 -- 0.0.0.0:6803/15163 register_=
entity osd.0
2011-12-16 13:19:15.329245 7f27eaa50780 -- 0.0.0.0:6803/15163 register_=
entity
osd.0 at 0.0.0.0:6803/15163
2011-12-16 13:19:15.329578 7f27eaa50780 filestore(/data/ceph/osd) mount=
 FIEMAP
ioctl is NOT supported
2011-12-16 13:19:15.329599 7f27eaa50780 filestore(/data/ceph/osd) mount=
 detected
btrfs
2011-12-16 13:19:15.329621 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
CLONE_RANGE ioctl is supported
2011-12-16 13:19:15.757027 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_CREATE is supported
2011-12-16 13:19:15.799624 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_DESTROY is supported
2011-12-16 13:19:15.800099 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
START_SYNC got 0 Success
2011-12-16 13:19:15.800110 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
START_SYNC is supported (transid 32479)
2011-12-16 13:19:16.466488 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
WAIT_SYNC is supported
2011-12-16 13:19:16.493199 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_CREATE_V2 got 0 Success
2011-12-16 13:19:16.493209 7f27eaa50780 filestore(/data/ceph/osd) mount=
 btrfs
SNAP_CREATE_V2 is supported
2011-12-16 13:19:16.553787 7f27eaa50780 filestore(/data/ceph/osd) mount=
 found
snaps <976557,976567>
2011-12-16 13:19:16.849830 7f27eaa50780 filestore(/data/ceph/osd) mount=
:
enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and 'fil=
estore
btrfs snap' mode is enabled
2011-12-16 13:19:16.859811 7f27eaa50780 journal _open /data/ceph.journa=
l fd 13:
536870912 bytes, block size 4096 bytes, directio =3D 1
2011-12-16 13:19:16.859835 7f27eaa50780 journal read_entry 282427392 : =
seq
976558 16091 bytes
2011-12-16 13:19:16.859856 7f27eaa50780 journal read_entry 282447872 : =
seq
976559 11995 bytes
2011-12-16 13:19:16.859863 7f27eaa50780 journal read_entry 282464256 : =
seq
976560 5301 bytes
2011-12-16 13:19:16.859868 7f27eaa50780 journal read_entry 282476544 : =
seq
976561 5301 bytes
2011-12-16 13:19:16.859879 7f27eaa50780 journal read_entry 282488832 : =
seq
976562 12427 bytes
2011-12-16 13:19:16.859885 7f27eaa50780 journal read_entry 282509312 : =
seq
976563 5301 bytes
2011-12-16 13:19:16.859896 7f27eaa50780 journal read_entry 282521600 : =
seq
976564 20187 bytes
2011-12-16 13:19:16.859902 7f27eaa50780 journal read_entry 282546176 : =
seq
976565 11995 bytes
2011-12-16 13:19:16.859908 7f27eaa50780 journal read_entry 282562560 : =
seq
976566 5301 bytes
2011-12-16 13:19:16.859913 7f27eaa50780 journal read_entry 282574848 : =
seq
976567 5301 bytes
2011-12-16 13:19:16.860255 7f27eaa50780 journal read_entry 282587136 : =
seq
952091 12427 bytes
2011-12-16 13:19:16.860263 7f27eaa50780 journal read_entry 282587136 : =
seq
952091 12427 bytes
2011-12-16 13:19:16.860272 7f27eaa50780 journal _open /data/ceph.journa=
l fd 13:
536870912 bytes, block size 4096 bytes, directio =3D 1
2011-12-16 13:19:16.860440 7f27eaa50780 FileStore is up to date.
2011-12-16 13:19:16.860524 7f27eaa50780 journal close /data/ceph.journa=
l

There is no warning or error - why is the osd not starting up?


with this version, the osds start up normaly:
ceph version 0.39-61-gd21f4ab (commit:d21f4abc0fb8c22636fb2b0ad81c7defc=
a6137f5)


--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
