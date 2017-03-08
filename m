From: Sage Weil <sage@newdream.net>
Subject: Re: denc nullptr issue
Date: Wed, 8 Mar 2017 17:28:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703081725510.10776@piezo.novalocal>
References: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal> <20170308172209.GC1780@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48980 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdCHR26 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 12:28:58 -0500
In-Reply-To: <20170308172209.GC1780@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, 8 Mar 2017, Adam C. Emerson wrote:
> On 07/03/2017, Sage Weil wrote:
> > We have three competing PRs to address the crashes when -O0 is used:
> > 
> > lixiaoy1	https://github.com/ceph/ceph/pull/12796
> > kefu		https://github.com/ceph/ceph/pull/13819
> > adam		https://github.com/ceph/ceph/pull/12931
> > 
> > Adam's is appealing because it will ensure the bounded encodes are in fact 
> > constant at compile time.  Unfortunately, it requires you to define DENC 
> > twice, like so:
> > 
> > -  DENC_FEATURED(bar_t, v, p, f) {
> > +  DENC_FEATURED_BOUNDED(bar_t, v, p, f) {
> >      ::denc(v.a, p, f);
> >      ::denc(v.b, p, f);
> >    }
> > +  DENC_FEATURED_BOUND_ENCODE(bar_t, p, f) {
> > +    DENC_START(1, 1, p);
> > +    ::denc(bounded_t<decltype(bar_t::a)>{}, p, f);
> > +    ::denc(bounded_t<decltype(bar_t::b)>{}, p, f);
> > +    DENC_FINISH(p);
> > +  }
> > 
> > which feels like a deal-killer to me... I think I'd rather just drop the 
> > check entirely and rely on the developer to be careful.
> 
> I have an fix for that in mind (it's why I haven't been pushing that
> PR too hard) but it's complicated.
> 
> Essentially, for bounded types, I /think/ I can hack together a way
> let people do something like:
> 
> struct Foo {
>   TypeA a;
>   TypeB b;
>   TypeC c;
> };
> 
> BUILD_BOUNDED_DENC(Foo, &Foo::a, &Foo::b, &Foo::c);
> 
> and not have to divide things up. We could probably go things
> involving fancier pants to handle features and other stuff.

That removes a lot of the flexibily of the current DENC.  OTOH, it might 
be that the set of cases where the above is insufficient and the current 
DENC still is is pretty small?
 
> > The other two PRs fix up the handful of type(s) that were actually
> > causing failures to manually define bound (again making the single
> > DENC macro unusable).
> > 
> > What about instead changing all of the instances of
> > 
> >       denc(*(const T*)nullptr, elem_size);
> > 
> > with a macro that will either do the above "*(const T*)nullptr" -or-, if 
> > it looks like this is a debug build or compiler optimizations are off or 
> > some other compiler environment indicates it won't work, replace it with 
> > "T()"?  That avoids crashes in the -O0 case, but still lets us keep some 
> > safeguard for other builds?
> 
> I would really, really rather not do this. The whole nullptr trick is
> definitely one of the black rituals of Nasal Goetia. Even if
> redefining it happens to make -O0 on gcc work now, other compilers,
> GCC on other architectures, or other versions of GCC are free to start
> crashing again.

I'm inclined to just drop the trick and pass T() everywhere instead... at 
least until we have something better.  Objections?

sage
