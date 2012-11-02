From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD trim / unmap support?
Date: Fri, 02 Nov 2012 09:20:03 +0100
Message-ID: <50938233.9090902@profihost.ag>
References: <509306CC.5080307@profihost.ag> <5093078C.4020404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40298 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2KBIUO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 04:20:14 -0400
In-Reply-To: <5093078C.4020404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 02.11.2012 00:36, schrieb Josh Durgin:
> On 11/01/2012 04:33 PM, Stefan Priebe wrote:
>> Hello list,
>>
>> does rbd support trim / unmap? Or is it planned to support it?
>>
>> Greets,
>> Stefan
>
> librbd (and thus qemu) support it. The rbd kernel module does not yet.
> See http://ceph.com/docs/master/rbd/qemu-rbd/#enabling-discard-trim

Thanks! Is there any recommanded value for discard_granularity? With 
fstrim and iscsi i use 128kb.

Stefan
