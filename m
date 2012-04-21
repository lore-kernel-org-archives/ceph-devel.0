From: Wido den Hollander <wido@widodh.nl>
Subject: RBD stall when creating and listing images
Date: Sat, 21 Apr 2012 13:26:28 +0200
Message-ID: <4F929964.8000506@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:44780 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab2DUL0b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Apr 2012 07:26:31 -0400
Received: from [IPv6:2a00:f10:11c:ab:52e5:49ff:fec2:c976] (unknown [IPv6:2a00:f10:11c:ab:52e5:49ff:fec2:c976])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPA id 3A3EF7619A
	for <ceph-devel@vger.kernel.org>; Sat, 21 Apr 2012 13:26:29 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I was just playing with my libvirt driver and I noticed a stall.

On one host I had running:

for i in {0..8192}; do rbd create --size 64 image-$i; echo "created 
image-$i"; done

And on the other host I was running a pool-refresh in libvirt.

As I was tailing the libvirt log I noticed that it had stalled, so I 
checked my other terminal and saw that the creation of new images had 
also stalled.

This situation persisted for about ~20 seconds and then everything 
started to continue.

At the moment of the stall libvirt was calling rbd_list and was not 
doing any rbd_stat yet.

I'm trying to reproduce it here, but I wonder if there is a logical 
explanation for this situation?

I'm running 0.44 on my cluster and 0.45 on the client btw.

Wido
