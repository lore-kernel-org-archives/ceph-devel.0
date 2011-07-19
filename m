From: Christian Gramsch <christian.gramsch@gmail.com>
Subject: RBD performance poor
Date: Tue, 19 Jul 2011 14:48:39 +0000 (UTC)
Message-ID: <loom.20110719T132334-607@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45473 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab1GSOzJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2011 10:55:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QjBhT-00032Z-4W
	for ceph-devel@vger.kernel.org; Tue, 19 Jul 2011 16:55:07 +0200
Received: from gate.myloc.de ([62.141.47.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 16:55:07 +0200
Received: from christian.gramsch by gate.myloc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 16:55:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'm currently testing Ceph/RBD for usage as a storage-backend for
virtual-machine-volumes.

So I've setup a basic cluster of 9 machines (1 mon, 2 mds, 6 osds) based on the
example configuration found in wiki. Ceph is accessed from dedicated hosts for
virtualization. There is a physical Gigabit-LAN dedicated for Ceph. All osds
have a dedicated hard-disk with one btrfs-volume mounted noatime. The
osd-journal is stored inside this btrfs-volume as suggested in example
configuration. 

When I mount the ceph-volume from the virtualization hosts, I was able to read
and write files very fast. But on rbd-volumes, the same performance is not
reached by far.

I tried it with an image mapped as device /dev/rbd0 and formatted as ext4 and
did performance-testing locally, I also installed an operating-system on the
image directly using qemu-rbd - both experiments give me a rather poor
performance with never more than 3 MB/s.  

I get these different results on exactly the same machine:

root@kvm2:~# mount -t ceph 172.23.42.1:/ /ceph
root@kvm2:~# cd /ceph
root@kvm2:/ceph# dd if=/dev/zero of=testfile bs=4096 count=10000 conv=fdatasync
[...]
40960000 Bytes (41 MB) kopiert, 1,77141 s, 23,1 MB/s
root@kvm2:/ceph# dd if=/dev/zero of=testfile bs=4096 count=10000 conv=fdatasync
[...]
40960000 Bytes (41 MB) kopiert, 1,55054 s, 26,4 MB/s
root@kvm2:/ceph# dd if=/dev/zero of=testfile bs=4096 count=10000 conv=fdatasync
[...]
40960000 Bytes (41 MB) kopiert, 1,51826 s, 27,0 MB/s
root@kvm2:/ceph# cd
root@kvm2:~# umount /ceph
root@kvm2:~# rbd map disk0
root@kvm2:~# mount /dev/rbd0 /ceph
root@kvm2:~# cd /ceph
root@kvm2:/ceph# dd if=/dev/zero of=testfile bs=4096 count=10000 conv=fdatasync
[...]
40960000 Bytes (41 MB) kopiert, 6,85968 s, 6,0 MB/s
[...]
40960000 Bytes (41 MB) kopiert, 7,38783 s, 5,5 MB/s

You see, the performance writing onto the rbd-device is worse, performance
inside virtual machines using qemu-rbd even worser (3-4 MB/s). 

Is there anything I could do to improve performance regarding rbd?
Anything what could be terribly wrong in my setup? 

I found a similar problem mentioned on this mailing-list about a year ago[1],
but it seems that it fizzled out and a concrete problem has not been
acknowledged, but I think there is one.

Regards
Christian Gramsch


[1] http://www.spinics.net/lists/ceph-devel/msg00660.html

