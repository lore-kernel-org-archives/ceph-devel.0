From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph-osd cpu usage
Date: Fri, 16 Nov 2012 10:11:36 +0100
Message-ID: <50A60348.5080604@profihost.ag>
References: <f23bc508-a0c1-445d-a2bd-062898847507@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51653 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2KPJLq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 04:11:46 -0500
In-Reply-To: <f23bc508-a0c1-445d-a2bd-062898847507@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

Am 16.11.2012 09:41, schrieb Alexandre DERUMIER:
>>> Any other ideas how to reduce ceph-osd while doing randwrite?
>>>
>>> Randread gives me with 3 VMs: 60.000 iops
>>> Randwrite gives me with 3 VMs: 25.000 iops
>
> Great to see that read scale !
Yes that works fine.


> For randwrite, what is the bottleneck now with filestore xattr use omap = true ?
Oh no the result was still with default fsetxattr. Filestore xattr use 
omap added another 20% load an resultet in much lower iops. Seems i 
wasn't clear enough about that.

Stefan
