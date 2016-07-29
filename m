From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [sepia] "This branch is out-of-date with the base branch"
Date: Fri, 29 Jul 2016 11:31:45 -0700
Message-ID: <CAJ4mKGbWcjkz3Uj65TkC1kkrN9Dhd-yQW=02RYkMmsE207Kfzw@mail.gmail.com>
References: <CALe9h7fiBXcFVzo9k2+smVxWrewBw_dK8uMY6kJuts_MwA6mtg@mail.gmail.com>
 <CALqRxCyOjLXBYJg=Le3Sz6c-_mJoTG8o7oTXRVWqe5SFvziJuw@mail.gmail.com>
 <CAJ4mKGY2ZyRBtkR+BAmFSc7Vc05dg=6fsEP4h2wTXuhUFw=Egw@mail.gmail.com> <CALqRxCzU=Ksj7zMKaAjWqPaMR5YLCi77tGKted+hfgzzWs8Gew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36086 "EHLO
	mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcG2Sbr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 14:31:47 -0400
Received: by mail-ua0-f179.google.com with SMTP id j59so67619351uaj.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 11:31:46 -0700 (PDT)
In-Reply-To: <CALqRxCzU=Ksj7zMKaAjWqPaMR5YLCi77tGKted+hfgzzWs8Gew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Zack Cerza <zack@redhat.com>, John Spray <jspray@redhat.com>, "sepia@lists.ceph.com" <sepia@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 11:08 AM, Ken Dreyer <kdreyer@redhat.com> wrote=
:
> On Fri, Jul 29, 2016 at 11:27 AM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
>> I know Zack wanted this on teuthology, but I really don't think it's
>> acceptable for the qa-suite stuff -- it practically guarantees we wo=
n't be
>> able to merge what was actually tested!
>> Also, those branches need to be coordinated with ceph PRs and contin=
uous
>> rebasing of them over the long periods of time that can entail is ju=
st not
>> feasible.
>> -Greg
>
> Personally I like "Require status checks to pass before merging", but
> the other setting, "Require branches to be up to date
> before merging" setting is pretty strict, particularly when every PR
> has to be rebased by hand.

Oh yes, the fast-forward requirement is what I meant as well =E2=80=94 =
I'm
really glad we flipped the switch to require tests be passing
everywhere!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
