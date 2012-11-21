From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Wed, 21 Nov 2012 14:05:17 -0800
Message-ID: <50AD501D.3060908@inktank.com>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com> <3210b770-431e-44ed-8d86-4610de89dd92@mailpro> <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com> <50ACF8C8.7020908@inktank.com> <50AD02AC.60802@inktank.com> <CAOLwVUmkPsPEC12VhWYz2TgH9-uaV-D7MbeQhXEmW7-pKuZ0NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49260 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab2KVT7J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:59:09 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6059493pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 11:59:09 -0800 (PST)
In-Reply-To: <CAOLwVUmkPsPEC12VhWYz2TgH9-uaV-D7MbeQhXEmW7-pKuZ0NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sequential is faster than random on a disk, but we are not
doing I/O to a disk, but a distributed storage cluster:

   small random operations are striped over multiple objects and
   servers, and so can proceed in parallel and take advantage of
   more nodes and disks.  This parallelism can overcome the added
   latencies of network I/O to yield very good throughput.

   small sequential read and write operations are serialized on
   a single server, NIC, and drive.  This serialization eliminates
   parallelism, and the network and other queuing delays are no
   longer compensated for.

This striping is a good idea for the small random I/O that is
typical of the way Linux systems talk to their disks.  But for
other I/O patterns, it is not optimal.

On 11/21/2012 01:47 PM, S=E9bastien Han wrote:
> Hi Mark,
>
> Well the most concerning thing is that I have 2 Ceph clusters and bot=
h
> of them show better rand than seq...
> I don't have enough background to argue on your assomptions but I
> could try to skrink my test platform to a single OSD and how it
> performs. We keep in touch on that one.
>
> But it seems that Alexandre and I have the same results (more rand
> than seq), he has (at least) one cluster and I have 2. Thus I start t=
o
> think that's not an isolated issue.
>
> Is it different for you? Do you usually get more seq IOPS from an RBD
> thant rand?
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
