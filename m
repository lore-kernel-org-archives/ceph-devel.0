From: Sage Weil <sage@newdream.net>
Subject: Re: cmds,cmon,cosd 100% cpu
Date: Wed, 27 Jul 2011 08:53:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107270852390.23984@cobra.newdream.net>
References: <CALFpzo5s1DCSkjGsbn5eN0SGR-GKZU3rZkWawcnQUHNj1Vs5iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50033 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab1G0Ptf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 11:49:35 -0400
In-Reply-To: <CALFpzo5s1DCSkjGsbn5eN0SGR-GKZU3rZkWawcnQUHNj1Vs5iw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Jul 2011, Marcus Sorensen wrote:
> I feel like this is probably something I should be able to find info
> on in an existing faq or archive, but I haven't been able to find
> anything. Are these daemons supposed to use a whole core 24x7? The
> setup *seems* to be functioning normally in initial testing

This was fixed by commit b98d7650aad28f07579b0f8f529dcd23dbb09466.  I take 
it you were running something from the master branch?  This bug 
was short-lived and shouldn't have appeared in any release..

sage


> 
> PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Flags
> WCHAN     COMMAND
>  4576 root      20   0  580m 468m 4528 S 100.0  2.9   1259:56 ..4.214.
> futex_wai cmds
>  4480 root      20   0  138m  39m 2904 S 100.1  0.2   1259:39 ..4.214.
> futex_wai cmon
> 
> PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  WCHAN
> Flags    COMMAND
>  2540 root      20   0 1140m 861m 3656 S 100.0  2.7   1269:59
> futex_wai ..4.214. cosd
> 
> As you can see almost all of the time is spent in futex wait, strace
> reveals a billion polling events on one of the threads (on each of
> cmds,cmon,cosd), e.g:
> 
> [pid  4583] poll([{fd=7, events=POLLIN|POLLRDBAND}, {fd=5,
> events=POLLIN|POLLRDBAND}], 2, 0) = 0 (Timeout)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
