From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Add Metavariable $imagename
Date: Wed, 04 Sep 2013 10:07:13 -0500
Message-ID: <52274CA1.2040801@inktank.com>
References: <522747D0.6050906@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54851 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935142Ab3IDPHG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Sep 2013 11:07:06 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so904551ieb.28
        for <ceph-devel@vger.kernel.org>; Wed, 04 Sep 2013 08:07:04 -0700 (PDT)
In-Reply-To: <522747D0.6050906@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/04/2013 09:46 AM, Mike Dawson wrote:
> There are currently a few metavariables available for use in ceph.conf:
> http://ceph.com/docs/master/rados/configuration/ceph-conf/#metavariables
>
> In addition to those listed in that document, $pid was added in Bobtail.
> That allows me to get RBD admin sockets for libvirt/qemu guests by
> specifying
>
> [client]
>      admin socket = /var/run/ceph/rbd-$pid.asok
>
> in /etc/ceph/ceph.conf. That works well for VMs with a single volume,
> but it does not work for VMs with multiple volumes. With multiple
> volumes, the admin only lists data on the last volume specified, leaving
> me unable to monitor stats on any volumes other than the last.
>
> I imagine you could specify a unique admin socket for each volume on the
> command-line that libvirt uses to spawn qemu, but that seems like a pain.
>
> Is it possible instead to add a metavariable that would expand to the
> image name? This way, my ceph.conf would look like
>
>
> [client]
>      admin socket = /var/run/ceph/$imagename.asok
>
> and I would end up with admin sockets like:
>
> /var/run/ceph/rbd-volume-0025b693-6230-443e-ad6a-3aa43efdd648.asok
> /var/run/ceph/rbd-volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6.asok
>
> # rbd -p volumes ls
> volume-0025b693-6230-443e-ad6a-3aa43efdd648
> volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6
>
> I'd be happy to provide a patch if someone could give me sufficient
> guidance on how/where to add this functionality.
>

Created a feature request in the tracker for this:

http://tracker.ceph.com/issues/6228

Mark
