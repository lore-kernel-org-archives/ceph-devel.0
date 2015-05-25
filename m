From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/5] libceph: a couple tweaks for wait loops
Date: Mon, 25 May 2015 10:40:48 -0500
Message-ID: <55634280.70309@ieee.org>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com>	<1432211706-10473-4-git-send-email-idryomov@gmail.com>	<555DDDA6.3050409@ieee.org> <CAOi1vP9JYRUfXv9hpGgVyBr0xsD6U4ocxMHRuiNEr=b+HTzzeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34544 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbEYPkt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 May 2015 11:40:49 -0400
Received: by ieczm2 with SMTP id zm2so74735021iec.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 May 2015 08:40:49 -0700 (PDT)
In-Reply-To: <CAOi1vP9JYRUfXv9hpGgVyBr0xsD6U4ocxMHRuiNEr=b+HTzzeg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On 05/25/2015 05:38 AM, Ilya Dryomov wrote:
> On Thu, May 21, 2015 at 4:29 PM, Alex Elder <elder@ieee.org> wrote:
>> On 05/21/2015 07:35 AM, Ilya Dryomov wrote:
>>> - return -ETIMEDOUT instead of -EIO in case of timeout
>>> - wait_event_interruptible_timeout() returns time left until timeout
>>>   and since it can be almost LONG_MAX we had better assign it to long
>>
>> Any error returned by wait_event_interruptible_timeout()
>> can now be returned by __ceph_open_session().  It looks
>> like that may, in fact, be only -EINTR and -ERESTARTSYS.
>> But it's a change you could note in the log message.
> 
> I think it's just -ERESTARTSYS so I didn't bother.

My point was almost a little more philosophical.  It's conceivable
(though not likely) that wait_event_interruptible_timeout() could
be changed to return a value that your caller here does not expect.

>> It turns out the only caller ignores the return value of
>> ceph_monc_wait_osdmap() anyway.  That should maybe be fixed.
> 
> That's on purpose - rbd map tries to wait for a new enough osdmap only
> if the pool that the image is supposed to be in doesn't exist and we
> know we have a stale osdmap.  We ignore wait retval because if we
> timeout we should return "this pool doesn't exist", not -ETIMEDOUT.

Yes I realize that.  This second part of my response was
following on to my previous thought.  That is, the caller
might get a different return value that it didn't expect;
but since the only caller ignores what gets returned, it's
a moot point.

					-Alex

> Thanks,
> 
>                 Ilya
> 

