From: Sage Weil <sage@newdream.net>
Subject: Re: error during mds replay
Date: Thu, 30 Sep 2010 22:04:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009302203190.4097@cobra.newdream.net>
References: <AANLkTikptuMyEH0fV4qJ9=cu3yALSjieYrAPiNgyzLyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43098 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0JAFCV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Oct 2010 01:02:21 -0400
In-Reply-To: <AANLkTikptuMyEH0fV4qJ9=cu3yALSjieYrAPiNgyzLyt@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry,

On Fri, 1 Oct 2010, Henry C Chang wrote:

> Hi,
> 
> Today I found that all my ceph clients are not able to 'ls' the ceph
> mount point.
> Since all ceph daemons are alive, I decided to restart the MDS to see
> if it helps.
> Unfortunately, MDS is never coming back again. It got an error during
> replay every time.
> 
> The last few lines of MDS log shows:

Can you post the full MDS log somewhere and let me know in the bug where I 
can find it?  This is either a problem with journal replay properly 
handling partial writes at the end of the journal, or a corruption.  

http://tracker.newdream.net/issues/451

Thanks!
sage


> 
> 2010-10-01 03:30:59.816017 7f991dcf7710 mds0.journaler try_read_entry
> at 822192580 reading 822192580~4 (have 160437)
> 2010-10-01 03:30:59.816022 7f991dcf7710 mds0.journaler try_read_entry
> got 0 len entry at offset 822192580
> 2010-10-01 03:30:59.816026 7f991dcf7710 mds0.log _replay journaler got
> error -22, aborting
> 2010-10-01 03:30:59.816030 7f991dcf7710 mds0.log _replay_thread kicking waiters
> 2010-10-01 03:30:59.816034 7f991dcf7710 mds0.18 boot_start encountered
> an error, failing
> 2010-10-01 03:30:59.816038 7f991dcf7710 mds0.18 suicide.  wanted
> up:replay, now down:dne
> 2010-10-01 03:30:59.816047 7f991dcf7710 mds0.cache WARNING: mdcache
> shutdown with non-empty cache
> 2010-10-01 03:30:59.816052 7f991dcf7710 mds0.cache show_subtrees
> 2010-10-01 03:30:59.816059 7f991dcf7710 mds0.cache |__ 0    auth [dir
> 1 / [2,head] auth v=327474 cv=0/0 dir_auth=0 state=1610612736 f(v5
> m2010-09-30 10:42:48.462366 5=0+5) n(v5922 rc2010-10-01
> 02:32:18.156019 b129532745664 784=23+761)/n(v5922 rc2010-10-01
> 02:32:18.156019 b129521095616 784=23+761) hs=1+0,ss=0+0 dirty=1 |
> child subtree dirty 0x7f98e8006ae0]
> 2010-10-01 03:30:59.816078 7f991dcf7710 mds0.cache |__ 0    auth [dir
> 100 ~mds0/ [2,head] auth v=795 cv=0/0 dir_auth=0 state=1610612736 f(v0
> 2=1+1) n(v54 rc2010-10-01 02:07:56.696257 b1883380490265 372=365+7)
> hs=1+0,ss=0+0 dirty=1 | child subtree dirty 0x7f98e80070f0]
> 2010-10-01 03:30:59.816094 7f991dcf7710 mds0.log _replay_thread finish
> 2010-10-01 03:30:59.816129 7f992d903710 mds0.18 handle_mds_beacon
> up:replay seq 3 rtt 7.483578
> 2010-10-01 03:30:59.816571 7f9930405720 7f9930405720 stopped.
> 
> I am wondering if there is a way to recover back from this situation.
> Thanks,
> 
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
