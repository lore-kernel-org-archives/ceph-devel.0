From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: ceph next branch: error creating empty object store in /srv/osd.10:
 (22) Invalid argument
Date: Thu, 14 Jun 2012 13:56:55 +0200
Message-ID: <4FD9D187.8030601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:33005 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab2FNL5D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 07:57:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

as i had some problems with the stable branch. Then i wanted to try the 
next branch to look if my problems are solved.

When i wanted to create the ceph FS with the next branch i get this error:

=== osd.10 ===
pushing conf and monmap to ssdstor000:/tmp/mkfs.ceph.3279
2012-06-14 13:54:21.001555 7fea16922780 -1 provided osd id 10 != 
superblock's -1
2012-06-14 13:54:21.001874 7fea16922780 -1  ** ERROR: error creating 
empty object store in /srv/osd.10: (22) Invalid argument
failed: 'ssh root@ssdstor000 /sbin/mkcephfs -d /tmp/mkfs.ceph.3279 
--init-daemon osd.10'

/dev/sdb1 on /srv/osd.10 type xfs 
(rw,noatime,nodiratime,nobarrier,discard,logbufs=8,logbsize=256k)

Stefan
