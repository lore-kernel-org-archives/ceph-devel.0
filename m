From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] crushtool: Add call to global_init() to avoid dout
 segfault
Date: Wed, 13 Jul 2011 21:39:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107132131240.22389@cobra.newdream.net>
References: <1310509259-29635-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34365 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab1GNEgZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 00:36:25 -0400
In-Reply-To: <1310509259-29635-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: colin.mccabe@dreamhost.com
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

Hey Colin,

I applied this to stable, but now crushtool is trying to read ceph.conf, 
despite CINIT_FLAG_NO_DEFAULT_CONFIG_FILE... I fixed it up in 
wip-default-conf, can you take a look?

thanks!
sage


On Tue, 12 Jul 2011, Jim Schutt wrote:

> 
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  src/crushtool.cc |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/src/crushtool.cc b/src/crushtool.cc
> index f2a35f9..336d456 100644
> --- a/src/crushtool.cc
> +++ b/src/crushtool.cc
> @@ -845,6 +845,10 @@ int main(int argc, const char **argv)
>    map<int, int> device_weight;
>    DEFINE_CONF_VARS(usage);
>  
> +  global_init(args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY,
> +	      CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
> +  common_init_finish(g_ceph_context);
> +
>    FOR_EACH_ARG(args) {
>      if (CEPH_ARGPARSE_EQ("clobber", '\0')) {
>        clobber = true;
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
