From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] crushtool: fix args parsing
Date: Thu, 22 Sep 2011 09:45:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109220943590.17520@cobra.newdream.net>
References: <1316709560-6521-1-git-send-email-henry.cy.chang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39464 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1IVQpL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 12:45:11 -0400
In-Reply-To: <1316709560-6521-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hey Henry-

Do you have a list of commands that were failing handy?  I'd like to 
extend the cli unit tests at the same time (src/test/cli/crushtool).

Thanks-
sage


On Fri, 23 Sep 2011, Henry C Chang wrote:

> Fix --add-item and --loc args parsing.
> 
> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
> ---
>  src/crushtool.cc |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
> 
> diff --git a/src/crushtool.cc b/src/crushtool.cc
> index 51531aa..f0ccb9b 100644
> --- a/src/crushtool.cc
> +++ b/src/crushtool.cc
> @@ -872,9 +872,6 @@ int main(int argc, const char **argv)
>        }
>        if (i == args.end())
>  	usage();
> -      i = args.erase(i);
> -      if (i == args.end())
> -	usage();
>        add_weight = atof(*i);
>        i = args.erase(i);
>        if (i == args.end())
> @@ -885,9 +882,6 @@ int main(int argc, const char **argv)
>        std::string type(val);
>        if (i == args.end())
>  	usage();
> -      i = args.erase(i);
> -      if (i == args.end())
> -	usage();
>        std::string name(*i);
>        i = args.erase(i);
>        add_loc[type] = name;
> @@ -897,9 +891,6 @@ int main(int argc, const char **argv)
>        reweight_name = val;
>        if (i == args.end())
>  	usage();
> -      i = args.erase(i);
> -      if (i == args.end())
> -	usage();
>        reweight_weight = atof(*i);
>        i = args.erase(i);
>      } else if (ceph_argparse_flag(args, i, "--build", (char*)NULL)) {
> @@ -954,10 +945,8 @@ int main(int argc, const char **argv)
>        int dev = tmp;
>        if (i == args.end())
>  	usage();
> -      i = args.erase(i);
> -      if (i == args.end())
> -	usage();
>        float f = atof(*i);
> +      i = args.erase(i);
>        int w = (int)(f * 0x10000);
>        if (w < 0)
>  	w = 0;
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
