From: Wido den Hollander <wido@42on.com>
Subject: Internal Qemu snapshots with RBD and libvirt
Date: Thu, 18 Jul 2013 17:21:01 +0200
Message-ID: <51E807DD.5050805@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49775 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756756Ab3GRP2f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Jul 2013 11:28:35 -0400
Received: from [IPv6:2001:980:7936:0:45ad:97de:546b:8fc5] (unknown [IPv6:2001:980:7936:0:45ad:97de:546b:8fc5])
	by websrv.42on.com (Postfix) with ESMTPSA id 83EB4C43F2
	for <ceph-devel@vger.kernel.org>; Thu, 18 Jul 2013 17:21:00 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm working on the RBD integration for CloudStack 4.2 and now I got to 
the point snapshotting.

The "problem" is that CloudStack uses libvirt for snapshotting 
Instances, but Qemu/libvirt also tries to store the memory contents of 
the domain to assure the snapshot is consistent.

So the way libvirt tries to do it is not possible with RBD right now, 
since there is no way to store the internal memory.

I was thinking about using the Java librbd bindings to create the 
snapshot, but that will not be consistent thus not 100% safe, so I'd 
rather avoid that.

How is this done in OpenStack? Or are you facing similar issues?

P.S.: I'm testing with libvirt 1.0.6 from the Ubuntu Cloud Team archive 
with packages for OpenStack Havana.

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
