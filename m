From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 13/15] src/osd/osd_types.h: pass function parameter by
 reference
Date: Sat, 9 Feb 2013 22:00:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302092159510.11665@cobra.newdream.net>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de> <1360266123-28972-14-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54232 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3BJGAz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 01:00:55 -0500
In-Reply-To: <1360266123-28972-14-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Thu, 7 Feb 2013, Danny Al-Gaaf wrote:
> Fix "(performance) Function parameter 'e' should be passed by reference."
> from cppchecker.

eversion_t is only 12-16 bytes (depending on alignment), so I'm not sure a 
pointer indirection (or whatever the compiler turns the & parameter into) 
is going to buy us anything.

> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/osd/osd_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
> index e068057..b193c2b 100644
> --- a/src/osd/osd_types.h
> +++ b/src/osd/osd_types.h
> @@ -496,7 +496,7 @@ inline bool operator>(const eversion_t& l, const eversion_t& r) {
>  inline bool operator>=(const eversion_t& l, const eversion_t& r) {
>    return (l.epoch == r.epoch) ? (l.version >= r.version):(l.epoch >= r.epoch);
>  }
> -inline ostream& operator<<(ostream& out, const eversion_t e) {
> +inline ostream& operator<<(ostream& out, const eversion_t& e) {
>    return out << e.epoch << "'" << e.version;
>  }
>  
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
