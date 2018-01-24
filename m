From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: How can rbd image qos take effect
Date: Wed, 24 Jan 2018 13:48:37 +0800
Message-ID: <6febb369-9985-af8f-8ff2-df7c43c22787@easystack.cn>
References: <CACGTc=E=dSdB4xWeWevqVu0Zwj1YZvP4XpLy=GOdWjnW6FaimA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m97138.mail.qiye.163.com ([220.181.97.138]:21106 "EHLO
        m97138.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeAXFzH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 00:55:07 -0500
In-Reply-To: <CACGTc=E=dSdB4xWeWevqVu0Zwj1YZvP4XpLy=GOdWjnW6FaimA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: denval re <redenval@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi


On 24/01/2018 12:23, denval re wrote:
> Hi,dongsheng (and cc ceph-devel)
>
> I've updated my code with ceph master and compiled it, according to
> the description of pr ''rbd: implement image qos in tokenbucket
> algorithm",   using the command "rbd image-meta set test
> conf_rbd_qos_iops_limit IOPS" could  limit the R&W iops of rbd image.
>
> Then I use vstart.sh script to start my cluster, but using fio tool
> with rbd ioengine way to randwrite rbd image, there is no effect to
> limit IOPS with the above command, Is there something wrong with my
> operation or is there some other setting that must set?
Did you update your librbd.so with what you compiled?

I think the reason is the fio is still using the old librbd you installed,
rather than what you compiled.

Yang
>
> Any advice will be appreciated.
> Thank you!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


