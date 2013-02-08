From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: cgroups to prevent OSD from taking down a whole machine
Date: Fri, 8 Feb 2013 17:58:05 +0300
Message-ID: <CABYiri-jGoi6mtM-7YnALKoZwqMf55sO2qjDHof_6NOwFtYakg@mail.gmail.com>
References: <51150FCE.7050501@widodh.nl> <51151128.4060707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:49764 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946365Ab3BHO62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 09:58:28 -0500
Received: by mail-ve0-f172.google.com with SMTP id cz11so3458230veb.3
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 06:58:25 -0800 (PST)
In-Reply-To: <51151128.4060707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 8, 2013 at 6:52 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> I've been thinking about using this for machines where people want to run
> OSDS and VMs on the same nodes.  Keep Ceph and the VMs in separate cgroups
> to help keep them from interfering with each other.
>
> It won't help with memory or QPI/hypertransport throughput (unless you have
> them segmented on different sockets), but it should help in some other
> cases.
>
If we don`t speak on strict memory pinning and related performance
boost, I have no idea how it can matters for cgroups by themselves.

> Mark
>
>
> On 02/08/2013 08:46 AM, Wido den Hollander wrote:
>>
>> Hi,
>>
>> Has anybody tried this yet?
>>
>> Running into the memory leaks during scrubbing[0] I started thinking
>> about a way to limit OSDs to a specific amount of memory.
>>
>> A machine has 32GB of memory, 4 OSDs, so you might want to limit each
>> OSD to 8GB so it can't take the whole machine down and would only kill
>> itself.
>>
>> I think I'll give it a try on a couple of machines, but I just wanted to
>> see if anybody has tried this already or sees any downsides to this?
>>
>> We use cgroups in the CloudStack project (through libvirt) to prevent
>> that a memory leak in one KVM proces can take down a whole hypervisor,
>> it works pretty well there.
>>
>> Suggestions or comments?
>>
>> Wido
>>
>> [0]: http://tracker.ceph.com/issues/3883
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
