From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: Re: How will Ceph cope with a failed Journal device?
Date: Fri, 18 May 2012 12:36:13 -0600
Message-ID: <CADxhoDTe5mO5-pAzBoZYesCw8MV4TUUzBCYMmmwPfKU4otTrNg@mail.gmail.com>
References: <2465580.E9977TXsHv@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52696 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758180Ab2ERSgO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 14:36:14 -0400
Received: by wibhj8 with SMTP id hj8so434674wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 11:36:13 -0700 (PDT)
In-Reply-To: <2465580.E9977TXsHv@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

I posted the same question to the list last week and never got a
reply.  In addition, I'd also like to know if there's a difference in
failure behavior between XFS backed Ceph (writeahead journaling) and
BTRFS backed Ceph (parallel journaling).

Calvin

On Fri, May 18, 2012 at 12:30 PM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Hi,
>
> We have been having a lot of discussions at my workplace about whethe=
r to
> employ a Ceph cluster in production or not, and if yes, how to set up=
 the
> hardware for it. During that discussion, I mentioned that, according =
to the
> documentation, we should see significant speedups from using dedicate=
d SSDs
> for the OSD's journals. Unfortunately, my colleagues did not like thi=
s idea at
> all - many of them had bad experiences with SSDs failing or at least =
read a
> lot about that on the Internet, and there's a general consensus that =
SSDs are
> just not quite reliable enough yet for production servers.
>
> This leads me to the question: What exactly can happen if an OSD's jo=
urnal
> device suddenly fails during operations? Can that lead to data loss o=
r
> corruption, or disruptions of the service?
>
> In my experience with the small three-machine test cluster I have her=
e, a
> single failed node usually would lead to a pretty severe outage of th=
e entire
> cluster on the order of ten minutes or more (probably much more when =
it's a
> really big node that fails), though so far no data loss or corruption=
=2E..
>
> Regards,
>
> =A0 =A0 =A0 =A0Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
