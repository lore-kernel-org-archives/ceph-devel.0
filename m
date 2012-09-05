From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Wed, 5 Sep 2012 09:21:27 -0600
Message-ID: <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33995 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2IEPV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 11:21:28 -0400
Received: by obbuo13 with SMTP id uo13so427422obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 08:21:27 -0700 (PDT)
In-Reply-To: <1344462671-21848-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I saw the limitations section references only being able to configure
a single monitor.  Some followup questions for someone interested in
using RBD with Cloudstack 4:

Is it that you can only specify a single monitor to connect to within
Cloudstack 4 (but can still have a 3 monitor configuration) ... or
must you only have a single monitor for some reason?

If you have a ceph.conf on the kvm nodes with more monitors, will it
pick up on the additional monitors?

Is it possible to use a "floating" ip address resource in a pacemaker
configuration for the CloudStack "monitor" IP address?  Is there any
other way around a single-monitor point of failure?

Thanks for your hard work and any guidance you can provide!

Calvin

On Wed, Aug 8, 2012 at 3:51 PM, Wido den Hollander <wido@widodh.nl> wrote:
>
> The basic documentation about how you can use RBD with CloudStack
>
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  doc/rbd/rbd-cloudstack.rst |   49
> ++++++++++++++++++++++++++++++++++++++++++++
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
> +* The libvirt version on the Hypervisor has to be at least 0.10 with RBD
> enabled
> +
> +Make sure you meet this requirements before installing the CloudStack
> Agent on the Hypervisor(s)!
> +
> +.. important:: To use RBD with CloudStack, you must have a running Ceph
> cluster!
> +
> +Limitations
> +-------------
> +Running instances from RBD has a couple of limitations:
> +
> +* An additional NFS Primary Storage pool is required for running System
> VM's
> +* Snapshotting RBD volumes is not possible (at this moment)
> +* Only one monitor can be configured
> +
> +Add Hypervisor
> +-------------
> +Please follow the official CloudStack documentation how to do this.
> +
> +There is no special way of adding a Hypervisor when using RBD, nor is any
> configuration needed on the hypervisor.
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
> +Create a special "Disk Offering" which needs to match the tag 'rbd' so
> you can make sure the StoragePoolAllocator
> +chooses the RBD pool when searching for a suiteable storage pool.
> +
> +Since there is also a NFS storage pool it's possible that instances get
> deployed on NFS instead of RBD.
> diff --git a/doc/rbd/rbd.rst b/doc/rbd/rbd.rst
> index af1682f..6fd1999 100644
> --- a/doc/rbd/rbd.rst
> +++ b/doc/rbd/rbd.rst
> @@ -31,7 +31,7 @@ the Ceph FS filesystem, and RADOS block devices
> simultaneously.
>         QEMU and RBD <qemu-rbd>
>         libvirt <libvirt>
>         RBD and OpenStack <rbd-openstack>
> -
> +       RBD and CloudStack <rbd-cloudstack>
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
