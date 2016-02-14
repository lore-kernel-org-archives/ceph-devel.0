From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: [PATCH] add CephFS support in VirtFS
Date: Sun, 14 Feb 2016 14:41:56 +0800
Message-ID: <56C021B4.4040705@gmail.com>
References: <56C00B60.6000502@gmail.com> <874mdbakzw.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <874mdbakzw.fsf@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, qemu-devel@nongnu.org
Cc: Sage Weil <sage@newdream.net>, haomaiwang@gmail.com, gkurz@linux.vnet.ibm.com, gfarnum@redhat.com, mst@redhat.com
List-Id: ceph-devel.vger.kernel.org

On 14/2/16 14:01, Aneesh Kumar K.V wrote:
>> diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
>> index f972731..385c01d 100644
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
>> +     * we will use AGESIZE as the unit. The reason why we choose
>> +     * AGESIZE is because the data will be splitted in terms of
>> +     * AGESIZE in the virtio layer. In this case, the final
>> +     * iounit is equal to the value of ((msize/unit) - 1) * unit.
>> +     */
>> +    if (stbuf.f_bsize > s->msize) {
>> +        iounit = 4096;
>> +        unit = 4096;
>> +    } else {
>> +            iounit = stbuf.f_bsize;
>> +        unit = stbuf.f_bsize;
>> +    }
>> +        iounit *= (s->msize - P9_IOHDRSZ)/unit;
>>        }
>>        if (!iounit) {
>>            iounit = s->msize - P9_IOHDRSZ;
>> --
>
> Can you split this out as a separate patch ?. Also explain what is
> AGESIZE.
Sure thing. "AGESIZE" is supposed to be "PAGESIZE".

Thanks,
Jevon
> -aneesh
>
