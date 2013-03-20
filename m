From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 08/39] mds: consider MDS as recovered when it
 reaches clientreply state.
Date: Wed, 20 Mar 2013 12:09:52 -0700
Message-ID: <0C905CE930EA480E9FFC3A4942410E22@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-9-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:61568 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3CTTJ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 15:09:57 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so1160501dad.32
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 12:09:57 -0700 (PDT)
In-Reply-To: <1363531902-24909-9-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

Oh, also: s/clientreply/clientreplay in the commit message 

Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> 
> MDS in clientreply state already start servering requests. It also
> make MDS::handle_mds_recovery() and MDS::recovery_done() match.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> ---
> src/mds/MDS.cc (http://MDS.cc) | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http://MDS.cc)
> index 282fa64..b91dcbd 100644
> --- a/src/mds/MDS.cc (http://MDS.cc)
> +++ b/src/mds/MDS.cc (http://MDS.cc)
> @@ -1032,7 +1032,9 @@ void MDS::handle_mds_map(MMDSMap *m)
> 
> set<int> oldactive, active;
> oldmap->get_mds_set(oldactive, MDSMap::STATE_ACTIVE);
> + oldmap->get_mds_set(oldactive, MDSMap::STATE_CLIENTREPLAY);
> mdsmap->get_mds_set(active, MDSMap::STATE_ACTIVE);
> + mdsmap->get_mds_set(active, MDSMap::STATE_CLIENTREPLAY);
> for (set<int>::iterator p = active.begin(); p != active.end(); ++p) 
> if (*p != whoami && // not me
> oldactive.count(*p) == 0) // newly so?
> -- 
> 1.7.11.7



