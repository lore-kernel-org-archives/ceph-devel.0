From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Increase number of PG
Date: Mon, 23 Jul 2012 09:00:15 -0700
Message-ID: <CADvuQREG6Wcyq9uTDjgWxZpDOcY-9EY7-mtZS4UGD_rQ6YTfhw@mail.gmail.com>
References: <-6895602369310022884@unknownmsgid> <CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
 <E9D5D1F5A022447F836E2F731FFED769@inktank.com> <CAC-hyiGK9kNCdsCj4baS6ugrBD1scY3FfKMpy5jjtDk6+YOJ5A@mail.gmail.com>
 <-5358762692366662001@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46047 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab2GWQAg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jul 2012 12:00:36 -0400
Received: by vbbff1 with SMTP id ff1so4814058vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 09:00:36 -0700 (PDT)
In-Reply-To: <-5358762692366662001@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jul 22, 2012 at 11:57 PM, S=C5=82awomir Skowron <szibis@gmail.c=
om> wrote:
> My workload looks like this:
>
> - Max 20% are PUTs, with 99% of objects smaller then 4MB,
> - 80% are GETs, and S3 metadata operations.

Well, the good news is that that's actually the easy to fix part --
just increase the number of PGs (which you currently have to do the
awkward way, as explained earlier in this thread), nothing else
needed.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
