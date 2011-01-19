From: Sage Weil <sage@newdream.net>
Subject: Re: would you recommend me  a solution to store xen-imgfile
Date: Wed, 19 Jan 2011 09:06:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101190905250.6864@cobra.newdream.net>
References: <4D36BDF9.4030404@wpkg.org> <1295437286.2255.25.camel@wido-desktop>
 <D0C67741759ABD4BBD8D3A5CB815606E07E47B@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37164 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1ASRGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 12:06:23 -0500
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E47B@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org, Wido den Hollander <wido@widodh.nl>, Tomasz Chmielewski <mangoo@wpkg.org>

Hi Longguang,

On Wed, 19 Jan 2011, Longguang Yue wrote:
> would you recommend me  a solution to store xen-imgfile
> 1. stability
> 2. throughout
> 3. redundancy
> If ceph suitable for storing xen-imgfile??

I would suggest using the kernel RBD driver, now present in 2.6.37.  See

	http://ceph.newdream.net/wiki/Rbd

sage
