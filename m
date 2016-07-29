From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [sepia] "This branch is out-of-date with the base branch"
Date: Fri, 29 Jul 2016 12:08:22 -0600
Message-ID: <CALqRxCzU=Ksj7zMKaAjWqPaMR5YLCi77tGKted+hfgzzWs8Gew@mail.gmail.com>
References: <CALe9h7fiBXcFVzo9k2+smVxWrewBw_dK8uMY6kJuts_MwA6mtg@mail.gmail.com>
 <CALqRxCyOjLXBYJg=Le3Sz6c-_mJoTG8o7oTXRVWqe5SFvziJuw@mail.gmail.com> <CAJ4mKGY2ZyRBtkR+BAmFSc7Vc05dg=6fsEP4h2wTXuhUFw=Egw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36633 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcG2SIY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 14:08:24 -0400
Received: by mail-vk0-f41.google.com with SMTP id n129so59597107vke.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 11:08:23 -0700 (PDT)
In-Reply-To: <CAJ4mKGY2ZyRBtkR+BAmFSc7Vc05dg=6fsEP4h2wTXuhUFw=Egw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Zack Cerza <zack@redhat.com>, John Spray <jspray@redhat.com>, "sepia@lists.ceph.com" <sepia@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 11:27 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> I know Zack wanted this on teuthology, but I really don't think it's
> acceptable for the qa-suite stuff -- it practically guarantees we won't be
> able to merge what was actually tested!
> Also, those branches need to be coordinated with ceph PRs and continuous
> rebasing of them over the long periods of time that can entail is just not
> feasible.
> -Greg

Personally I like "Require status checks to pass before merging", but
the other setting, "Require branches to be up to date
before merging" setting is pretty strict, particularly when every PR
has to be rebased by hand.

I think OpenStack's Zuul has the right approach - as I understand it,
you can tell Zuul "go ahead merge this if all the tests pass on the
result of what would be merged". GitHub does not have something like
that built in, it seems.

- Ken
