From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: building boost statically
Date: Thu, 28 Apr 2016 19:45:06 -0400 (EDT)
Message-ID: <847912519.21444831.1461887106208.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <robbat2-20160428T225021-424429122Z@orbis-terrarum.net> <alpine.DEB.2.11.1604281908430.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34335 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbcD1XpI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 19:45:08 -0400
In-Reply-To: <alpine.DEB.2.11.1604281908430.25990@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: ceph-devel@vger.kernel.org
> Sent: Thursday, April 28, 2016 7:14:15 PM
> Subject: Re: building boost statically
> 
> On Thu, 28 Apr 2016, Robin H. Johnson wrote:
> > On Thu, Apr 28, 2016 at 06:47:55PM -0400,  Sage Weil wrote:
> > > Hi all,
> > > 
> > > We'd really like to use the latest boost, mainly so that we can use
> > > small_vector in a zillion places and avoid extra memory allocations.  The
> > > distros, as always, are behind.
> >
> > From a distribution perspective, LESS static building is better, so this
> > proposal is a concern, but I do realize that the Gentoo/ArchLinux/CoreOS
> > perspective is very different than the Ubuntu LTS perspective.
> > 
> > What's the state of having a more-up-to-date Boost in things like Ubuntu
> > backports, so that you don't have the overhead of having to maintain
> > your own boost packages or statically link?
> >
> > If support for statically linking a newer Boost is brought it, please,
> > please keep dynamic boost builds as fully supported, for distributions
> > that can keep up to date. As a bonus, at some point in the future, when
> > the slower distributions catch up, you might be able to escape the
> > static again.
> 
> Yeah, having the option to either build statically or dynamically against
> an up-to-date distro is probably the right carrot/stick combination to
> incentivize the distros to move to a newer boost.

++

> 
> Being able to conditionally not use the new stuff (e.g., typedef
> small_vector<> back to vector<>) may or may not work well, depending on
> which new thing we're trying to use.

I wouldn't want to do that.

> 
> FWIW, we made the static -> dynamic transition with leveldb because the
> distros complained and it was nothing but sadness--so so many hours wasted
> chasing bugs in ancient distro versions of leveldb, and a huge matrix of
> version possibilities that made it difficult to reproduce user issues.  I
> can't tell if there was ever an instance where it actually gained us
> anything (e.g., security update in leveldb), but I kind of doubt it.

This reminds me--we seem to still have issues with distro leveldbs, rocksdbs and clang++.

Matt

> 
> sage
> --


-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
