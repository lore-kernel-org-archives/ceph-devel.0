From: Dan Mick <dan.mick@inktank.com>
Subject: Re: accident corruption in osdmap
Date: Wed, 08 Aug 2012 20:53:53 -0700
Message-ID: <50233451.1060204@inktank.com>
References: <60E83269D669544E8069A09CB69135EA01C298@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56698 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab2HIDx4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 23:53:56 -0400
Received: by pbbrr13 with SMTP id rr13so193346pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Aug 2012 20:53:56 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA01C298@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org



On 08/08/2012 08:19 PM, Eric_YH_Chen@wiwynn.com wrote:
> Dear all:
>
> My Environment:  two servers, and 12 hard-disk on each server.
>                    Version: Ceph 0.48, Kernel: 3.2.0-27
>
>   We create a ceph cluster with 24 osd, 3 monitors
>   Osd.0 ~ osd.11 is on server1
>   Osd.12 ~ osd.23 is on server2
>   Mon.0 is on server1
>   Mon.1 is on server2
>   Mon.2 is on server3 which has no osd
>
> We create a rbd device and mount it as ext4 file system.
> During read/write data on the rbd device, one of the storage server is shutdown by accident.
> After reboot the server, we cannot access the rbd device any more.
> One of the log shows the osdmap is corrupted.
>
> Aug  5 15:37:24 ubuntu-002 kernel: [78579.998582] libceph: corrupt inc osdmap epoch 78 off 98 (ffffc9000177d07e of ffffc9000177d01c-ffffc9000177edf2)
>
> We would like to know what kind of scenario would cause the corruption of osdmap and how to avoid it?
> It seems that osdmap corruption cannot be recovered by the ceph cluster itself.
>
> Is it the same issue with http://tracker.newdream.net/issues/2446?
> In which version of kernel that we can find this patch? Thanks!

I'm not sure if it's the same issue, but looking at the Linux kernel 
tree, it seems as though that fix is in v3.5-rc1
