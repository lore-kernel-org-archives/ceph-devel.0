From: Amon Ott <a.ott@m-privacy.de>
Subject: Bug #1047 reproduced
Date: Thu, 1 Dec 2011 09:37:36 +0100
Message-ID: <201112010937.37642.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Rzz1OSQX13A3ypp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:34320 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab1LAIhr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Dec 2011 03:37:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id C2E3785ECD
	for <ceph-devel@vger.kernel.org>; Thu,  1 Dec 2011 09:37:46 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 02379-07 for <ceph-devel@vger.kernel.org>;
 Thu,  1 Dec 2011 09:37:40 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id F0CD085ECC
	for <ceph-devel@vger.kernel.org>; Thu,  1 Dec 2011 09:37:39 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 5D21626D7C
	for <ceph-devel@vger.kernel.org>; Thu,  1 Dec 2011 09:37:39 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--Boundary-00=_Rzz1OSQX13A3ypp
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On all four nodes of my test cluster, MDS crashes with a trace like that in=
=20
bug #1047. Example and ceph.conf attached. Ceph server side is from git=20
master, last commit ce6572273943ffdca4b7dc5344152d6c35106a2d.

MDS does not start on any node here, it reliably crashes with that assert.

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_Rzz1OSQX13A3ypp
Content-Type: text/plain;
  charset="iso 8859-15";
  name="ceph.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ceph.conf"

[global]
	pid file = /var/run/ceph/$name.pid
	debug ms = 1
	keyring = /etc/ceph/keyring
	cluster_network = 192.168.111.0/24
[mon]
	mon data = /var/lib/ceph/mon
; Use odd number of monitors, three is good, five or more on big clusters
[mon.0]
	host = tgpro1
	mon addr = 192.168.111.1
[mon.1]
	host = tgpro2
	mon addr = 192.168.111.2
[mon.2]
	host = tgpro3
	mon addr = 192.168.111.3
[mds]
	max mds = 2
[mds.0]
	host = tgpro1
	mds addr = 192.168.111.1
	mds standby replay = true
[mds.1]
	host = tgpro2
	mds addr = 192.168.111.2
	mds standby replay = true
[mds.2]
	host = tgpro3
	mds addr = 192.168.111.3
	mds standby replay = true
[mds.3]
	host = tgpro4
	mds addr = 192.168.111.4
	mds standby replay = true
[osd]
	sudo = true
	osd data = /ceph/data
;	osd journal = /ceph/journal
;	osd journal size = 512
	osd journal = /dev/sda7
	filestore journal = writeahead
[osd.0]
	host = tgpro1
	osd addr = 192.168.111.1
[osd.1]
	host = tgpro2
	osd addr = 192.168.111.2
[osd.2]
	host = tgpro3
	osd addr = 192.168.111.3
[osd.3]
	host = tgpro4
	osd addr = 192.168.111.4

--Boundary-00=_Rzz1OSQX13A3ypp
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="mds-crash-anchor_map.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mds-crash-anchor_map.log"

2011-12-01 09:24:48.852444 486c1b70 -- 192.168.111.4:6802/25235 <== mds.0 192.168.111.4:6802/25235 0 ==== mds_table_request(anchortable query 8 bytes) v1 ==== 0+0+0 (0 0 0) 0x113a5240 con 0x110c0000
mds/AnchorServer.cc: In function 'virtual void AnchorServer::handle_query(MMDSTableRequest*)', in thread '486c1b70'
mds/AnchorServer.cc: 249: FAILED assert(anchor_map.count(curino) == 1)
 ceph version  (commit:)
 1: (AnchorServer::handle_query(MMDSTableRequest*)+0x1c2) [0x10dfd272]
 2: (MDSTableServer::handle_request(MMDSTableRequest*)+0xd4) [0x10dfbb54]
 3: (MDS::handle_deferrable_message(Message*)+0xe01) [0x10b97611]
 4: (MDS::_dispatch(Message*)+0x1ae2) [0x10baf402]
 5: (MDS::ms_dispatch(Message*)+0xa5) [0x10bafac5]
 6: (SimpleMessenger::dispatch_entry()+0x7c9) [0x10ec3fd9]
 7: (SimpleMessenger::DispatchThread::entry()+0x3b) [0x10b83f7b]
 8: (Thread::_entry_func(void*)+0x1c) [0x10e7c3bc]
 9: (()+0x5905) [0x4adfe905]
 10: (clone()+0x5e) [0x4a7968ce]
 ceph version  (commit:)
 1: (AnchorServer::handle_query(MMDSTableRequest*)+0x1c2) [0x10dfd272]
 2: (MDSTableServer::handle_request(MMDSTableRequest*)+0xd4) [0x10dfbb54]
 3: (MDS::handle_deferrable_message(Message*)+0xe01) [0x10b97611]
 4: (MDS::_dispatch(Message*)+0x1ae2) [0x10baf402]
 5: (MDS::ms_dispatch(Message*)+0xa5) [0x10bafac5]
 6: (SimpleMessenger::dispatch_entry()+0x7c9) [0x10ec3fd9]
 7: (SimpleMessenger::DispatchThread::entry()+0x3b) [0x10b83f7b]
 8: (Thread::_entry_func(void*)+0x1c) [0x10e7c3bc]
 9: (()+0x5905) [0x4adfe905]
 10: (clone()+0x5e) [0x4a7968ce]
*** Caught signal (Segmentation fault) **
 in thread 486c1b70
 ceph version  (commit:)
 1: (()+0x4703a3) [0x10f613a3]
 2: [0x4ae40400]
 3: (abort()+0xea) [0x4a6f653a]
reraise_fatal: failed to re-raise signal 11

--Boundary-00=_Rzz1OSQX13A3ypp--
