From: Haomai Wang <haomai@xsky.com>
Subject: Re: ceph issue
Date: Fri, 18 Nov 2016 15:19:28 +0800
Message-ID: <CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com> <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0101.outbound.protection.outlook.com ([104.47.126.101]:10698
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751799AbcKRHwd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 18 Nov 2016 02:52:33 -0500
Received: by mail-ua0-f172.google.com with SMTP id 51so163684823uai.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Nov 2016 23:19:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Marov Aleksey <Marov.A@raidix.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi Marov,

Other person also met this problem when using rdma, but it's ok to me.
so plz give more infos to figure it out

On Thu, Nov 17, 2016 at 10:49 PM, Sage Weil <sweil@redhat.com> wrote:
> [adding ceph-devel]
>
> On Thu, 17 Nov 2016, Marov Aleksey wrote:
>> Hello Sage
>>
>> My name is Alex. I need some help with resolving issue with ceph. I have
>> been testing ceph with rdma messenger and I got an error
>>
>> src/log/SubsystemMap.h: 62: FAILED assert(sub < m_subsys.size())
>>
>> I have no idea what it means. I noticed that you was the last one who
>> committed in SubsystemMap.h so I think you have some understanding of this
>> condition in assert
>>
>> bool should_gather(unsigned sub, int level) {
>>   assert(sub < m_subsys.size());
>>   return level <= m_subsys[sub].gather_level ||
>>     level <= m_subsys[sub].log_level;
>> }
>>
>> This error occurs only when I use fio benchmark to test rbd. When I use "rbd
>> bench-write ..."  it is ok. But fio is much mire flexible . In any case I
>> think it is not good to get any assert.
>>
>> Can you explain this for me please, or give a hint where to investigate my
>> trouble.
>
> Can you generate a core file, and then use gdb to capture the output of
> 'thread apply all bt'?
>
> Thanks-
> asge
