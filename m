From: Wido den Hollander <wido@widodh.nl>
Subject: cgroups to prevent OSD from taking down a whole machine
Date: Fri, 08 Feb 2013 15:46:38 +0100
Message-ID: <51150FCE.7050501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:49958 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758622Ab3BHOql (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 09:46:41 -0500
Received: from [IPv6:2a00:f10:113:0:f944:6048:3793:55af] (unknown [IPv6:2a00:f10:113:0:f944:6048:3793:55af])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 7D5F27634A
	for <ceph-devel@vger.kernel.org>; Fri,  8 Feb 2013 15:46:39 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Has anybody tried this yet?

Running into the memory leaks during scrubbing[0] I started thinking 
about a way to limit OSDs to a specific amount of memory.

A machine has 32GB of memory, 4 OSDs, so you might want to limit each 
OSD to 8GB so it can't take the whole machine down and would only kill 
itself.

I think I'll give it a try on a couple of machines, but I just wanted to 
see if anybody has tried this already or sees any downsides to this?

We use cgroups in the CloudStack project (through libvirt) to prevent 
that a memory leak in one KVM proces can take down a whole hypervisor, 
it works pretty well there.

Suggestions or comments?

Wido

[0]: http://tracker.ceph.com/issues/3883
