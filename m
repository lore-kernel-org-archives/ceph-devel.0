From: Dan van der Ster <dan@vanderster.com>
Subject: Re: libradosstriper
Date: Fri, 18 Aug 2017 10:28:28 +0200
Message-ID: <CABZ+qqmcJa13bevAhQhQbDqvHM6Z9XfUKXxL-em-mJAmELYHCA@mail.gmail.com>
References: <alpine.LSU.2.21.1708171218020.18428@linux-psd4> <CAJ4mKGb8tEU9xVcuk2hWMTsZvU6X+Pza1XTrW4uwegLxzmm_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34911 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdHRI3M (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Aug 2017 04:29:12 -0400
Received: by mail-lf0-f41.google.com with SMTP id t128so39788690lff.2
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 01:29:12 -0700 (PDT)
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com. [209.85.215.47])
        by smtp.gmail.com with ESMTPSA id f78sm1076989lji.45.2017.08.18.01.29.09
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 01:29:09 -0700 (PDT)
Received: by mail-lf0-f47.google.com with SMTP id g77so7381834lfg.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 01:29:09 -0700 (PDT)
In-Reply-To: <CAJ4mKGb8tEU9xVcuk2hWMTsZvU6X+Pza1XTrW4uwegLxzmm_tg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Squid Cybernetic <ceph-devel@vger.kernel.org>, Giuseppe Lo Presti <Giuseppe.LoPresti@cern.ch>

On Thu, Aug 17, 2017 at 11:39 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Thu, Aug 17, 2017 at 12:18 PM, Jesse Williamson <jwilliamson@suse.de> wrote:
>>
>> Hi folks,
>>
>> What are the future plans for libradosstriper? Are we planning on keeping it
>> around, or does the crystal ball forsee a fond farewell?
>
> I've not heard any talk of removing it, and I don't think it adds much
> load to carry on.
>
> Although I also think the CERN guys who were maintaining it said
> they're not making use of it any more, so I don't know if anybody
> feels any dedication to maintaining it either.

(cc'ing my colleague Giuseppe)

In fact it is still used at CERN and we're aware of at least one other
user in our HEP community at RAL. Xrootd -- the storage framework we
use heavily in HEP -- has a Ceph module built around libradosstriper.

As to maintenance, it's true that the original contributor is
currently on a different assignment, so it hasn't seen much dev
activity. Are there any issues we should be aware of that need
following up?

Cheers, Dan
