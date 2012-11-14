From: Alex Jiang <alex.jiang.zju@gmail.com>
Subject: Re: [Help] Use Ceph RBD as primary storage in CloudStack 4.0
Date: Wed, 14 Nov 2012 17:15:01 +0800
Message-ID: <CAGVY77fLQcwHPPALSgjHDB=JTxXe2CUofnd01qgZzT5LzJU0rA@mail.gmail.com>
References: <CAGVY77c+mRcjh+qSJS2V2yj-snEtrA+hzp3RTy+LVkBp1CUNbg@mail.gmail.com>
	<50A2BB78.5060407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34435 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964785Ab2KNJPD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 04:15:03 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so178341oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 01:15:02 -0800 (PST)
In-Reply-To: <50A2BB78.5060407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Dan
Thank you for your reply.After installing ceph, I can compile Qemu
with RBD enable and have added the host to CloudStack successfully.

2012/11/14 Dan Mick <dan.mick@inktank.com>:
> Hi Alex:
>
> did you install the ceph packages before trying to build qemu?  It sounds
> like qemu is looking for the Ceph libraries and not finding them.
>
>
> On 11/12/2012 09:38 PM, Alex Jiang wrote:
>>
>> Hi, All
>>
>> Has somebody used Ceph RBD in CloudStack as primary storage? I see
>> that in the new features of CS 4.0, RBD is supported for KVM. So I
>> tried using RBD as primary storage but met with some problems.
>>
>> I use a CentOS6.3 server as host. First I erase the qemu-kvm(0.12.1)
>> and libvirt(0.9.10) because their versions are too low (Qemu on the
>> Hypervisor has to be compiled with RBD enabled .The libvirt version on
>> the Hypervisor has to be at least 0.10 with RBD enabled).Then I
>> download the latest qemu(1.2.0) and libvirt(1.0.0) source code and
>> compile and install them. But when compiling qemu source code,
>>
>> #wget http://wiki.qemu-project.org/download/qemu-1.2.0.tar.bz2
>> #tar jxvf qemu-1.2.0.tar.bz2
>> # cd qemu-1.2.0
>> # ./configure --enable-rbd
>>
>> the following errors occur:
>> ERROR: User requested feature rados block device
>> ERROR: configure was not able to find it
>>
>> But on Ubuntu12.04 I tried compiling qemu source code and succeed.Now
>> I am very confused.How to use Ceph RBD as primary storage in
>> CloudStack on CentOS6.3?Anyone can help me?
>>
>> Best Regards,
>>
>>   Alex
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
