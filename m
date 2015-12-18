From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Thu, 17 Dec 2015 23:23:16 -0700
Message-ID: <CA+9C14aAAVaaLtjDCjLkc9TSmU=aMh-2iq0xKOb-KEcc9vcuMQ@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
	<CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
	<CAAM7YAnktfNvd-EXU+1Eok4kUafWwnvj+CCGocF7ffTcAt-dsA@mail.gmail.com>
	<CA+9C14bbtBjgOD0hpSfapRrsx+Eg_dYyFfV+uXvgB5X7eRidDg@mail.gmail.com>
	<CA+9C14bMs1u80P3g1D4QsDHHzLy5YUvB+KWmcrKa0o5aX9W38g@mail.gmail.com>
	<CAAM7YAm2r+LVPMpE_GbWCJmE-bdi-uXHyzqAR1JgPMXCSx55pQ@mail.gmail.com>
	<CA+9C14bVgWKMxxOe04qiLW6U+baA_TGbFt9RNjY+wPNMiW_R3w@mail.gmail.com>
	<CAAM7YAkTA9skmSxyEPVnEWAyykg4hsoLwxxjFp2nJgMbJAC8VQ@mail.gmail.com>
	<00b601d13954$5d4a94e0$17dfbea0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36221 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbLRGXR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 01:23:17 -0500
Received: by mail-yk0-f173.google.com with SMTP id x184so47590762yka.3
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 22:23:16 -0800 (PST)
In-Reply-To: <00b601d13954$5d4a94e0$17dfbea0$@samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chao Yu <chao2.yu@samsung.com>, "Yan, Zheng" <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

> Hi Yan Zheng, Eric Eastman
>
> Similar bug was reported in f2fs, btrfs, it does affect 4.4-rc4, the fixing
> patch was merged into 4.4-rc5, dfd01f026058 ("sched/wait: Fix the signal
> handling fix").
>
> Related report & discussion was here:
> https://lkml.org/lkml/2015/12/12/149
>
> I'm not sure the current reported issue of ceph was related to that though,
> but at least try testing with an upgraded or patched kernel could verify it.
> :)
>
> Thanks,
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of
>> Yan, Zheng
>> Sent: Friday, December 18, 2015 12:05 PM
>> To: Eric Eastman
>> Cc: Ceph Development
>> Subject: Re: Issue with Ceph File System and LIO
>>
>> On Fri, Dec 18, 2015 at 3:49 AM, Eric Eastman
>> <eric.eastman@keepertech.com> wrote:
>> > With cephfs.patch and cephfs1.patch applied and I am now seeing:
>> >
>> > [Thu Dec 17 14:27:59 2015] ------------[ cut here ]------------
>> > [Thu Dec 17 14:27:59 2015] WARNING: CPU: 0 PID: 3036 at
>> > fs/ceph/addr.c:1171 ceph_write_begin+0xfb/0x120 [ceph]()
>> > [Thu Dec 17 14:27:59 2015] Modules linked in: iscsi_target_mod
...
>> >
>>
>> The page gets unlocked mystically. I still don't find any clue. Could
>> you please try the new patch (not incremental patch). Besides, please
>> enable CONFIG_DEBUG_VM when compiling the kernel.
>>
>> Thanks you very much
>> Yan, Zheng
>
I have just installed the cephfs_new.patch and have set
CONFIG_DEBUG_VM=y on a new 4.4rc4 kernel and restarted the ESXi iSCSI
test to my Ceph File System gateway.  I plan to let it run overnight
and report the status tomorrow.

Let me know if I should move on to 4.4rc5 with or without patches and
with or without  CONFIG_DEBUG_VM=y

Looking at the network traffic stats on my iSCSI gateway, with
CONFIG_DEBUG_VM=y, throughput seems to be down by a factor of at least
10 compared to my last test without setting CONFIG_DEBUG_VM=y

Regards,
Eric
