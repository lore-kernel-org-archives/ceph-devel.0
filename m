From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Wed, 30 Jan 2013 21:08:28 -0800
Message-ID: <5109FC4C.1070407@inktank.com>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de> <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com> <510966CF.6070501@bisect.de> <alpine.DEB.2.00.1301301153510.18801@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43067 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3AaFIc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 00:08:32 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so1516137pad.26
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 21:08:32 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301301153510.18801@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Watkins Noah <noah.watkins@inktank.com>



On 01/30/2013 11:55 AM, Sage Weil wrote:

> I think the end goal is to build an rbd-fuse package, just like ceph-fuse.
> I'm not sure it matters how mature the tool is before it goes into the
> package; as long as it is separate, people can not install it, and the
> distros can keep it out of their supported repos as they like.

I like that plan a lot better.
