From: Sage Weil <sage@newdream.net>
Subject: Re: scaling issues
Date: Thu, 8 Mar 2012 16:26:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203081625030.21631@cobra.newdream.net>
References: <4F59414B.3000403@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55288 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2CIA0d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 19:26:33 -0500
In-Reply-To: <4F59414B.3000403@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 8 Mar 2012, Jim Schutt wrote:
> Hi,
> 
> I've been trying to scale up a Ceph filesystem to as big
> as I have hardware for - up to 288 OSDs right now.
> 
> (I'm using commit ed0f605365e - tip of master branch from
> a few days ago.)
> 
> My problem is that I cannot get a 288 OSD filesystem to go active
> (that's with 1 mon and 1 MDS).  Pretty quickly I start seeing
> "mds e4 e4: 1/1/1 up {0=cs33=up:creating(laggy or crashed)}".
> Note that as this is happening all the OSDs and the MDS are
> essentially idle; only the mon is busy.
> 
> While tailing the mon log I noticed there was a periodic pause;
> after adding a little more debug printing, I learned that the
> pause was due to encoding pg_stat_t before writing the pg_map to disk.
> 
> Here's the result of a scaling study I did on startup time for
> a freshly created filesystem.  I normally run 24 OSDs/server on
> these machines with no trouble, for small numbers of OSDs.
> 
>                    seconds from      seconds from     seconds to
>    OSD       PG   store() mount     store() mount      encode
>                        to            to all PGs       pg_stat_t   Notes
>                    up:active        active+clean*
> 
>     48     9504       58                63              0.30
>     72    14256       70                89              0.65
>     96    19008       93               117              1.1
>    120    23760      132               138              1.7
>    144    28512       92               165              2.3
>    168    33264      215               218              3.2       periods of
> "up:creating(laggy or crashed)"
>    192    38016      392               344              4.0       periods of
> "up:creating(laggy or crashed)"
>    240    47520     1189               644              6.3       periods of
> "up:creating(laggy or crashed)"
>    288    57024   >14400            >14400              9.0       never went
> active; >200 OSDs out, reporting "wrongly marked me down"

Weird, pg_stat_t really shouldn't be growing quadratically.  Can you look 
at the size of the monitors pg/latest file, and see if those are growing 
quadratically as well?  I would expect it to be proportional to the 
encode time.

And maybe send us a copy of one of the big ones?

Thanks-
sage


> 
> *   active+clean includes active+clean+scrubbing, i.e., no peering or creating
> **  all runs up to 288 used mon osd down out interval = 30; 288 used that for
>       first hour, then switched to 300
> 
> It might be that the filesystem never went to active at 288 OSDs due
> to some lurking bugs, but even so, the results for time to encode
> pg_stat_t is worrisome; gnuplot fit it for me to
>     2.18341 * exp(OSDs/171.373) - 2.67065
> 
> ----
> After 79 iterations the fit converged.
> final sum of squares of residuals : 0.0363573
> rel. change during last iteration : -4.77639e-06
> 
> degrees of freedom    (FIT_NDF)                        : 6
> rms of residuals      (FIT_STDFIT) = sqrt(WSSR/ndf)    : 0.0778431
> variance of residuals (reduced chisquare) = WSSR/ndf   : 0.00605955
> 
> Final set of parameters            Asymptotic Standard Error
> =======================            ==========================
> 
> a               = 2.18341          +/- 0.2276       (10.42%)
> b               = 171.373          +/- 8.344        (4.869%)
> c               = -2.67065         +/- 0.3049       (11.42%)
> ----
> 
> I haven't dug deeply into what all goes into a pg_stat_t; how is that
> expected to scale?  I tried to fit it to some other functions, but
> they didn't look as good to me (not very scientific).
> 
> If that fit is correct, and I had the hardware to double my cluster
> size to 576 OSDs, the time to encode pg_stat_t for such a cluster
> would be ~60 seconds.  That seems unlikely to work well, and what
> I'd really like to get to is thousands of OSDs.
> 
> Let me know if there is anything I can do to help with this.  I've still
> got the mon logs for the above runs, with debug ms = 1 and debug mon = 10;
> 
> -- Jim
> 
> P.S. Here's how I instrumented to get above results:
> 
> 
> diff --git a/src/mon/PGMap.cc b/src/mon/PGMap.cc
> index d961ac1..58198d7 100644
> --- a/src/mon/PGMap.cc
> +++ b/src/mon/PGMap.cc
> @@ -5,6 +5,7 @@
> 
>  #define DOUT_SUBSYS mon
>  #include "common/debug.h"
> +#include "common/Clock.h"
> 
>  #include "common/Formatter.h"
> 
> @@ -311,8 +312,17 @@ void PGMap::encode(bufferlist &bl) const
>    __u8 v = 3;
>    ::encode(v, bl);
>    ::encode(version, bl);
> +
> +  utime_t start = ceph_clock_now(g_ceph_context);
>    ::encode(pg_stat, bl);
> +  utime_t end = ceph_clock_now(g_ceph_context);
> +  dout(10) << "PGMap::encode pg_stat took " << end - start << dendl;
> +
> +  start = end;
>    ::encode(osd_stat, bl);
> +  end = ceph_clock_now(g_ceph_context);
> +  dout(10) << "PGMap::encode osd_stat took " << end - start << dendl;
> +
>    ::encode(last_osdmap_epoch, bl);
>    ::encode(last_pg_scan, bl);
>    ::encode(full_ratio, bl);
> -- 
> 1.7.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
