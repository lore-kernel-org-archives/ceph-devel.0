From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 3/5] libceph: a couple tweaks for wait loops
Date: Mon, 25 May 2015 13:38:21 +0300
Message-ID: <CAOi1vP9JYRUfXv9hpGgVyBr0xsD6U4ocxMHRuiNEr=b+HTzzeg@mail.gmail.com>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
	<1432211706-10473-4-git-send-email-idryomov@gmail.com>
	<555DDDA6.3050409@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35383 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbEYKiW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 May 2015 06:38:22 -0400
Received: by wicmx19 with SMTP id mx19so44196709wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 May 2015 03:38:21 -0700 (PDT)
In-Reply-To: <555DDDA6.3050409@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Thu, May 21, 2015 at 4:29 PM, Alex Elder <elder@ieee.org> wrote:
> On 05/21/2015 07:35 AM, Ilya Dryomov wrote:
>> - return -ETIMEDOUT instead of -EIO in case of timeout
>> - wait_event_interruptible_timeout() returns time left until timeout
>>   and since it can be almost LONG_MAX we had better assign it to long
>
> Any error returned by wait_event_interruptible_timeout()
> can now be returned by __ceph_open_session().  It looks
> like that may, in fact, be only -EINTR and -ERESTARTSYS.
> But it's a change you could note in the log message.

I think it's just -ERESTARTSYS so I didn't bother.

>
> It turns out the only caller ignores the return value of
> ceph_monc_wait_osdmap() anyway.  That should maybe be fixed.

That's on purpose - rbd map tries to wait for a new enough osdmap only
if the pool that the image is supposed to be in doesn't exist and we
know we have a stale osdmap.  We ignore wait retval because if we
timeout we should return "this pool doesn't exist", not -ETIMEDOUT.

Thanks,

                Ilya
