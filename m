From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] ceph: remove request from unsafe list if it is
 canceled/timed out
Date: Tue, 15 Mar 2011 09:53:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103150953280.24223@cobra.newdream.net>
References: <1300180682-18749-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55752 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333Ab1COQvb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2011 12:51:31 -0400
In-Reply-To: <1300180682-18749-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry,

I've applied these both, and queued them for 2.6.39-rc1.

Thanks!
sage


On Tue, 15 Mar 2011, Henry C Chang wrote:

> This fixes the list corruption warning like this:
> 
> ------------[ cut here ]------------
> WARNING: at lib/list_debug.c:30 __list_add+0x68/0x81()
> Hardware name: X8DTU
> list_add corruption. prev->next should be next (ffff880618931250), but was (null). (prev=ffff880c188b9130).
> Modules linked in: nfsd lockd nfs_acl auth_rpcgss exportfs ceph libceph libcrc32c sunrpc ipv6 fuse igb i2c_i801 ioatdma i2c_core iTCO_wdt iTCO_vendor_support joydev dca serio_raw usb_storage [last unloaded: scsi_wait_scan]
> Pid: 10977, comm: smbd Tainted: G        W  2.6.32.23-170.Elaster.xendom0.fc12.x86_64 #1
> Call Trace:
> [<ffffffff8105753c>] warn_slowpath_common+0x7c/0x94
> [<ffffffff810575ab>] warn_slowpath_fmt+0x41/0x43
> [<ffffffff812351a3>] __list_add+0x68/0x81
> [<ffffffffa014799d>] ceph_aio_write+0x614/0x8a2 [ceph]
> [<ffffffff8111d2a0>] do_sync_write+0xe8/0x125
> [<ffffffff81075a1f>] ? autoremove_wake_function+0x0/0x39
> [<ffffffff811f21ec>] ? selinux_file_permission+0x5c/0xb3
> [<ffffffff811e8521>] ? security_file_permission+0x16/0x18
> [<ffffffff8111d864>] vfs_write+0xae/0x10b
> [<ffffffff8111d91b>] sys_pwrite64+0x5a/0x76
> [<ffffffff81012d32>] system_call_fastpath+0x16/0x1b
> ---[ end trace 08573eb9f07ff6f4 ]---
> 
> Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> ---
>  fs/ceph/file.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 7d0e4a8..db5d863 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -568,7 +568,14 @@ more:
>  			spin_unlock(&ci->i_unsafe_lock);
>  			ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
>  		}
> +		
>  		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> +		if (ret < 0 && req->r_safe_callback) {
> +			spin_lock(&ci->i_unsafe_lock);
> +			list_del_init(&req->r_unsafe_item);
> +			spin_unlock(&ci->i_unsafe_lock);
> +			ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
> +		}
>  	}
>  
>  	if (file->f_flags & O_DIRECT)
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
