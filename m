From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: denc nullptr issue
Date: Wed, 8 Mar 2017 12:44:26 -0500
Message-ID: <20170308174422.GD1780@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal>
 <20170308172209.GC1780@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1703081725510.10776@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdCHRpW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Mar 2017 12:45:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC4ED1293
        for <ceph-devel@vger.kernel.org>; Wed,  8 Mar 2017 17:44:27 +0000 (UTC)
Received: from ultraspiritum.eng.arb.redhat.com ([10.17.150.166])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id v28HiRNx008814
        for <ceph-devel@vger.kernel.org>; Wed, 8 Mar 2017 12:44:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1703081725510.10776@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 08/03/2017, Sage Weil wrote:
> That removes a lot of the flexibily of the current DENC.  OTOH, it
> might be that the set of cases where the above is insufficient and
> the current DENC still is is pretty small?

Well! In the bounded case we know there's a limit on the amount of
flexibility we /can/ have, just because we're not allowed to vary the
encoding based on anything BUT supplied feature bits, so I don't think
we have to worry about encodings.

I /suspect/ the amount of flexibility we'd end up using for bounded
objects if fairly small, though I can, as mentioned, think of fancier
things to do. (I think any interesting, likely cases could be handled
by const functions that take some set of class members and return some
stuff to be encoded. Which coudl be done in the same sort of
semideclarative style.)

> I'm inclined to just drop the trick and pass T() everywhere
> instead... at least until we have something better.  Objections?

Two potential ones. On the one hand that would require everything
dencable to be default constructible. That isn't a problem now but
it's something I'd like to not have be the case forever. (But that
bridge can be crossable in the Idealized Future.)

The more pressing objection might be that if the current idea is to
make sure bounded objects really /are/ bounded, passing T() might be
the worst of all worlds. If caught at compile time the problem goes
away. If caught at runtime with the nullptr it at least gives a
definite error in a useful place. If we pass T() then an object that
claims to be bounded but /isn't/ could calculate the wrong bound and
then we'd have to debug overruns or underruns or something.

Given that, I think if we're going to give up on this feature for now,
the 'least bad' alternative would be to just document the requirements
for an object that claims to be bounded but pass the supplied object
reference in all cases. We might have poorer performance from someone
violating the guarantee, but not outright incorrectness. Also errors
of this sort seem as if they should be easily eyeballed. One need only
look for objects that claim to be bounded and see how they implement
their bound_encode method.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
