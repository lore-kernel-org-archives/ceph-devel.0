From: Sage Weil <sage@newdream.net>
Subject: Re: Nodown/Noout by OSD_ID?
Date: Wed, 20 Jan 2016 10:26:30 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601201025140.4600@cpach.fuggernut.com>
References: <CAEYCsVLFUYAeKT_2bxyA1DpC5K5yzS6JHM=eJ=4WuGpjdypTnw@mail.gmail.com> <alpine.DEB.2.11.1601200813250.4600@cpach.fuggernut.com> <CALe9h7cqj+ck9-tKBgKuSx=4KcPSJnjO3O=eWSfV3yUT3J=QcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39560 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbcATP0X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 10:26:23 -0500
In-Reply-To: <CALe9h7cqj+ck9-tKBgKuSx=4KcPSJnjO3O=eWSfV3yUT3J=QcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Xiaoxi Chen <superdebuger@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 20 Jan 2016, John Spray wrote:
> On Wed, Jan 20, 2016 at 1:32 PM, Sage Weil <sage@newdream.net> wrote:
> > On Wed, 20 Jan 2016, Xiaoxi Chen wrote:
> >> Hi,
> >>
> >>      In many case we need to tag some OSD with NODOWN/NOOUT/NOUP/NOIN
> >> tag, but we dont want it cluster wise as these tag may stop other OSDs
> >> doing self-healthing.As a an example when an recovered OSD need to
> >> catch up with the OSDMap, to prevent flipping we set
> >> NODOWN/NOOUT/NOUP, but if other OSD failed by disk error, the failure
> >> will be hidden and we are in the risk of lossing the data.
> >>
> >>      Is that reasonable to have these flag work in OSD granularity?
> >> say ceph osd nodown osd.xxx?
> >>      Quick look at the code seems NODOWN/NOUP is easier as we could
> >> have new status bits in OSDMap
> >>      /* status bits */
> >> #define CEPH_OSD_EXISTS  (1<<0)
> >> #define CEPH_OSD_UP      (1<<1)
> >> #define CEPH_OSD_AUTOOUT (1<<2)  /* osd was automatically marked out */
> >> #define CEPH_OSD_NEW     (1<<3)  /* osd is new, never marked in */
> >>
> >> #define CEPH_OSD_NOUP     (1<<4)  /* osd cannot be marked in */
> >> #define CEPH_OSD_NODOWN     (1<<5)  /* osd cannot be marked out */
> >>
> >>      But for NOIN/NOOUT seems a bit struggle as IN/OUT depends on
> >> weight? Any suggestion?
> >
> > This looks reasonable if we can sort out a good interface and suitable
> > health warnings.  For example, ceph health and ceph -s should say "N osds
> > have noin set", and 'ceph health detail' should tell you which ones.
> >
> > Maybe something like
> >
> >  ceph osd set-osd osd.123 noin
> >
> > ?  I don't particularly like that but we can't do 'ceph osd set ...' since
> > that does global osdmap flags.
> 
> I think we should make this operate on arbitrary named CRUSH nodes
> rather than just OSDs, so that someone can mark a whole host/rack.

Good call!  Yeah, definitely.

I wonder if we should make a tree_flags map that lets you map existing 
state bits over a set of OSDs, or whether it should be an independent and 
new way to store hierarchical state.  Probably the latter is less prone to 
error.

sage

