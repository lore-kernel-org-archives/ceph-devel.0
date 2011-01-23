From: Chris Webb <chris@arachsys.com>
Subject: Cloning rados block devices
Date: Sun, 23 Jan 2011 14:07:52 +0000
Message-ID: <20110123140750.GE30531@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:46925 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1AWO1u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Jan 2011 09:27:50 -0500
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Ph0bv-0001t6-16
	for ceph-devel@vger.kernel.org; Sun, 23 Jan 2011 14:08:07 +0000
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a hosting product which consists of qemu-kvm virtual machines backed
by LVM2 logical volumes as virtual drives, accessed either locally or over
iscsi. I'm thinking of migrating in time to a distributed block store, such
as Ceph's rbd or Sheepdog.

One feature I would really like to be able to export to users is an ability
to make copy-on-write clones of virtual hard drives, in a Ceph context
generating a new rbd image from an existing one, or from a snapshot of an
existing image if that's easier.

I've seen Ceph's snapshot support, and in particular the rbd snapshot
support, which lets me make read-only clones of a rados block device.

What I'm after is not quite the same as writeable snapshots, as I'd also
like to be able to offer the user the ability to delete the original block
device independently of the clone, potentially before the clone itself is
deleted, so the clone is properly independent of the source apart from some
shared blocks. (If I stored my images as files in a local btrfs filesystem,
I could get exactly the behaviour I'm imagining by cloning the image file.)

I don't see any mention of a feature like this on the Ceph roadmap, and I'm
not familiar enough with the internal design yet to know whether this is an
easy extension given the book-keeping already in place for snapshots, or
whether what I'm proposing is much harder. Is anyone working on this sort of
thing already, or does the feature even already exist and I've failed to
find it? If not, I'd be very interested in any thoughts on how difficult
this would be to implement given the infrastructure that is already in
place.

Best wishes,

Chris.
