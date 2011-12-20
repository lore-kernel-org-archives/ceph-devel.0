From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how many MDS active daemons to run
Date: Tue, 20 Dec 2011 15:39:52 -0800
Message-ID: <CAF3hT9B0jq0adbT2hy6TjFyzs9TcRfVapnXEV0OAjrnby553zg@mail.gmail.com>
References: <4EF11A83.2030006@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41727 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab1LTXjx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 18:39:53 -0500
Received: by iaeh11 with SMTP id h11so10940404iae.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 15:39:52 -0800 (PST)
In-Reply-To: <4EF11A83.2030006@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, Dec 20, 2011 at 3:30 PM, Matt Weil <mweil@genome.wustl.edu> wro=
te:
> Hello all:
>
> given six osd servers does it make any difference of each one also ru=
ns a
> mds or not?
>
> How many mds's is to many. =A0How does this effect metadata performan=
ce.
Right now a single-MDS system is significantly more stable than a
system with multiple active MDSes, so if possible you should use that
configuration. Only add MDSes when you need more metadata throughput
(probably you only need one).

Adding more MDSes should increase metadata throughput; it wouldn't
surprise me if you could construct a set of operations that slow down
but you're not going to run into one by mistake.

However, if you just start up a metadata server on each OSD node
without changing the max_mds parameter, what you'll actually get is
one active MDS and 5 standby daemons, which will be fine and give you
lots of changes to fail over your MDS in the event of crashes. ;)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
