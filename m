From: Sage Weil <sage@newdream.net>
Subject: Re: [GSoC] Queries regarding the Project
Date: Mon, 27 Mar 2017 13:47:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703271345110.10776@piezo.novalocal>
References: <CAAXqJ+omQh-sSv06i0Wo50JEVzGsin7Zoe4zKYTW9q=Eu_QUUw@mail.gmail.com> <CAJE9aOMqs+KiNqq-HWp3rhahZc37664o9L0JymJANBKGOdVAwg@mail.gmail.com> <CAAXqJ+pou7Fk9r8hm9FQqQOy+bFnjzLVyUXPpOZxr++U3apqkg@mail.gmail.com> <CAJE9aOOxuhHXCveDY71tdB2RGkotx=Gm-=jDEdSDLcWQffN7Rw@mail.gmail.com>
 <CAAXqJ+r-vcRmxOtJbwZDnv72M=q9+D-Wy2w2zeDXSk=TB2zYXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49370 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbdC0NsY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Mar 2017 09:48:24 -0400
In-Reply-To: <CAAXqJ+r-vcRmxOtJbwZDnv72M=q9+D-Wy2w2zeDXSk=TB2zYXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 27 Mar 2017, Spandan Kumar Sahu wrote:
> When CRUSH algorithm detects, that an object cannot be placed in a PG
> that came through the draw, does CRUSH not draw another PG, until the
> PG drawn can be written to?

Nope.  The assignment of of objects to PGs is a simple deterministic hash 
function and happens before CRUSH.  (CRUSH then maps pgids to OSDs.)

If we did something like you suggest then there would be many locations 
where an object could exist, you'd have to look in multiple locations to 
conclude it doesn't exist, and you'd have to deal with the range of race 
conditions that result from that due to, say, OSDs transitioning from full 
to non-full or back while you're deciding where to write or whether an 
object exists.

sage



> 
> On Mon, Mar 27, 2017 at 2:34 PM, kefu chai <tchaikov@gmail.com> wrote:
> > On Fri, Mar 24, 2017 at 8:08 PM, Spandan Kumar Sahu
> > <spandankumarsahu@gmail.com> wrote:
> >> I understand that, we can't write to objects which belong to the
> >> particular PG (the one having at least one full OSD). But a storage
> >> pool can have multiple PGs, and some of them must have only non-full
> >> OSDs. Through those PGs, we can write to the OSDs which are not full.
> >
> > but we cannot impose the restriction on the client that only a subset
> > of PGs of the given pool can be written.
> >
> >>
> >> Did I understand it correctly?
> >>
> >>
> >> On Fri, Mar 24, 2017 at 1:01 PM, kefu chai <tchaikov@gmail.com> wrote:
> >>> Hi Spandan,
> >>>
> >>> Please do not email me privately, instead use the public mailing list,
> >>> which allows other developers to provide you help if I am unable to do
> >>> so. it also means that you can start interacting with the rest of the
> >>> community instead of only me (barely useful).
> >>>
> >>> On Fri, Mar 24, 2017 at 2:38 PM, Spandan Kumar Sahu
> >>> <spandankumarsahu@gmail.com> wrote:
> >>>> Hi
> >>>>
> >>>> I couldn't figure out, why is this happening,
> >>>>
> >>>> "...Because once any of the storage device assigned to a storage pool is
> >>>> full, the whole pool is not writeable anymore, even there is abundant space
> >>>> in other devices."
> >>>> -- Ceph GSoC Project Ideas (Smarter reweight-by-utilisation)
> >>>>
> >>>> I went through this[1] paper on CRUSH, and according to what I understand,
> >>>> CRUSH pseudo-randomly chooses a device based on weights which can reflect
> >>>> various parameters like the amount of space available.
> >>>
> >>> CRUSH is a variant of consistent hashing. Ceph cannot automatically
> >>> choose *another* OSD which is not chosen by CRUSH, even if that OSD is
> >>> not full and has abundant space.
> >>>
> >>>>
> >>>> What I don't understand is, how will it stop a pool having abundant space on
> >>>> other devices, from getting selected, if one of its devices is full? Sure,
> >>>> the chances of getting selected might decrease, if one device is full, but
> >>>> how does it completely prevent writing to the pool?
> >>>
> >>> if a PG are served by three OSDs. if any of them is full, how can we
> >>> continue creating/writing to objects which belong to that PG?
> >>>
> >>>
> >>> --
> >>> Regards
> >>> Kefu Chai
> >>
> >>
> >>
> >> --
> >> Spandan Kumar Sahu
> >> IIT Kharagpur
> >
> >
> >
> > --
> > Regards
> > Kefu Chai
> 
> 
> 
> -- 
> Spandan Kumar Sahu
> IIT Kharagpur
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
