From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH] rbd: implement REQ_OP_WRITE_ZEROES
Date: Wed, 24 May 2017 15:34:46 -0400
Message-ID: <CA+aFP1DKTV2Q_5z4sBAa-6X+gJL2CKrg0=Od=RoGQuAY6hFH-A@mail.gmail.com>
References: <1495552107-1237-1-git-send-email-idryomov@gmail.com>
 <CA+aFP1CMXuVFn80iFMX_5XJKgBCeG91438Na5TD6yj_4v4jmgg@mail.gmail.com>
 <1952072407.12977460.1495625908099.JavaMail.zimbra@oxygem.tv>
 <CA+aFP1BYCnxeCL6PJO1crAFsDFciuH9X7c5pB02Yd4PZKjZQtA@mail.gmail.com> <274721074.13000578.1495647514038.JavaMail.zimbra@oxygem.tv>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36101 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936992AbdEXTes (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 15:34:48 -0400
Received: by mail-yw0-f182.google.com with SMTP id b68so94171778ywe.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 12:34:47 -0700 (PDT)
In-Reply-To: <274721074.13000578.1495647514038.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>

On Wed, May 24, 2017 at 1:38 PM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
>>>I just opened a tracker ticket for this [1]
>>>
>>>[1] http://tracker.ceph.com/issues/20070
>
> Thanks Jason!
>
>>>-- let me know if you have
>>>any other QEMU improvement ideas.
>
> For the moment, the bigger limitation is cpu usage of librbd,
> as qemu can only 1 thread, I can't reach more than around 70000 iops by disk.
> (3,1ghz cpu, disabling debug, rbd_cache, using jemalloc).
>
> So any improvement to reduce cpu usage could be great :)

We've had some interest expressed in volunteering time and code
contributions to reduce the CPU usage of librbd / librados. I am
hoping some of these improvements will be included in the Mimic
release.

> Also, in the future, I think qemu will support multiple iothreads by disk,
> I don't known if librbd is already ready for this ?

This is hopefully another improvement we can make in the Mimic release
timeframe. librbd already has an architecture to support multiple
internal IO threads, but we have it disabled for now due to lack of
thorough testing -- and for the fact that librados needs to utilize
multiple IO threads as well.

>
>
> ----- Mail original -----
> De: "Jason Dillaman" <jdillama@redhat.com>
> À: "aderumier" <aderumier@odiso.com>
> Cc: "Ilya Dryomov" <idryomov@gmail.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.com>
> Envoyé: Mercredi 24 Mai 2017 13:53:40
> Objet: Re: [PATCH] rbd: implement REQ_OP_WRITE_ZEROES
>
> I just opened a tracker ticket for this [1] -- let me know if you have
> any other QEMU improvement ideas.
>
> [1] http://tracker.ceph.com/issues/20070
>
> On Wed, May 24, 2017 at 7:38 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
>> Hi,
>>
>> is it planned to implement write zeroes in qemu rbd block driver soon ?
>> (bdrv_co_write_zeroes)
>>
>> It's really missing currently, as qemu drive-mirror need it to have sparse images on copy.
>>
>> Ref from my discussion with Paolo from redhat in 2014 about this:
>> https://lists.gnu.org/archive/html/qemu-devel/2014-10/msg01274.html
>>
>>
>> REgards,
>>
>> Alexandre
>>
>> ----- Mail original -----
>> De: "Jason Dillaman" <jdillama@redhat.com>
>> À: "Ilya Dryomov" <idryomov@gmail.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.com>
>> Envoyé: Mardi 23 Mai 2017 20:28:00
>> Objet: Re: [PATCH] rbd: implement REQ_OP_WRITE_ZEROES
>>
>> lgtm
>>
>> Reviewed-by: Jason Dillaman <dillaman@redhat.com>
>>
>> On Tue, May 23, 2017 at 11:08 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>> Commit 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
>>> explicitly didn't implement REQ_OP_WRITE_ZEROES for rbd, while the
>>> following commit 48920ff2a5a9 ("block: remove the discard_zeroes_data
>>> flag") dropped ->discard_zeroes_data in favor of REQ_OP_WRITE_ZEROES.
>>>
>>> rbd does support efficient zeroing via CEPH_OSD_OP_ZERO opcode and will
>>> release either some or all blocks depending on whether the zeroing
>>> request is rbd_obj_bytes() aligned. This is how we currently implement
>>> discards, so REQ_OP_WRITE_ZEROES can be identical to REQ_OP_DISCARD for
>>> now. Caveats:
>>>
>>> - REQ_NOUNMAP is ignored, but AFAICT that's true of at least two other
>>> current implementations - nvme and loop
>>>
>>> - there is no ->write_zeroes_alignment and blk_bio_write_zeroes_split()
>>> is hence less helpful than blk_bio_discard_split(), but this can (and
>>> should) be fixed on the rbd side
>>>
>>> In the future we will split these into two code paths to respect
>>> REQ_NOUNMAP on zeroout and save on zeroing blocks that couldn't be
>>> released on discard.
>>>
>>> Fixes: 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
>>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>>> ---
>>> drivers/block/rbd.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 454bf9c34882..c16f74547804 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -4023,6 +4023,7 @@ static void rbd_queue_workfn(struct work_struct *work)
>>>
>>> switch (req_op(rq)) {
>>> case REQ_OP_DISCARD:
>>> + case REQ_OP_WRITE_ZEROES:
>>> op_type = OBJ_OP_DISCARD;
>>> break;
>>> case REQ_OP_WRITE:
>>> @@ -4420,6 +4421,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>>> q->limits.discard_granularity = segment_size;
>>> q->limits.discard_alignment = segment_size;
>>> blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
>>> + blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);
>>>
>>> if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
>>> q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
>>> --
>>> 2.4.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Jason
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason
>



-- 
Jason
