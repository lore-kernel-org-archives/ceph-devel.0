From: Josh Pieper <jjp@pobox.com>
Subject: Re: Possible RBD inconsistencies with kvm+Windows 7
Date: Mon, 2 Apr 2012 10:58:16 -0400
Message-ID: <20120402145816.GB2847@rcn.com>
References: <20120203181935.GA4676@rcn.com>
 <4F2C3BBE.6070802@dreamhost.com>
 <20120203201552.GA6365@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:58723 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab2DBPIN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 11:08:13 -0400
Content-Disposition: inline
In-Reply-To: <20120203201552.GA6365@rcn.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Josh Pieper wrote:
> Josh Durgin wrote:
> > On 02/03/2012 10:19 AM, Josh Pieper wrote:
> > >I have a Windows 7 guest running under kvm/libvirt with RBD as a
> > >backend to a cluster of 3 OSDs.  With this setup, I am seeing behavior
> > >that looks suspiciously like disk corruption in the guest VM executing
> > >some of our workloads.
> > >
> > >For instance, in one occurance, there is a python function that
> > >recursively deletes a large directory tree while the disk is otherwise
> > >loaded.  For us, this occasionally fails because the OS reported that
> > >all the files in the directory were deleted, but then reports the
> > >directory is not empty when going to remove it.  In another, a simple
> > >test application writes new files to a directory every 50ms, then
> > >after 6s verifies that at least 3 files were written, also while the
> > >disk is under heavy load.
> > >
> > >We have never ever seen these failures on bare metal, or on kvm
> > >instances backed by a LVM volume in years of operation, but they
> > >happen every couple of hours with RBD.  Unfortunately, I have been
> > >unsuccessful when attempting to create synthetic test cases to
> > >demonstrate the inconsistent RBD behavior.
> > >
> > >Has anyone else seen similar inconsistent RBD behavior, or have ideas
> > >how to diagnose further?
> > 
> > What fs are your osds using? A while ago there was a bug in ext4's
> > fiemap that sometimes caused incorrect reads - if you set
> > filestore_fiemap_threshold larger than your object size, you can test
> > whether fiemap is the problem.
> 
> The OSDs are using xfs.  In my testing with 0.40, btrfs had incredible
> performance problems after a day or so of operation.  The last I
> heard, ext4 could potentially have data loss due to its limited xattr
> support.
> 
> > Are you using the rbd_writeback_window option? If so, does the
> > corruption occur without it?
> 
> Yes I was.  In prior tests, performance was abysmal without it.  I
> will test without it, but our runs will load the system very
> differently when they are going so slowly.
> 
> > In any case, a log of this occurring with debug_ms=1 and
> > debug_rbd=20 from qemu will tell us if there are out-of-order
> > operations happening.
> 
> Great, I will attempt to record some.

Reponse much delayed.

I have finally gotten around to doing more tests here, now with ceph
0.44.1, although the kvm version is still the same at 1.0.

Disabling the rbd_writeback_window option definitely makes all the
problems clear up.  With it on, I can trigger a failure approximately
2 or 3 times per day, whereas with it off, I have been problem free
for a week now.

I have not yet managed to get our kvm to run with the appropriate
logging parameters.  For various reasons it is a lot easier for our
kvm's to run through libvirt.  I have been passing the
rbd_writeback_window option by just appending a
":rbd_writeback_window=x" to the filename in my libvirt xml file.
Doing the same thing with debug_rbd didn't appear to get the option to
the right place no matter which form I tried.  Is there any secret
easy way to get kvm/qemu rbd debugging options turned on when invoked
through libvirt?

Regards,
Josh Pieper
