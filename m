From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD and MON memory usage
Date: Mon, 19 Nov 2012 15:15:33 -0800
Message-ID: <CAPYLRzj95YK92KUwMnZF5W7oRJOx4kaaSL0siZ27Vt_x7d-Tzw@mail.gmail.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44914 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab2KSXPe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:15:34 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7698026iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:15:33 -0800 (PST)
In-Reply-To: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Fri, Nov 16, 2012 at 9:24 AM, Cl=E1udio Martins <ctpm@ist.utl.pt> wr=
ote:
>
>  Hi,
>
>  We're testing ceph using a recent build from the 'next' branch (comm=
it
> b40387d) and we've run into some interesting problems related to memo=
ry
> usage.
>
>  The setup consists of 64 OSDs (4 boxes, each with 16 disks, most of
> them 2TB, some 1.5TB, XFS filesystems, Debian Wheezy). After the
> initial mkcephfs, a 'ceph -s' reports 12480 pgs total.
>
>  For generating some load we used
>
> rados -p rbd bench 28000 write -t 25
>
> and left it running overnight.
>
>  After several hours most of the OSDs had eaten up around 1GB or more
> of memory each, which caused trashing on the servers (12GB of RAM
> per box), and eventually the OOM killer was invoked, killing many OSD=
s
> and even the SSH daemons. This seems to have caused a domino effect,
> and in the morning only around 18 of the OSD were still up.

That's not good! Sam thinks you may have hit a memory leak, and I
believe I heard him making noises about discovering it elsewhere
earlier today. I will let him talk about that.


>  After a hard reboot of the boxes that were unresponsive, we are now =
in
> a situation in which there is simply not enough memory for the cluste=
r
> to recover. That is, after restarting the OSDs, in 2 to 3 minutes we
> have many of them using 1~1.5GB of RAM and the trashing starts all ov=
er
> again, the OOM killer comes in and things go downhill again. Efective=
ly
> the cluster is not able to recover no matter how many times we restar=
t
> the daemons.
>
>  We're not using any non-default options in the OSD section of the
> config. file. We checked that there is free space for logging on the
> system partitions.
>
>  While I know that 12GB per machine can be hardly called to much RAM,
> the question I put forward is: is it reasonable for a OSD to consume =
so
> much memory in normal usage, or even recovery situations, when there =
is
> just around ~200 PGs per OSD and only around ~3TB of objects created =
by
> rados bench?

In normal usage, absolutely not. In recovery, for now, yes, we
consider that reasonable usage. We may be able to continue bringing
that down, but since it's a good number to have available for page
cache anyway we haven't been focusing on it much lately.

>  Is there a rule of thumb to estimate the amount of memory consumed a=
s
> a function of PG count, object count and perhaps the number of PGs
> trying to recover in a given instant? One of my concerns here is also
> to understand if memory consumption during recovery is bounded and
> deterministic at all, or if we're simply hitting a severe memory leak
> in the OSDs.

It's going to vary based mostly on the number of PGs it's going to
recover, and especially based on if it's recovering or not. We
generally recommend 1GB per daemon for a well-configured (PGs in the
50-200 per OSD range) cluster.


>  As for the monitor daemon on this cluster (running on a dedicated
> machine), it is currently using 3.2GB of memory, and it got to that
> point again in a matter of minutes after being restarted. Would it be
> good if we tested with the changes from the wip-mon-leaks-fix branch?

Can you restart your monitor, then run "ceph heap start_profiler", and
then once the memory has gone way up run "ceph heap dump"? You should
find some files in the same directory as your monitor log files that
you can analyze using tcmalloc's tools (see
http://ceph.com/wiki/Memory_Profiling for some info), or send them our
way for analysis.
This will go easier if you also have Ceph's debug symbol packages insta=
lled. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
