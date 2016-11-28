From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Proposition - latency histogram
Date: Mon, 28 Nov 2016 18:05:42 -0500
Message-ID: <CANP1eJH1+ejUupk84ikBLBhPMs79hJSus1u1Q9t2EhBaXYk8hQ@mail.gmail.com>
References: <69bf4eec-3959-f021-ad8f-d1b6d3e2ceaf@corp.ovh.com> <BLUPR0201MB1524749EAC9F82FC140D379DE88A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34977 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933063AbcK1XFp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2016 18:05:45 -0500
Received: by mail-lf0-f42.google.com with SMTP id b14so108301972lfg.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2016 15:05:44 -0800 (PST)
In-Reply-To: <BLUPR0201MB1524749EAC9F82FC140D379DE88A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 28, 2016 at 11:46 AM, Allen Samuels
<Allen.Samuels@sandisk.com> wrote:
>
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Bartlomiej Swiecki
> > Sent: Monday, November 28, 2016 8:22 AM
> > To: Ceph Development <ceph-devel@vger.kernel.org>
> > Subject: Proposition - latency histogram
> >
> > Hi,
> >
> >
> > Currently we can query OSD for op latency but it's given as an average.
> > Average may not give
> > the bets information in this case - i.e. spikes can easily get hidden there.
> >
> > Instead of an average we could easily do a simple histogram - quantize the
> > latency into predefined set of time intervals, for each of them have a simple
> > performance counter, at each op increase one of them. Since those are per
> > OSD, we could have pretty high resolution with fractional memory usage,
> > performance impact should be negligible since only one (two if split into read
> > and write) of those counters would be incremented per one osd op.
> >
>
> +1
>
> A reminder, there are different latency domains for the different media types (flash, HDD). One solution is to make the buckets be parameterized.


The histogram can be represented using Count Min Sketch which can
compress a lot buckets in a small space giving us more resolution in
the X axis in exchange for some error in Y axis. You can later
transform it on the fly into something that is closely related to the
buckets you want to use. If you have a cluster that uses different
kind of storage (nvme, ssd, spinning disk and maybe EC) you will end
up values all over the map (as you mentioned).

And while Count Min Sketch it should be enough to estimate and show a
visual representation of PDF or CDF (probability/cumulative density
function) from the discretized estimate.

There's also other sketches for doing histograms like these, but I'm
less familiar with them. I'm guessing that somebody with a
stats/science background can point to them/


>
>
> > In addition we could also do this in 2D - each counter matching given latency
> > range and op size range.
> > having such 2D table would show both latency histogram, request size
> > histogram and combinations of those (i.e. latency histogram of ~4k ops only).
> >
> > What do you think about this idea? I can prepare some code - a simple proof
> > of concept looks really straightforward to implement.
> >
> >
> > Bartek
> >
