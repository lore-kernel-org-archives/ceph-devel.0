From: Loic Dachary <loic@dachary.org>
Subject: Re: crush_reweight_uniform_bucket documentation
Date: Wed, 25 Jan 2017 06:39:15 +0100
Message-ID: <0ee8e507-a496-41ff-76b7-18b90dee143a@dachary.org>
References: <7b20a259-5918-9180-a544-be43ec937609@dachary.org>
 <alpine.DEB.2.11.1701242341410.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35090 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbdAYFjU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 00:39:20 -0500
In-Reply-To: <alpine.DEB.2.11.1701242341410.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/25/2017 12:43 AM, Sage Weil wrote:
> On Wed, 25 Jan 2017, Loic Dachary wrote:
>> Hi Sage,
>>
>> While documenting crush_reweight_bucket[1] I came accross something that 
>> I don't understand when reweighting uniform buckets[2]. The associated 
>> commit[3] is six years old but maybe your remember why the item_weight 
>> had to be adjusted with the average of the weight of the buckets... but 
>> only if there are more buckets than leaves ?
> 
> I think it's just a half-hearted attempt to Do The Right Thing when the 
> situation is nonsensical.  Uniform buckets are meant to be used with leave 
> (device) items of fixed weight (item_weight).  If you (ab)use them with 
> bucket children, the algorithm can't really do the right thing because it 
> doesn't understand the child bucket weights.  If there are a lot of bucket 
> children it resets item_weight to their average.
> 
> This is probably pointless... we could just remove it, and perhaps warn 
> (or error out?) in CrushCompiler if a uniform bucket child is a 
> non-device.

Understood. http://libcrush.org/main/libcrush/issues/8 was created to track that.

Thanks !

> s
> 
> 
>>
>> Cheers
>>
>> [1] http://libcrush.org/main/libcrush/blob/wip-2-doxygen/crush/builder.h#L111
>> [2] http://libcrush.org/main/libcrush/blob/wip-2-doxygen/crush/builder.c#L1282
>> [3] http://libcrush.org/main/libcrush/commit/60f627f88c6314c5a89bb7119ead907ca8b8ef37
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>>

-- 
Loïc Dachary, Artisan Logiciel Libre
