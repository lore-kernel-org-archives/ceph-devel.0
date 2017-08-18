From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: Requesting to change "doesn't" to "does not", isn't to "is not".
Date: Fri, 18 Aug 2017 14:12:37 +0200
Message-ID: <87378p3wi2.fsf@suse.com>
References: <5996d47e.4ef9620a.e0733.1ba8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43329 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdHRMMj (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 18 Aug 2017 08:12:39 -0400
In-Reply-To: <5996d47e.4ef9620a.e0733.1ba8@mx.google.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Amit <amitkuma@redhat.com> writes:

> Hello,
>
> I believe coding guidelines does not speak about this.
>
> But PR (https://github.com/ceph/ceph/pull/16705) talks on it. And its
ITYM it's here ;-)

> still open.
> If we donot agree on contractions, Let's close it.
>
> Though "I am" instead of "I'm" -- both are completely correct English.
> But I read on PR, It suits more on ESL speakers and takes care of
> non-english speakers.
>
> I believe while reviewing the PRs, we can ask developers for changing
> "isn't" to "is not". [If we accept above PR?]
> Would be a step in including "Strong Phrases, Active voices" into
> documentation/Comments/std output..

Well there are enough comments on the PR itself supporting/opposing it,
however in the PR itself, John Wilkins mentions that if approved, it
would be mostly automated scripts that'd doing the cleanups and not an
imposition on the community itself to do anything special, and this
would be better rather than requesting changes from PR submitters
themselves. My stance on contractions themselves resonate Nathan's
comments on the PR, but I'd not oppose whatever documentation team
decides as it.

However on code comments themselves I believe we shouldn't impose
anything, while typo fixes and obvious mistakes should be fixed, I think
it would be too much of an imposition if we expect every PR to confirm
to a contract of non contractions

Best,
Abhishek

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
