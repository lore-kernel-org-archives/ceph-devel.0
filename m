From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Add Metavariable $imagename
Date: Wed, 04 Sep 2013 10:46:40 -0400
Message-ID: <522747D0.6050906@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:52199 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934761Ab3IDOqp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Sep 2013 10:46:45 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so451025obc.10
        for <ceph-devel@vger.kernel.org>; Wed, 04 Sep 2013 07:46:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There are currently a few metavariables available for use in ceph.conf:
http://ceph.com/docs/master/rados/configuration/ceph-conf/#metavariables

In addition to those listed in that document, $pid was added in Bobtail. 
That allows me to get RBD admin sockets for libvirt/qemu guests by 
specifying

[client]
     admin socket = /var/run/ceph/rbd-$pid.asok

in /etc/ceph/ceph.conf. That works well for VMs with a single volume, 
but it does not work for VMs with multiple volumes. With multiple 
volumes, the admin only lists data on the last volume specified, leaving 
me unable to monitor stats on any volumes other than the last.

I imagine you could specify a unique admin socket for each volume on the 
command-line that libvirt uses to spawn qemu, but that seems like a pain.

Is it possible instead to add a metavariable that would expand to the 
image name? This way, my ceph.conf would look like


[client]
     admin socket = /var/run/ceph/$imagename.asok

and I would end up with admin sockets like:

/var/run/ceph/rbd-volume-0025b693-6230-443e-ad6a-3aa43efdd648.asok
/var/run/ceph/rbd-volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6.asok

# rbd -p volumes ls
volume-0025b693-6230-443e-ad6a-3aa43efdd648
volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6

I'd be happy to provide a patch if someone could give me sufficient 
guidance on how/where to add this functionality.

-- 
Thanks,

Mike Dawson
Co-Founder & Director of Cloud Architecture
Cloudapt LLC
6330 East 75th Street, Suite 170
Indianapolis, IN 46250
