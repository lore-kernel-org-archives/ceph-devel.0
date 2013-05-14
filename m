From: Wido den Hollander <wido@42on.com>
Subject: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 12:16:32 +0200
Message-ID: <51920F00.406@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:58995 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756451Ab3ENKQf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 May 2013 06:16:35 -0400
Received: from [IPv6:2a00:f10:113:0:7cc5:df83:59c0:f2cf] (unknown [IPv6:2a00:f10:113:0:7cc5:df83:59c0:f2cf])
	by websrv.42on.com (Postfix) with ESMTPSA id AB0A3BF650
	for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 12:16:32 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

While working on the CloudStack code for 4.2 I'm running into some 
problems with QCOW2 and RBD format 2.

A quick cap of the problem:

CloudStack stores all the templates on "Secondary Storage" as QCOW2 files.

When a VM is deployed, this image will be copied (once) from Secondary 
Storage to Primary Storage, this is done by qemu-img which does the 
conversion.

When the image is on Primary Storage it will be copied to the 
destination volume and the Instance/VM is started.

In that last step I want to use layering, but the problem is that my 
image is RBD format 1 due to the qemu-img copy.

I can skip the qemu-img copy, but I have to find a way to go from QCOW2 
to RBD format 2 in preferably one step. There is a issue about this in 
the tracker [0], but that won't be finished on time.

Another idea would be to do QCOW2 -> RAW -> RBD format 2, but that extra 
step will take a lot of time. It would also require some temporary 
storage on the hypervisor.

I also thought of creating the RBD image prior to converting to it, but 
that fails, since qemu-img won't let you convert to a already existing 
image.

Any brights ideas? Maybe even doing the QCOW2 -> RAW format in memory? 
In Java?

The goal is to go from QCOW2 to RBD format 2 in one step.

[0]: http://tracker.ceph.com/issues/4897

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
