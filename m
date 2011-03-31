From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] mkcephfs: Actually do a mkfs.btrfs
Date: Thu, 31 Mar 2011 11:39:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103311139430.28788@cobra.newdream.net>
References: <1301594380-27512-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34391 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab1CaSgo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 14:36:44 -0400
In-Reply-To: <1301594380-27512-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Ha!  Applied.  :)
sage


On Thu, 31 Mar 2011, Wido den Hollander wrote:

> 
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  src/mkcephfs.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index b193528..834d776 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -273,7 +273,7 @@ if [ -n "$prepareosdfs" ]; then
>      done
>  
>      modprobe btrfs || true
> -    echo mkfs.btrfs $btrfs_devs
> +    mkfs.btrfs $btrfs_devs
>      btrfsctl -a
>      mount -t btrfs $btrfs_opt $first_dev $btrfs_path
>      chown $osd_user $btrfs_path
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
