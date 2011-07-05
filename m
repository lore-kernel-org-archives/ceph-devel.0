From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Move stat/*.log to the end of logrotate.conf
Date: Tue, 5 Jul 2011 09:23:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107050923340.5150@cobra.newdream.net>
References: <ory60e3se2.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34571 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab1GEQUf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 12:20:35 -0400
In-Reply-To: <ory60e3se2.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Mon, 4 Jul 2011, Alexandre Oliva wrote:

> Logrotate ignores entries after a rule that doesn't match any files.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/logrotate.conf |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/src/logrotate.conf b/src/logrotate.conf
> index 14bc02c..a4fb73f 100644
> --- a/src/logrotate.conf
> +++ b/src/logrotate.conf
> @@ -1,12 +1,3 @@
> -# Separate stat/*.log into a different rule because sometimes
> -# it doesn't exist, and logrotate will ignore the entire rule
> -# if any part of the file list isn't found.
> -/var/log/ceph/stat/*.log {
> -    rotate 7
> -    daily
> -    compress
> -}
> -
>  /var/log/ceph/*.log {
>      rotate 7
>      daily
> @@ -16,3 +7,13 @@
>          invoke-rc.d ceph reload >/dev/null || service ceph reload >/dev/null
>      endscript
>  }
> +
> +# Separate stat/*.log into a different rule because sometimes
> +# it doesn't exist, and logrotate will ignore the entire rule
> +# and the remainder of the file if any part of the file list
> +# isn't found.
> +/var/log/ceph/stat/*.log {
> +    rotate 7
> +    daily
> +    compress
> +}
> -- 
> 1.7.4.4
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
