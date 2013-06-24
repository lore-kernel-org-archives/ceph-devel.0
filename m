From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rgw: Added an encoder for time_t to fix compilation
Date: Mon, 24 Jun 2013 10:19:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306241017140.29802@cobra.newdream.net>
References: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com> <CABBk=J8J_tKY-Wy-sWb2=GREauqN0GfaJaHk14jzRVM0fx59Bg@mail.gmail.com> <CAA8043j7SpO-93KEgk1JQD=BYV=H8GwQVZYz=2LhkSZgVF+dBA@mail.gmail.com>
 <CAA8043gJKa-t_DWeHE-OeGThNGwdMjb83Ve4ENSxcUU3nSFM6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59660 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3FXRTc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 13:19:32 -0400
In-Reply-To: <CAA8043gJKa-t_DWeHE-OeGThNGwdMjb83Ve4ENSxcUU3nSFM6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

> Sorry, wrong patch attached.
> 
> Here comes the updated version.

This might work, but I'm worried that utime_t is probably typedef'd to a 
unsigned long or something and we may accidentally call into the uint32_t 
or uint64_t method (whichever it is for that platform).  I would prefer 
something like


Mything::encode(bufferlist& bl) const
{
  ...
  uint64_t t = time;
  ::encode(t, bl);
  ...
}

and similarly in decode to

  uint64_t t;
  ::decode(t, bl);
  time = t;

sage

> 
> Best regards.
> 
> On Mon, Jun 24, 2013 at 4:36 PM, christophe courtaut
> <christophe.courtaut@gmail.com> wrote:
> > Here come a new patch.
> >
> > I do not generate an encoder/decoder using WRITE_RAW_ENCODER anymore.
> >
> > Instead i added a encoder/decoder for time_t using a __u64.
> >
> > On Thu, Jun 20, 2013 at 10:44 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> >> On Thu, Jun 20, 2013 at 6:57 AM, christophe courtaut
> >> <christophe.courtaut@gmail.com> wrote:
> >>> On the rgw-wip-geo-2 branch, the encode decode function are called
> >>> with time_t now,
> >>> but there is no encode/decode function created for time_t type.
> >>>
> >>> http://tracker.ceph.com/issues/5402 refs #5402
> >>>
> >>> This patch adds a WRITE_RAW_ENCODER to support this type.
> >>>
> >>> --
> >>> Christophe Courtaut
> >>
> >>
> >> The problem here is that we can't use the generic encoder / decoder as
> >> time_t may have different size on different architectures. We should
> >> just have a fixed size encoding for it (probably 64 bit albeit the
> >> waste).
> >>
> >> Thanks,
> >> Yehuda
> >
> >
> >
> > --
> > Christophe Courtaut
> 
> 
> 
> -- 
> Christophe Courtaut
> 
