From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: mount.ceph: modprobe failed, exit status 127
Date: Fri, 15 Apr 2011 14:57:02 +0200
Message-ID: <4DA8409E.9000808@provocation.net>
References: <4DA82A9E.5010504@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:52032 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab1DOM5G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 08:57:06 -0400
In-Reply-To: <4DA82A9E.5010504@science-computing.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/15/2011 01:23 PM, Christoph Raible wrote:

> I compiled new kernel on CentOS 5.6 (kernel-ml-2.6.38-2) with CEPH support

>     CONFIG_CEPH_LIB=y
>     # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
>     CONFIG_CEPH_FS=y 

This builds the drivers into the kernel. For loadable modules you should use
CONFIG_CEPH_LIB=m and CONFIG_CEPH_FS=m .

> Now when I want to mount a Ceph filesystem with
>     mount -t ceph 10.1.9.46:/ /mnt/ceph
> I got following error:
>     "mount.ceph: modprobe failed, exit status 127"

Since ceph and libceph are already in the kernel, it seems logical that loading
them would fail; after all, there are no modules to be loaded. Then again, it
doesn't make sense that mount tries to load them anyway and fails.

Z

