From: Thomas Mueller <thomas@chaschperli.ch>
Subject: crush update failure ("corrupt inc osdmap epoch 5 off 50")
Date: Wed, 16 Jun 2010 06:32:46 +0000 (UTC)
Message-ID: <hv9r6e$4tp$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47365 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab0FPGcz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jun 2010 02:32:55 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OOmBC-0003Ed-PQ
	for ceph-devel@vger.kernel.org; Wed, 16 Jun 2010 08:32:54 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 08:32:54 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 08:32:54 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi 

i tried to change data "max_size" to 1 to disable replication for testing.

what i've done (reproducable):

mkcephfs -c /etc/ceph/ceph.conf --mkbtrfs (1mds, 1mon, 2osd (2 phyiscal disks))
start ceph
mount ceph fs
write some files to the mount
ceph osd getcrushmap -o /tmp/crush
crushtool -d /tmp/crush -o /tmp/crush.txt
change data "max_size 10" to "max_size 1" in /tmp/crush.txt
crushtool -c /tmp/crush.txt -o /tmp/crush.new
ceph osd setcrushmap -i /tmp/crush.new (Output:
* read 428 bytes from /tmp/crush.new
* 10.06.16_08:12:57.187556 41223950 monclient(hunting): found mon0
* 10.06.16_08:12:57.188298 mon <- [osd,setcrushmap]
* 10.06.16_08:12:58.303241 mon0 -> 'set crush map' (0)
)


after starting to write a file to the mount, I see these kernel messages :
http://pastebin.com/maVj9daV

ceph / kclient are yesterdays git unstable / unstable-backport versions.
kernel is debian lenny backport 2.6.32.

- Thomas

