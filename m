From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 07:34:40 -0600
Message-ID: <50F7FDF0.6010809@inktank.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com> <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net> <50F72150.7080002@inktank.com> <D37FDADD-C230-48D8-AA09-38C474D1F395@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37725 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab3AQNeo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 08:34:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4736401ieb.33
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 05:34:44 -0800 (PST)
In-Reply-To: <D37FDADD-C230-48D8-AA09-38C474D1F395@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/16/2013 11:47 PM, Stefan Priebe - Profihost AG wrote:
> Hi Mark,
>
> Am 16.01.2013 um 22:53 schrieb Mark
>> With only 2 SSDs for 12 spinning disks, you'll need to make sure the SSDs are really fast.  I use Intel 520s for testing which are great, but I wouldn't use them in  production.
>
> Why not? I use them for a ssd only ceph cluster.
>
> Stefan

It's pretty tough to get an apples-to-apples comparison of endurance 
when looking at the Intel 520 vs something like the DC S3700. If I were 
actually building out a production deployment I'd probably stick with 
the DC S3700 (especially if sticking journals, flashcache, and xfs 
journals for 6 osds on 1 drive!).  There's probably a reasonable 
endurance per cost argument for a severely under-subscribed 520 (or 
other similar drive) as well.  It'd be an interesting study to look at 
how long it takes a small enterpise drives to die vs a larger 
under-subscribed consumer drive.

-- 
Mark Nelson
Performance Engineer
Inktank
