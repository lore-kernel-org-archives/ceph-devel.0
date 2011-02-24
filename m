From: Sage Weil <sage@newdream.net>
Subject: Re: C++ api for librados 0.25
Date: Thu, 24 Feb 2011 10:30:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102241029350.12531@cobra.newdream.net>
References: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
 <4D669D48.6060202@dreamhost.com> <AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45327 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab1BXS3L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 13:29:11 -0500
In-Reply-To: <AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, 24 Feb 2011, Colin McCabe wrote:
> > Also, what is the constructor Pool(Rados *rados_, pool_t *pool_)
> > intended to be used for? I don't see a method to get a pool_t from
> > this API.
> 
> Rados has to create Pools somehow, and that means they need a constructor.
> 
> It could be hidden deeper using the usual C++ bag of tricks (like
> private constructors and friend functions), but it didn't seem
> necessary.

What about a private constructor, and then in Rados have

	Pool *pool_open(const char *name);

IMO that's less weird than

	Rados::Pool *p = new Rados::Pool(...);
	rados->pool_open(name, p);

sage
