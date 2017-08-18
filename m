From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: libradosstriper
Date: Fri, 18 Aug 2017 16:38:45 -0700
Message-ID: <CAJ4mKGZxxPZRWZYAxduPW9L275LCzWVfa7LnCcPCtFOoNWCSOA@mail.gmail.com>
References: <alpine.LSU.2.21.1708171218020.18428@linux-psd4>
 <CAJ4mKGb8tEU9xVcuk2hWMTsZvU6X+Pza1XTrW4uwegLxzmm_tg@mail.gmail.com> <CABZ+qqmcJa13bevAhQhQbDqvHM6Z9XfUKXxL-em-mJAmELYHCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:32980 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdHRXis (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Aug 2017 19:38:48 -0400
Received: by mail-it0-f54.google.com with SMTP id o72so2955568ita.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 16:38:48 -0700 (PDT)
In-Reply-To: <CABZ+qqmcJa13bevAhQhQbDqvHM6Z9XfUKXxL-em-mJAmELYHCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Squid Cybernetic <ceph-devel@vger.kernel.org>, Giuseppe Lo Presti <Giuseppe.LoPresti@cern.ch>

On Fri, Aug 18, 2017 at 1:28 AM, Dan van der Ster <dan@vanderster.com> wrote:
> On Thu, Aug 17, 2017 at 11:39 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Thu, Aug 17, 2017 at 12:18 PM, Jesse Williamson <jwilliamson@suse.de> wrote:
>>>
>>> Hi folks,
>>>
>>> What are the future plans for libradosstriper? Are we planning on keeping it
>>> around, or does the crystal ball forsee a fond farewell?
>>
>> I've not heard any talk of removing it, and I don't think it adds much
>> load to carry on.
>>
>> Although I also think the CERN guys who were maintaining it said
>> they're not making use of it any more, so I don't know if anybody
>> feels any dedication to maintaining it either.
>
> (cc'ing my colleague Giuseppe)
>
> In fact it is still used at CERN and we're aware of at least one other
> user in our HEP community at RAL. Xrootd -- the storage framework we
> use heavily in HEP -- has a Ceph module built around libradosstriper.
>
> As to maintenance, it's true that the original contributor is
> currently on a different assignment, so it hasn't seen much dev
> activity. Are there any issues we should be aware of that need
> following up?

I'm not aware of any issues at the time. Just not having an active
maintainer does make it susceptible to bitrot; and I'e seen a few
queries go by on the lists that I don't think anybody was able to
answer. So those are the potential avenues that would prompt a
removal, but AFAIK no issues yet.
-Greg
