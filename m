From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 07/39] mds: mark connection down when MDS fails
Date: Wed, 20 Mar 2013 11:37:22 -0700
Message-ID: <C592BE9FE22A48508BB45E6E7F1DBF32@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-8-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:53116 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646Ab3CTSpJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 14:45:09 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so1132930dae.23
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 11:45:09 -0700 (PDT)
In-Reply-To: <1363531902-24909-8-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

Reviewed-by: Greg Farnum <greg@inktank.com>



Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> 
> So if the MDS restarts and uses the same address, it does not get
> old messages.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> ---
> src/mds/MDS.cc (http://MDS.cc) | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http://MDS.cc)
> index 859782a..282fa64 100644
> --- a/src/mds/MDS.cc (http://MDS.cc)
> +++ b/src/mds/MDS.cc (http://MDS.cc)
> @@ -1046,8 +1046,10 @@ void MDS::handle_mds_map(MMDSMap *m)
> oldmap->get_failed_mds_set(oldfailed);
> mdsmap->get_failed_mds_set(failed);
> for (set<int>::iterator p = failed.begin(); p != failed.end(); ++p)
> - if (oldfailed.count(*p) == 0)
> + if (oldfailed.count(*p) == 0) {
> + messenger->mark_down(oldmap->get_inst(*p).addr);
> mdcache->handle_mds_failure(*p);
> + }
> 
> // or down then up?
> // did their addr/inst change?
> @@ -1055,8 +1057,10 @@ void MDS::handle_mds_map(MMDSMap *m)
> mdsmap->get_up_mds_set(up);
> for (set<int>::iterator p = up.begin(); p != up.end(); ++p) 
> if (oldmap->have_inst(*p) &&
> - oldmap->get_inst(*p) != mdsmap->get_inst(*p))
> + oldmap->get_inst(*p) != mdsmap->get_inst(*p)) {
> + messenger->mark_down(oldmap->get_inst(*p).addr);
> mdcache->handle_mds_failure(*p);
> + }
> }
> if (is_clientreplay() || is_active() || is_stopping()) {
> // did anyone stop?
> -- 
> 1.7.11.7



