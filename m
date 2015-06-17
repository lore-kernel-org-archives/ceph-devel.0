From: juncheng bai <baijuncheng@unitedstack.com>
Subject: Re: [PATCH RFC] storage:rbd: make the size of request is equal to
 the, size of the object
Date: Wed, 17 Jun 2015 17:47:51 +0800
Message-ID: <55814247.4090301@unitedstack.com>
References: <557EB47F.6090708@unitedstack.com>	<CAOi1vP9iF6LVGrHsORoYGUkx_Ttqr7gsBUMz7EM--b7asOUPCA@mail.gmail.com>	<557ED1D4.20605@unitedstack.com>	<CAOi1vP_VLVVhoFrJ+ETRa7+o+sAjyHquZR_g2kYdO9n-8jxdoQ@mail.gmail.com>	<557F97CB.6070608@unitedstack.com>	<CAOi1vP-2dqn_FmgCK-1O6M10FHGpEPVxkAKs6SMoUB_kU9X5TQ@mail.gmail.com>	<55800F24.6060100@unitedstack.com>	<CAOi1vP-jnE+1-TA5P2=rGx9Bdoc4fTyp7u0g+QDpksm9RTxAqA@mail.gmail.com>	<55802F46.7020804@unitedstack.com>	<CAOi1vP8=kMQR0=nXC-QtfGPvZGOnByKt4NpSod5HKP57spfN5Q@mail.gmail.com>	<5580E3A0.6050504@unitedstack.com> <CAOi1vP_-N=_2H+39LWjNUv=Ym7jE97FzDiN6eidQPEB0Q2=omQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbgsg2.qq.com ([54.254.200.128]:43924 "EHLO smtpbgsg2.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbbFQJsD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 05:48:03 -0400
In-Reply-To: <CAOi1vP_-N=_2H+39LWjNUv=Ym7jE97FzDiN6eidQPEB0Q2=omQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: idryomov@redhat.com, Alex Elder <elder@linaro.org>, Josh Durgin <josh.durgin@inktank.com>, Guangliang Zhao <lucienchao@gmail.com>, jeff@garzik.org, yehuda@hq.newdream.net, Sage Weil <sage@newdream.net>, elder@inktank.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>



On 2015/6/17 16:24, Ilya Dryomov wrote:
> On Wed, Jun 17, 2015 at 6:04 AM, juncheng bai
> <baijuncheng@unitedstack.com> wrote:
>> Hi.
>> Yeah, you are right, use the default max_segments, the request size can
>> be the object size, because the bi_phys_segments of bio could be recount,
>> there's just a possibility.
>>
>> I want to fully understand the bi_phys_segments, hope you can give me some
>> information, thanks.
>>
>> The test information as shown below:
>> The systemtap script:
>> global greq=0;
>> probe kernel.function("bio_attempt_back_merge")
>> {
>>      greq=pointer_arg(2);
>> }
>>
>> probe kernel.function("bio_attempt_back_merge").return
>> {
>>      printf("after req addr:%p req segments:%d req offset:%lu req
>> length:%lu\n",
>>          greq,
>>          @cast(greq, "request")->nr_phys_segments,
>>          @cast(greq, "request")->__sector * 512,
>>          @cast(greq, "request")->__data_len);
>> }
>>
>> probe kernel.function("blk_mq_start_request")
>> {
>>      printf("req addr:%p nr_phys_segments:%d, offset:%lu len:%lu\n",
>>          pointer_arg(1),
>>          @cast(pointer_arg(1), "request")->nr_phys_segments,
>>          @cast(pointer_arg(1), "request")->__sector * 512,
>>          @cast(pointer_arg(1), "request")->__data_len);
>> }
>>
>> Test command:
>> dd if=/dev/zero  of=/dev/rbd0 bs=4M count=2 oflag=direct seek=100
>>
>> Cast one:
>> blk_queue_max_segments(q, 256);
>>
>> The output of stap:
>> after req addr:0xffff880ff60a08c0 req segments:73 req offset:419430400 req
>> length:2097152
>> after req addr:0xffff880ff60a08c0 req segments:73 req offset:419430400 req
>> length:2097152
>> after req addr:0xffff880ff60a0a80 req segments:186 req offset:421527552 req
>> length:1048576
>> req addr:0xffff880ff60a08c0 nr_phys_segments:73, offset:419430400
>> len:2097152
>> req addr:0xffff880ff60a0a80 nr_phys_segments:186, offset:421527552
>> len:1048576
>> req addr:0xffff880ff60a0c40 nr_phys_segments:232, offset:422576128
>> len:1048576
>>
>> after req addr:0xffff880ff60a0c40 req segments:73 req offset:423624704 req
>> length:2097152
>> after req addr:0xffff880ff60a0c40 req segments:73 req offset:423624704 req
>> length:2097152
>> after req addr:0xffff880ff60a0e00 req segments:186 req offset:425721856 req
>> length:1048576
>> req addr:0xffff880ff60a0c40 nr_phys_segments:73, offset:423624704
>> len:2097152
>> req addr:0xffff880ff60a0e00 nr_phys_segments:186, offset:425721856
>> len:1048576
>> req addr:0xffff880ff60a0fc0 nr_phys_segments:232, offset:426770432
>> len:1048576
>>
>> Case two:
>> blk_queue_max_segments(q, segment_size / PAGE_SIZE);
>>
>> The output of stap:
>> after req addr:0xffff88101c9a0000 req segments:478 req offset:419430400 req
>> length:4194304
>> req addr:0xffff88101c9a0000 nr_phys_segments:478, offset:419430400
>> len:4194304
>>
>> after req addr:0xffff88101c9a0000 req segments:478 req offset:423624704 req
>> length:4194304
>> req addr:0xffff88101c9a0000 nr_phys_segments:478, offset:423624704
>> len:4194304
>>
>> 1.Based on the setting of max_sectors and max_segments, decides the
>>    size of a request.
>> 2.We have already set max_sectors to an object's size, so we should try
>>    to ensure that a request to the size as possible as merge bio.
>
> Yeah, I also tried to explain this in the commit description [1].
> Initially I had BIO_MAX_PAGES in there, and realistically I still think
> it's enough for most cases, but discussion with you made me consider
> readv/writev case and so I changed it in my patch to max_hw_sectors
> (i.e. segment_size / SECTOR_SIZE) - this ensures that max_segments will
> never be a limiting factor even in theory.
>
> [1] https://github.com/ceph/ceph-client/commit/2d8006795564fbc0fa68d75758f605fe9f7a108e
>
> Thanks,
>
>                  Ilya
>
Yeah, I agree with you.

Thanks.
----
juncheng bai


