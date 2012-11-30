From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [PATCHv5] rbd block driver fix race between aio completition
 and aio cancel
Date: Fri, 30 Nov 2012 09:57:53 +0100
Message-ID: <50B87511.1010100@profihost.ag>
References: <1354225046-9761-1-git-send-email-s.priebe@profihost.ag> <CAJSP0QVoBckEU62zmyW9uDDNK-hU1iV5maDgS-s96PH-6byFLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60854 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab2K3I6E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 03:58:04 -0500
In-Reply-To: <CAJSP0QVoBckEU62zmyW9uDDNK-hU1iV5maDgS-s96PH-6byFLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>

fixed in V6

Am 30.11.2012 09:26, schrieb Stefan Hajnoczi:
> On Thu, Nov 29, 2012 at 10:37 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> @@ -568,6 +562,10 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
>>   {
>>       RBDAIOCB *acb = (RBDAIOCB *) blockacb;
>>       acb->cancelled = 1;
>> +
>> +    while (acb->status == -EINPROGRESS) {
>> +        qemu_aio_wait();
>> +    }
>>   }
>>
>>   static const AIOCBInfo rbd_aiocb_info = {
>> @@ -639,6 +637,7 @@ static void rbd_aio_bh_cb(void *opaque)
>>       acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
>>       qemu_bh_delete(acb->bh);
>>       acb->bh = NULL;
>> +    acb->status = 0;
>>
>>       qemu_aio_release(acb);
>>   }
>
> We cannot release acb in rbd_aio_bh_cb() when acb->cancelled == 1
> because qemu_rbd_aio_cancel() still accesses it.  This was discussed
> in an early version of the patch.
>
> Stefan
>
