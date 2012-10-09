From: Gregory Farnum <greg@inktank.com>
Subject: Re: chaos monkeys
Date: Tue, 9 Oct 2012 10:16:47 -0700
Message-ID: <CAPYLRzi5PWbPoq8L9DSiMq9wkgeLEER_ZFDg_b28sUbt20=3oA@mail.gmail.com>
References: <5074541B.4000504@inktank.com>
	<CAPYLRzhqfbWcP0_oXDQmoGSmzPOEGO9DutPSRBS32kzPjuLoZw@mail.gmail.com>
	<507457EB.4000802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:42453 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2JIRQt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 13:16:49 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3216031lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 10:16:47 -0700 (PDT)
In-Reply-To: <507457EB.4000802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

<also moved to ceph-devel>
On Tue, Oct 9, 2012 at 9:59 AM, Sam Lang <sam.lang@inktank.com> wrote:
> On 10/09/2012 11:46 AM, Gregory Farnum wrote:
>>
>> On Tue, Oct 9, 2012 at 9:43 AM, Sam Lang <sam.lang@inktank.com> wrot=
e:
>>>
>>>
>>> Could we add some other chaos monkeys to the network/storage
>>> infrastructure
>>> besides ms_inject_socket_failures?  In particular, I would like to =
add
>>> ms_inject_delay_msg and ms_inject_reorder_msgs?  I think those coul=
d
>>> potentially help flush out some bugs (such as:
>>>
>>> https://github.com/ceph/ceph/commit/fa66eaa162542ac01752ada91a46051=
dde060831).
>>
>>
>> You're going to have to explain these more =97 ordered delivery over=
 a
>> connection is one of the guarantees that the messaging layer provide=
s,
>> so that doesn't sound like a configurable we're going to add.
>
>
> That's true, but there's no guarantee that the source will always sen=
d them
> in the same order.  The bug I linked above is a good example, the mds=
 was
> sending out two messages, one the open session reply, and another the=
 stale
> session async message.  The bug is only expressed when the stale come=
s
> before the open session, which is possible in some cases.  The stale
> originates from a timer expiring, and the open session is sent after =
the
> journal commit, so the timing (and ordering) of those two messages ca=
n vary
> based on when the timer thread gets scheduled to execute, how long th=
e
> journal commit takes, etc.
>
> Reordering messages at the destination would act to simulate all the
> asynchronous paths like this that exist in our code.

The sending messenger also maintains ordering invariants. The endpoint
(the MDS) might not dispatch them in the same order all the time, but
that's at a different semantic layer and is not something we can
simulate inside the messenger =97 it requires semantic knowledge of
which messages are okay to reorder. If we just did random reordering
like you're suggesting, absolutely everything would break.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
