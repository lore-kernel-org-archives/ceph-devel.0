From: Sage Weil <sage@newdream.net>
Subject: Re: librados.hpp fix
Date: Tue, 3 Aug 2010 09:45:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008030945240.19076@cobra.newdream.net>
References: <AANLkTi=wtavHtw04KwZRfK2LrWahS6TdmN2nh_phcRJn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42631 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180Ab0HCQnE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Aug 2010 12:43:04 -0400
In-Reply-To: <AANLkTi=wtavHtw04KwZRfK2LrWahS6TdmN2nh_phcRJn@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

Thanks, applied this.  And fixed the acconfig.h #include.  Pushed to 
the testing and unstable branches.

sage

On Tue, 3 Aug 2010, Takuya ASADA wrote:

> Hi,
> 
> I just realized librados.hpp could compile only if "using namespace
> std;" is declared before "#include <rados/librados.hpp>", because
> "vector" used without std namespace, and I think it's wrong.
> It can fix following patch.
> 
> syuu
> 
> diff --git a/src/include/librados.hpp b/src/include/librados.hpp
> index b0d3622..06fa3b2 100644
> --- a/src/include/librados.hpp
> +++ b/src/include/librados.hpp
> @@ -38,7 +38,7 @@ namespace librados {
> 
>    struct SnapContext {
>      snap_t seq;
> -    vector<snap_t> snaps;
> +    std::vector<snap_t> snaps;
>    };
> 
> 
> @@ -57,7 +57,7 @@ public:
>    int lookup_pool(const char *name);
> 
>    void set_snap(pool_t pool, snap_t seq);
> -  int set_snap_context(pool_t pool, snap_t seq, vector<snap_t>& snaps);
> +  int set_snap_context(pool_t pool, snap_t seq, std::vector<snap_t>& snaps);
> 
> 
>    int create(pool_t pool, const std::string& oid, bool exclusive);
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
