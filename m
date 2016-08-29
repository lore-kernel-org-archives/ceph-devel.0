From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: debugging librbd to a VM
Date: Mon, 29 Aug 2016 11:03:15 +0300
Message-ID: <20160829080314.GA1733@gmail.com>
References: <MWHPR12MB19342F27DDBF165F5BAE4ADC9BEC0@MWHPR12MB1934.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36824 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756425AbcH2IEP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 04:04:15 -0400
Received: by mail-lf0-f44.google.com with SMTP id g62so94940125lfe.3
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 01:03:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <MWHPR12MB19342F27DDBF165F5BAE4ADC9BEC0@MWHPR12MB1934.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

May be qemu does not see you ceph.conf? Or some other environmental
issue (e.g. with qemu rbd driver). Try

ldd /usr/bin/qemu-system-x86_64 |grep rbd

Have you tried starting it from command line?

You could check if config debug options work as expected setting them
on your working cluster.

On Fri, Aug 26, 2016 at 09:08:30PM +0000, Deneau, Tom wrote:
> I have two small clusters configured with the same version of Ceph and the same OS version.
> (different processor hardware)
> 
> On these clusters I have bootable RBD images that I expect a VM to boot from.
> On one cluster, the VM does not boot from the image.  On the other cluster, it boots fine.
> On the failing cluster, a VM can boot fine from the base qcow2 image from which the rbd image was created.  It's only rbd images that are causing problems for the VM.
> 
> I would like to enable some debug logging that could tell where the two clusters are diverging.
> 
> I tried adding
>         debug rbd = 20
>         log file = /tmp/cbt/ceph/log/$name.log
> 
> I do see some rbd debug messages to stderr during operations like rbd clone, etc. but I don't see any log files created in /tmp/cbt/ceph or /var/log/ceph or any messages when librbd is being used by say qemu-img convert, or by qemu-kvm.
> 
> Is there a way to see detailed debug messages for librbd?
> 
> Or is there a better way to see where things are diverging between these two clusters?
> (note: I tried lttng but could not get it to record anything)
> 
> -- Tom
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
