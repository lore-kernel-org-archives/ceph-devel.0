From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 12:26:43 -0400
Message-ID: <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
 <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755177AbcHXQ1s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 12:27:48 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8E1A4E4DB
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 16:27:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On 24/08/2016, Sage Weil wrote:
[snip]
> This is appealing, except:
> 
> > > Note that using the system assert isn't a total disaster: system 
> > > assert will trigger an abort, which will trigger the SIGABRT handler 
> > > which *also* dumps a stack trace to the debug log.  The problem is 
> > > that it doesn't show the assertion condition and line number.
[snip]
> I think not getting the assertion condition and line number in the
> ceph log is a deal breaker.

We should be able to get the condition and line number in the log,
they're passed to __assert_fail() so we could pass them to
ceph_assert_fail (see the commit that Casey linked to.)

I can see arguments either way, the main one I would make AGAINST this
approach is that it makes portability/building more complicated.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
