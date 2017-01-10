From: Wido den Hollander <wido@42on.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Tue, 10 Jan 2017 08:59:56 +0100 (CET)
Message-ID: <1695028895.6375.1484035196479@ox.pcextreme.nl>
References: <592054113.6138.1483710244101@ox.pcextreme.nl>
 <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
 <308159841.6179.1483720942271@ox.pcextreme.nl>
 <CAN=+7FWbLpgDhoxH1QHgPBpMuDAUL2gg3QOhWGAE_9cKt=yBBA@mail.gmail.com>
 <CA+z5DsxYf7DGZTw2QCRMztQ13zFX5NZd3Kj62xFxmwhznosNmg@mail.gmail.com>
 <1927481418.6225.1483952382193@ox.pcextreme.nl>
 <CAN=+7FU7PfEiCRWr_wRJYSk1R=CJvGuUSy2xtvZ=oAXVoUvh9A@mail.gmail.com>
 <CAJ4mKGZDc2=9Jg7EyWhvtnp2uBcmSA7ULx9_tHpc=d0nrLbajg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57899 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933106AbdAJIFA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2017 03:05:00 -0500
In-Reply-To: <CAJ4mKGZDc2=9Jg7EyWhvtnp2uBcmSA7ULx9_tHpc=d0nrLbajg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Blair Bethwaite <blair.bethwaite@gmail.com>


> Op 9 januari 2017 om 23:34 schreef Gregory Farnum <gfarnum@redhat.com>:
> 
> 
> On Mon, Jan 9, 2017 at 8:00 AM, Samuel Just <sjust@redhat.com> wrote:
> > 30M namespaces is not a problem since they are pretty much just object
> > name prefixes.  30M different cephx users probably would be a problem.
> > -Sam
> 
> This is sort of the interesting bit of the problem. If you have a
> limited number of users you want to be able to collectively read 30M
> namespaces (without wide permissions) then you need to *enumerate*
> those 30M namespaces within their keyrings, and the OSDAuthCaps
> structure is unlikely to handle that well (although we don't really
> know).
> 

Yes, it is. For us it is currently not a problem. We are just going to use the namespaces with a key that has access to all the data in a pool. We might do something in the future with limiting keys to a namespace, but that's not relevant right now for us.

Good point though Greg.

Wido

> Otherwise, you need a different keyring for each namespace, and that
> has two separate points of contention:
> 1) If they're all online frequently, that's a whole bunch of
> independent connections to the OSDs. (I sort of assume this is not
> likely.)
> 2) Storing each of those keyrings in the monitor LevelDB instances. I
> think the only analogue here is the limited throughput of very large
> RWG bucket indices; I think the situation ought to be quite a bit
> better for the monitors — but I don't have any real data about it.
> -Greg
> 
> >
> > On Mon, Jan 9, 2017 at 12:59 AM, Wido den Hollander <wido@42on.com> wrote:
> >>
> >>> Op 7 januari 2017 om 2:03 schreef Blair Bethwaite <blair.bethwaite@gmail.com>:
> >>>
> >>>
> >>> On 7 January 2017 at 04:04, Samuel Just <sjust@redhat.com> wrote:
> >>> > Namespaces are pretty much just a prefix, nothing tracks them.  Are
> >>> > you using them simply to avoid name conflicts?
> >>
> >> Yes, but also to be able to list objects (I know, slow!) per 'user'.
> >>
> >>>
> >>> I assumed for some sort of data and/or security segregation using
> >>> cephx? 30M pools is not exactly feasible...
> >>>
> >>
> >> Eventually yes. We have 30M users in this system now and using namespaces seems like a clean way to separate their data inside RADOS.
> >>
> >> Might use different cephx users in the future if we want to.
> >>
> >> Wido
> >>
> >>> --
> >>> Cheers,
> >>> ~Blairo
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
