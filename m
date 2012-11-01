From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Cephfs losing files and corrupting others
Date: Thu, 01 Nov 2012 17:32:00 -0500
Message-ID: <5092F860.7040708@inktank.com>
References: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40681 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762214Ab2KAWcG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 18:32:06 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2029296pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 15:32:05 -0700 (PDT)
In-Reply-To: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Howell <nathan.d.howell@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu 01 Nov 2012 11:22:59 AM CDT, Nathan Howell wrote:
> We have a small (3 node) Ceph cluster that occasionally has issues. It
> loses files and directories, truncates them or fills the contents with
> NULL bytes. So far we haven't been able to build a repro case but it
> seems to happen when bulk loading data into the cluster, a process
> that is run each evening by a cron job. We've gone about a month
> without any issues but had it happen again yesterday during a larger
> bulk load.  The data is backed up outside of ceph and can be reloaded
> but finding the corrupt files takes quite a while.
>
> Has anyone heard of similar issues before? Should I try upgrading to
> 0.48.2 or a newer kernel?

Hi Nathan,

Do the writes succeed?  I.e. the programs creating the files don't get 
errors back?  Are you seeing any problems with the ceph mds or osd 
processes crashing?  Can you describe your I/O workload during these 
bulk loads?  How many files, how much data, multiple clients writing, 
etc.

As far as I know, there haven't been any fixes to 0.48.2 to resolve 
problems like yours.  You might try the ceph fuse client to see if you 
get the same behavior.  If not, then at least we have narrowed down the 
problem to the ceph kernel client.

Thanks,
-sam

>
> ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
> Linux _ 3.4.4-gentoo #2 SMP Sun Jul 1 18:28:16 UTC 2012 x86_64
> Intel(R) Xeon(R) CPU E31240 @ 3.30GHz GenuineIntel GNU/Linux
>
> I'm using the kernel provided cephfs, mounted with these options:
> 10.0.2.2:6789:/ on /ceph type ceph (rw,noatime,nodiratime)
>
> thanks,
> -n
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


