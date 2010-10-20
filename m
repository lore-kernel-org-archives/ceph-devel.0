From: "Jim Schutt" <jaschut@sandia.gov>
Subject: commit ad12d5d5be41ce introduces a mkcephfs regression?
Date: Wed, 20 Oct 2010 09:08:27 -0600
Message-ID: <1287587307.6806.15.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:48628 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0JTPIk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 11:08:40 -0400
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 10BAC4D55DB
	for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 09:08:35 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

Current testing head mkcephfs fails when trying to create
a file system with an osd journal on a partition, rather than
a file, when the journal size is not specified.  It fails like
this:

=== osd.0 === 
scp: /etc/ceph/ceph.conf: Read-only file system
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd data" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd journal" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "keyring" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs path" "/ram/mnt/ceph/disk.00p2"
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs devs" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs options" "noatime"
--- ssh an1  "cd /root ; ulimit -c unlimited ; test -d /ram/mnt/ceph/disk.00p2 || mkdir -p /ram/mnt/ceph/disk.00p2"
Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of known hosts.
--- ssh an1  "cd /root ; ulimit -c unlimited ; test -d /dev/disk/by-path/fc-0:0:00:00p1 || mkdir -p /dev/disk/by-path"
Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of known hosts.
Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of known hosts.
monmap.17120                                                                                                                                                                                 100%  183     0.2KB/s   00:00    
--- ssh an1  "cd /root ; ulimit -c unlimited ; /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.17120 -i 0 --mkfs --osd-data /ram/mnt/ceph/disk.00p2"
Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of known hosts.
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
 ** ERROR: error creating empty object store in /ram/mnt/ceph/disk.00p2: Invalid argument
failed: 'ssh an1 /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.17120 -i 0 --mkfs --osd-data /ram/mnt/ceph/disk.00p2'


The osd.0 part of my ceph.conf looks like this:

; osd daemon common options:
[osd]
        keyring = /ceph/osd/keyring.$name
        osd client message size cap = 67108864
        debug osd = 5

; osd daemon options per instance:
[osd0]
        host = an1
        osd addr = 172.17.40.21
        osd journal = /dev/disk/by-path/fc-0:0:00:00p1
        btrfs devs  = /dev/disk/by-path/fc-0:0:00:00p2
        osd data = /ram/mnt/ceph/disk.00p2
        # Do not attempt btrfs mount until udev link shows up,
        # and make sure mount point exists.
        pre mount command = "until [ -L /dev/disk/by-path/fc-0:0:00:00p2 ]; do sleep 1; done && { [ -d /mnt/ceph/disk.00p2 ] || mkdir /mnt/ceph/disk.00p2; }"


Adding "osd journal size = 104857600" to my ceph.conf
allows mkcephfs to succeed.

Alternatively, reverting commit ad12d5d5be41ce allows mkcephfs to
succeed without specifying the journal size.

Was this change of behavior an intentional part of the 
bugfix, or am I doing something wrong?  

Would it be possible to discover when the journal is a 
partition, and if so query its size?

Thanks -- Jim



