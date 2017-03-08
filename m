From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: denc nullptr issue
Date: Wed, 8 Mar 2017 13:04:24 -0500
Message-ID: <20170308180342.GE1780@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal>
 <20170308172209.GC1780@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1703081725510.10776@piezo.novalocal>
 <20170308174422.GD1780@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGZ1RSKR6_39r9bMd1=Dm_m2y7ZoNH6LkEoum-J-33fizg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbdCHSMg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Mar 2017 13:12:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7046C04BD29
        for <ceph-devel@vger.kernel.org>; Wed,  8 Mar 2017 18:04:25 +0000 (UTC)
Received: from ultraspiritum.eng.arb.redhat.com ([10.17.150.166])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v28I4POU011960
        for <ceph-devel@vger.kernel.org>; Wed, 8 Mar 2017 13:04:25 -0500
Content-Disposition: inline
In-Reply-To: <CAJ4mKGZ1RSKR6_39r9bMd1=Dm_m2y7ZoNH6LkEoum-J-33fizg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 08/03/2017, Gregory Farnum wrote:
> I haven't followed this discussion closely, but when I saw your macro
> usage the thing that struck me was the lack of versioning, which is
> what I assume Sage is referring to. If there's a good way to define
> versioned encoding that would probably be fine?
> Unless the nullptr issue strikes more complicated structures — we need
> to hand-write the OSDMap encoder for instance, and clever macros will
> never be clever enough for that.
> -Greg

At least as far as I'm aware the only way we could output different
versions would be in response to feature bits, since bounded objects
are only allowed to depend on the type and the set of feature bits for
the size.

I think doing something based on feature bits is doable, though it
might be slightly baroque and tempt a combinatorial explosion for
something that is bounded and features and varies quite a bit with a
lot of bits.

To be honest while this might be fun to write, it's probably more of a
compile-time-DSL than the value of the check warrants, so I think I'd
advocate just taking 'bounded' as an annotation by the author of a
class and leaving it up to him to make sure his class actually is
bounded.

> >
> >> I'm inclined to just drop the trick and pass T() everywhere
> >> instead... at least until we have something better.  Objections?
> >
> > Two potential ones. On the one hand that would require everything
> > dencable to be default constructible. That isn't a problem now but
> > it's something I'd like to not have be the case forever. (But that
> > bridge can be crossable in the Idealized Future.)
> >
> > The more pressing objection might be that if the current idea is to
> > make sure bounded objects really /are/ bounded, passing T() might be
> > the worst of all worlds. If caught at compile time the problem goes
> > away. If caught at runtime with the nullptr it at least gives a
> > definite error in a useful place. If we pass T() then an object that
> > claims to be bounded but /isn't/ could calculate the wrong bound and
> > then we'd have to debug overruns or underruns or something.
> >
> > Given that, I think if we're going to give up on this feature for now,
> > the 'least bad' alternative would be to just document the requirements
> > for an object that claims to be bounded but pass the supplied object
> > reference in all cases. We might have poorer performance from someone
> > violating the guarantee, but not outright incorrectness. Also errors
> > of this sort seem as if they should be easily eyeballed. One need only
> > look for objects that claim to be bounded and see how they implement
> > their bound_encode method.
> >
> > --
> > Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> > IRC: Aemerson@{RedHat, OFTC}
> > 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
