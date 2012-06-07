From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 07 Jun 2012 12:48:05 -0700
Message-ID: <4FD10575.7010300@inktank.com>
References: <21601270.dfB0BsVfyn@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39071 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab2FGTsJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 15:48:09 -0400
Received: by ghrr11 with SMTP id r11so716226ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 12:48:09 -0700 (PDT)
In-Reply-To: <21601270.dfB0BsVfyn@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/07/2012 11:04 AM, Guido Winkelmann wrote:
> Hi,
>
> I'm using Ceph with RBD to provide network-transparent disk images for KVM-
> based virtual servers. The last two days, I've been hunting some weird elusive
> bug where data in the virtual machines would be corrupted in weird ways. It
> usually manifests in files having some random data - usually zeroes - at the
> start before the actual contents that should be in there start.

I definitely want to figure out what's going on with this.
A few questions:

Are you using rbd caching? If so, what settings?

In either case, does the corruption still occur if you
switch caching on/off? There are different I/O paths here,
and this might tell us if the problem is on the client side.

Another thing to try is turning off sparse reads on the osd by setting
filestore fiemap threshold = 0

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

Those versions should all work.

> The ceph cluster uses btrf for the osd's data dirs. The journal is on a tmpfs.
> (This is not a production setup - luckily.)
> The virtual machine is using ext4 as its filesystem.
> There were no obvious other problems with either the ceph cluster or the KVM
> host machines.

Were there any nodes with osds restarted during the test runs? I wonder
if it's a problem with losing the tmpfs journal.

As Oliver suggested, switching the osd data dir filesystem might help
too.

> I have attached a copy of the ceph.conf in use, in case it might be helpful.
>
> This is a huge problem, and any help in tracking it down would be much
> appreciated.

Agreed, and I'm happy to help.

Josh

> Regards,
>
> 	Guido
