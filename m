From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 0/7] ceph: misc fixes
Date: Tue, 5 Mar 2013 12:44:57 -0800
Message-ID: <9E3594992B884B3FBCE30CC17587A16C@inktank.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
 <CAPYLRzjSOrZJUKAED2iw4uGSRwmB1euEekkcP5mjGjjWdMxP1g@mail.gmail.com>
 <513568D1.60305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:55640 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab3CEUpF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 15:45:05 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so4962956pbc.29
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 12:45:05 -0800 (PST)
In-Reply-To: <513568D1.60305@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

I've merged this series into the testing branch, with appropriate Reviewed-by tags from me (and Sage on #4). Thanks much for the code and helping me go through it. :) 
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Monday, March 4, 2013 at 7:38 PM, Yan, Zheng wrote:

> On 03/05/2013 02:49 AM, Gregory Farnum wrote:
> > On Thu, Feb 28, 2013 at 10:46 PM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> > > From: "Yan, Zheng" <zheng.z.yan@intel.com>
> > > 
> > > These patches are also in:
> > > git://github.com/ukernel/linux.git (http://github.com/ukernel/linux.git) wip-ceph
> > 
> > 
> > 
> > 1, 2, 3, 5, 7 all look good to me. If you can double-check Sage's
> > concerns on 4 and my questions on 6 I'll be happy to pull these in. :)
> 
> 
> 
> I rechecked locking assumption in patch 4, nothing goes wrong.
> 
> Regards
> Yan, Zheng
> 
> > -Greg 


