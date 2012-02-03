From: Josh Pieper <jjp@pobox.com>
Subject: Re: Possible RBD inconsistencies with kvm+Windows 7
Date: Fri, 3 Feb 2012 15:15:52 -0500
Message-ID: <20120203201552.GA6365@rcn.com>
References: <20120203181935.GA4676@rcn.com>
 <4F2C3BBE.6070802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:6788 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab2BCUPz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 15:15:55 -0500
Content-Disposition: inline
In-Reply-To: <4F2C3BBE.6070802@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Josh Durgin wrote:
> On 02/03/2012 10:19 AM, Josh Pieper wrote:
> >I have a Windows 7 guest running under kvm/libvirt with RBD as a
> >backend to a cluster of 3 OSDs.  With this setup, I am seeing behavior
> >that looks suspiciously like disk corruption in the guest VM executing
> >some of our workloads.
> >
> >For instance, in one occurance, there is a python function that
> >recursively deletes a large directory tree while the disk is otherwise
> >loaded.  For us, this occasionally fails because the OS reported that
> >all the files in the directory were deleted, but then reports the
> >directory is not empty when going to remove it.  In another, a simple
> >test application writes new files to a directory every 50ms, then
> >after 6s verifies that at least 3 files were written, also while the
> >disk is under heavy load.
> >
> >We have never ever seen these failures on bare metal, or on kvm
> >instances backed by a LVM volume in years of operation, but they
> >happen every couple of hours with RBD.  Unfortunately, I have been
> >unsuccessful when attempting to create synthetic test cases to
> >demonstrate the inconsistent RBD behavior.
> >
> >Has anyone else seen similar inconsistent RBD behavior, or have ideas
> >how to diagnose further?
> 
> What fs are your osds using? A while ago there was a bug in ext4's
> fiemap that sometimes caused incorrect reads - if you set
> filestore_fiemap_threshold larger than your object size, you can test
> whether fiemap is the problem.

The OSDs are using xfs.  In my testing with 0.40, btrfs had incredible
performance problems after a day or so of operation.  The last I
heard, ext4 could potentially have data loss due to its limited xattr
support.

> Are you using the rbd_writeback_window option? If so, does the
> corruption occur without it?

Yes I was.  In prior tests, performance was abysmal without it.  I
will test without it, but our runs will load the system very
differently when they are going so slowly.

> In any case, a log of this occurring with debug_ms=1 and
> debug_rbd=20 from qemu will tell us if there are out-of-order
> operations happening.

Great, I will attempt to record some.

Regards,
Josh
