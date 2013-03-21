From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 37/39] mds: eval inodes with caps imported by cache rejoin message
Date: Wed, 20 Mar 2013 20:45:41 -0700
Message-ID: <CAPYLRzioEPawmqO1FgBEHcOOgqkrkG12k-+9hUt7gLpQuKrYBg@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-38-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61961 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3CUDpm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:45:42 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so6066545wib.9
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:45:41 -0700 (PDT)
In-Reply-To: <1363531902-24909-38-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 30687ec..24f1109 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -3823,6 +3823,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
>         dout(10) << " claiming cap import " << p->first << " client." << q->first << " on " << *in << dendl;
>         rejoin_import_cap(in, q->first, q->second, from);
>        }
> +      mds->locker->eval(in, CEPH_CAP_LOCKS, true);
>      }
>    } else {
>      assert(mds->is_rejoin());
> --
> 1.7.11.7
>
