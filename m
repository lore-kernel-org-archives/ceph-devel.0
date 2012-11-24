From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [Qemu-devel] [PATCH] rbd block driver fix race between aio completition
 and aio cancel
Date: Sat, 24 Nov 2012 21:21:46 +0100
Message-ID: <50B12C5A.5010804@profihost.ag>
References: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag> <CAAu8pHti5JOzMcAK1P_3HrtxfpQgmeJA84CMRBAO9BF7-X2TEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39062 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2KXUVq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 15:21:46 -0500
In-Reply-To: <CAAu8pHti5JOzMcAK1P_3HrtxfpQgmeJA84CMRBAO9BF7-X2TEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com, josh.durgin@inktank.com

Am 24.11.2012 20:54, schrieb Blue Swirl:
> On Thu, Nov 22, 2012 at 10:00 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> This one fixes a race which qemu had also in iscsi block driver
>> between cancellation and io completition.
>>
>> qemu_rbd_aio_cancel was not synchronously waiting for the end of
>> the command.
>>
>> To archieve this it introduces a new status flag which uses
>> -EINPROGRESS.
>>
>> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
...
>>
>> -    qemu_aio_release(acb);
>> +    if (!acb->cancelled)
>
> Missing braces, please read CODING_STYLE.

Will fix this if the rest is OK. Waiting for Stefan and Paolo.

Stefan
