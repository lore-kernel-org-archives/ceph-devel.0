From: Sage Weil <sage@newdream.net>
Subject: Re: PATCH: extend man page mount.ceph.8 with available options
Date: Mon, 28 Jun 2010 09:53:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006280947510.3822@cobra.newdream.net>
References: <i09d8p$qic$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58084 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0F1QwZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jun 2010 12:52:25 -0400
In-Reply-To: <i09d8p$qic$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Mon, 28 Jun 2010, Thomas Mueller wrote:
> * i've excludede fsidmajor and fsidminor as i really don't known 
> what they do 

Yeah, those are poorly implemented anyway.  They'll be fixed up in the 
next cycle.

> * excluded monport as it seems not to be use anywhere in the code.

Fixed, thanks.

> * for dirstat and nodirstat i don't know which of the both
> is enabled by default.

Off by default.

> * rbytes/norbytes - same as for dirstat and I don't know what the
> switch does.

On by default (makes reported dir st_size equal to rbytes).

> * "don't share client with other sbs" - what does "sbs" mean? (found
> this one in the code)

Superblocks.  Normally, if you mount the same cluster twice (maybe two 
subdirs, or in two different places) the same client instance is shared.  
'noshare' will force a new, unique client instance.

I'll fix this up and apply, thanks!

Thanks-
sage

> 
> 
> 
> - Thomas
> 
> 
> 
> diff --git a/man/mount.ceph.8 b/man/mount.ceph.8
> index 996d68e..771b293 100644
> --- a/man/mount.ceph.8
> +++ b/man/mount.ceph.8
> @@ -29,10 +29,125 @@ the time of mount.
>  .PP
>  A subdirectory \fIsubdir\fP may be specified if a subset of the file system is to be
>  mounted.
> +
>  .SH OPTIONS
> +
> +wsize
> +.IP
> +int, ?
> +.PP
> +
> +rsize
> +.IP
> +int (bytes), max readahead, multiple of 1024, Default: 524288 (512*1024)
> +.PP
> +
> +osdtimeout
> +.IP
> +int (seconds), Default: 60
> +.PP
> +
> +osdkeepalivetimeout
> +.IP
> +int, Default: 5
> +.PP
> +
> +mount_timeout
> +.IP
> +int (seconds), Default: 60
> +.PP
> +
> +osd_idle_ttl
> +.IP
> +int (seconds), Default: 60
> +.PP
> +
> +caps_wanted_delay_min
> +.IP
> +int, cap release delay, Default: 5
> +.PP
> +
> +caps_wanted_delay_max
> +.IP
> +int, cap release delay, Default: 60
> +.PP
> +
> +cap_release_safety
> +.IP
> +int, Default: calculated
> +.PP
> +
> +readdir_max_entries
> +.IP
> +int, Default: 1024
> +.PP
> +
> +readdir_max_bytes
> +.IP
> +int, Default: 524288 (512*1024)
> +.PP
> +
> +write_congestion_kb
> +.IP
> +int (kb), max writeback in flight. scale with available memory. Default: calculated from available memory
> +.PP
> +
>  snapdirname
>  .IP
> -set the name of the hidden snapdir. Default: .snap
> +string, set the name of the hidden snapdir. Default: .snap
> +.PP
> +
> +name
> +.IP
> +string, used with authx, Default: guest
> +.PP
> +
> +secret
> +.IP
> +string, used with authx 
> +.PP
> +
> +ip
> +.IP
> +my ip
> +.PP
> +
> +noshare
> +.IP
> +don't share client with other sbs
> +.PP
> +
> +dirstat
> +.IP
> +funky `cat dirname` for stats
> +.PP
> +
> +nodirstat
> +.IP
> +no funky `cat dirname` for stats
> +.PP
> +
> +rbytes
> +.IP
> +?
> +.PP
> +
> +norbytes
> +.IP
> +?
> +.PP
> +
> +nocrc
> +.IP
> +no data crc on writes
> +.PP
> +
> +noasyncreaddir
> +.IP
> +no dcache readdir
> +.PP
> +
> +
>  .SH EXAMPLES
>  Mount the full file system:
>  .IP
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
