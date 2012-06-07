From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 7 Jun 2012 20:18:52 +0200
Message-ID: <47203FB1-758C-46E9-A49A-6F9896B663DC@profihost.ag>
References: <21601270.dfB0BsVfyn@pc10>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53394 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759608Ab2FGSTA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 14:19:00 -0400
In-Reply-To: <21601270.dfB0BsVfyn@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think the test script would help a lot so others can test too.

Am 07.06.2012 um 20:04 schrieb Guido Winkelmann <guido-ceph@thisisnotatest.de>:

> Hi,
> 
> I'm using Ceph with RBD to provide network-transparent disk images for KVM-
> based virtual servers. The last two days, I've been hunting some weird elusive 
> bug where data in the virtual machines would be corrupted in weird ways. It 
> usually manifests in files having some random data - usually zeroes - at the 
> start before the actual contents that should be in there start.
> 
> To track this down, I wrote a simple io tester. It does the following:
> 
> - Create 1 Megabyte of random data
> - Calculate the SHA256 hash of that data
> - Write the data to a file on the harddisk, in a given directory, using the 
> hash as the filename
> - Repeat until the disk is full
> - Delete the last file (because it is very likely to be incompletely written)
> - Read and delete all the files just written while checking that their sha256 
> sums are equal to their filenames
> 
> When running this io tester in a VM that uses a qcow2 file on a local harddisk 
> for its virtual disk, no errors are found. When the same VM is running using 
> rbd, the io tester finds on average about one corruption every 200 Megabytes, 
> reproducably.
> 
> (As in an interesting aside, the io tester also prints how long it took to 
> read or write 100 MB, and it turns out reading the data back in again is about 
> three times slower than writing them in the first place...)
> 
> Ceph is version 0.47.2. Qemu KVM is 1.0, compiled with the spec file from 
> http://pkgs.fedoraproject.org/gitweb/?p=qemu.git;a=summary
> (And compiled after ceph 0.47.2 was installed on that machine, so it would use 
> the correct headers...)
> Both the Ceph cluster and the KVM host machines are running on Fedora 16, with 
> a fairly recent 3.3.x kernel.
> The ceph cluster uses btrf for the osd's data dirs. The journal is on a tmpfs. 
> (This is not a production setup - luckily.)
> The virtual machine is using ext4 as its filesystem.
> There were no obvious other problems with either the ceph cluster or the KVM 
> host machines.
> 
> I have attached a copy of the ceph.conf in use, in case it might be helpful.
> 
> This is a huge problem, and any help in tracking it down would be much 
> appreciated.
> 
> Regards,
> 
>    Guido
> <ceph.conf>
