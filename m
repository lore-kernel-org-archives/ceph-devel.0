From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Degraded PGs blocking open()?
Date: Tue, 7 Jun 2011 02:37:34 +0200
Message-ID: <201106070237.34854.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OLX7NXluUjBCbex"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:54065 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288Ab1FGAoU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Jun 2011 20:44:20 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by mail.ki.iif.hu (Postfix) with ESMTP id 0E8CB87557
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jun 2011 02:37:39 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id VQ5Z4v3XMbWf for <ceph-devel@vger.kernel.org>;
	Tue,  7 Jun 2011 02:37:36 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id 2D53A87558
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jun 2011 02:37:35 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--Boundary-00=_OLX7NXluUjBCbex
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

I have a three node ceph setup, two nodes playing all three roles (OSD, MDS, 
MON), and one being just a monitor (which happens to be the client I'm using 
the filesystem from).

I want to achieve high availablity by mirroring all data between the OSDs and 
being able to still access everything even if one of them goes down. The 
mirroring works fine, I see the space being consumed on both nodes as I copy 
data on the file system. According to `ceph -s`, all PGs are in active+clean 
state. If I start reading a big file and shut down one of the (OSD+MDS+MON) 
nodes, the file can still be read until the end, that's fine. Moreover, the 
contents read back seem correct when compared to the original file. Very nice. 
But if I start reading the file while one of the nodes is down, it blocks until 
the node comes up again. I can't even kill the reading process with KILL, 
TERM, or INT.

Am I doing something wrong, or was not careful enough reading the docs, or may 
this be a bug? My ceph.conf is attached.

Thanks,
-- 
cc


--Boundary-00=_OLX7NXluUjBCbex
Content-Type: text/plain;
  name="ceph.conf"
Content-Transfer-Encoding: 7bit

[global]
auth supported = cephx
keyring = /etc/ceph/keyring.$name



[mds]

[mds.0]
host = iscsigw1

[mds.1]
host = iscsigw2



[osd]
osd data = /srv/ceph/osd.$id

[osd.0]
host = iscsigw1

[osd.1]
host = iscsigw2



[mon]
mon data = /srv/ceph/mon.$id

[mon.0]
host = iscsigw1
mon addr = <node1_ip>:6789

[mon.1]
host = iscsigw2
mon addr = <node2_ip>:6789

[mon.cc]
host = cc
mon addr = <node3_ip>:6789

--Boundary-00=_OLX7NXluUjBCbex--
