From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Fix OP dequeuing order
Date: Fri, 30 Oct 2015 13:53:00 -0600
Message-ID: <CAANLjFomSiM2fDpYs_S+Kzp4Hb84_cLuHLOhndBVg0z_jMObdg@mail.gmail.com>
References: <CAANLjFqQtsEUtz+ACn=3H8yfFd8Hftymzf1PWEbqNayEUKKP8g@mail.gmail.com>
	<alpine.DEB.2.00.1510282152110.1004@cobra.newdream.net>
	<CAJ4mKGa-CnYr8uLL0_euV=+02UFvZ9H6XLeXrqsLCCwfg3y=Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34001 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759991AbbJ3TxB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 15:53:01 -0400
Received: by vkgs66 with SMTP id s66so54224069vkg.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2015 12:53:00 -0700 (PDT)
In-Reply-To: <CAJ4mKGa-CnYr8uLL0_euV=+02UFvZ9H6XLeXrqsLCCwfg3y=Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'll take a look at the two values mentioned to see if adjusting them help any.

In my reading of the code seems to indicate that the token
implementation is not like any I'm used to. My understanding of token
bucket algorithms is that queues that stay under their token rate get
priority. This could be due to a steady rate of token depletion or
bursts with idle time between them. In my reading of the code, it
doesn't seem that this is being done because as soon as a subqueue is
empty it is removed along with any excess tokens. So when a "new" op
for an empty priority is queued it is immediately penalized to not run
because it hasn't accrued any tokens yet. So it has to sit and wait
for tokens to build up even if there may not have been any activity in
that queue for some time.

The real result of this really depends on how many tokens are still
able to be run verses the priority of the op. If all tokens have been
exhausted, then it starts the strict priority queue which dequeues
differently from the token queue. All of this seems to lead to very
unpredictable behavior in how OPs are dequeued.

What I'd like to know is what is the consensus of how OPs should be
dequeued. Since priorities are being assigned I'm going to assume that
it should be taken into account:
1. Strict priority (some priorities can be starved)
2. Priority token bucket (sort of what is there now, dequeues in
priority order but favors idle priorities)
3. Fair share (each priority gets an opportunity to run in proportion
to their priority)

I'm leaning to implement #3 to test against what is in the code now. I
don't feel like #1 is the right way to go. I think #2 can add a lot of
administrative overhead to each OP especially if there have been a lot
of different priorities that we should remember even if the subqueue
is empty (I think MDS assigns many different priorities) which will
really be detrimental for high IOP workloads (SSD). I think I can
implement #3 with less overhead than what is in the current code and
prevent any queue from being starved.

