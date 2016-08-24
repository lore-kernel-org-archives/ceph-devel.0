From: Sage Weil <sage@newdream.net>
Subject: Re: assert
Date: Wed, 24 Aug 2016 16:26:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608241625330.25681@piezo.us.to>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to> <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com> <alpine.DEB.2.11.1606271642550.2844@piezo.us.to> <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com> <e27ed37d-be2c-47d1-587f-91735e42ab15@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47123 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757021AbcHXQ0f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 12:26:35 -0400
In-Reply-To: <e27ed37d-be2c-47d1-587f-91735e42ab15@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 24 Aug 2016, Casey Bodley wrote:
> On 08/24/2016 11:45 AM, Adam C. Emerson wrote:
> > On 24/08/2016, Matt Benjamin wrote:
> > > Mark Nelson called attention to this topic again yesterday in #ceph-devel.
> > > 
> > > We favor retaining the ability to re-declare specific asserts such that
> > > they are, as with assert in general historically, compiled out.  I think
> > > it's reasonable if this is a marked case.
> > > 
> > > That seems to imply that if ceph_assert is the unmarked case, it won't be
> > > compiled out, so is essentially ceph_assert_always, as below (or else that
> > > form should be used...it's a little long).
> > If we want to go for brevity, we could have ceph_assert() be the
> > unmarked case that functions just like assert macro.
> > 
> > Then we could use something like ceph_demand() (ceph_ultimatum?
> > ceph_blackmail?) to indicate the case that isn't compiled out.
> > 
> > Personally, I would just like to get rid of Ceph's assert.h and its
> > unending war with every other header file in the world. At one point
> > killed off the header and linked in an object that overrode
> > __assert_fail. This worked very well, though it would require handling
> > every C library implementation we're compiled against.
> > 
> 
> I dug up an old commit as an example of overriding libc's __assert_fail()
> function, which would allow us to use the system's assert.h as is:
> https://github.com/cohortfsllc/cohortfs-ceph/commit/40956ad3661192462246ed7e5435522c5708ffbc

Oh, this looks nice.

In that case, we still need a ceph_abort (and an associated cleanup).

I think we also still need some distinction between asserts that are safe 
to compile out and those that are not, though.

sage
