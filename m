From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: fix a memory leak in handle_watch_notify
Date: Thu, 11 Sep 2014 15:11:10 +0400
Message-ID: <CALFYKtAfX=B8O7W7pFZ_r-GspKpB_x8GiiSwWT2EpUmwPwr_cA@mail.gmail.com>
References: <1410394821-13054-1-git-send-email-roy.qing.li@gmail.com>
	<5410FDE5.5090804@ieee.org>
	<CALFYKtBWjm69_zVUMKjiyAW6K+dE+nx4XzUce57gT1Sc_-Optw@mail.gmail.com>
	<54117E61.6080004@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:34390 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbaIKLLL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 07:11:11 -0400
Received: by mail-qa0-f47.google.com with SMTP id dc16so83059qab.6
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 04:11:11 -0700 (PDT)
In-Reply-To: <54117E61.6080004@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: roy.qing.li@gmail.com, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 11, 2014 at 2:50 PM, Alex Elder <elder@ieee.org> wrote:
> On 09/11/2014 03:31 AM, Ilya Dryomov wrote:
>>
>> On Thu, Sep 11, 2014 at 5:41 AM, Alex Elder <elder@ieee.org> wrote:
>>>
>>> On 09/10/2014 07:20 PM, roy.qing.li@gmail.com wrote:
>>>>
>>>>
>>>> From: Li RongQing <roy.qing.li@gmail.com>
>>>>
>>>> event_work should be freed when adding it to queue failed
>>>>
>>>> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
>>>
>>>
>>>
>>> Looks good.
>>>
>>> Reviewed-by: Alex Elder <elder@linaro.org>
>>
>>
>> Hmm, queue_work() returns %false if @work was already on a queue, %true
>> otherwise, so this seems bogus to me.  I'd go with something like this
>> (mangled).
>
>
> The original change was fine.  Whether it matters is another question.
> Your suggestion looks good as well, and on the assumption that if you
> choose to use it instead your "real" fix is done correctly you can
> use "Reviewed-by: <me>" if you like.

Well, the original change makes something bogus even more bogus.  It's
basically:

    foo = kmalloc(...);
    foo->bar = 0;

    if (foo->bar & BAZ) {
        /* WARNING */
        kfree(foo);
        goto ...
    }

So yeah, I'm going to use your Reviewed-by on my "real" fix ;)

Thanks,

                Ilya
