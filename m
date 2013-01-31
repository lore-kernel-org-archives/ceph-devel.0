From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Wed, 30 Jan 2013 23:22:33 -0800
Message-ID: <36B0FB63-30B2-4F1D-8BFE-3EE5ECE0980B@inktank.com>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de> <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com> <510966CF.6070501@bisect.de> <alpine.DEB.2.00.1301301153510.18801@cobra.newdream.net> <5109FC4C.1070407@inktank.com> <5109FCD5.4040303@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63866 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab3AaHWi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 02:22:38 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1585220pad.32
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 23:22:37 -0800 (PST)
In-Reply-To: <5109FCD5.4040303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Watkins Noah <noah.watkins@inktank.com>

I'll pick up these patches and create an rbd-fuse package.

Cheers,
Gary

On Jan 30, 2013, at 9:10 PM, Dan Mick wrote:

> 
> 
> On 01/30/2013 09:08 PM, Dan Mick wrote:
>> 
>> 
>> On 01/30/2013 11:55 AM, Sage Weil wrote:
>> 
>>> I think the end goal is to build an rbd-fuse package, just like
>>> ceph-fuse.
>>> I'm not sure it matters how mature the tool is before it goes into the
>>> package; as long as it is separate, people can not install it, and the
>>> distros can keep it out of their supported repos as they like.
>> 
>> I like that plan a lot better.
> 
> and the major reason it wasn't yet done is that there are no manpages, tests, etc., but I wanted this to be available to experimenters.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

