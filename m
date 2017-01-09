From: Wido den Hollander <wido@42on.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Mon, 9 Jan 2017 17:10:03 +0100 (CET)
Message-ID: <1574188543.6346.1483978203643@ox.pcextreme.nl>
References: <592054113.6138.1483710244101@ox.pcextreme.nl>
 <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
 <308159841.6179.1483720942271@ox.pcextreme.nl>
 <CAN=+7FWbLpgDhoxH1QHgPBpMuDAUL2gg3QOhWGAE_9cKt=yBBA@mail.gmail.com>
 <CA+z5DsxYf7DGZTw2QCRMztQ13zFX5NZd3Kj62xFxmwhznosNmg@mail.gmail.com>
 <1927481418.6225.1483952382193@ox.pcextreme.nl>
 <CAN=+7FU7PfEiCRWr_wRJYSk1R=CJvGuUSy2xtvZ=oAXVoUvh9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:49179 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbdAIQKK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 11:10:10 -0500
In-Reply-To: <CAN=+7FU7PfEiCRWr_wRJYSk1R=CJvGuUSy2xtvZ=oAXVoUvh9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Blair Bethwaite <blair.bethwaite@gmail.com>


> Op 9 januari 2017 om 17:00 schreef Samuel Just <sjust@redhat.com>:
> 
> 
> 30M namespaces is not a problem since they are pretty much just object
> name prefixes.  30M different cephx users probably would be a problem.

Yes, figured so. Not going that route now. Will use namespaces to separate data from our application's users in RADOS to make it all future proof.

Don't want to play with object name prefixes if RADOS already provides this.

Hint: https://github.com/42on/librmb

Wido

> -Sam
> 
> On Mon, Jan 9, 2017 at 12:59 AM, Wido den Hollander <wido@42on.com> wrote:
> >
> >> Op 7 januari 2017 om 2:03 schreef Blair Bethwaite <blair.bethwaite@gmail.com>:
> >>
> >>
> >> On 7 January 2017 at 04:04, Samuel Just <sjust@redhat.com> wrote:
> >> > Namespaces are pretty much just a prefix, nothing tracks them.  Are
> >> > you using them simply to avoid name conflicts?
> >
> > Yes, but also to be able to list objects (I know, slow!) per 'user'.
> >
> >>
> >> I assumed for some sort of data and/or security segregation using
> >> cephx? 30M pools is not exactly feasible...
> >>
> >
> > Eventually yes. We have 30M users in this system now and using namespaces seems like a clean way to separate their data inside RADOS.
> >
> > Might use different cephx users in the future if we want to.
> >
> > Wido
> >
> >> --
> >> Cheers,
> >> ~Blairo
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
