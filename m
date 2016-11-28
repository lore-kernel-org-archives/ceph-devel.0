From: Sage Weil <sage@newdream.net>
Subject: Re: Proposition - latency histogram
Date: Mon, 28 Nov 2016 16:51:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611281648510.28496@piezo.us.to>
References: <69bf4eec-3959-f021-ad8f-d1b6d3e2ceaf@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-848652567-1480351734=:28496"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48516 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbcK1Qvm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2016 11:51:42 -0500
In-Reply-To: <69bf4eec-3959-f021-ad8f-d1b6d3e2ceaf@corp.ovh.com>
Content-ID: <alpine.DEB.2.11.1611281648580.28496@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Bart=B3omiej_=A6wi=EAcki?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-848652567-1480351734=:28496
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1611281648581.28496@piezo.us.to>

On Mon, 28 Nov 2016, Bart³omiej ¦wiêcki wrote:
> Hi,
> 
> Currently we can query OSD for op latency but it's given as an average. 
> Average may not give the bets information in this case - i.e. spikes can 
> easily get hidden there.
> 
> Instead of an average we could easily do a simple histogram - quantize 
> the latency into predefined set of time intervals, for each of them have 
> a simple performance counter, at each op increase one of them. Since 
> those are per OSD, we could have pretty high resolution with fractional 
> memory usage, performance impact should be negligible since only one 
> (two if split into read and write) of those counters would be 
> incremented per one osd op.
> 
> In addition we could also do this in 2D - each counter matching given 
> latency range and op size range. having such 2D table would show both 
> latency histogram, request size histogram and combinations of those 
> (i.e. latency histogram of ~4k ops only).
> 
> What do you think about this idea? I can prepare some code - a simple proof of
> concept looks really
> straightforward to implement.

This sounds like a great idea.  I think the main issue is that the data 
won't be easily exposed via the perfcounter interface... at least not in a 
way that generic tools can visualize.  Unless there is a standardish way 
to report histogram metrics?

sage
--8323329-848652567-1480351734=:28496--
