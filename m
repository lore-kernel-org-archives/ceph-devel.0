From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph Benchmark HowTo
Date: Wed, 25 Jul 2012 13:25:20 -0700
Message-ID: <CAPYLRzjkEisL6GqXQDMJUnYbiObRBSw-jELXr7u2Je=zFk4hqg@mail.gmail.com>
References: <20120724144300.GA3317@mail.sileht.net>
	<CAPUexz-G2R_amz9_Eh7bisOVrOC66uowMqavvdg7n87XTz56QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52546 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751074Ab2GYUZW convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Jul 2012 16:25:22 -0400
Received: by lahd3 with SMTP id d3so877227lah.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 13:25:20 -0700 (PDT)
In-Reply-To: <CAPUexz-G2R_amz9_Eh7bisOVrOC66uowMqavvdg7n87XTz56QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Mehdi Abaakouk <sileht@sileht.net>, ceph-devel@vger.kernel.org

On Wed, Jul 25, 2012 at 1:06 PM, Florian Haas <florian@hastexo.com> wro=
te:
> Hi Mehdi,
>
> great work! A few questions (for you, Mark, and anyone else watching
> this thread) regarding the content of that wiki page:
>
> For the OSD tests, which OSD filesystem are you testing on? Are you
> using a separate journal device? If yes, what type?
>
> For the RADOS benchmarks:
>
> # rados bench -p pbench 900 seq
> ...
>    611      16     17010     16994   111.241       104   1.05852  0.5=
74897
>    612      16     17037     17021   111.236       108   1.17321  0.5=
74932
>    613      16     17056     17040   111.178        76   1.01611  0.5=
74903
>  Total time run:        613.339616
> Total reads made:     17056
> Read size:            4194304
> Bandwidth (MB/sec):    111.234
>
> Average Latency:       0.575252
> Max latency:           1.65182
> Min latency:           0.07418
>
> How meaningful is it to use a (arithmetic) average here, consisting
> the min and max differ by a factor of 22? Aren't we being bitten by
> outliers pretty severely here, and wouldn't, say, a median be much
> more useful? (Actually, would the "max latency" include the initial
> hunt for a mon and the mon/osdmap exchange?)

Yeah, an average isn't necessarily very useful here =97=A0it's what you
get because that's easy to implement (with a sum and a counter
variable, instead of binning). The inclusion of max and min latencies
is an attempt to cheaply compensate for that...but if somebody wants
to find/write an appropriately-licensed statistical counting library
and integrate it with rados bench, then (say it with me) contributions
are welcome! ;)


> seekwatcher -t rbd-latency-write.trace -o rbd-latency-write.png -p 'd=
d
> if=3D/dev/zero of=3D/dev/rbd0 bs=3D4M count=3D1000 oflag=3Ddirect' -d=
 /dev/rbd0
>
> Just making sure: are you getting the same numbers just with dd,
> rather than dd invoked by seekwatcher?
>
> Also, for your dd latency test of 4M direct I/O reads writes, you see=
m
> to be getting 39 and 300 ms average latency, yet further down it says
> "RBD latency read/write: 28ms and 114.5ms". Any explanation for the
> write latency being cut in half on what was apparently a different
> test run?
>
> Also, were read and write caches cleared between tests? (echo 3 >
> /proc/sys/vm/drop_caches)
>
> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
