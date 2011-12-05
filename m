From: Sage Weil <sage@newdream.net>
Subject: Re: 'ceph -w' in 0.39
Date: Mon, 5 Dec 2011 13:42:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112051342290.13773@cobra.newdream.net>
References: <CAO47_--yZib5-zpwDutQSdiw7f8CWu=2CE0jNVAVP2fD4nrcZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41802 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409Ab1LEVmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 16:42:53 -0500
In-Reply-To: <CAO47_--yZib5-zpwDutQSdiw7f8CWu=2CE0jNVAVP2fD4nrcZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Hi Christian,

On Mon, 5 Dec 2011, Christian Brunner wrote:
> I've just updated to 0.39. Everything seems to be fine, except one
> minor thing I noticed:
> 
> 'ceph -w' output stops after a few minutes. With "debug ms = 1" it
> ends with these lines:
> 
> 2011-12-05 14:45:52.939300 7fc700637700 -- 10.255.0.21:0/14145 <==
> mon.2 10.255.0.22:6789/0 315 ==== mon_observe_notify(v4525550 1303
> bytes v4525550) v1 ==== 1354+0+0 (339634604 0 0) 0x7fc6f4000920 con
> 0x874070
> 2011-12-05 14:45:52.939319    pg v4525550: 2776 pgs: 2776
> active+clean; 3362 GB data, 1646 GB used, 57135 GB / 59615 GB avail
> 
> After that, silence...

I just pushed a fix for this to the stable branch.  

Thanks!
sage
