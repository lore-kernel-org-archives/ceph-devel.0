From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: debugging librbd to a VM
Date: Tue, 30 Aug 2016 07:54:10 +0300
Message-ID: <20160830045408.GA22787@gmail.com>
References: <MWHPR12MB19342F27DDBF165F5BAE4ADC9BEC0@MWHPR12MB1934.namprd12.prod.outlook.com>
 <20160829080314.GA1733@gmail.com>
 <MWHPR12MB19344F276252365A9F02AFBC9BE10@MWHPR12MB1934.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35194 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcH3EyO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Aug 2016 00:54:14 -0400
Received: by mail-lf0-f47.google.com with SMTP id f93so5065186lfi.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 21:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <MWHPR12MB19344F276252365A9F02AFBC9BE10@MWHPR12MB1934.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Jason Dillaman <jdillama@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Aug 29, 2016 at 06:33:28PM +0000, Deneau, Tom wrote:
 
> I notice on both clusters the qemu process running is
> /usr/libexec/qemu-kvm (this is RHEL 7.2) and the
> euser,fgroup,ruser,uname printed by ps are all user qemu.

> (note: I am initiating the VM thru virsh define xyz.xml followed by
> virsh start, and the user initiating both those virsh commands is
> root).

So I advise to look at ps output for exact qemu command line and
compare this with the working environments. If they are the same, try
to run this manually from command line (instead of virsh) to see if
there is useful output (under qemu user and root). If you don't see
the qemu process on the non-working environment (because it terminated
with failure), try to run here the command from the working env.

> On both clusters /etc/ceph/ceph.conf is 644 access.
> 
> On both clusters, I get
> ldd /usr/libexec/qemu-kvm | grep rbd
>     librbd.so.1 => /lib64/librbd.so.1 (0x00007fbdf1071000)
> 
> 
> When I try 
>     rbd --id admin export <image-spec> - | md5sum
> I get the same md5sum values on both clusters.
> 
> If I use --id qemu instead, I get 
>     rbd: couldn't connect to the cluster
> on both clusters.

Why did you try 'qemu' id? I doubt qemu sets it this way.

> 
> If I leave off the --id option entirely, it works on both clusters and I get the same md5sum.
> 
> Have not tried setting debug options on the working cluster, will
> try that.

So it does not look like rbd issue. I don't think 'debug rbd' is
useful here. You could try increasing 'debug ms' (ceph messages)
though.

-- 
Mykola Golub