I'll rough in some code and hopefully I can get it put up to the group
next week.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWM8qYCRDmVDuy+mK58QAAs2UP/jbMo9jSD6+LaeqN0Ldu
El+/MVILzAYNeD25djLi2CF1vT0cuNAhMdUefAYUG0QOTaenLyk7EzUdhBul
z7z3GAZuGMVGfh8NKWUNMdf6j4OKgQvPQmA+bnFE23ou3Fxvm3+OOMjv9nRm
f8O308nkdZx3YlpaBq/jEuvhdPg4PtLNLgWg5EWDP26zl3NBO3xWBMtF/hh2
u+qxHVfev432xPcNZmOAadEiC9mQkfAbG2ms0OJ8nGaeEAA/fWPxfKmN5axL
sG2YaJ5nuh+ygIhYNiGSZrbGBBB93WBV9tGyNHAJx15/3Dz9ZZU3OHg84ufr
L6WssbnjkX48ExOc2GfWH/sxI/UqpyzCHKY2G/iWWpmZO27dCjYQOTUO3H7Q
/en1JDyl8hAl9BqKBPFUthRH3gv/RYkkQTejE2iVfdvSn8l9+EcfzCtsdGou
LXDYb+k5jyxZelvR3qY1QdRxcuBxqLnmYVzS/iPph6nU3TINZGpyi/mFZiN5
mxIED4BQGNLAG6hBr4OD7WusH9I8U2CEXFs5nGjlMxBsAQpM8L0xTwhmgthC
4aHZqp0hH2DlNcBC8L1gNbDV15Q7fg0T8x2jXnh7F81Oq3AF+S4xYm6OzisC
jUc+Pmb1XwlWoL9wkcwqZ+GwKRcw2W4a/0ryi4KDriU+zTUo7J0P6qQHm6ab
nImA
=e7Ar
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Oct 30, 2015 at 12:08 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> As we've discussed on the PR, this isn't right. We deliberately
> iterate through the lower-priority queues first so that the
> higher-priority ones don't starve them out entirely: they might be
> generating tokens more quickly than tokens can be used, which would
> prevent low queues from ever getting any ops at all, and that's
> contrary to the intention. ...I guess this could also happen where the
> lower-priority queues are generating tokens so quickly they never run
> out, but that doesn't seem likely unless you have *very* small
> objects.
>
> You might also try tuning the osd_op_pq_max_tokens_per_priority and
> osd_op_pq_min_cost values, which specify the maximum number of tokens
> and the minimum token cost of an op for each. (Defaults are 4194304
> and 65536, ie 4MB and 64KB.) I wouldn't expect this to be an issue
> (that builds up to a maximum of 64 recovery ops getting processed in a
> single go before it hits its long-term token average limit) but maybe
> something isn't behaving as expected.
> -Greg
>
>
>
> On Wed, Oct 28, 2015 at 9:52 PM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 28 Oct 2015, Robert LeBlanc wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> I created a pull request to fix an op dequeuing order problem. I'm not
>>> sure if I need to mention it here.
>>>
>>> https://github.com/ceph/ceph/pull/6417
>>
>> Wow, good catch.  Have you found that this materially impacts the behavior
>> in your cluster?
>>
>> sage
>>
>>
>>>
>>> - ----------------
>>> Robert LeBlanc
>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: Mailvelope v1.2.3
>>> Comment: https://www.mailvelope.com
>>>
>>> wsFcBAEBCAAQBQJWMVh6CRDmVDuy+mK58QAAztQP/385BOI8AH2uEJhN8pQ4
>>> QnAJxRy4HceWzjfAUulqNbbiD1scHZMU7LDW1GtsXfOZzmndTnJSBrR4+aHq
>>> F7py9zgXcxXH4uTAoILbRzkCF3rWdmkeh1/m5aY4LqmhE2N/O/LLOmDUe2BT
>>> XkQgZ9sROzY9pSj6pjA2vuv7k2u1SWtF3Ky14Hll3LHjqJibXoXYy+ik7lOP
>>> lRUoAY08Yf+c/Ag/Yy7CLGgIk/y6mdaJZPd2PCaVsKFa55NJAlYv0PHJKX0j
>>> XkSAY10MednMX6N+QL8XAq+yiAd//UADfCNhxHkP84YsPPCpNeS1OcoF6WGG
>>> g5H8uMK84kZCk37ummW/ANg9WNnO3hN2j22r9ezA+4GfxqKibT4lEMba6h88
>>> i5L3rQwWmM0cdpjS9plH1yUiPP2DexJV8PaiAIVVMAkw+AC0Xb/nUXKX6u5+
>>> YU744kSjtscN95Caf72V6HirB/uEU4sm+4lUuUBHzTcvau/r9WUHezwvmUiH
>>> HHL9bSU5TJ4jXvQhDEBYKbflTzLNKjXPcp1PagN2P9ZWQvNaxrQm32iB84DW
>>> 6jLEArFX10kE3eZ8IqoBikw5d+y3YtnuJ1oAIkfzj1ANofm37VKcQY/Wfrjw
>>> eke0nR4QBuN6SibbPXqIsjjIWZdo/jCgOCylNONXCFn9Qp08/7UJMQtzHk/1
>>> xRRp
>>> =g+NJ
>>> -----END PGP SIGNATURE-----
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
