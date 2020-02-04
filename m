From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 02/15] rbd: use READ_ONCE() when checking the mapping size
Date: Tue, 4 Feb 2020 08:05:35 +0100
Message-ID: <43e755d9-d7c0-5d0c-436f-220a1c807f85@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
 <20200131103739.136098-3-hare@suse.de>
 <CAOi1vP--6qWHtifpeBVWRYOP8J_CC+fvKOkG7Xdsjoxaa7mrDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP--6qWHtifpeBVWRYOP8J_CC+fvKOkG7Xdsjoxaa7mrDQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On 2/3/20 5:50 PM, Ilya Dryomov wrote:
> On Fri, Jan 31, 2020 at 11:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> The mapping size is changed only very infrequently, so we don't
>> need to take the header mutex for checking; using READ_ONCE()
>> is sufficient here. And it avoids having to take a mutex in the
>> hot path.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/block/rbd.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index db80b964d8ea..792180548e89 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -4788,13 +4788,13 @@ static void rbd_queue_workfn(struct work_struct *work)
>>
>>         blk_mq_start_request(rq);
>>
>> -       down_read(&rbd_dev->header_rwsem);
>> -       mapping_size = rbd_dev->mapping.size;
>> +       mapping_size = READ_ONCE(rbd_dev->mapping.size);
>>         if (op_type != OBJ_OP_READ) {
>> +               down_read(&rbd_dev->header_rwsem);
>>                 snapc = rbd_dev->header.snapc;
>>                 ceph_get_snap_context(snapc);
>> +               up_read(&rbd_dev->header_rwsem);
>>         }
>> -       up_read(&rbd_dev->header_rwsem);
>>
>>         if (offset + length > mapping_size) {
>>                 rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
>> @@ -4981,9 +4981,9 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>         u64 mapping_size;
>>         int ret;
>>
>> -       down_write(&rbd_dev->header_rwsem);
>> -       mapping_size = rbd_dev->mapping.size;
>> +       mapping_size = READ_ONCE(rbd_dev->mapping.size);
>>
>> +       down_write(&rbd_dev->header_rwsem);
>>         ret = rbd_dev_header_info(rbd_dev);
>>         if (ret)
>>                 goto out;
>> @@ -4999,7 +4999,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>         }
>>
>>         rbd_assert(!rbd_is_snap(rbd_dev));
>> -       rbd_dev->mapping.size = rbd_dev->header.image_size;
>> +       WRITE_ONCE(rbd_dev->mapping.size, rbd_dev->header.image_size);
>>
>>  out:
>>         up_write(&rbd_dev->header_rwsem);
> 
> Does this result in a measurable performance improvement?
> 
> I'd rather not go down the READ/WRITE_ONCE path and continue using
> proper locking, especially given that it's only for reads.  FWIW the
> plan is to replace header_rwsem with a spin lock, after refactoring
> header read-in code to use a private buffer instead of reading into
> rbd_dev directly.
> 
Well ... Not sure if I like the spin_lock idea.
Thing is, the mapping size is evaluated exactly _once_ when assembling
the request. So any change to the mapping size just after we've read it
would go unnoticed.

Hence it should be possible to combine both approaches; use READ_ONCE()
to read the mapping size, but use a spin lock for updating it as you
suggested. That way we'll eliminate a lock in the hot path, but would be
getting safe updates.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
