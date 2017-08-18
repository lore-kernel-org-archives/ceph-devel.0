From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Requesting to change "doesn't" to "does not", isn't to "is not".
Date: Fri, 18 Aug 2017 12:10:06 -0400
Message-ID: <20170818161005.GA13493@ultraspiritum.eng.arb.redhat.com>
References: <md5:4EcWvCzo9b/7898pSLmrOQ==>
 <5996d47e.4ef9620a.e0733.1ba8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdHRQKH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 18 Aug 2017 12:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 074DD81DE3
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 16:10:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5996d47e.4ef9620a.e0733.1ba8@mx.google.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit <amitkuma@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 18/08/2017, Amit wrote:
[snip]
> Though "I am" instead of "I'm" -- both are completely correct English.
> But I read on PR, It suits more on ESL speakers and takes care of
> non-english speakers.

Speaking as someone who was a lingusit in a past life, there is some
research on this. ‘I'm’, ‘can't’, ‘don't’, and other simple
contractions do not harm comprehension by second-language
learners. (The humongous amount of channel coding in natural language
is on their side here and the brain is well-adapted to using it.)

Contractions that elide syntactic elements have been shown to cause
some, slight difficulty in parsing by second language learners. For
example:

I'd gone if he'd said something.

for

I would have gone if he had said something.

The difficulty is usually quite minor.

While this sort of contraction isn't easy to transform with a script,
it also doesn't show up in software documentation. It occurs in speech
and written dialog and isn't really a concern for us.

There's also the infamous back formation often written by native but
uneducated English speakers:

You should of come with me.

for

You should have come with me.

This is basic illiteracy and we should rise in wrath against^W^W^W^Wgently
and kindly correct anyone who writes it.

> Would be a step in including "Strong Phrases, Active voices" into
> documentation/Comments/std output..

It is thought that the passive voice being banned must be firmly
condemned by all. No place should be found in our hearts or our style
guides for such restrictions. Mistakes were made by many well-meaning
authors by whom advice has been given, and the passive voice's being
thrown into disrepute is ranked high among them.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
