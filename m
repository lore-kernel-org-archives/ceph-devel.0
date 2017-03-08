From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: denc nullptr issue
Date: Wed, 8 Mar 2017 09:52:22 -0800
Message-ID: <CAJ4mKGZ1RSKR6_39r9bMd1=Dm_m2y7ZoNH6LkEoum-J-33fizg@mail.gmail.com>
References: <alpine.DEB.2.11.1703072243100.24356@piezo.novalocal>
 <20170308172209.GC1780@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1703081725510.10776@piezo.novalocal>
 <20170308174422.GD1780@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36377 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbdCHRxO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 12:53:14 -0500
Received: by mail-oi0-f43.google.com with SMTP id 126so23789251oig.3
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 09:52:23 -0800 (PST)
In-Reply-To: <20170308174422.GD1780@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Mar 8, 2017 at 9:44 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 08/03/2017, Sage Weil wrote:
>> That removes a lot of the flexibily of the current DENC.  OTOH, it
>> might be that the set of cases where the above is insufficient and
>> the current DENC still is is pretty small?
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

I haven't followed this discussion closely, but when I saw your macro
usage the thing that struck me was the lack of versioning, which is
what I assume Sage is referring to. If there's a good way to define
versioned encoding that would probably be fine?
Unless the nullptr issue strikes more complicated structures — we need
to hand-write the OSDMap encoder for instance, and clever macros will
never be clever enough for that.
-Greg

>
>> I'm inclined to just drop the trick and pass T() everywhere
>> instead... at least until we have something better.  Objections?
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
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
