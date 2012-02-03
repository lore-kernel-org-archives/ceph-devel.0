From: Josh Pieper <jjp@pobox.com>
Subject: Possible RBD inconsistencies with kvm+Windows 7
Date: Fri, 3 Feb 2012 13:19:35 -0500
Message-ID: <20120203181935.GA4676@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:5635 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2BCSTh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 13:19:37 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a Windows 7 guest running under kvm/libvirt with RBD as a
backend to a cluster of 3 OSDs.  With this setup, I am seeing behavior
that looks suspiciously like disk corruption in the guest VM executing
some of our workloads.

For instance, in one occurance, there is a python function that
recursively deletes a large directory tree while the disk is otherwise
loaded.  For us, this occasionally fails because the OS reported that
all the files in the directory were deleted, but then reports the
directory is not empty when going to remove it.  In another, a simple
test application writes new files to a directory every 50ms, then
after 6s verifies that at least 3 files were written, also while the
disk is under heavy load.

We have never ever seen these failures on bare metal, or on kvm
instances backed by a LVM volume in years of operation, but they
happen every couple of hours with RBD.  Unfortunately, I have been
unsuccessful when attempting to create synthetic test cases to
demonstrate the inconsistent RBD behavior.

Has anyone else seen similar inconsistent RBD behavior, or have ideas
how to diagnose further?

For reference, I am running ceph 0.41, qemu-kvm 1.0 on ubuntu 11.10
amd64.

Regards,
Josh
