From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply is received
Date: Thu, 25 Jul 2013 11:43:33 -0400
Message-ID: <CANP1eJEi5utUmnr8kB-g6qVRydWqntJ=Hea1qV_QgUS=FuUQtA@mail.gmail.com>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com>
	<51D12FA7.1090605@intel.com>
	<alpine.DEB.2.00.1307011245410.11177@cobra.newdream.net>
	<alpine.DEB.2.00.1307031455220.3375@cobra.newdream.net>
	<CANP1eJFe+d-UM4vSOSLiFP07NrbXGUeD1TNaXusSLrEo8HEXTQ@mail.gmail.com>
	<CAAM7YAnVZhTa6LQWo9KzMGHdkYCrwAQJLweJUBEm=dUaVqA5bA@mail.gmail.com>
	<CANP1eJFzM-61iXyreZpMHH6Bp5ZV5vJZYtQretg8Xx+C3njjBw@mail.gmail.com>
	<CANP1eJEBepbExdz9srBPDaXCd8MC1vBnDv_nN6FFJuapir-nKQ@mail.gmail.com>
	<CAAM7YAmgOB3_+xdYV758K5yWGTaQ3MQLYeJ-L=WWmm=w6Sn+PA@mail.gmail.com>
	<CANP1eJGf2_XbXYnUxWsGFrVfSpYQ0mZOFGWW1HTVnaUZSghd6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:43421 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab3GYPne (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 11:43:34 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so5796685wiv.8
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 08:43:33 -0700 (PDT)
In-Reply-To: <CANP1eJGf2_XbXYnUxWsGFrVfSpYQ0mZOFGWW1HTVnaUZSghd6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alex Elder <alex.elder@linaro.org>, Sage Weil <sage@inktank.com>

I just wanted to follow up to say that after applying these patches
and running it for a few weeks we're I haven't seen another lock up
under load.

- Milosz

On Mon, Jul 8, 2013 at 5:16 PM, Milosz Tanski <milosz@adfin.com> wrote:
> In this case (unlike last week) the restart did unlock my clients.
>
> - M
>
> On Mon, Jul 8, 2013 at 4:30 PM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Tue, Jul 9, 2013 at 3:58 AM, Milosz Tanski <milosz@adfin.com> wrote:
>>> Yan,
>>>
>>> Actually after playing some more today I have another one of my
>>> clients stuck in this spot. When I look at the kernel stacks this is
>>> what I see for all the threads:
>>>
>>> [<ffffffffa02d2bab>] ceph_mdsc_do_request+0xcb/0x1a0 [ceph]
>>> [<ffffffffa02c018f>] ceph_do_getattr+0xdf/0x120 [ceph]
>>> [<ffffffffa02c01f4>] ceph_getattr+0x24/0x100 [ceph]
>>> [<ffffffff811775fd>] vfs_getattr+0x4d/0x80
>>> [<ffffffff8117784d>] vfs_fstat+0x3d/0x70
>>> [<ffffffff81177895>] SYSC_newfstat+0x15/0x30
>>> [<ffffffff8117794e>] SyS_newfstat+0xe/0x10
>>> [<ffffffff8155dd59>] system_call_fastpath+0x16/0x1b
>>> [<ffffffffffffffff>] 0xffffffffffffffff
>>>
>>>
>>> Anything I can do on my end to debug this issue?
>>>
>>
>> find the hang request (and inode) through /sys/kernel/debug/ceph/xxx/mdsc,
>> use 'ceph mds tell \* dumpcache' to dump mds cache.
>> open /cachedump.xxx and check the inode's state.
>>
>> does your kernel include all fixes in testing branch of ceph-client ?
>> does restarting the mds resolve the hang ?
>>
>> yan, zheng
