From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: KVM/RBD Block device hangs
Date: Mon, 21 May 2012 22:51:14 +0200
Message-ID: <4FBAAAC2.3020600@profihost.ag>
References: <4FBA54E2.3000703@profihost.ag> <4FBA559D.7040902@widodh.nl> <4FBA5647.40101@profihost.ag> <4FBA584F.7070406@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:43386 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2EUUvT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:51:19 -0400
In-Reply-To: <4FBA584F.7070406@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 21.05.2012 16:59, schrieb Wido den Hollander:
> Probably after, but both is fine. I just want to know how your cluster
> is doing and what the PG states are.
will do so.

dmesg says at least:
[ 4975.850765] ceph-osd[6226]: segfault at 439d34000 ip 00007f0db39bfb23 
sp 00007f0da8c5e240 error 4 in libtcmalloc.so.0.0.0[7f0db399b000+3d000]

Stefan
