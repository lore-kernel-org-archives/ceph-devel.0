From: Brian Edmonds <mornir@gmail.com>
Subject: ceph performance under xen?
Date: Thu, 28 Jun 2012 07:27:30 -0700
Message-ID: <CAMsVa3t8foWYguozDeFCiHf0jrK6b2+L4pKtU__-G1mTVVHzWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35766 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2F1O1v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 10:27:51 -0400
Received: by qcro28 with SMTP id o28so1154238qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 07:27:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've installed a little, four node Ceph (0.47.2) cluster using Xen
virtual machines for testing, and when I run bonnie against a (kernel
driver) mount of it, it seems to be somewhat flaky (disturbing log
messages, occasional binary deaths), and very slow.  I expected some
slowness, with all the virtualization going on, but when bonnie is
running, simply doing a cd into the mount takes minutes to complete.
Is this to be expected, or is it worth spending time to investigate?
I intend to deploy this on bare metal eventually, but was hoping to
get some operational experience with Ceph before investing the money
in that.

For background, I'm investigating Ceph as a "redundant array of
inexpensive machines" replacement for RAID arrays at home.  I'm
planning eventually to deploy something (even if I have to write it
myself) that works essentially like Google's GFS, with a POSIX,
mountable interface, running on the cheapest machines I can assemble,
so there should be no failures that cannot be dealt with through
obvious and cheap hardware replacement.

Brian.
