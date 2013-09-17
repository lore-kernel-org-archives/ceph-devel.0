From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] osd: compute full ratio from kb_avail
Date: Tue, 17 Sep 2013 06:32:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309170632100.2366@cobra.newdream.net>
References: <orli2v6he3.fsf@livre.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab3IQNcQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Sep 2013 09:32:16 -0400
In-Reply-To: <orli2v6he3.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

s

On Tue, 17 Sep 2013, Alexandre Oliva wrote:

> On btrfs, kb_used + kb_avail can be much smaller than total kb, and
> what really matters to avoid filling up the disk is how much space is
> available, not how much we've used.  Thus, compute the ratio we use to
> determine full or nearfull from kb_avail rather than from kb_used.
> 
> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> ---
>  src/osd/OSD.cc |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
> index 66364ec3..841f1c4 100644
> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -2457,7 +2457,12 @@ void OSDService::check_nearfull_warning(const osd_stat_t &osd_stat)
>  
>    time_t now = ceph_clock_gettime(NULL);
>  
> -  float ratio = ((float)osd_stat.kb_used) / ((float)osd_stat.kb);
> +  // We base ratio on kb_avail rather than kb_used because they can
> +  // differ significantly e.g. on btrfs volumes with a large number of
> +  // chunks reserved for metadata, and for our purposes (avoiding
> +  // completely filling the disk) it's far more important to know how
> +  // much space is available to use than how much we've already used.
> +  float ratio = ((float)(osd_stat.kb - osd_stat.kb_avail)) / ((float)osd_stat.kb);
>    float nearfull_ratio = get_nearfull_ratio();
>    float full_ratio = get_full_ratio();
>    cur_ratio = ratio;
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
