From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Increase number of PG
Date: Mon, 23 Jul 2012 18:46:57 +0200
Message-ID: <2440676923366115374@unknownmsgid>
References: <-6895602369310022884@unknownmsgid> <CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
 <E9D5D1F5A022447F836E2F731FFED769@inktank.com> <CAC-hyiGK9kNCdsCj4baS6ugrBD1scY3FfKMpy5jjtDk6+YOJ5A@mail.gmail.com>
 <-5358762692366662001@unknownmsgid> <CADvuQREG6Wcyq9uTDjgWxZpDOcY-9EY7-mtZS4UGD_rQ6YTfhw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46472 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2GWQq6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jul 2012 12:46:58 -0400
Received: by lbbgm6 with SMTP id gm6so8260331lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 09:46:57 -0700 (PDT)
In-Reply-To: <CADvuQREG6Wcyq9uTDjgWxZpDOcY-9EY7-mtZS4UGD_rQ6YTfhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok everything is clear now, Thanks. I will try this in planning service=
 works.

Regards

Slawomir Skowron.

On 23 lip 2012, at 18:00, Tommi Virtanen <tv@inktank.com> wrote:

> On Sun, Jul 22, 2012 at 11:57 PM, S=C5=82awomir Skowron <szibis@gmail=
=2Ecom> wrote:
>> My workload looks like this:
>>
>> - Max 20% are PUTs, with 99% of objects smaller then 4MB,
>> - 80% are GETs, and S3 metadata operations.
>
> Well, the good news is that that's actually the easy to fix part --
> just increase the number of PGs (which you currently have to do the
> awkward way, as explained earlier in this thread), nothing else
> needed.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
