From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Sat, 01 Dec 2012 16:27:29 -0800
Message-ID: <50BAA071.70300@inktank.com>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com> <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag> <50B3CA6F.6000000@inktank.com> <50B484FF.9070500@profihost.ag> <50B62580.2030301@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58674 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab2LBA1t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Dec 2012 19:27:49 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so772676dak.19
        for <ceph-devel@vger.kernel.org>; Sat, 01 Dec 2012 16:27:48 -0800 (PST)
In-Reply-To: <50B62580.2030301@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/28/2012 6:53 AM, Stefan Priebe - Profihost AG wrote:
> Hi Dan,
>
> thanks for your update / new import-export branch.
>
> The import seems to work now. What i'm wondering is that it is really 
> slow.
>
> I see around 10% CPU Usage on importing host (host where rbd import is 
> started) and just 4MB every 2s raising Data on ceph. This means 40GB 
> took around 5-6 hours.
>
> Night this be due to he size update? 4MB every 2s looks like the 
> stripe size.

I did change the resize to double each time to help with that before
pushing to master, but that still seems awfully slow.  You should 
definitely use the
version in the mainline, though; it's better in several ways.

Are these particularly sparse images?  I'm testing a "preserve 
sparseness" tweak that should help
a lot if so (and save space in the cluster, obviously).

