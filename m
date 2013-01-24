From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 10:16:18 -0800
Message-ID: <51017A72.1010706@inktank.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <50FC1C0F.9090706@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:54045 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab3AXSQW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 13:16:22 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so5576736pbb.24
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 10:16:21 -0800 (PST)
In-Reply-To: <50FC1C0F.9090706@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dmaziuk@bmrb.wisc.edu
Cc: ceph-devel@vger.kernel.org

On 01/20/2013 08:32 AM, Dimitri Maziuk wrote:
> On 1/19/2013 11:13 AM, Sage Weil wrote:
>
>> If you want to use the kernel client(s), that is true: there are no 
>> plans
>> to backport the client code to the ancient RHEL kernels. Nothing 
>> prevents
>> you from running the server side, though, or the userland clients
>> (ceph-fuse, librbd, qemu/KVM, radosgw, etc.)
>
> mkcephfs form 5-minute start fails without rbd.ko. I already reported 
> that.
>
> Dima

This is an apparently-unique problem, and we'd love to see details.
