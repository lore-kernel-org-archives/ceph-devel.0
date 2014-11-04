From: Sage Weil <sage@newdream.net>
Subject: Re: Conflict with libgoogle-perftools4 in ubuntu12.04(precise)
Date: Tue, 4 Nov 2014 01:11:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411040109430.15135@cobra.newdream.net>
References: <CABF_e-Fv1V8ACFFOYuiKWe8gy133P-eJuY0u8t4Nf3V_AWODrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48753 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbaKDJLf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 04:11:35 -0500
In-Reply-To: <CABF_e-Fv1V8ACFFOYuiKWe8gy133P-eJuY0u8t4Nf3V_AWODrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cheng Wei-Chung <freeze.vicente.cheng@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 4 Nov 2014, Cheng Wei-Chung wrote:
> Dear all:
> 
> I know that the default precise repo did not have libgoogle-perftools4.
> It should only have libgoogle-perftools0.
> In the situation that we add the Ubuntu Cloud Archive will bring
> libgoogle-perftools4 with havana icehouse, juno and later version.
> It will make conflict with ceph if we have other softwares like
> mongodb that depends on libgoogle-perftools4.
> 
> I found the following feature:
> http://tracker.ceph.com/issues/8039
> Is this feature still haven't done, right?

Right, it's not done yet.

> I try to build the ceph version 0.87 with libgoogle-perftools4 and
> upgrade from firefly in my test environment.
> 
> It looks work normally. I think ceph can work on
> libgoogle-perftools0/libgoogle-perftools4.

Great!  It just needs patches to the packaging files, to go through 
testing, and then we need to make backported packages (possibly/probably) 
for a few older distros.

It will be a bit awkward to to changed this for a stable release like 
firefly, though.  How disruptive will that be?

sage


> Is there the plan for fix this conflict for the people using the
> ubuntu cloud archive in precise?
> Or we need to build a specific version with libgoogle-perftools4 if we
> have any reasons to use libgoogle-perftools4.
> 
> very thanks!!!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
