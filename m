From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Add rc script for rbd map/unmap
Date: Mon, 24 Jun 2013 21:53:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306242149240.9788@cobra.newdream.net>
References: <1371827829-1025-1-git-send-email-laurent@ksperis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38055 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab3FYExM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 00:53:12 -0400
In-Reply-To: <1371827829-1025-1-git-send-email-laurent@ksperis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Barbe <laurent@ksperis.com>, dan.mick@inktank.com
Cc: ceph-devel@vger.kernel.org

Hi Laurent,

I opened a github pull request for this at

	https://github.com/ceph/ceph/pull/378

We might consider putting /etc/rbdmap in /etc/ceph/rbdmap to avoid 
polluting /etc... Dan, can you take a look?

Thanks!
sage


On Fri, 21 Jun 2013, Laurent Barbe wrote:

> Init script for mapping/unmapping rbd device on startup and shutdown.
> On start, map rbd dev according to /etc/rbdmap, and force mount -a
> On stop, umount file system depending on rbd and unmap all rbd
> Since some distribution use symlink for /etc/mtab, the user-space attribute _netdev is not enough to umount file system before rbd dev.
> (also concern: #1790)
> 
> Signed-off-by: Laurent Barbe <laurent@ksperis.com>
> ---
>  src/init-rbdmap | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/rbdmap      |   3 ++
>  2 files changed, 106 insertions(+)
>  create mode 100755 src/init-rbdmap
>  create mode 100644 src/rbdmap
> 
> diff --git a/src/init-rbdmap b/src/init-rbdmap
> new file mode 100755
> index 0000000..a2187ce
> --- /dev/null
> +++ b/src/init-rbdmap
> @@ -0,0 +1,103 @@
> +#!/bin/bash
> +
> +### BEGIN INIT INFO
> +# Provides:          rbdmap
> +# Required-Start:    $network
> +# Required-Stop:     $network
> +# Default-Start:     2 3 4 5
> +# Default-Stop:      0 1 6
> +# Short-Description: Ceph RBD Mapping
> +# Description:       Ceph RBD Mapping
> +### END INIT INFO
> +
> +DESC="RBD Mapping"
> +RBDMAPFILE="/etc/rbdmap"
> +
> +. /lib/lsb/init-functions
> +
> +do_map() {
> +	if [ ! -f "$RBDMAPFILE" ]; then
> +		log_warning_msg "$DESC : No $RBDMAPFILE found."	
> +		exit 0
> +	fi
> +
> +	log_daemon_msg "Starting $DESC"
> +	# Read /etc/rbdtab to create non-existant mapping
> +	newrbd=
> +	RET=0
> +	while read DEV PARAMS; do
> +		case "$DEV" in
> +		  ""|\#*)
> +			continue
> +			;;
> +		  */*)
> +			;;
> +		  *)
> +			DEV=rbd/$DEV
> +			;;
> +		esac
> +		OIFS=$IFS
> +		IFS=','
> +		for PARAM in ${PARAMS[@]}; do
> +			CMDPARAMS="$CMDPARAMS --$(echo $PARAM | tr '=' ' ')"
> +		done
> +		IFS=$OIFS
> +		if [ ! -b /dev/rbd/$DEV ]; then
> +			log_progress_msg $DEV
> +			rbd map $DEV $CMDPARAMS
> +			[ $? -ne "0" ] && RET=1
> +			newrbd="yes"
> +		fi
> +	done < $RBDMAPFILE
> +	log_end_msg $RET
> +
> +	# Mount new rbd
> +	if [ "$newrbd" ]; then
> +                log_action_begin_msg "Mounting all filesystems"
> +		mount -a
> +               	log_action_end_msg $?
> +	fi
> +}
> +
> +do_unmap() {
> +	log_daemon_msg "Stopping $DESC"
> +	RET=0
> +	# Unmap all rbd device
> +	for DEV in /dev/rbd[0-9]*; do
> +		log_progress_msg $DEV
> +		# Umount before unmap
> +		MNTDEP=$(findmnt --mtab --source $DEV --output TARGET | sed 1,1d | sort -r)
> +		for MNT in $MNTDEP; do
> +			umount $MNT || sleep 1 && umount -l $DEV
> +		done 
> +		rbd unmap $DEV
> +		[ $? -ne "0" ] && RET=1
> +	done
> +	log_end_msg $RET
> +}
> +
> +
> +case "$1" in
> +  start)
> +	do_map
> +	;;
> +
> +  stop)
> +	do_unmap
> +	;;
> +
> +  reload)
> +	do_map
> +	;;
> +
> +  status)
> +	rbd showmapped
> +	;;
> +
> +  *)
> +	log_success_msg "Usage: rbdmap {start|stop|reload|status}"
> +	exit 1
> +	;;
> +esac
> +
> +exit 0
> diff --git a/src/rbdmap b/src/rbdmap
> new file mode 100644
> index 0000000..9d34e9e
> --- /dev/null
> +++ b/src/rbdmap
> @@ -0,0 +1,3 @@
> +# RbdDevice		Parameters
> +#rbd/rbddevice		id=client,keyring=/etc/ceph/ceph.client.keyring
> +
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
