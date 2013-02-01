From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Thu, 31 Jan 2013 23:00:48 -0800
Message-ID: <FFA4897D-6F2D-43A3-B52D-6F700D537B63@inktank.com>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de> <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com> <510966CF.6070501@bisect.de> <alpine.DEB.2.00.1301301153510.18801@cobra.newdream.net> <5109FC4C.1070407@inktank.com> <5109FCD5.4040303@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37851 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab3BAHAx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 02:00:53 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp8so2018059pbb.20
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 23:00:53 -0800 (PST)
In-Reply-To: <5109FCD5.4040303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Gregory Farnum <greg@inktank.com>, Watkins Noah <noah.watkins@inktank.com>, Dan Mick <dan.mick@inktank.com>

The patches have been applied to the wip-rpm-update3 branch.  Additionally, rbd-fuse has been put into it's own package.

Please have a look and let me know if that works for everyone.

Thanks,
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

