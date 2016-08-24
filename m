From: Sage Weil <sweil@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 16:23:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to> <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com> <alpine.DEB.2.11.1606271642550.2844@piezo.us.to> <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757076AbcHXQcl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 12:32:41 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEFAD13A99
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 16:23:05 +0000 (UTC)
In-Reply-To: <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On Wed, 24 Aug 2016, Adam C. Emerson wrote:
> On 24/08/2016, Matt Benjamin wrote:
> > Mark Nelson called attention to this topic again yesterday in #ceph-devel.
> >
> > We favor retaining the ability to re-declare specific asserts such that they are, as with assert in general historically, compiled out.  I think it's reasonable if this is a marked case.
> >
> > That seems to imply that if ceph_assert is the unmarked case, it won't be compiled out, so is essentially ceph_assert_always, as below (or else that form should be used...it's a little long).
> 
> If we want to go for brevity, we could have ceph_assert() be the
> unmarked case that functions just like assert macro.
> 
> Then we could use something like ceph_demand() (ceph_ultimatum?
> ceph_blackmail?) to indicate the case that isn't compiled out.
> 
> Personally, I would just like to get rid of Ceph's assert.h and its
> unending war with every other header file in the world. At one point
> killed off the header and linked in an object that overrode
> __assert_fail. This worked very well, though it would require handling
> every C library implementation we're compiled against.

This is appealing, except:

> > Note that using the system assert isn't a total disaster: system 
> > assert will trigger an abort, which will trigger the SIGABRT handler 
> > which *also* dumps a stack trace to the debug log.  The problem is 
> > that it doesn't show the assertion condition and line number.

I think not getting the assertion condition and line number in the ceph 
log is a deal breaker.


I would go for ceph_abort (abort with message in log etc), ceph_assert 
(may get compiled out in the future), and ceph_demand (never compiled 
out).

sage
