From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: [PATCH 2/2] hw/9pfs: fix alignment issue when host
 filesystem block size is larger than client msize
Date: Fri, 19 Feb 2016 17:32:02 +0800
Message-ID: <56C6E112.8090102@gmail.com>
References: <56C02E4F.6030303@gmail.com> <87y4an8l93.fsf@linux.vnet.ibm.com>
	<56C41DE8.2030904@gmail.com>
	<20160217112419.62c49792@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20160217112419.62c49792@bahia.huguette.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, sage@newdream.net, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, gfarnum@redhat.com
List-Id: ceph-devel.vger.kernel.org

Hi Greg,
>>>> From: Jevon Qiao <scaleqiao@gmail.com>
>>>> Date: Sun, 14 Feb 2016 15:11:08 +0800
>>>> Subject: [PATCH] hw/9pfs: fix alignment issue when host filesystem block
>>>> size
>>>>     is larger than client msize.
>>>>
>>>> Per the previous implementation, iounit will be assigned to be 0 after the
>>>> first if statement as (s->msize - P9_IOHDRSZ)/stbuf.f_bsize will be zero
>>>> when
>>>> host filesystem block size is larger than msize. Finally, iounit will be
>>>> equal
>>>> to s->msize - P9_IOHDRSZ, which is usually not aligned.
>>>>
>>>> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
>>>> ---
>>>>     hw/9pfs/virtio-9p.c | 19 ++++++++++++++++---
> Hmmm I just realize your tree is not up-to-date since hw/9pfs/virtio-9p.c got
> renamed with this recent commit:
>
> commit 60ce86c7140d5ca33d5fd87ce821681165d06b2a
> Author: Wei Liu <wei.liu2@citrix.com>
> Date:   Thu Jan 7 18:42:20 2016 +0000
>
>      9pfs: rename virtio-9p.c to 9p.c
>
> Also 9p.c only contains generic code now, not related to virtio... see below.
The feature was finished before it happened, I'm sorry I did not sync my 
tree up
with master.
>>>>     1 file changed, 16 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
>>>> index f972731..005d3a8 100644
>>>> --- a/hw/9pfs/virtio-9p.c
>>>> +++ b/hw/9pfs/virtio-9p.c
>>>> @@ -1326,7 +1326,7 @@ out_nofid:
>>>>     static int32_t get_iounit(V9fsPDU *pdu, V9fsPath *path)
>>>>     {
>>>>         struct statfs stbuf;
>>>> -    int32_t iounit = 0;
>>>> +    int32_t iounit = 0, unit = 0;
>>>>         V9fsState *s = pdu->s;
>>>>
>>>>         /*
>>>> @@ -1334,8 +1334,21 @@ static int32_t get_iounit(V9fsPDU *pdu, V9fsPath
>>>> *path)
>>>>          * and as well as less than (client msize - P9_IOHDRSZ))
>>>>          */
>>>>         if (!v9fs_co_statfs(pdu, path, &stbuf)) {
>>>> -        iounit = stbuf.f_bsize;
>>>> -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
>>>> +    /*
>>>> +     * If host filesystem block size is larger than client msize,
>>>> +     * we will use PAGESIZE as the unit. The reason why we choose
>>>> +     * PAGESIZE is because the data will be splitted in terms of
>>>> +     * PAGESIZE in the virtio layer. In this case, the final
> ... and here you mention virtio. Does this code really belong here ?
Sorry for confusing you, the comment might not be very clear. Here I mean
the issue I mentioned in another thread with Aneesh. It's not related to 
virtio.
>>>> +     * iounit is equal to the value of ((msize/unit) - 1) * unit.
>>>> +     */
>>>> +    if (stbuf.f_bsize > s->msize) {
>>>> +        iounit = 4096;
>>>> +        unit = 4096;
> This looks weird when reading the initial comment in get_iounit()... is
> iounit a multiple of stbuf.f_bsize in this case ?
Yes, I think so. The stbuf.f_bsize refers to the iounit of backend 
filesystem,
and to comply with the backend is a right way to go always.
>>> What page size it should be guest or host ?. Also why 4096 ?. ppc64 use
>>> 64K page size.
>> The data to be read or written will be divided into pieces according to the
>> size of iounit and msize firstly, and then mapped to pages before being
>> added
>> into virtqueue. Since all these operations happen in the guest side, so the
>> page size should be guest. Please correct me if I'm wrong.
>>
>> As for the number 4096, It's the default value in Linux OS. I did not take
>> other platforms into account, it's my fault. To make it suitable for all
>> platforms,
>> shall I use the function getpagesize() here?
>>
> getpagesize() will return the host page size. If you need the guest page size,
> you should use TARGET_PAGE_SIZE.
> And then you will hit another problem: the 9p.c file is in common-obj and
> cannot contain target specific code...
Well, good to know this, thank you for sharing this.
> Along with the other remark, I'm beginning to think you may need to move this
> to virtio-9p-device.c.
I'll think of this, thank you for the option.

Thanks,
Jevon
>> Thanks,
>> Jevon
>>>> +    } else {
>>>> +            iounit = stbuf.f_bsize;
>>>> +        unit = stbuf.f_bsize;
>>>> +    }
>>>> +        iounit *= (s->msize - P9_IOHDRSZ)/unit;
>>>>         }
>>>>         if (!iounit) {
>>>>             iounit = s->msize - P9_IOHDRSZ;
>>>> --
>>> -aneesh
>>>   
