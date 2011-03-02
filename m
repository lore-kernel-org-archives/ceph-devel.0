From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: fix build with tcmalloc on Freed-ora 13
Date: Wed, 2 Mar 2011 13:25:02 -0800
Message-ID: <C3B7CD46D19F4453B56B9900E22D7D89@gmail.com>
References: <orwrkh8jpb.fsf@oliva.athome.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61657 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919Ab1CBVZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 16:25:07 -0500
Received: by iyb26 with SMTP id 26so332921iyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2011 13:25:07 -0800 (PST)
In-Reply-To: <orwrkh8jpb.fsf@oliva.athome.lsd.ic.unicamp.br>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Hmm, that's not a warning I've seen locally! The prototype for IsHeapProfilerRunning got changed sometime last year (from bool to int, to better accommodate C programmers) and that's caused one or two other issues with mismatched headers ons ome distributions; I wonder if a similar issue is causing fallout.

In any case, I applied your patch to our "next" branch, which will become v0.25 (I don't think we're doing any more point releases on v0.24).
(I'm redoing the entire interface to be less ugly for v0.26 and am about to push that, or I'd put it into master too.)
Thanks!
-Greg
On Wednesday, March 2, 2011 at 10:24 AM, Alexandre Oliva wrote: 
> G++ complains about the difference between the return type of tcmalloc's
> IsHeapProfilerRunning (int) and the return type of the function that
> g_conf.profiler_running is supposed to point to (bool). We could
> probably get away with a type-cast, but as a compiler developer and
> former C++ language lawyer, I'd rather not take the risk of destroying
> the universe by invoking undefined behavior ;-)
> 
> The one thing I'm not sure about is whether the type of profiler_running
> is always going to be bool. If you know otherwise, let me know, and
> I'll come up with some C++ template trickery to infer the appropriate
> type.
> 
>  Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> 
> diff --git a/src/cmds.cc b/src/cmds.cc
> index 4264f36..f4adf9d 100644
> --- a/src/cmds.cc
> +++ b/src/cmds.cc
> @@ -46,6 +46,13 @@ void usage()
>  generic_server_usage();
>  }
> 
> +#ifdef HAVE_LIBTCMALLOC
> +/* Adjust the return type. */
> +static bool isHeapProfilerRunning(void) {
> + return IsHeapProfilerRunning();
> +}
> +#endif
> +
>  int main(int argc, const char **argv) 
>  {
>  vector<const char*> args;
> @@ -58,7 +65,7 @@ int main(int argc, const char **argv)
>  common_set_defaults(true);
>  #ifdef HAVE_LIBTCMALLOC
>  g_conf.profiler_start = HeapProfilerStart;
> - g_conf.profiler_running = IsHeapProfilerRunning;
> + g_conf.profiler_running = isHeapProfilerRunning;
>  g_conf.profiler_stop = HeapProfilerStop;
>  g_conf.profiler_dump = HeapProfilerDump;
>  g_conf.tcmalloc_have = true;
> diff --git a/src/cosd.cc b/src/cosd.cc
> index 7e77799..28730ce 100644
> --- a/src/cosd.cc
> +++ b/src/cosd.cc
> @@ -42,6 +42,12 @@ void usage()
>  generic_server_usage();
>  }
> 
> +#ifdef HAVE_LIBTCMALLOC
> +/* Adjust the return type. */
> +static bool isHeapProfilerRunning(void) {
> + return IsHeapProfilerRunning();
> +}
> +#endif
> 
>  int main(int argc, const char **argv) 
>  {
> @@ -62,7 +68,7 @@ int main(int argc, const char **argv)
>  common_set_defaults(true);
>  #ifdef HAVE_LIBTCMALLOC
>  g_conf.profiler_start = HeapProfilerStart;
> - g_conf.profiler_running = IsHeapProfilerRunning;
> + g_conf.profiler_running = isHeapProfilerRunning;
>  g_conf.profiler_stop = HeapProfilerStop;
>  g_conf.profiler_dump = HeapProfilerDump;
>  g_conf.tcmalloc_have = true;
> 
> 
> -- 
> Alexandre Oliva, freedom fighter http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/ FSF Latin America board member
> Free Software Evangelist Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

