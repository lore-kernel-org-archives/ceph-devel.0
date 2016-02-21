From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/4] libceph: use the right footer size when skipping a message
Date: Sun, 21 Feb 2016 15:31:04 +0100
Message-ID: <CAOi1vP9jV87zoR5bG7p-b3gKBt7JBVYP5iH-tjyx0Jnf-oLNsA@mail.gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
	<1455986729-12544-3-git-send-email-idryomov@gmail.com>
	<56C8B40D.90602@ieee.org>
	<CAOi1vP-3TvUMVL+SMcagJ_wf1RE7Z3PbeUhUzUvOUJkX+1D_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34304 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbcBURZT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Feb 2016 12:25:19 -0500
Received: by mail-wm0-f44.google.com with SMTP id b205so127770862wmb.1
        for <ceph-devel@vger.kernel.org>; Sun, 21 Feb 2016 09:25:18 -0800 (PST)
In-Reply-To: <CAOi1vP-3TvUMVL+SMcagJ_wf1RE7Z3PbeUhUzUvOUJkX+1D_Ww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

On Sat, Feb 20, 2016 at 9:05 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Sat, Feb 20, 2016 at 7:44 PM, Alex Elder <elder@ieee.org> wrote:
>> +On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
>>> ceph_msg_footer is 21 bytes long, while ceph_msg_footer_old is only 13.
>>> Don't skip too much when CEPH_FEATURE_MSG_AUTH isn't negotiated.
>>
>> This looks good, but I have a few suggestions.
>>
>> You could done some factoring in prepare_write_message_footer()
>> to use the new function for setting iov_len and updating
>> out_kvec_bytes.
>
> I considered it, but we'd still need the if on MSG_AUTH bit, so
> I decided it wasn't worth it.  TBH I'm more inclined to rip this
> old_footer stuff entirely - it's supported since v0.55, that's
> pre-bobtail...

What I missed yesterday was that using sizeof_footer() makes it
possible to use con_out_kvec_add().  I updated 4/4 and also pulled the
need_sign -> sizeof_footer() hunk from 2/4 into it.

Thanks,

                Ilya
