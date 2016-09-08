From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Thu, 8 Sep 2016 19:19:11 +0200
Message-ID: <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com> <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35338 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965916AbcIHRTN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 13:19:13 -0400
Received: by mail-qk0-f181.google.com with SMTP id v123so55337652qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 10:19:13 -0700 (PDT)
In-Reply-To: <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Sep 7, 2016 at 11:05 PM, Casey Bodley <cbodley@redhat.com> wrote:
> Some specific requirements that I recall from our past discussions include:
>
> - don't heap allocate auth state per request

Great. I understood that we don't need to optimize the early
run-time (setup, initialization) to eradicate dynamic allocations.
This would allow to make the things easier to read through
skipping some crazy CRTP/SFINAE stuff.

> - don't construct or call into AuthEngines that shouldn't be enabled for the
> given handler

This sounds like a step further in comparison with the current
solution. In the past we had a lot of "ifs" executed per request.
Currently, the logic is split into per-engine pieces and encapsulated
in is_applicable method of AuthEngines. In my understanding
the goal is to introduce init-time preselection. However, we need
to discuss dealing with run-time config changes (operator injecting
new configuration without restart). Do we want to cover this use
case at all?

> I'll add some of the other refactoring goals we've discussed, but I don't
> think they place any strict requirements on the auth subsystem:
>
> - RGWHandler: being able to reuse handler instances, instead of allocating a
> new one for each request

At the moment RGWHandler is dynamically allocated on each
request. Do we plan to remove only the allocations or go even
further and make handlers entirely state-less?

> - req_state: contains too many unrelated fields, some of which are
> transformed in confusing ways over the lifetime of the request. needs to be
> broken up into smaller, better encapsulated sub-objects

I'm 100% behind that.

> - concurrency: move away from a synchronous process_request() to build on
> asio frontend work

Sound really interesting.


Let me propose another requirement:
 - critical components should facilitate unit testing. In the future
   they should be covered by reasonable set of unit tests.

What do you think?

Regards,
Radek
