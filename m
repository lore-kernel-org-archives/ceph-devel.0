From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [Help] Use Ceph RBD as primary storage in CloudStack 4.0
Date: Tue, 13 Nov 2012 13:28:24 -0800
Message-ID: <50A2BB78.5060407@inktank.com>
References: <CAGVY77c+mRcjh+qSJS2V2yj-snEtrA+hzp3RTy+LVkBp1CUNbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2KMV21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 16:28:27 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so87463pbc.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 13:28:27 -0800 (PST)
In-Reply-To: <CAGVY77c+mRcjh+qSJS2V2yj-snEtrA+hzp3RTy+LVkBp1CUNbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Jiang <alex.jiang.zju@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Alex:

did you install the ceph packages before trying to build qemu?  It 
sounds like qemu is looking for the Ceph libraries and not finding them.

On 11/12/2012 09:38 PM, Alex Jiang wrote:
> Hi, All
>
> Has somebody used Ceph RBD in CloudStack as primary storage? I see
> that in the new features of CS 4.0, RBD is supported for KVM. So I
> tried using RBD as primary storage but met with some problems.
>
> I use a CentOS6.3 server as host. First I erase the qemu-kvm(0.12.1)
> and libvirt(0.9.10) because their versions are too low (Qemu on the
> Hypervisor has to be compiled with RBD enabled .The libvirt version on
> the Hypervisor has to be at least 0.10 with RBD enabled).Then I
> download the latest qemu(1.2.0) and libvirt(1.0.0) source code and
> compile and install them. But when compiling qemu source code,
>
> #wget http://wiki.qemu-project.org/download/qemu-1.2.0.tar.bz2
> #tar jxvf qemu-1.2.0.tar.bz2
> # cd qemu-1.2.0
> # ./configure --enable-rbd
>
> the following errors occur:
> ERROR: User requested feature rados block device
> ERROR: configure was not able to find it
>
> But on Ubuntu12.04 I tried compiling qemu source code and succeed.Now
> I am very confused.How to use Ceph RBD as primary storage in
> CloudStack on CentOS6.3?Anyone can help me?
>
> Best Regards,
>
>   Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
