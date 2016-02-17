From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: [PATCH 2/2] hw/9pfs: fix alignment issue when host
 filesystem block size is larger than client msize
Date: Wed, 17 Feb 2016 15:14:48 +0800
Message-ID: <56C41DE8.2030904@gmail.com>
References: <56C02E4F.6030303@gmail.com> <87y4an8l93.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <87y4an8l93.fsf@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: sage@newdream.net, haomaiwang@gmail.com, gkurz@linux.vnet.ibm.com, gfarnum@redhat.com, mst@redhat.com
List-Id: ceph-devel.vger.kernel.org

Hi Aneesh,

Thank you for reviewing my code, please see my reply in-line.
On 14/2/16 21:38, Aneesh Kumar K.V wrote:
> Jevon Qiao <scaleqiao@gmail.com> writes:
>
>> The following patch is to fix alignment issue when host filesystem block
>> size
>> is larger than client msize.
>>
>> Thanks,
>> Jevon
> That is not the right format to send patch. You can send them as a
> series using git-send-email.
Yes, you're correct. I will send the patches later after I address all 
the technical comments.
>> From: Jevon Qiao <scaleqiao@gmail.com>
>> Date: Sun, 14 Feb 2016 15:11:08 +0800
>> Subject: [PATCH] hw/9pfs: fix alignment issue when host filesystem block
>> size
>>    is larger than client msize.
>>
>> Per the previous implementation, iounit will be assigned to be 0 after the
>> first if statement as (s->msize - P9_IOHDRSZ)/stbuf.f_bsize will be zero
>> when
>> host filesystem block size is larger than msize. Finally, iounit will be
>> equal
>> to s->msize - P9_IOHDRSZ, which is usually not aligned.
>>
>> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
>> ---
>>    hw/9pfs/virtio-9p.c | 19 ++++++++++++++++---
>>    1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
>> index f972731..005d3a8 100644
>> --- a/hw/9pfs/virtio-9p.c
>> +++ b/hw/9pfs/virtio-9p.c
>> @@ -1326,7 +1326,7 @@ out_nofid:
>>    static int32_t get_iounit(V9fsPDU *pdu, V9fsPath *path)
>>    {
>>        struct statfs stbuf;
>> -    int32_t iounit = 0;
>> +    int32_t iounit = 0, unit = 0;
>>        V9fsState *s = pdu->s;
>>
>>        /*
>> @@ -1334,8 +1334,21 @@ static int32_t get_iounit(V9fsPDU *pdu, V9fsPath
>> *path)
>>         * and as well as less than (client msize - P9_IOHDRSZ))
>>         */
>>        if (!v9fs_co_statfs(pdu, path, &stbuf)) {
>> -        iounit = stbuf.f_bsize;
>> -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
>> +    /*
>> +     * If host filesystem block size is larger than client msize,
>> +     * we will use PAGESIZE as the unit. The reason why we choose
>> +     * PAGESIZE is because the data will be splitted in terms of
>> +     * PAGESIZE in the virtio layer. In this case, the final
>> +     * iounit is equal to the value of ((msize/unit) - 1) * unit.
>> +     */
>> +    if (stbuf.f_bsize > s->msize) {
>> +        iounit = 4096;
>> +        unit = 4096;
> What page size it should be guest or host ?. Also why 4096 ?. ppc64 use
> 64K page size.
The data to be read or written will be divided into pieces according to the
size of iounit and msize firstly, and then mapped to pages before being 
added
into virtqueue. Since all these operations happen in the guest side, so the
page size should be guest. Please correct me if I'm wrong.

As for the number 4096, It's the default value in Linux OS. I did not take
other platforms into account, it's my fault. To make it suitable for all 
platforms,
shall I use the function getpagesize() here?

Thanks,
Jevon
>> +    } else {
>> +            iounit = stbuf.f_bsize;
>> +        unit = stbuf.f_bsize;
>> +    }
>> +        iounit *= (s->msize - P9_IOHDRSZ)/unit;
>>        }
>>        if (!iounit) {
>>            iounit = s->msize - P9_IOHDRSZ;
>> -- 
> -aneesh
>
