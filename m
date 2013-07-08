From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply is received
Date: Mon, 8 Jul 2013 15:58:15 -0400
Message-ID: <CANP1eJEBepbExdz9srBPDaXCd8MC1vBnDv_nN6FFJuapir-nKQ@mail.gmail.com>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com>
	<51D12FA7.1090605@intel.com>
	<alpine.DEB.2.00.1307011245410.11177@cobra.newdream.net>
	<alpine.DEB.2.00.1307031455220.3375@cobra.newdream.net>
	<CANP1eJFe+d-UM4vSOSLiFP07NrbXGUeD1TNaXusSLrEo8HEXTQ@mail.gmail.com>
	<CAAM7YAnVZhTa6LQWo9KzMGHdkYCrwAQJLweJUBEm=dUaVqA5bA@mail.gmail.com>
	<CANP1eJFzM-61iXyreZpMHH6Bp5ZV5vJZYtQretg8Xx+C3njjBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52477 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3GHT6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jul 2013 15:58:16 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so10872763iea.18
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jul 2013 12:58:15 -0700 (PDT)
In-Reply-To: <CANP1eJFzM-61iXyreZpMHH6Bp5ZV5vJZYtQretg8Xx+C3njjBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alex Elder <alex.elder@linaro.org>, Sage Weil <sage@inktank.com>

Yan,

Actually after playing some more today I have another one of my
clients stuck in this spot. When I look at the kernel stacks this is
what I see for all the threads:

[<ffffffffa02d2bab>] ceph_mdsc_do_request+0xcb/0x1a0 [ceph]
[<ffffffffa02c018f>] ceph_do_getattr+0xdf/0x120 [ceph]
[<ffffffffa02c01f4>] ceph_getattr+0x24/0x100 [ceph]
[<ffffffff811775fd>] vfs_getattr+0x4d/0x80
[<ffffffff8117784d>] vfs_fstat+0x3d/0x70
[<ffffffff81177895>] SYSC_newfstat+0x15/0x30
[<ffffffff8117794e>] SyS_newfstat+0xe/0x10
[<ffffffff8155dd59>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff


Anything I can do on my end to debug this issue?

- Milosz

P.S: Sorry for the second email if you got it gmail keep switching me
to non-plain text mode. Sigh.

On Mon, Jul 8, 2013 at 10:42 AM, Milosz Tanski <milosz@adfin.com> wrote:
> Yan,
>
> So it looks like it fixes the issue. I had to update all my clients
> and restart MDS and things got back to normal.
>
> - Milosz
>
> On Wed, Jul 3, 2013 at 6:43 PM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Thu, Jul 4, 2013 at 6:07 AM, Milosz Tanski <milosz@adfin.com> wrote:
>>> Yan,
>>>
>>> Can you help me understand how this change fixes:
>>> http://tracker.ceph.com/issues/2019 ? The symptom on the client is
>>> that the processes get stuck waiting in ceph_mdsc_do_request according
>>> to /proc/PID/stack.
>>
>> The bug this patch fixes is that ceph_sync_write_unsafe can be called
>> multiple times
>> with parameter unsafe=true. The bug prevents the kclient from
>> releasing Fw cap, further
>> lead to filelock stuck in unstable state forever and request hang.
>>
>> Yan, Zheng
