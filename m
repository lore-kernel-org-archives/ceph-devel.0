From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] hw/9pfs: fix alignment issue when host filesystem block size is larger than client msize
Date: Wed, 17 Feb 2016 20:14:23 +0530
Message-ID: <87h9h7z9a0.fsf@linux.vnet.ibm.com>
References: <56C02E4F.6030303@gmail.com> <87y4an8l93.fsf@linux.vnet.ibm.com> <56C41DE8.2030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:59791 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423553AbcBQOoe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 09:44:34 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 07:44:34 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7D39C19D804E
	for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 07:32:28 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1HEiUeo9896048
	for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 14:44:30 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
	by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1HEetpg004256
	for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 09:40:56 -0500
In-Reply-To: <56C41DE8.2030904@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>, qemu-devel@nongnu.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: mst@redhat.com, gkurz@linux.vnet.ibm.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

Jevon Qiao <scaleqiao@gmail.com> writes:

> Hi Aneesh,
>
> Thank you for reviewing my code, please see my reply in-line.
> On 14/2/16 21:38, Aneesh Kumar K.V wrote:
>> Jevon Qiao <scaleqiao@gmail.com> writes:
>>
>>> The following patch is to fix alignment issue when host filesystem block
>>> size
>>> is larger than client msize.
>>>
>>> Thanks,
>>> Jevon
>> That is not the right format to send patch. You can send them as a
>> series using git-send-email.
> Yes, you're correct. I will send the patches later after I address all 
> the technical comments.
>>> From: Jevon Qiao <scaleqiao@gmail.com>
>>> Date: Sun, 14 Feb 2016 15:11:08 +0800
>>> Subject: [PATCH] hw/9pfs: fix alignment issue when host filesystem block
>>> size
>>>    is larger than client msize.
>>>
>>> Per the previous implementation, iounit will be assigned to be 0 after the
>>> first if statement as (s->msize - P9_IOHDRSZ)/stbuf.f_bsize will be zero
>>> when
>>> host filesystem block size is larger than msize. Finally, iounit will be
>>> equal
>>> to s->msize - P9_IOHDRSZ, which is usually not aligned.
>>>
>>> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
>>> ---
>>>    hw/9pfs/virtio-9p.c | 19 ++++++++++++++++---
>>>    1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
>>> index f972731..005d3a8 100644
>>> --- a/hw/9pfs/virtio-9p.c
>>> +++ b/hw/9pfs/virtio-9p.c
>>> @@ -1326,7 +1326,7 @@ out_nofid:
>>>    static int32_t get_iounit(V9fsPDU *pdu, V9fsPath *path)
>>>    {
>>>        struct statfs stbuf;
>>> -    int32_t iounit = 0;
>>> +    int32_t iounit = 0, unit = 0;
>>>        V9fsState *s = pdu->s;
>>>
>>>        /*
>>> @@ -1334,8 +1334,21 @@ static int32_t get_iounit(V9fsPDU *pdu, V9fsPath
>>> *path)
>>>         * and as well as less than (client msize - P9_IOHDRSZ))
>>>         */
>>>        if (!v9fs_co_statfs(pdu, path, &stbuf)) {
>>> -        iounit = stbuf.f_bsize;
>>> -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
>>> +    /*
>>> +     * If host filesystem block size is larger than client msize,
>>> +     * we will use PAGESIZE as the unit. The reason why we choose
>>> +     * PAGESIZE is because the data will be splitted in terms of
>>> +     * PAGESIZE in the virtio layer. In this case, the final
>>> +     * iounit is equal to the value of ((msize/unit) - 1) * unit.
>>> +     */
>>> +    if (stbuf.f_bsize > s->msize) {
>>> +        iounit = 4096;
>>> +        unit = 4096;
>> What page size it should be guest or host ?. Also why 4096 ?. ppc64 use
>> 64K page size.
> The data to be read or written will be divided into pieces according to the
> size of iounit and msize firstly, and then mapped to pages before being 
> added
> into virtqueue. Since all these operations happen in the guest side, so the
> page size should be guest. Please correct me if I'm wrong.

I am not sure I understand the details correctly. iounit is the size
that we use in client_read to determine the  size in which
we should request I/O from the client. But we still can't do I/O in size
larger than s->msize. If you look at the client side (kernel 9p fs), you
will find

	rsize = fid->iounit;
	if (!rsize || rsize > clnt->msize-P9_IOHDRSZ)
		rsize = clnt->msize - P9_IOHDRSZ;

if your iounit calculation ends up zero, that should be handled
correctly by

    if (!iounit) {
        iounit = s->msize - P9_IOHDRSZ;
    }
    return iounit;


So what is the issue here. ?

-aneesh

