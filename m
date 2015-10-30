From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Fix OP dequeuing order
Date: Fri, 30 Oct 2015 11:08:02 -0700
Message-ID: <CAJ4mKGa-CnYr8uLL0_euV=+02UFvZ9H6XLeXrqsLCCwfg3y=Pw@mail.gmail.com>
References: <CAANLjFqQtsEUtz+ACn=3H8yfFd8Hftymzf1PWEbqNayEUKKP8g@mail.gmail.com>
	<alpine.DEB.2.00.1510282152110.1004@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35881 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758904AbbJ3SID (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 14:08:03 -0400
Received: by wmec75 with SMTP id c75so18296128wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2015 11:08:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510282152110.1004@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>

As we've discussed on the PR, this isn't right. We deliberately
iterate through the lower-priority queues first so that the
higher-priority ones don't starve them out entirely: they might be
generating tokens more quickly than tokens can be used, which would
prevent low queues from ever getting any ops at all, and that's
contrary to the intention. ...I guess this could also happen where the
lower-priority queues are generating tokens so quickly they never run
out, but that doesn't seem likely unless you have *very* small
objects.

You might also try tuning the osd_op_pq_max_tokens_per_priority and
osd_op_pq_min_cost values, which specify the maximum number of tokens
and the minimum token cost of an op for each. (Defaults are 4194304
and 65536, ie 4MB and 64KB.) I wouldn't expect this to be an issue
(that builds up to a maximum of 64 recovery ops getting processed in a
single go before it hits its long-term token average limit) but maybe
something isn't behaving as expected.
-Greg



On Wed, Oct 28, 2015 at 9:52 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 28 Oct 2015, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> I created a pull request to fix an op dequeuing order problem. I'm not
>> sure if I need to mention it here.
>>
>> https://github.com/ceph/ceph/pull/6417
>
> Wow, good catch.  Have you found that this materially impacts the behavior
> in your cluster?
>
> sage
>
>
>>
>> - ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.2.3
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJWMVh6CRDmVDuy+mK58QAAztQP/385BOI8AH2uEJhN8pQ4
>> QnAJxRy4HceWzjfAUulqNbbiD1scHZMU7LDW1GtsXfOZzmndTnJSBrR4+aHq
>> F7py9zgXcxXH4uTAoILbRzkCF3rWdmkeh1/m5aY4LqmhE2N/O/LLOmDUe2BT
>> XkQgZ9sROzY9pSj6pjA2vuv7k2u1SWtF3Ky14Hll3LHjqJibXoXYy+ik7lOP
>> lRUoAY08Yf+c/Ag/Yy7CLGgIk/y6mdaJZPd2PCaVsKFa55NJAlYv0PHJKX0j
>> XkSAY10MednMX6N+QL8XAq+yiAd//UADfCNhxHkP84YsPPCpNeS1OcoF6WGG
>> g5H8uMK84kZCk37ummW/ANg9WNnO3hN2j22r9ezA+4GfxqKibT4lEMba6h88
>> i5L3rQwWmM0cdpjS9plH1yUiPP2DexJV8PaiAIVVMAkw+AC0Xb/nUXKX6u5+
>> YU744kSjtscN95Caf72V6HirB/uEU4sm+4lUuUBHzTcvau/r9WUHezwvmUiH
>> HHL9bSU5TJ4jXvQhDEBYKbflTzLNKjXPcp1PagN2P9ZWQvNaxrQm32iB84DW
>> 6jLEArFX10kE3eZ8IqoBikw5d+y3YtnuJ1oAIkfzj1ANofm37VKcQY/Wfrjw
>> eke0nR4QBuN6SibbPXqIsjjIWZdo/jCgOCylNONXCFn9Qp08/7UJMQtzHk/1
>> xRRp
>> =g+NJ
>> -----END PGP SIGNATURE-----
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
