From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Random data corruption in VM, possibly caused by rbd
Date: Thu, 07 Jun 2012 20:04:09 +0200
Message-ID: <21601270.dfB0BsVfyn@pc10>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2128551.d98ZmqMQco"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:45256 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932678Ab2FGSEQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 14:04:16 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 625DD10C866
	for <ceph-devel@vger.kernel.org>; Thu,  7 Jun 2012 20:04:15 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--nextPart2128551.d98ZmqMQco
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I'm using Ceph with RBD to provide network-transparent disk images for KVM-
based virtual servers. The last two days, I've been hunting some weird elusive 
bug where data in the virtual machines would be corrupted in weird ways. It 
usually manifests in files having some random data - usually zeroes - at the 
start before the actual contents that should be in there start.

To track this down, I wrote a simple io tester. It does the following:

- Create 1 Megabyte of random data
- Calculate the SHA256 hash of that data
- Write the data to a file on the harddisk, in a given directory, using the 
hash as the filename
- Repeat until the disk is full
- Delete the last file (because it is very likely to be incompletely written)
- Read and delete all the files just written while checking that their sha256 
sums are equal to their filenames

When running this io tester in a VM that uses a qcow2 file on a local harddisk 
for its virtual disk, no errors are found. When the same VM is running using 
rbd, the io tester finds on average about one corruption every 200 Megabytes, 
reproducably.

(As in an interesting aside, the io tester also prints how long it took to 
read or write 100 MB, and it turns out reading the data back in again is about 
three times slower than writing them in the first place...)

Ceph is version 0.47.2. Qemu KVM is 1.0, compiled with the spec file from 
http://pkgs.fedoraproject.org/gitweb/?p=qemu.git;a=summary
(And compiled after ceph 0.47.2 was installed on that machine, so it would use 
the correct headers...)
Both the Ceph cluster and the KVM host machines are running on Fedora 16, with 
a fairly recent 3.3.x kernel.
The ceph cluster uses btrf for the osd's data dirs. The journal is on a tmpfs. 
(This is not a production setup - luckily.)
The virtual machine is using ext4 as its filesystem.
There were no obvious other problems with either the ceph cluster or the KVM 
host machines.

I have attached a copy of the ceph.conf in use, in case it might be helpful.

This is a huge problem, and any help in tracking it down would be much 
appreciated.

Regards,

	Guido
--nextPart2128551.d98ZmqMQco
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: 7Bit
Content-Type: application/octet-stream; name="ceph.conf"

; global
[global]
	; enable secure authentication
	; auth supported = cephx
        max open files = 131072
        log file = /var/log/ceph/$name.log
        ; log_to_syslog = true        ; uncomment this line to log to syslog
        pid file = /var/run/ceph/$name.pid

; monitors
[mon]
        mon data = /mondata/$name

[mon.alpha]
	host = storage1
	mon addr = 10.6.224.129:6789

[mon.beta]
	host = storage2
	mon addr = 10.6.224.130:6789

[mon.gamma]
	host = storage3
	mon addr = 10.6.224.131:6789

; mds
[mds]
	; where the mds keeps it's secret encryption keys
	keyring = /mdsdata/keyring.$name

[mds.alpha]
	host = storage1

[mds.beta]
	host = storage2

[mds.gamma]
	host = storage3

; osd
[osd]
	osd data = /osddata/$name

	osd journal = /journaldata/$name/journal
	osd journal size = 1000 ; journal size, in megabytes

        ; If you want to run the journal on a tmpfs, disable DirectIO
        journal dio = false

        osd recovery max active = 5

	btrfs devs = /dev/sda5 /dev/sdb5

	keyring = /osddata/$name/keyring

[osd.0]
	host = storage1
	cluster addr = 10.6.224.193
	public addr = 10.6.224.129

[osd.1]
	host = storage2
	cluster addr = 10.6.224.194
	public addr = 10.6.224.130

[osd.2]
	host = storage3
	cluster addr = 10.6.224.195
	public addr = 10.6.224.131

[client]   ; userspace client
;      debug ms = 1
;      debug client = 10


--nextPart2128551.d98ZmqMQco--

