From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH V2] mds: fix CDir::_commit_partial() bug
Date: Sat, 01 Dec 2012 21:58:12 +0800
Message-ID: <50BA0CF4.60203@intel.com>
References: <1353603165-1724-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:15255 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933Ab2LAN6R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Dec 2012 08:58:17 -0500
In-Reply-To: <1353603165-1724-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

This patch is buggy, please drop it from wip-mds.

On 11/23/2012 12:52 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When a null dentry is encountered, CDir::_commit_partial() adds
> a OSD_TMAP_RM command to delete the dentry. But if the dentry is
> new, the osd will not find the dentry when handling the command
> and the tmap update operation will fail totally.
> 
> This patch also makes sure dentries are properly marked as new
> when preparing new dentries and exporting dentries.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
SNIP
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index ec0d5d5..228fede 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -1685,6 +1685,9 @@ CDentry* Server::prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dn
>        }
>      }
>  
> +    if (!dn->is_dirty())
> +      dn->mark_new();
> +
This should be something like 'else if (!dn->is_dirty())'. This issue
has been fixed on the osd side, this patch is no longer needed.

Regards
Yan, Zheng

>      return dn;
>    }
>  
> 

