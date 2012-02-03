From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Possible RBD inconsistencies with kvm+Windows 7
Date: Fri, 03 Feb 2012 11:55:42 -0800
Message-ID: <4F2C3BBE.6070802@dreamhost.com>
References: <20120203181935.GA4676@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56698 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab2BCTzn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 14:55:43 -0500
In-Reply-To: <20120203181935.GA4676@rcn.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Pieper <jjp@pobox.com>
Cc: ceph-devel@vger.kernel.org

On 02/03/2012 10:19 AM, Josh Pieper wrote:
> I have a Windows 7 guest running under kvm/libvirt with RBD as a
> backend to a cluster of 3 OSDs.  With this setup, I am seeing behavior
> that looks suspiciously like disk corruption in the guest VM executing
> some of our workloads.
>
> For instance, in one occurance, there is a python function that
> recursively deletes a large directory tree while the disk is otherwise
> loaded.  For us, this occasionally fails because the OS reported that
> all the files in the directory were deleted, but then reports the
> directory is not empty when going to remove it.  In another, a simple
> test application writes new files to a directory every 50ms, then
> after 6s verifies that at least 3 files were written, also while the
> disk is under heavy load.
>
> We have never ever seen these failures on bare metal, or on kvm
> instances backed by a LVM volume in years of operation, but they
> happen every couple of hours with RBD.  Unfortunately, I have been
> unsuccessful when attempting to create synthetic test cases to
> demonstrate the inconsistent RBD behavior.
>
> Has anyone else seen similar inconsistent RBD behavior, or have ideas
> how to diagnose further?

What fs are your osds using? A while ago there was a bug in ext4's
fiemap that sometimes caused incorrect reads - if you set
filestore_fiemap_threshold larger than your object size, you can test
whether fiemap is the problem.

Are you using the rbd_writeback_window option? If so, does the
corruption occur without it?

In any case, a log of this occurring with debug_ms=1 and debug_rbd=20 
from qemu will tell us if there are out-of-order operations happening.

>
> For reference, I am running ceph 0.41, qemu-kvm 1.0 on ubuntu 11.10
> amd64.
>
> Regards,
> Josh

