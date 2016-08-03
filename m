From: Zack Cerza <zack@redhat.com>
Subject: Re: [sepia] "This branch is out-of-date with the base branch"
Date: Wed, 3 Aug 2016 10:53:44 -0600
Message-ID: <CACk6Fj=O0p32_4LtjCs_TSuhGvHTvQpL5rnb22Mp=sCdB_z0mQ@mail.gmail.com>
References: <CALe9h7fiBXcFVzo9k2+smVxWrewBw_dK8uMY6kJuts_MwA6mtg@mail.gmail.com>
 <CALqRxCyOjLXBYJg=Le3Sz6c-_mJoTG8o7oTXRVWqe5SFvziJuw@mail.gmail.com>
 <CAJ4mKGY2ZyRBtkR+BAmFSc7Vc05dg=6fsEP4h2wTXuhUFw=Egw@mail.gmail.com>
 <CALqRxCzU=Ksj7zMKaAjWqPaMR5YLCi77tGKted+hfgzzWs8Gew@mail.gmail.com> <CAJ4mKGbWcjkz3Uj65TkC1kkrN9Dhd-yQW=02RYkMmsE207Kfzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34426 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbcHCRQJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 13:16:09 -0400
Received: by mail-lf0-f49.google.com with SMTP id l69so165827874lfg.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2016 10:16:08 -0700 (PDT)
In-Reply-To: <CAJ4mKGbWcjkz3Uj65TkC1kkrN9Dhd-yQW=02RYkMmsE207Kfzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, John Spray <jspray@redhat.com>, "sepia@lists.ceph.com" <sepia@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

I'm sorry folks - I didn't see this until now (filters?)

I must have changed this the same day I changed teuthology's behavior.
It was a mistake; sorry for any inconvenience!

On Fri, Jul 29, 2016 at 12:31 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, Jul 29, 2016 at 11:08 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> On Fri, Jul 29, 2016 at 11:27 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> I know Zack wanted this on teuthology, but I really don't think it's
>>> acceptable for the qa-suite stuff -- it practically guarantees we won't be
>>> able to merge what was actually tested!
>>> Also, those branches need to be coordinated with ceph PRs and continuous
>>> rebasing of them over the long periods of time that can entail is just not
>>> feasible.
>>> -Greg
>>
>> Personally I like "Require status checks to pass before merging", but
>> the other setting, "Require branches to be up to date
>> before merging" setting is pretty strict, particularly when every PR
>> has to be rebased by hand.
>
> Oh yes, the fast-forward requirement is what I meant as well — I'm
> really glad we flipped the switch to require tests be passing
> everywhere!
> -Greg
