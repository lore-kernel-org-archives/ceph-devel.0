From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Facing some basic stability issues
Date: Thu, 10 Mar 2011 16:34:56 +0530
Message-ID: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ctyvXWw6lzRrI+7znfZx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:40539 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751022Ab1CJMuR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2011 07:50:17 -0500
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id C9C6613962
	for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 16:34:56 +0530 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-ctyvXWw6lzRrI+7znfZx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi List,

We are trying to setup a small 3 node ceph testbed.
The basic setup is:

    node1: cmon and mds

    node2: osd1

    node3: osd2

    cl1 and cl2: The clients where ceph filesystem
                 is mounted. We are using it as a
                 standard POSIX filesystem and not
                 using fuse.

    Operating System: All the participating systems
                 have Fedora core 14 as the operating
                 system.

    Underlying Filesystem: We have tried both btrfs and
                 and ext4. For each filesystem type we
                 have tried both with and without journal
                 options.

    Ceph version: 0.25
 
The problem we are facing is:

    The setup goes thru fine. When we copy single files of
    upto 5-6 GB that also is fine. However we get into trouble
    if we untar even small files (e.g. 50 MB). The untar
    process on the client hangs. In fact if any process tries
    to access the ceph mounted filesystem (e.g. doing 'ls -l'),
    the process simply hangs and even the shell gets locked
    up. The only solution seems to be a system reboot.

The ceph.conf file is attached with the mail.

Pl help us solve this problem. I have seen
other postings in this list where people talk
about performance benchmarking but we are
stuck up on this very basic issue.

Thanks in anticipation.

--ajit


--=-ctyvXWw6lzRrI+7znfZx
Content-Disposition: attachment; filename="ceph.conf"
Content-Type: text/plain; name="ceph.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[global]
   
user = root
; where the mdses and osds keep their secret encryption keys
keyring = /home/ceph3/keyring.$name

; monitors
[mon]
;Directory for monitor files
mon data = /home/ceph3/mon$id
debug mon = 5

[mon0]
host = test3
mon addr = 10.200.60.63:6789


[mds]
[mds0]
host = test3
debug mds = 5


; OSDs
[osd]
;osd data is where the btrfs volume will be mounted;
;it will be created if absent
osd data = /home/osd/osd$id
;osd data = /home/osd/


; osd journal is the regular file or device to be used for journaling
osd journal = /home/osd/journal
; If the OSD journal is a file, you need to specify the size. This is specified in MB.
osd journal size = 512
filestore journal writeahead = true
journaler_allow_split_entries = true







debug osd = 10
debug filestore = 10


[osd1]
host = test1
btrfs devs = /dev/cciss/c0d0p3
;devs = /dev/cciss/c0d0p3

[osd2]
host = test2
btrfs devs = /dev/cciss/c0d0p3
;devs = /dev/cciss/c0d0p3



--=-ctyvXWw6lzRrI+7znfZx--

