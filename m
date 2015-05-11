From: Mark Nelson <mnelson@redhat.com>
Subject: Re: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 12:13:33 -0500
Message-ID: <5550E33D.8000909@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com> <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbbEKRNi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 May 2015 13:13:38 -0400
In-Reply-To: <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/11/2015 12:03 PM, Sage Weil wrote:
> On Mon, 11 May 2015, Deneau, Tom wrote:
>> I have noticed the following while running rados bench seq read tests with a 40M object size
>>
>>      single rados bench, 4 concurrent ops,                     bandwidth = 190 MB/s
>>      4 copies of rados bench, 1 concurrent op each,  aggregate bandwidth = 310 MB/s
>>
>> and in fact the single rados bench seems limited to 190, no matter how many concurrent ops.
>>
>> I don't see this kind of behavior with a 4M object size.
>>
>> (The above are with caches dropped on the osd targets)
>>
>> It doesn't seem to be related to the total number of bytes being processed by the single
>> because if I don't drop the caches, both the single rados bench and the 4-copy rados bench
>> get much higher numbers (600 vs. 900) but still the single rados bench appears limited, no matter
>> how many concurrent ops are used.
>>
>> Is there kind of throttling going on by design here?
>
> It might be the librados throttles:
>
> OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max in-flight data (both directions)
> OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max in-flight ios
>
> IIRC these only affect librados.. which would include 'rados bench'.

That's a very good point.  I missed in my first scan that this was 40MB 
objects.  Increasing the objecter_inflight_op_bytes would be an 
interesting experiment.

>
> sage
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
