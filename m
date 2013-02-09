From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Unable to mount cephfs - can't read superblock
Date: Sat, 09 Feb 2013 20:40:02 +1000
Message-ID: <kf5920$1de$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48674 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab3BIKkR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 05:40:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U47rE-0003AM-Or
	for ceph-devel@vger.kernel.org; Sat, 09 Feb 2013 11:40:32 +0100
Received: from 124-170-93-254.dyn.iinet.net.au ([124.170.93.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 11:40:32 +0100
Received: from a.nielsen by 124-170-93-254.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 11:40:32 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi again,

I'm trying to mount my new Ceph volume on a remote PC using cephfs.  I've 
followed the quick start guide, but when I try to mount the filesystem I get this:

remote$ mount -t ceph 192.168.0.6:6789:/ /mnt/ceph/
mount: 192.168.0.6:6789:/: can't read superblock

remote$ dmesg | tail
[951382.981690] libceph: client4105 fsid aa447ff8-8270-491b-b59e-2735e852eaf5
[951382.983486] libceph: mon0 192.168.0.6:6789 session established

I'm not sure what the problem is.  The osd, mon and mds daemons are running on 
the Ceph host and no traffic is firewalled between the two machines.  I have 
disabled authentication in ceph.conf.  The only issue I can see is this:

cephhost$ ceph health
HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean

I'm not sure what that means as I have only used mkcephfs and then started the 
ceph service.  I haven't actually used it yet so I'm not sure where the 
unclean pgs are coming from.  The underlying filesystem is ext4 though.

I'm a bit stuck as to what to do next.  I can't see why the filesystem won't 
mount remotely, and the troubleshooting docs say unclean pgs are related to 
outages which doesn't seem possible on a newly created volume with only one 
osd/mon/mds instance.

Any pointers would be much appreciated!

Many thanks,
Adam.

