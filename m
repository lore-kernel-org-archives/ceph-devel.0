From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Fri, 01 Feb 2013 15:22:19 +0100
Message-ID: <510BCF9B.5080407@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de> <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com> <510966CF.6070501@bisect.de> <alpine.DEB.2.00.1301301153510.18801@cobra.newdream.net> <5109FC4C.1070407@inktank.com> <5109FCD5.4040303@inktank.com> <FFA4897D-6F2D-43A3-B52D-6F700D537B63@inktank.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:41264 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755473Ab3BAOWY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 09:22:24 -0500
In-Reply-To: <FFA4897D-6F2D-43A3-B52D-6F700D537B63@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Watkins Noah <noah.watkins@inktank.com>, Dan Mick <dan.mick@inktank.com>

Hi Gary,

seems to work fine. Feel free to check [1] for build results
(i586/x86_64) on openSUSE 11.4-Factory, SLE11-SP2, Fedora 16-18, RHEL6,
CentOS6, Ubuntu 12.10 (the source of the package is currently a merge of
master and wip-rpm-update3).

Danny

[1]
https://build.opensuse.org/package/show?package=ceph&project=home%3Adalgaaf%3Aceph

Am 01.02.2013 08:00, schrieb Gary Lowell:
> The patches have been applied to the wip-rpm-update3 branch.
> Additionally, rbd-fuse has been put into it's own package.
> 
> Please have a look and let me know if that works for everyone.
> 
> Thanks, Gary
> 
> On Jan 30, 2013, at 9:10 PM, Dan Mick wrote:
> 
>> 
>> 
>> On 01/30/2013 09:08 PM, Dan Mick wrote:
>>> 
>>> 
>>> On 01/30/2013 11:55 AM, Sage Weil wrote:
>>> 
>>>> I think the end goal is to build an rbd-fuse package, just
>>>> like ceph-fuse. I'm not sure it matters how mature the tool is
>>>> before it goes into the package; as long as it is separate,
>>>> people can not install it, and the distros can keep it out of
>>>> their supported repos as they like.
>>> 
>>> I like that plan a lot better.
>> 
>> and the major reason it wasn't yet done is that there are no
>> manpages, tests, etc., but I wanted this to be available to
>> experimenters. -- To unsubscribe from this list: send the line
>> "unsubscribe ceph-devel" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 
> -- To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

