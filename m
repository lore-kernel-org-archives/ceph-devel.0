From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [Cbt] Bluestore cluster example
Date: Fri, 15 Apr 2016 20:56:23 -0400 (EDT)
Message-ID: <2128927538.12354620.1460768183247.JavaMail.zimbra@redhat.com>
References: <5710D936.9040507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:59629 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbcDPA4Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 20:56:25 -0400
In-Reply-To: <5710D936.9040507@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

Just to clarify.
When I build ceph cluster using vstart.sh adding --bluestore option, "osd objectstore" in global section still has filestore.

Anything missing?

Cheers,
Shinobu

----- Original Message -----
From: "Mark Nelson" <mnelson@redhat.com>
To: "cbt" <cbt@ceph.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Friday, April 15, 2016 9:06:14 PM
Subject: [Cbt] Bluestore cluster example

Hi all,

A couple of folks have asked me how to setup bluestore clusters for 
performance testing.  I personally am using cbt for this, but you should 
be able to use ceph-disk with some other cluster creation method as well.

For CBT, you really don't need to do much.  In the old newstore days, a 
"block" symlink needed to be created in the osd data dir to link to the 
new block device.  CBT did this when the "newstore_block: True" option 
was set in the cluster section of the cbt yaml file.  This isn't really 
needed anymore, as you can now specify the block, db, and wal devices 
directly in your ceph.conf file.  If your partitions are setup properly 
you can create bluestore clusters without having to do anything beyond 
changing the ceph.conf file (with cbt at least).

Here's a very basic example:

[global]
         enable experimental unrecoverable data corrupting features = 
bluestore rocksdb
         osd objectstore = bluestore

[osd.0]
         host = incerta01.front.sepia.ceph.com
         osd data = /tmp/cbt/mnt/osd-device-0-data
         bluestore block path = /dev/disk/by-partlabel/osd-device-0-block
         bluestore block db path = /dev/disk/by-partlabel/osd-device-0-db
         bluestore block wal path = /dev/disk/by-partlabel/osd-device-0-wal


Here we enable the experimental bluestore and rocksdb features, set the 
objectstore to bluestore, and then in the OSD sections manually set the 
osd data, bluestore block, bluestore block db, and bluestore block wal 
paths.  You might be wondering what all of these are for:

osd data <-- very small directory on FS for bootstrapping OSD.
bluestore block <-- where the actual object data lives
bluestore block db path <-- where rocksdb lives
bluestore block wal path <-- where rocksdb writeahead log lives

And that's basically it.  I've uploaded an example partitioning script, 
ceph.conf file, and cbt yaml configuration file based on actual tests 
I'm running to the examples folder that I've actually been using for 
testing here:

https://github.com/ceph/cbt/tree/master/example/bluestore

Thanks,
Mark
_______________________________________________
Cbt mailing list
Cbt@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/cbt-ceph.com
