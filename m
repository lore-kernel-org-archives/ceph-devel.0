From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 10:28:57 +0100
Message-ID: <509B7B59.3050706@profihost.ag>
References: <d0e5e2d7-0ffa-4f0e-8cb8-fa9717cd051e@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59279 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2KHJ3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 04:29:06 -0500
In-Reply-To: <d0e5e2d7-0ffa-4f0e-8cb8-fa9717cd051e@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 08.11.2012 10:05, schrieb Alexandre DERUMIER:
>> Do you have tried to compare virtio-blk and virtio-scsi ?
>>> How to change? Right now i'm using the PVE defaults => scsi-hd.
>
> (virtio-blk is "classic" virtio ;)
>
>>> Do you have tried directly from the host with the rbd kernel module ?
>>> No don't know how to use ;-)
> http://ceph.com/docs/master/rbd/rbd-ko/
> #modprobe rbd
> #sudo rbd map {image-name} --pool {pool-name} --id {user-name}

this gives me also 8000 iops on the host with 3.6 Ghz. So this is the 
same like in KVM.

Stefan
