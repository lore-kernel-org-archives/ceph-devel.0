From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph osd crush add - uknown command crush
Date: Fri, 22 Jun 2012 23:26:17 -0700
Message-ID: <0F418367B1BD43F2A50EC0CBD0043A7A@inktank.com>
References: <CAMwB3TjS_r-U55py7WPu1RZmNob78nodB6a=i9sb1sx3mxvXDw@mail.gmail.com>
 <271B7E7C4B014BFE86FC17F9AF863BD8@inktank.com>
 <CACkq2moDXngPxLZ3Tb36SW_R+E-P-aE1vGELsK7mWa2XHBPJqQ@mail.gmail.com>
 <CAPYLRzhTzMwORq75WJ81Lx6dTow=RFwFb4D57Z=e1wDVGYnXEQ@mail.gmail.com>
 <B0F7A6F1-020D-4CAB-BCFF-22C8CA4B068A@barryp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53004 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229Ab2FWG0V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 02:26:21 -0400
Received: by pbbrp8 with SMTP id rp8so4434107pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 23:26:21 -0700 (PDT)
In-Reply-To: <B0F7A6F1-020D-4CAB-BCFF-22C8CA4B068A@barryp.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barry Pederson <bp@barryp.org>
Cc: ceph-devel@vger.kernel.org

On Thursday, June 21, 2012 at 11:12 AM, Barry Pederson wrote:
> =20
> On Jun 20, 2012, at 4:59 PM, Gregory Farnum wrote:
> > On Wed, Jun 20, 2012 at 2:53 PM, Travis Rhoden <trhoden@gmail.com (=
mailto:trhoden@gmail.com)> wrote:
> > > This incorrect syntax is still published in the docs at
> > > http://ceph.com/docs/master/ops/manage/crush/#adjusting-crush
> > > =20
> > > Are the docs that end up on that page in GitHub? I'd be happy to
> > > start making fixes and issuing pull-request. I've run into a few
> > > gotchas when following the commands on those pages.
> > =20
> > Yes, they are in git! All the docs are generated from the sources i=
n
> > doc/ under the same hierarchy as on the website. The page you're
> > interested in is at "{ceph_root}/doc/ops/manage/crush.rst".
> =20
> =20
> =20
> I'm playing with ceph, and just now adding a 2nd node to an existing =
cluster, and unfortunately still see the old commands on that webpage. =
Can somebody give be a quick hint what the new equivalent to =20
> =20
> ceph osd crush add 123 osd.123 1.0 pool=3Ddefault rack=3Drackbar host=
=3Dhostfoo
> =20


You're looking for "ceph osd crush set=E2=80=A6."
The docs have been updated now, thanks to a pull request from Travis. :=
)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
