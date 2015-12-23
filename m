From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Tue, 22 Dec 2015 22:26:51 -0700
Message-ID: <CA+9C14budUAMg6uYet=aWM6C=jYg6z6LUWG5B8_Uq0UqfGojwQ@mail.gmail.com>
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
	<CA+9C14aAAVaaLtjDCjLkc9TSmU=aMh-2iq0xKOb-KEcc9vcuMQ@mail.gmail.com>
	<CAAM7YAky6409uw-hyDOJFE+3ftm46cDXpWG7RHznbZtQXcneCw@mail.gmail.com>
	<CA+9C14bj8A0NbQjrdyGJ5AMKmtoax9VJjEN3a9iXdtfJHueiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33777 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbbLWF0w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 00:26:52 -0500
Received: by mail-yk0-f173.google.com with SMTP id 140so184992734ykp.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 21:26:52 -0800 (PST)
In-Reply-To: <CA+9C14bj8A0NbQjrdyGJ5AMKmtoax9VJjEN3a9iXdtfJHueiTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Chao Yu <chao2.yu@samsung.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Dec 20, 2015 at 7:38 PM, Eric Eastman
<eric.eastman@keepertech.com> wrote:
> On Fri, Dec 18, 2015 at 12:18 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Fri, Dec 18, 2015 at 2:23 PM, Eric Eastman
>> <eric.eastman@keepertech.com> wrote:
>>>> Hi Yan Zheng, Eric Eastman
>>>>
>>>> Similar bug was reported in f2fs, btrfs, it does affect 4.4-rc4, the fixing
>>>> patch was merged into 4.4-rc5, dfd01f026058 ("sched/wait: Fix the signal
>>>> handling fix").
>>>>
>>>> Related report & discussion was here:
>>>> https://lkml.org/lkml/2015/12/12/149
>>>>
>>>> I'm not sure the current reported issue of ceph was related to that though,
>>>> but at least try testing with an upgraded or patched kernel could verify it.
>>>> :)
>>>>
>>>> Thanks,
>
>>
>> please try rc5 kernel without patches and DEBUG_VM=y
>>
>> Regards
>> Yan, Zheng
>
>
> The latest test with 4.4rc5 with CONFIG_DEBUG_VM=y has ran for over 36
> hours with no ERRORS or WARNINGS.  My plan is to install the 4.4rc6
> kernel from the Ubuntu kernel-ppa site once it is available, and rerun
> the tests.
>

Test has run for 2 days using the 4.4rc6 kernel from the Ubuntu
kernel-ppa kernel site without error or warning.  Looks like it was a
4.4rc4 bug.
