From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Truncated file on posix mount
Date: Fri, 15 Jun 2012 13:32:12 +0200
Message-ID: <4FDB1D3C.1040309@widodh.nl>
References: <4FDB03CD.5010202@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54132 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2FOLcP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 07:32:15 -0400
In-Reply-To: <4FDB03CD.5010202@opera.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sverre stoltenberg <sverrest@opera.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 15-06-12 11:43, sverre stoltenberg wrote:
> I have a ceph posix mount for openstack instances, and have found some
> of my kernels truncated. It looks rather random, and I have not found a
> way to reproduce it, but it will happen from time to time with normal use.
>

Can you share the following information?

- Kernel version
- Ceph version
- "ceph -s" output

The MDS / POSIX filesystem hasn't been tested very well at the moment, 
in the next sprint (starting soon) the developers will start focusing on 
the POSIX filesystem.

Thanks,

Wido

> the 5e...aa checksum is the correct one.
>
> root@t06-16:/var/lib/nova/instances# md5sum */kernel
> 3e0a48130ddb8bfe88239df05c073a0b instance-00000001/kernel
> 5e9463bd77757a3889a1d9758b2b94aa instance-0000000f/kernel
> 5e9463bd77757a3889a1d9758b2b94aa instance-00000010/kernel
> 5e9463bd77757a3889a1d9758b2b94aa instance-00000011/kernel
> 5e9463bd77757a3889a1d9758b2b94aa instance-00000012/kernel
> 5e9463bd77757a3889a1d9758b2b94aa instance-00000013/kernel
> 3e0a48130ddb8bfe88239df05c073a0b instance-00000014/kernel
>
> root@t06-16:/var/lib/nova/instances/instance-00000001# stat kernel
> File: `kernel'
> Size: 2097152 Blocks: 4096 IO Block: 4194304 regular file
> Device: 0h/0d Inode: 1099511627899 Links: 1
> Access: (0664/-rw-rw-r--) Uid: ( 109/libvirt-qemu) Gid: ( 111/ kvm)
> Access: 2012-06-13 11:56:56.462433802 +0200
> Modify: 2012-06-04 11:47:17.730781000 +0200
> Change: 2012-06-04 11:47:17.730781000 +0200
> Birth: -
>
> root@t06-16:/var/lib/nova/instances/instance-00000010# stat kernel
> File: `kernel'
> Size: 2424448 Blocks: 4736 IO Block: 4194304 regular file
> Device: 0h/0d Inode: 1099511627989 Links: 1
> Access: (0664/-rw-rw-r--) Uid: ( 109/libvirt-qemu) Gid: ( 111/ kvm)
> Access: 2012-06-13 09:44:03.779892491 +0200
> Modify: 2012-06-13 09:43:47.178125000 +0200
> Change: 2012-06-13 09:44:00.020102878 +0200
> Birth: -
>
