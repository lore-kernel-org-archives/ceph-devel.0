From: Sage Weil <sweil@redhat.com>
Subject: bluestore, and how to handle buggy kernels
Date: Sun, 6 Nov 2016 15:59:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611061550170.18089@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbcKFQAC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 6 Nov 2016 11:00:02 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "sepia@ceph.com" <sepia@ceph.com>, zcerza@redhat.com

Under load BlueStore triggers this bug

	http://www.gossamer-threads.com/lists/linux/kernel/1993181

in 3.13.0-100-generic, the original trusty 14.04 kernel.  We currently do 
most of the Ceph testing on trusty, xenial, and centos 7.x, and we use the 
default/original distro kernels (vs the latest ones) exactly so that we 
notice when kernel bugs like this rear their heads.

(We had an embarassing problem with firefly where a bug in the old precise 
12.04 kernel affected users but we were testing with the latest ubuntu 
kernel.)

Anyway, that's good and all, but the question is how to deal with it now 
that we know this kernel is problematic.

1) Reproduce the aio bug reproducer in the OSD, and refuse to start if the 
host kernel is buggy.

2) Same as 1, but only if bluestore is enabled.  (This shouldn't affect 
the aio we use for the FileStore journal bc we never have 128 IOs in 
flight.)

Assuming we do one of those, we'll also need to stop using this kernel in 
the QA environment because it will fail.  That makes me lean towards (1).

Zack, this means we'll need to do something different with the kernel task 
so that we avoid using this particular kernel for the 'distro' kernel.  
Which, in turn, means we may want to rethink how that currently works, 
since there are a whole range of kernels that users might have installed 
on an LTS ubuntu release (or a centos 7.x release).  I wonder if we should 
have a list of possible kernels that will be used and pick one at random 
or something so that we get some coverage?  E.g., for centos, we might 
want to do either the latest or any of the initial kernels bundled with 
each of the 7.x releases (which are probably the most likely ones to be 
installed).

Thoughts?
sage
