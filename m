From: Joe Landman <landman@scalableinformatics.com>
Subject: Running into an error with mkcephfs
Date: Fri, 20 Jul 2012 17:45:49 -0400
Message-ID: <5009D18D.6050506@scalableinformatics.com>
Reply-To: landman@scalableinformatics.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ec2-23-23-234-153.compute-1.amazonaws.com ([23.23.234.153]:55191
	"EHLO mail2.scalableinformatics.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753043Ab2GTVvE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Jul 2012 17:51:04 -0400
Received: from mail2.scalableinformatics.com (localhost [127.0.0.1])
	by mail2.scalableinformatics.com (Postfix) with ESMTP id 6824D20C04
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 21:44:36 +0000 (UTC)
Received: from [192.168.1.171] (alamo.scalableinformatics.com [173.10.54.97])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: landman)
	by mail2.scalableinformatics.com (Postfix) with ESMTPSA id 4764720A50
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 21:44:36 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks:

   Setting up a test cluster.  Simple ceph.conf

[global]
  	auth supported = cephx

[mon]
	mon data = /data/mon$id
	debug ms = 1

[mon.0]
	host = n01
	mon addr = 10.202.1.142:6789

[mon.1]
	host = n02
	mon addr = 10.202.1.141:6789

[mon.2]
	host = siflash-ssd
	mon addr = 10.202.1.128:6789

[mds]
	keyring = /data/keyring.$name

[mds.a]
	host = siflash-ssd-1

[osd]
	osd data = /data/1/osd$id
	osd journal = /data/2/osd$id/journal
         osd journal size = 512

[osd.0]
	host = dv4-1


[osd.1]
	host = dv4-2


Following along on the directions: 
http://ceph.com/docs/master/start/quick-start/

mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring

[root@n01 ceph]# mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyringtemp 
dir is /tmp/mkcephfs.W73fq9MYo0
preparing monmap in /tmp/mkcephfs.W73fq9MYo0/monmap
/usr/bin/monmaptool --create --clobber --add 0 10.202.1.142:6789 --add 1 
10.202.1.141:6789 --add 2 10.202.1.128:6789 --print 
/tmp/mkcephfs.W73fq9MYo0/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.W73fq9MYo0/monmap
/usr/bin/monmaptool: generated fsid 3ffcf9f3-f589-4dae-a534-f53daa3bc12c
epoch 0
fsid 3ffcf9f3-f589-4dae-a534-f53daa3bc12c
last_changed 2012-07-19 17:35:14.024091
created 2012-07-19 17:35:14.024091
0: 10.202.1.128:6789/0 mon.2
1: 10.202.1.141:6789/0 mon.1
2: 10.202.1.142:6789/0 mon.0
/usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.W73fq9MYo0/monmap 
(3 monitors)
=== osd.0 ===
pushing conf and monmap to dv4-1:/tmp/mkfs.ceph.26215
2012-07-20 17:38:12.605503 7f30d6d41760 -1  ** ERROR: error creating 
empty object store in /data/1/osd0: (2) No such file or directory
failed: 'ssh root@dv4-1 /sbin/mkcephfs -d /tmp/mkfs.ceph.26215 
--init-daemon osd.0'

Not sure what its having trouble with doing, the code path suggests that 
an mkfs failed (we are using an xfs backing store already built and 
mounted).

OS is Centos 6.3 with a 3.2.[12]3 kernel.  Any clues on what I should 
look for, or try by hand?

Thanks!


-- 
Joseph Landman, Ph.D
Founder and CEO
Scalable Informatics Inc.
email: landman@scalableinformatics.com
web  : http://scalableinformatics.com
        http://scalableinformatics.com/sicluster
phone: +1 734 786 8423 x121
fax  : +1 866 888 3112
cell : +1 734 612 4615

