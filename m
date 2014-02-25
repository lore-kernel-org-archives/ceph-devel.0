From: Wido den Hollander <wido@42on.com>
Subject: Libvirt patches for Ubuntu 14.04
Date: Tue, 25 Feb 2014 11:45:24 +0100
Message-ID: <530C7444.1090206@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:51824 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbaBYKp2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Feb 2014 05:45:28 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: james.page@ubuntu.com

Hi James, Ceph-dev,

Some time ago you manually pushed a patch for libvirt to the 14.04 
repositories, but this patch [0] now made it upstream and will be in 
libvirt 1.2.2.

It's a patch for creating RBD images with format 2 by default.

Another patch [1] of my just got accepted into upstream, it sets timeout 
options for librados to prevent libvirt from locking up when something 
happens to the network or the Ceph cluster where the last one if 
obviously impossible due to the design of Ceph ;-)

Looking at the release schedule [2] for Ubuntu 14.04 I see that there is 
a Beta 1 Freeze planned for Feb 27th and currently libvirt 1.2.1 is in 
the 14.04 repo [3].

Looking at the Ubuntu patches [4] I see that the RBD format 2 patch has 
been backported.

What's the chance of libvirt 1.2.2 making it into 14.04? And is it 
possible that you (also) backport the second patch into 14.04?

[0]: 
http://libvirt.org/git/?p=libvirt.git;a=commitdiff;h=0227889ab0dfbbf16ba0e146800d9efcb631e281
[1]: 
http://libvirt.org/git/?p=libvirt.git;a=commitdiff;h=60f70542f97805af49d656a582be35445046a0c9
[2]: https://wiki.ubuntu.com/TrustyTahr/ReleaseSchedule
[3]: http://packages.ubuntu.com/trusty/libvirt-bin
[4]: 
http://archive.ubuntu.com/ubuntu/pool/main/libv/libvirt/libvirt_1.2.1-0ubuntu9.debian.tar.gz

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
