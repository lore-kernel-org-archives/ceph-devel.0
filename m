From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD stall when creating and listing images
Date: Mon, 23 Apr 2012 11:03:35 +0200
Message-ID: <4F951AE7.1080707@widodh.nl>
References: <4F929964.8000506@widodh.nl> <Pine.LNX.4.64.1204212132530.29786@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:33066 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab2DWJDi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Apr 2012 05:03:38 -0400
In-Reply-To: <Pine.LNX.4.64.1204212132530.29786@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/22/2012 06:34 AM, Sage Weil wrote:
> On Sat, 21 Apr 2012, Wido den Hollander wrote:
>> Hi,
>>
>> I was just playing with my libvirt driver and I noticed a stall.
>>
>> On one host I had running:
>>
>> for i in {0..8192}; do rbd create --size 64 image-$i; echo "created image-$i";
>> done
>>
>> And on the other host I was running a pool-refresh in libvirt.
>>
>> As I was tailing the libvirt log I noticed that it had stalled, so I checked
>> my other terminal and saw that the creation of new images had also stalled.
>>
>> This situation persisted for about ~20 seconds and then everything started to
>> continue.
>>
>> At the moment of the stall libvirt was calling rbd_list and was not doing any
>> rbd_stat yet.
>>
>> I'm trying to reproduce it here, but I wonder if there is a logical
>> explanation for this situation?
>>
>> I'm running 0.44 on my cluster and 0.45 on the client btw.
>
> Nothing comes to mind.. unless libvirt is doing something silly on
> pool-refresh and actually modifies each image header (which would make
> users stop and refresh).
>

No, it doesn't. This is the libvirt code: 
https://github.com/wido/libvirt/blob/rbd/src/storage/storage_backend_rbd.c#L312

> If you can reproduce this with some logs (ideally the stalling client),
> I'd love to see what's going on.

I think a "rbd ls" on one host and "rbd create" on another host should 
give the same result.

I'll try with that and see what comes out of it.

Wido

>
> sage
