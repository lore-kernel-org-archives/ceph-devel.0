From: "K. Richard Pixley" <rich@noir.com>
Subject: Re: simple performance tests
Date: Wed, 16 Jun 2010 10:58:01 -0700
Message-ID: <4C1910A9.4030305@noir.com>
References: <hva4nu$2nr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m209-5.dsl.rawbw.com ([198.144.209.5]:33222 "EHLO
	kyoto.noir.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756492Ab0FPSGa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jun 2010 14:06:30 -0400
In-Reply-To: <hva4nu$2nr$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi.  I've been running some similar tests recently, (on ubuntu, but still).

Thomas Mueller wrote:
> dbench 1 results:
> * 1 disk, btrfs: 115
> * 2 disks, btrfs data/metadata raid0: 115
>   
This is suspicious.

I'm also not sure whether you mean that you're running btrfs on an md or 
lvm stripe or using multiple device btrfs file systems.

My numbers are showing that btrfs multidevice support may not be very 
good right now but I get pretty good results from lvm stripes.  The 
hardware I'm testing now is the first hardware I've tried, (of prolly a 
couple dozen over the years), where the controller can actually keep all 
disks spinning.  Most cannot.

Try building an lvm stripe on your two disks and testing dd directly to 
the stripe.

--rich


