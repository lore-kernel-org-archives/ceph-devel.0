From: Dan Mick <dan.mick@inktank.com>
Subject: Re: some questions about rbd
Date: Mon, 22 Oct 2012 21:21:13 -0700
Message-ID: <50861B39.8010008@inktank.com>
References: <CAB6Jr7QLS1=G0vPavT70knKUteDczF4yho1Bha_Tgsv1tsXusA@mail.gmail.com> <CAB6Jr7Q3NcJAFiENv5w=p+DVtZoPksWtQH+cgF4ysHAxMzn6ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46882 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab2JWEVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 00:21:19 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2451854pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 21:21:18 -0700 (PDT)
In-Reply-To: <CAB6Jr7Q3NcJAFiENv5w=p+DVtZoPksWtQH+cgF4ysHAxMzn6ng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jie sun <0maidou0@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 10/22/2012 08:10 PM, jie sun wrote:
> Hi,
>
> I create a image and map it to a virtual machine,and then mkfs and mount it.
>
> I want to remove the image from mon server forcely, but it says
> "Removing image: 99% complete...failed.
>   delete error: image still has watchers
>   This means the image is still open or the client using it crashed.
> Try again after closing/unmapping it or waiting 30s for the crashed
> client to timeout."
>
> I want to know is there any other way to remove it by force?

Are you saying the vm still has the device open and is trying to use it?
But even so, you want the image to be deleted?

