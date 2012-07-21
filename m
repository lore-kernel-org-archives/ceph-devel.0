From: Gregory Farnum <greg@inktank.com>
Subject: Re: Increase number of PG
Date: Sat, 21 Jul 2012 10:13:09 -0700
Message-ID: <E9D5D1F5A022447F836E2F731FFED769@inktank.com>
References: <-6895602369310022884@unknownmsgid>
 <CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63964 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab2GURNM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Jul 2012 13:13:12 -0400
Received: by pbbrp8 with SMTP id rp8so8131027pbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 21 Jul 2012 10:13:12 -0700 (PDT)
In-Reply-To: <CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: =?utf-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>, ceph-devel@vger.kernel.org

On Fri, Jul 20, 2012 at 1:15 PM, Tommi Virtanen <tv@inktank.com (mailto=
:tv@inktank.com)> wrote:
> On Fri, Jul 20, 2012 at 8:31 AM, S=C5=82awomir Skowron <szibis@gmail.=
com (mailto:szibis@gmail.com)> wrote:
> > I know that this feature is disabled, are you planning to enable th=
is
> > in near future ??
> > =20
> =20
> =20
> PG splitting/joining is the next major project for the OSD. It won't
> be backported to argonaut, but it will be in the next stable release,
> and will probably appear in our regular development release in 2-3
> months.
> =20
> > I have many of drives, and my S3 instalation use only few of them i=
n
> > one time, and i need to improve that.
> > =20
> > When i use it as rbd it use all of them.
> =20
> Radosgw normally stores most of the data for a single S3-level object
> in a single RADOS object, where as RBD stripes disk images across
> objects by default in 4MB chunks. If you have only a few S3 objects,
> you will see an uneven distribution. It will get more balanced as you
> upload more images. Also, if you use multi-part uploads, each part
> goes into a separate RADOS object, so that'll spread the load more
> evenly.
> =20

RGW only does this for small objects =E2=80=94 I believe its default ch=
unk size is also 4MB.


But I'm pretty sure this is his problem:
> Now, if your problem comes from the rgw pools having too few PGs to
> begin with, the distribution will be.. lumpy.. even with more objects=
=2E
> Here's another mailing list thread that talks about what you can do
> about that: http://article.gmane.org/gmane.comp.file-systems.ceph.dev=
el/8069
> =20

-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
