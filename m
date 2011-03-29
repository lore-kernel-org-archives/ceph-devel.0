From: Sage Weil <sage@newdream.net>
Subject: Re: What ports do each of the ceph daemons listen on?
Date: Tue, 29 Mar 2011 14:36:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103291434460.24826@cobra.newdream.net>
References: <AANLkTik7Q6B2mDApjWTq_AvLNhbEUTA2Ojr-gq9s=FFq@mail.gmail.com>
 <1301432126.2364.17.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40887 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab1C2VdL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 17:33:11 -0400
In-Reply-To: <1301432126.2364.17.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Jay Hacker <jayqhacker@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 29 Mar 2011, Wido den Hollander wrote:
> Hi,
> 
> On Tue, 2011-03-29 at 16:27 -0400, Jay Hacker wrote:
> > I'd like to be able to open just the required ports in my firewall.
> 
> The monitor by default binds on 6789, the mds on 6800.
> 
> OSD's bind on 6800 (if available) and increment from there, but I think
> the MDS'es do the same.
> 
> For example, if you have 3 OSD's on one host, the first OSD will bind on
> 6800, the second on 6801, etc, etc.

Basically the MDS and OSD search for an open port starting at 6800.  The 
MDS uses one port, the OSD uses 3.  Be sure to open up a sufficiently wide 
range.

Also, be aware there hasn't been any time spent on hardening the servers 
from a security standpoint.

sage
