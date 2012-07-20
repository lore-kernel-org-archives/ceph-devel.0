From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Increase number of PG
Date: Fri, 20 Jul 2012 13:15:45 -0700
Message-ID: <CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
References: <-6895602369310022884@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49187 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2GTUQG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 16:16:06 -0400
Received: by pbbrp8 with SMTP id rp8so6653755pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 13:16:05 -0700 (PDT)
In-Reply-To: <-6895602369310022884@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 20, 2012 at 8:31 AM, S=C5=82awomir Skowron <szibis@gmail.co=
m> wrote:
> I know that this feature is disabled, are you planning to enable this
> in near future ??

PG splitting/joining is the next major project for the OSD. It won't
be backported to argonaut, but it will be in the next stable release,
and will probably appear in our regular development release in 2-3
months.

> I have many of drives, and my S3 instalation use only few of them in
> one time, and i need to improve that.
>
> When i use it as rbd it use all of them.

Radosgw normally stores most of the data for a single S3-level object
in a single RADOS object, where as RBD stripes disk images across
objects by default in 4MB chunks. If you have only a few S3 objects,
you will see an uneven distribution. It will get more balanced as you
upload more images. Also, if you use multi-part uploads, each part
goes into a separate RADOS object, so that'll spread the load more
evenly.

Now, if your problem comes from the rgw pools having too few PGs to
begin with, the distribution will be.. lumpy.. even with more objects.
Here's another mailing list thread that talks about what you can do
about that: http://article.gmane.org/gmane.comp.file-systems.ceph.devel=
/8069
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
