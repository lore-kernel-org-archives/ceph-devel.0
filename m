From: denval re <redenval@gmail.com>
Subject: Re: How can rbd image qos take effect
Date: Wed, 24 Jan 2018 14:19:26 +0800
Message-ID: <CACGTc=GAefFj3PA8Wcz2qSKH+Y1Q8qw+NXfdir2z=cqbavm=KA@mail.gmail.com>
References: <CACGTc=E=dSdB4xWeWevqVu0Zwj1YZvP4XpLy=GOdWjnW6FaimA@mail.gmail.com>
 <6febb369-9985-af8f-8ff2-df7c43c22787@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34004 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbeAXGT1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 01:19:27 -0500
Received: by mail-io0-f178.google.com with SMTP id c17so3634620iod.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 22:19:27 -0800 (PST)
In-Reply-To: <6febb369-9985-af8f-8ff2-df7c43c22787@easystack.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: ceph-devel@vger.kernel.org

As you said, the version of  fio I used is old, I download the latest
source code of fio  and it's works well.
Thanks a lot !

2018-01-24 13:48 GMT+08:00 Dongsheng Yang <dongsheng.yang@easystack.cn>:
> Hi
>
>
> On 24/01/2018 12:23, denval re wrote:
>>
>> Hi,dongsheng (and cc ceph-devel)
>>
>> I've updated my code with ceph master and compiled it, according to
>> the description of pr ''rbd: implement image qos in tokenbucket
>> algorithm",   using the command "rbd image-meta set test
>> conf_rbd_qos_iops_limit IOPS" could  limit the R&W iops of rbd image.
>>
>> Then I use vstart.sh script to start my cluster, but using fio tool
>> with rbd ioengine way to randwrite rbd image, there is no effect to
>> limit IOPS with the above command, Is there something wrong with my
>> operation or is there some other setting that must set?
>
> Did you update your librbd.so with what you compiled?
>
> I think the reason is the fio is still using the old librbd you installed,
> rather than what you compiled.
>
> Yang
>>
>>
>> Any advice will be appreciated.
>> Thank you!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
