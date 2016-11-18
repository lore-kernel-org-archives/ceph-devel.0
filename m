From: John Spray <jspray@redhat.com>
Subject: Re: Automate PGs calculation in Ceph?
Date: Fri, 18 Nov 2016 14:11:39 +0000
Message-ID: <CALe9h7c5qvn3tj+0TXs5ONOaMor4T45-LdzCh9XBuQNE6ypcPw@mail.gmail.com>
References: <CA+HUO7LtJANRqMDC8AsFDp-Fr2u1toafiKX6uCSvjCjC-4MoyQ@mail.gmail.com>
 <CALe9h7eKrZmQ1gjv_TT4T8+q9u7nNVL9o7jH-jiMfCXft5co+w@mail.gmail.com> <CA+HUO7JZSYJpzeAsqqbereRgRu8gV0p+v8ppxO12Y29yi2uEZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33091 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcKROMA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2016 09:12:00 -0500
Received: by mail-qk0-f174.google.com with SMTP id x190so263685014qkb.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2016 06:12:00 -0800 (PST)
In-Reply-To: <CA+HUO7JZSYJpzeAsqqbereRgRu8gV0p+v8ppxO12Y29yi2uEZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <shan@redhat.com>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Nov 18, 2016 at 1:48 PM, Sebastien Han <shan@redhat.com> wrote:
> Thanks John that makes sense, since we miss user's overall intent
> there is no point of doing this within the mons :).
> It would be nice to have something a bit more dynamic though, where we
> can decrease PGs based on the topology and the current number of
> pools... Of course this will trigger movements but this is not an
> issue for Ceph :).

Yeah, being able to decrease pg_num (i.e. do pg joins on the OSDs)
would solve a lot of usability problems: currently we have no choice
but to educate users about PGs on day 1 in order for them to decide
how many they want in a pool.  If we could auto-guess, and then
decrease later if we get it wrong, then most users would not need to
know what a PG is to do normal operations.

I would envision any auto-decrease in pg_num working in concert with a
guided pool creation process; as well as recommending how many pgs new
pools should have, we would recommend any decrease in existing pools,
and provide information about the expected cost of the associated data
movement.

John

>
> On Thu, Nov 17, 2016 at 10:02 PM, John Spray <jspray@redhat.com> wrote:
>> On Thu, Nov 17, 2016 at 6:14 PM, Sebastien Han <shan@redhat.com> wrote:
>>> Hey,
>>>
>>> I was wondering, since we have PG calc online to decide the right
>>> value for our PGs per pool. The logic seems to be easy and well
>>> understood. Looks like a simple calculation, I don't see anything like
>>> depending on a use case we are changing the value or anything.
>>>
>>> Any reason why this logic is not part of Ceph?
>>> Mons know about everything on the cluster and since they manage pool
>>> creations they should be able to take the right decision.
>>>
>>> Am I missing something?
>>
>> I think the reason nobody has done this so far is that there's no
>> overall (multiple pools at a time) setup interface in Ceph.  To do the
>> pg calc stuff, you need a user to tell you not just that they want a
>> pool, but how many pools they want and what they will use them for:
>> something friendlier than the current "osd pool create" command can
>> handle.
>>
>> Having mons do any kind of guessing on a "pool at a time" basis
>> without visibility of the user's overall intent is pretty dangerous,
>> because users can never fix a bad automatic choice (can't decrease
>> pg_num).
>>
>> John
>>
>>> Thanks!
>>>
>>> --
>>> Cheers
>>>
>>> ––––––
>>> Sébastien Han
>>> Principal Storage Architect
>>>
>>> "Always give 100%. Unless you're giving blood."
>>>
>>> Mail: seb@redhat.com
>>> Address: 11 bis, rue Roquépine - 75008 Paris
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers
>
> ––––––
> Sébastien Han
> Principal Storage Architect
>
> "Always give 100%. Unless you're giving blood."
>
> Mail: seb@redhat.com
> Address: 11 bis, rue Roquépine - 75008 Paris
