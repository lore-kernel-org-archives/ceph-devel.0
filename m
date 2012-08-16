From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] fix keyring generation for mds and osd
Date: Thu, 16 Aug 2012 09:25:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208160925221.26904@cobra.newdream.net>
References: <1345114618-3464-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40287 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757599Ab2HPQZg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 12:25:36 -0400
In-Reply-To: <1345114618-3464-1-git-send-email-danny.kukawka@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

Hi Danny,

I've applied both of these.  Thanks!

sage

On Thu, 16 Aug 2012, Danny Kukawka wrote:

> Fix config keys for OSD/MDS data dirs. As in documentation and other
> places of the scripts the keys are 'osd data'/'mds data' and not
> 'osd_data'
> 
> In case if MDS: if 'mds data' doesn't exist, create it.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
> ---
>  src/mkcephfs.in |    5 +++--
>  1 Datei ge?ndert, 3 Zeilen hinzugef?gt(+), 2 Zeilen entfernt(-)
> 
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index 402c870..7ab6664 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -251,14 +251,15 @@ if [ -n "$initdaemon" ]; then
>      if [ $type = "osd" ]; then
>  	$BINDIR/ceph-osd -c $conf --monmap $dir/monmap -i $id --mkfs --mkkey
>  
> -	get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd_data"
> +	get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data"
>  	get_conf osd_keyring "$osd_data/keyring" "keyring"
>  	$BINDIR/ceph-authtool -p -n $name $osd_keyring > $dir/key.$name
>      fi
>      
>      if [ $type = "mds" ]; then
> -	get_conf mds_data "/var/lib/ceph/mds/ceph-$id" "mds_data"
> +	get_conf mds_data "/var/lib/ceph/mds/ceph-$id" "mds data"
>  	get_conf mds_keyring "$mds_data/keyring" "keyring"
> +	test -d $mds_data || mkdir -p $mds_data
>  	echo "creating private key for $name keyring $mds_keyring"
>  	$BINDIR/ceph-authtool --create-keyring --gen-key -n $name $mds_keyring
>  	$BINDIR/ceph-authtool -p -n $name $mds_keyring > $dir/key.$name
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
