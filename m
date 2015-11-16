From: Sage Weil <sage@newdream.net>
Subject: Re: scrub randomization and load threshold
Date: Mon, 16 Nov 2015 07:20:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511160717510.7964@cobra.newdream.net>
References: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com> <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net> <CABZ+qqnj81gQDe6mApNdGa-HK2LbeKJwHH-7Lj9ovq2+ci1MgA@mail.gmail.com> <alpine.DEB.2.00.1511120705240.614@cobra.newdream.net>
 <CABZ+qq=hEkD1QwqoYeytOGKanbSKVBodQmmsb_sXSTsGwDKimA@mail.gmail.com> <CABZ+qqma+-bOPcPr3K_9mZaDHE54pvNtWw0OmiAFCYH1zX3Ysw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54687 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbKPPUQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 10:20:16 -0500
In-Reply-To: <CABZ+qqma+-bOPcPr3K_9mZaDHE54pvNtWw0OmiAFCYH1zX3Ysw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Herve Rousseau <herve.rousseau@cern.ch>

On Mon, 16 Nov 2015, Dan van der Ster wrote:
> Instead of keeping a 24hr loadavg, how about we allow scrubs whenever
> the loadavg is decreasing (or below the threshold)? As long as the
> 1min loadavg is less than the 15min loadavg, we should be ok to allow
> new scrubs. If you agree I'll add the patch below to my PR.

I like the simplicity of that, I'm afraid its going to just trigger a 
feedback loop and oscillations on the host.  I.e., as soo as we see *any* 
decrease, all osds on the host will start to scrub, which will push the 
load up.  Once that round of PGs finish, the load will start to drop 
again, triggering another round.  This'll happen regardless of whether 
we're in the peak hours or not, and the high-level goal (IMO at least) is 
to do scrubbing in non-peak hours.

sage

> -- dan
> 
> 
> diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
> index 0562eed..464162d 100644
> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -6065,20 +6065,24 @@ bool OSD::scrub_time_permit(utime_t now)
> 
>  bool OSD::scrub_load_below_threshold()
>  {
> -  double loadavgs[1];
> -  if (getloadavg(loadavgs, 1) != 1) {
> +  double loadavgs[3];
> +  if (getloadavg(loadavgs, 3) != 3) {
>      dout(10) << __func__ << " couldn't read loadavgs\n" << dendl;
>      return false;
>    }
> 
>    if (loadavgs[0] >= cct->_conf->osd_scrub_load_threshold) {
> -    dout(20) << __func__ << " loadavg " << loadavgs[0]
> -            << " >= max " << cct->_conf->osd_scrub_load_threshold
> -            << " = no, load too high" << dendl;
> -    return false;
> +    if (loadavgs[0] >= loadavgs[2]) {
> +      dout(20) << __func__ << " loadavg " << loadavgs[0]
> +              << " >= max " << cct->_conf->osd_scrub_load_threshold
> +               << " and >= 15m avg " << loadavgs[2]
> +              << " = no, load too high" << dendl;
> +      return false;
> +    }
>    } else {
>      dout(20) << __func__ << " loadavg " << loadavgs[0]
>              << " < max " << cct->_conf->osd_scrub_load_threshold
> +            << " or < 15 min avg " << loadavgs[2]
>              << " = yes" << dendl;
>      return true;
>    }
> 
> 
