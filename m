From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [PATCH] rbd block driver fix race between aio completition and
 aio cancel
Date: Thu, 29 Nov 2012 15:32:48 +0100
Message-ID: <50B77210.70009@profihost.ag>
References: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag> <20121129135851.GA13694@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41113 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab2K2Oc5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 09:32:57 -0500
In-Reply-To: <20121129135851.GA13694@stefanha-thinkpad.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, josh.durgin@inktank.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com

Hi,

i hope i've done everything correctly. I've send a new v4 patch.

Am 29.11.2012 14:58, schrieb Stefan Hajnoczi:
> On Thu, Nov 22, 2012 at 11:00:19AM +0100, Stefan Priebe wrote:
>> @@ -406,10 +401,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>>               acb->ret = r;
>>           }
>>       }
>> +    acb->status = 0;
>> +
>
> I suggest doing this in the BH.  The qemu_aio_wait() loop in
> qemu_rbd_aio_cancel() needs to wait until the BH has executed.  By
> clearing status in the BH we ensure that no matter in which order
> qemu_aio_wait() invokes BHs and callbacks, we'll always wait until the
> BH has completed before ending the while loop in qemu_rbd_aio_cancel().
>
>> @@ -737,7 +741,8 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
>>   failed:
>>       g_free(rcb);
>>       s->qemu_aio_count--;
>> -    qemu_aio_release(acb);
>> +    if (!acb->cancelled)
>> +        qemu_aio_release(acb);
>>       return NULL;
>>   }
>
> This scenario is impossible.  We haven't returned the acb back to the
> caller yet so they could not have invoked qemu_aio_cancel().

Greets,
Stefan
