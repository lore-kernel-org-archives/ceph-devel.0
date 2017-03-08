From: Sage Weil <sage@newdream.net>
Subject: Re: denc nullptr issue
Date: Wed, 8 Mar 2017 18:23:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703081820520.10776@piezo.novalocal>
References: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal> <20170308172209.GC1780@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1703081725510.10776@piezo.novalocal> <20170308174422.GD1780@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49227 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbdCHSZA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 13:25:00 -0500
In-Reply-To: <20170308174422.GD1780@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, 8 Mar 2017, Adam C. Emerson wrote:
> On 08/03/2017, Sage Weil wrote:
> > That removes a lot of the flexibily of the current DENC.  OTOH, it
> > might be that the set of cases where the above is insufficient and
> > the current DENC still is is pretty small?
> 
> Well! In the bounded case we know there's a limit on the amount of
> flexibility we /can/ have, just because we're not allowed to vary the
> encoding based on anything BUT supplied feature bits, so I don't think
> we have to worry about encodings.
> 
> I /suspect/ the amount of flexibility we'd end up using for bounded
> objects if fairly small, though I can, as mentioned, think of fancier
> things to do. (I think any interesting, likely cases could be handled
> by const functions that take some set of class members and return some
> stuff to be encoded. Which coudl be done in the same sort of
> semideclarative style.)

Thinking this through a bit more, I think the most common case is that you 
have a method with struct_v and compat_v values and some items exist only 
in later encodings.  That isn't easily captured in a macro like the 
above...

> > I'm inclined to just drop the trick and pass T() everywhere
> > instead... at least until we have something better.  Objections?
> 
> Two potential ones. On the one hand that would require everything
> dencable to be default constructible. That isn't a problem now but
> it's something I'd like to not have be the case forever. (But that
> bridge can be crossable in the Idealized Future.)
> 
> The more pressing objection might be that if the current idea is to
> make sure bounded objects really /are/ bounded, passing T() might be
> the worst of all worlds. If caught at compile time the problem goes
> away. If caught at runtime with the nullptr it at least gives a
> definite error in a useful place. If we pass T() then an object that
> claims to be bounded but /isn't/ could calculate the wrong bound and
> then we'd have to debug overruns or underruns or something.
> 
> Given that, I think if we're going to give up on this feature for now,
> the 'least bad' alternative would be to just document the requirements
> for an object that claims to be bounded but pass the supplied object
> reference in all cases. We might have poorer performance from someone
> violating the guarantee, but not outright incorrectness. Also errors
> of this sort seem as if they should be easily eyeballed. One need only
> look for objects that claim to be bounded and see how they implement
> their bound_encode method.

Oh, right.  Yeah, let's do that.  I guess we just have to be a bit careful 
with the containers so that they call denc on the first item only if it is 
non-empty() (vs blindly multiplying elem_size by size() like they do now).

sage
