From: Sage Weil <sweil@redhat.com>
Subject: Re: Confused about SnapMapper::get_prefix
Date: Sun, 8 Feb 2015 07:07:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502080707030.27042@cobra.newdream.net>
References: <CANf+_kL0_tYtF+vDvLSTPP5LtP_4P6r9_M5qu7VeyP2GYfFw9Q@mail.gmail.com> <CAC6JEv8zKQZ8JVQrfo3bu=AW-xuHfOAC_NN260ywzboFVLuryA@mail.gmail.com> <CA+4uBUYP=eVxgQ0ur4x8kowfCf=uh+YETqL08WyY3an7QFfDZQ@mail.gmail.com> <CA+4uBUbAAKEX9YL2ZcgxumvzCkOYcCnT6CAC59ZBSN2kb7ygOA@mail.gmail.com>
 <CANf+_k+unMa4NNEGnF1bjgg8VYHG=NYTJ-BhrP+qX2aGEODG-g@mail.gmail.com> <CANf+_kLDDEAy2Ra-3U-zXiuHnTG+q9TO2it5eWmRYzpBYm4i-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbbBHPHT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 8 Feb 2015 10:07:19 -0500
In-Reply-To: <CANf+_kLDDEAy2Ra-3U-zXiuHnTG+q9TO2it5eWmRYzpBYm4i-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ding Dinghua <dingdinghua85@gmail.com>
Cc: sjust@redhat.com, Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This looks right to me.  Sam?

sage


On Sun, 8 Feb 2015, Ding Dinghua wrote:

> Ping..
> 
> I think so, snap_id is defined and used as uint64_t in ceph, but here
> static_cast may introduce bug, since two snap_id may get the same
> prefix, then same key in snap_mapper.
> 
> diff --git a/src/osd/SnapMapper.cc b/src/osd/SnapMapper.cc
> index 315e2e2..27cc2b7 100644
> --- a/src/osd/SnapMapper.cc
> +++ b/src/osd/SnapMapper.cc
> @@ -72,8 +72,7 @@ string SnapMapper::get_prefix(snapid_
> t snap)
>    char buf[100];
>    int len = snprintf(
>      buf, sizeof(buf),
> -    "%.*X_", (int)(sizeof(snap)*2),
> -    static_cast<unsigned>(snap));
> +    "%.*llX_", (int)(sizeof(snap)*2), snap);
> 
> 2015-02-04 12:02 GMT+08:00 Ding Dinghua <dingdinghua85@gmail.com>:
> > I think so, snap_id is defined and used as uint64_t in ceph, but here
> > static_cast may introduce bug, since two snap_id may get the same
> > prefix, then same key in snap_mapper.
> >
> > diff --git a/src/osd/SnapMapper.cc b/src/osd/SnapMapper.cc
> > index 315e2e2..27cc2b7 100644
> > --- a/src/osd/SnapMapper.cc
> > +++ b/src/osd/SnapMapper.cc
> > @@ -72,8 +72,7 @@ string SnapMapper::get_prefix(snapid_
> > t snap)
> >    char buf[100];
> >    int len = snprintf(
> >      buf, sizeof(buf),
> > -    "%.*X_", (int)(sizeof(snap)*2),
> > -    static_cast<unsigned>(snap));
> > +    "%.*llX_", (int)(sizeof(snap)*2), snap);
> >
> > 2015-02-04 1:25 GMT+08:00 Samuel Just <sam.just@inktank.com>:
> >> Should probably be cast to long unsigned with lX conversion specifier?
> >> -Sam
> >>
> >> On Tue, Feb 3, 2015 at 9:21 AM, Samuel Just <sam.just@inktank.com> wrote:
> >>> It looks like snapid_t is a uint64_t, but snprintf expects an unsigned there.
> >>> -Sam
> >>>
> >>> On Tue, Feb 3, 2015 at 9:15 AM, Gregory Farnum <greg@gregs42.com> wrote:
> >>>> On Tue, Feb 3, 2015 at 4:12 AM, Ding Dinghua <dingdinghua85@gmail.com> wrote:
> >>>>> Hi all:
> >>>>>       I don't understand why SnapMapper::get_prefix   static_cast snap
> >>>>> to unsigned:
> >>>>>
> >>>>> string SnapMapper::get_prefix(snapid_t snap)
> >>>>> {
> >>>>>   char buf[100];
> >>>>>   int len = snprintf(
> >>>>>     buf, sizeof(buf),
> >>>>>     "%.*X_", (int)(sizeof(snap)*2),
> >>>>>     static_cast<unsigned>(snap));
> >>>>>   return MAPPING_PREFIX + string(buf, len);
> >>>>> }
> >>>>>
> >>>>> Will this limit snapshot count in pool to 2^32 -1 ?
> >>>>>
> >>>>> Could anyone clarify ? Thanks
> >>>>
> >>>> I think the code base is a little confused about whether snaps should
> >>>> be 32 or 64 bits in various places. :( That said, the size of unsigned
> >>>> can vary across architectures, so this should probably be sized more
> >>>> explicitly as whatever it's supposed to be on the disk...
> >
> >
> >
> > --
> > Ding Dinghua
> 
> 
> 
> -- 
> Ding Dinghua
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
