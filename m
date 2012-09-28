From: Sage Weil <sage@inktank.com>
Subject: Re: v0.52 released
Date: Fri, 28 Sep 2012 08:20:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209280819100.10331@cobra.newdream.net>
References: <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net> <506552C1.4020300@ledeuns.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49873 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758476Ab2I1PUJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 11:20:09 -0400
In-Reply-To: <506552C1.4020300@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org

On Fri, 28 Sep 2012, Denis Fondras wrote:
> Hello all,
> 
> Is it possible/recommended to mix versions ? ie. OSD with 0.48 and MON with
> 0.52 or some OSD with 0.48 and some with 0.52 ?

Yes, that is supported.  We haven't done heavy-duty testing yet mixing 
0.48 with 0.52+ and osd thrashing, but we will be shortly.

sage

