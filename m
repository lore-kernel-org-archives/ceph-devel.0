From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [RFC PATCH] ceph: fix the debug message for calc_layout
Date: Mon, 3 Feb 2020 18:46:50 +0800
Message-ID: <a032d2e1-e463-e4e7-5583-5c71e52edd96@redhat.com>
References: <20200203040133.39319-1-xiubli@redhat.com>
 <CAOi1vP-pGZ1dBhr_EY8t=jas-16T887HTmtyJuVz70roKiYW1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727309AbgBCKrF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2020 05:47:05 -0500
In-Reply-To: <CAOi1vP-pGZ1dBhr_EY8t=jas-16T887HTmtyJuVz70roKiYW1A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2020/2/3 18:25, Ilya Dryomov wrote:
> On Mon, Feb 3, 2020 at 5:02 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   net/ceph/osd_client.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 108c9457d629..6afe36ffc1ba 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -113,10 +113,11 @@ static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
>>          if (*objlen < orig_len) {
>>                  *plen = *objlen;
>>                  dout(" skipping last %llu, final file extent %llu~%llu\n",
>> -                    orig_len - *plen, off, *plen);
>> +                    orig_len - *plen, off, off + *plen);
>>          }
>>
>> -       dout("calc_layout objnum=%llx %llu~%llu\n", *objnum, *objoff, *objlen);
>> +       dout("calc_layout objnum=%llx, object extent %llu~%llu\n", *objnum,
>> +            *objoff, *objoff + *objlen);
> Hi Xiubo,
>
> offset~length is how extents are printed both on the OSD side and
> elsewhere in the kernel client.

Okay, so my understanding is not correct then.

Thanks.


> Thanks,
>
>                  Ilya
>
