From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Tue, 4 Sep 2012 16:49:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209041649070.14139@cobra.newdream.net>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43168 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2IDXt2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 19:49:28 -0400
In-Reply-To: <1344462671-21848-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Finally applied this one.  Great work, Wido!

sage


On Wed, 8 Aug 2012, Wido den Hollander wrote:

> The basic documentation about how you can use RBD with CloudStack
> 
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  doc/rbd/rbd-cloudstack.rst |   49 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/rbd/rbd.rst            |    2 +-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 doc/rbd/rbd-cloudstack.rst
> 
> diff --git a/doc/rbd/rbd-cloudstack.rst b/doc/rbd/rbd-cloudstack.rst
> new file mode 100644
> index 0000000..04e1a7c
> --- /dev/null
> +++ b/doc/rbd/rbd-cloudstack.rst
> @@ -0,0 +1,49 @@
> +===================
> + RBD and Apache CloudStack
> +===================
> +You can use RBD to run instances on in Apache CloudStack.
> +
> +This can be done by adding a RBD pool as Primary Storage.
> +
> +There are a couple of prerequisites:
> +* You need to CloudStack 4.0 or higher
> +* Qemu on the Hypervisor has to be compiled with RBD enabled
> +* The libvirt version on the Hypervisor has to be at least 0.10 with RBD enabled
> +
> +Make sure you meet this requirements before installing the CloudStack Agent on the Hypervisor(s)!
> +
> +.. important:: To use RBD with CloudStack, you must have a running Ceph cluster!
> +
> +Limitations
> +-------------
> +Running instances from RBD has a couple of limitations:
> +
> +* An additional NFS Primary Storage pool is required for running System VM's
> +* Snapshotting RBD volumes is not possible (at this moment)
> +* Only one monitor can be configured
> +
> +Add Hypervisor
> +-------------
> +Please follow the official CloudStack documentation how to do this.
> +
> +There is no special way of adding a Hypervisor when using RBD, nor is any configuration needed on the hypervisor.
> +
> +Add RBD Primary Storage
> +-------------
> +Once the hypervisor has been added, log on to the CloudStack UI.
> +
> +* Infrastructure 
> +* Primary Storage
> +* "Add Primary Storage"
> +* Select "Protocol" RBD
> +* Fill in your cluster information (cephx is supported)
> +* Optionally add the tag 'rbd'
> +
> +Now you should be able to deploy instances on RBD.
> +
> +RBD Disk Offering
> +-------------
> +Create a special "Disk Offering" which needs to match the tag 'rbd' so you can make sure the StoragePoolAllocator
> +chooses the RBD pool when searching for a suiteable storage pool.
> +
> +Since there is also a NFS storage pool it's possible that instances get deployed on NFS instead of RBD.
> diff --git a/doc/rbd/rbd.rst b/doc/rbd/rbd.rst
> index af1682f..6fd1999 100644
> --- a/doc/rbd/rbd.rst
> +++ b/doc/rbd/rbd.rst
> @@ -31,7 +31,7 @@ the Ceph FS filesystem, and RADOS block devices simultaneously.
>  	QEMU and RBD <qemu-rbd>
>  	libvirt <libvirt>
>  	RBD and OpenStack <rbd-openstack>
> -	
> +	RBD and CloudStack <rbd-cloudstack>
>  	
>  	
>  	
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
