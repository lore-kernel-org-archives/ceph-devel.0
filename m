From: Sam Lang <sam.lang@inktank.com>
Subject: Re: chaos monkeys
Date: Tue, 09 Oct 2012 13:32:34 -0500
Message-ID: <50746DC2.90609@inktank.com>
References: <5074541B.4000504@inktank.com> <CAPYLRzhqfbWcP0_oXDQmoGSmzPOEGO9DutPSRBS32kzPjuLoZw@mail.gmail.com> <507457EB.4000802@inktank.com> <CAPYLRzi5PWbPoq8L9DSiMq9wkgeLEER_ZFDg_b28sUbt20=3oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53906 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2JISch (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 14:32:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5510903pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 11:32:37 -0700 (PDT)
In-Reply-To: <CAPYLRzi5PWbPoq8L9DSiMq9wkgeLEER_ZFDg_b28sUbt20=3oA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/09/2012 12:16 PM, Gregory Farnum wrote:
> <also moved to ceph-devel>
> On Tue, Oct 9, 2012 at 9:59 AM, Sam Lang <sam.lang@inktank.com> wrote=
:
>> On 10/09/2012 11:46 AM, Gregory Farnum wrote:
>>>
>>> On Tue, Oct 9, 2012 at 9:43 AM, Sam Lang <sam.lang@inktank.com> wro=
te:
>>>>
>>>>
>>>> Could we add some other chaos monkeys to the network/storage
>>>> infrastructure
>>>> besides ms_inject_socket_failures?  In particular, I would like to=
 add
>>>> ms_inject_delay_msg and ms_inject_reorder_msgs?  I think those cou=
ld
>>>> potentially help flush out some bugs (such as:
>>>>
>>>> https://github.com/ceph/ceph/commit/fa66eaa162542ac01752ada91a4605=
1dde060831).
>>>
>>>
>>> You're going to have to explain these more =97 ordered delivery ove=
r a
>>> connection is one of the guarantees that the messaging layer provid=
es,
>>> so that doesn't sound like a configurable we're going to add.
>>
>>
>> That's true, but there's no guarantee that the source will always se=
nd them
>> in the same order.  The bug I linked above is a good example, the md=
s was
>> sending out two messages, one the open session reply, and another th=
e stale
>> session async message.  The bug is only expressed when the stale com=
es
>> before the open session, which is possible in some cases.  The stale
>> originates from a timer expiring, and the open session is sent after=
 the
>> journal commit, so the timing (and ordering) of those two messages c=
an vary
>> based on when the timer thread gets scheduled to execute, how long t=
he
>> journal commit takes, etc.
>>
>> Reordering messages at the destination would act to simulate all the
>> asynchronous paths like this that exist in our code.
>
> The sending messenger also maintains ordering invariants. The endpoin=
t
> (the MDS) might not dispatch them in the same order all the time, but
> that's at a different semantic layer and is not something we can
> simulate inside the messenger =97 it requires semantic knowledge of
> which messages are okay to reorder. If we just did random reordering
> like you're suggesting, absolutely everything would break.

Putting a delay on the sender would avoid the reordering of messages=20
that have semantic meaning but allow delay-caused reordering to occur=20
for those that have no semantic dependency.

You're right that reordering at the receiver won't work, but it would b=
e=20
nice to have more concrete examples.  The only example I can come up=20
with is the unsafe/safe messages from mds to client.  Even in that case=
=20
it looks like we handle it by throwing away the unsafe message.  What=20
other examples exist?  Caps issue/revoke?

-sam


>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
