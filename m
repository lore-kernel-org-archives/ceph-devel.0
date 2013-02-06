From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 7/8] messages/MOSDRepScrub.h: initialize member variable
 in constructor
Date: Tue, 5 Feb 2013 21:50:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302052148060.22404@cobra.newdream.net>
References: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de> <1360104750-16098-8-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37379 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3BFFu3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 00:50:29 -0500
In-Reply-To: <1360104750-16098-8-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Tue, 5 Feb 2013, Danny Al-Gaaf wrote:
> Initialize chunky and deep bool member variables in the constructor
> with false.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/messages/MOSDRepScrub.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/messages/MOSDRepScrub.h b/src/messages/MOSDRepScrub.h
> index 2d3a66d..cd1de06 100644
> --- a/src/messages/MOSDRepScrub.h
> +++ b/src/messages/MOSDRepScrub.h
> @@ -36,7 +36,7 @@ struct MOSDRepScrub : public Message {
>    hobject_t end;         // upper bound of scrub, exclusive
>    bool deep;             // true if scrub should be deep
>  
> -  MOSDRepScrub() : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION) { }
> +  MOSDRepScrub() : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION) { chunky = false; deep = false; }

Let's use the C++ initalize syntax:

  MOSDRepScrub() : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION)
    : chunky(false), deep(false) {}

Just for consistency's sake!

sage

>    MOSDRepScrub(pg_t pgid, eversion_t scrub_from, eversion_t scrub_to,
>  	       epoch_t map_epoch)
>      : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION),
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
