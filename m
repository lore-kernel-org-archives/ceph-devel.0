From: Greg Farnum <greg@inktank.com>
Subject: Re: mds dump
Date: Fri, 8 Jun 2012 12:46:15 -0700
Message-ID: <96F588468D534E32AFF4784464C393E7@inktank.com>
References: <Pine.LNX.4.64.1206080857530.8391@cobra.newdream.net>
 <cacaf6c2-6adf-456e-85b3-b33a4f477cf7@mail.linserv.se>
 <CADvuQRHR-EL+GpSgFUcSzQa1Jg++2LHvj83ZF3L1T_zT+NUqoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48499 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933432Ab2FHTqU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:46:20 -0400
Received: by pbbrp8 with SMTP id rp8so2953120pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 12:46:20 -0700 (PDT)
In-Reply-To: <CADvuQRHR-EL+GpSgFUcSzQa1Jg++2LHvj83ZF3L1T_zT+NUqoA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Martin Wilderoth <martin.wilderoth@linserv.se>, ceph-devel <ceph-devel@vger.kernel.org>

On Friday, June 8, 2012 at 12:31 PM, Tommi Virtanen wrote:
> On Fri, Jun 8, 2012 at 12:22 PM, Martin Wilderoth
> <martin.wilderoth@linserv.se (mailto:martin.wilderoth@linserv.se)> wr=
ote:
> > I have removed the data and metadata pool. Do I need to create them=
 again, or
> > will they be created automaticly.
> > Maybe I need the undocumented way of creating the mds map ?. I woul=
d like to
> > get an empty cephfs to play with again.
> =20
> =20
> =20
> Just create them again with rados mkpool, that gets you back to squar=
e one.
Actually, this doesn't =E2=80=94 the MDS uses pool IDs for its access, =
not pool names, so you need to do a bit more (Sage illustrated the simp=
lest route for handling that).
-Greg


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
