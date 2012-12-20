From: Sage Weil <sage@inktank.com>
Subject: Re: reference to global_context.h in dout.h
Date: Thu, 20 Dec 2012 10:44:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212201043170.16508@cobra.newdream.net>
References: <CAN04cT7m4umbZ_bBszWR0Q4STyjmgv5Lx4HBy=-QgZPVZAj=FQ@mail.gmail.com> <6C8FBDB1-C946-438E-A902-83658BEE33BE@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52661 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab2LTSoc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 13:44:32 -0500
In-Reply-To: <6C8FBDB1-C946-438E-A902-83658BEE33BE@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Roald van Loon <roaldvanloon@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 20 Dec 2012, Dan Mick wrote:
> dout/err and ldout/err rely on CeohContext being available. It's 
> possible the includes should be separated; i'd have to look more closely 
> to have a real judgment.  But the macros really do need a cct to work at 
> all.

Right.

In an ideal world, things that link in g_ceph_context would have a 
separate #include and other code wouldn't see the declaration, but we 
didn't get that far when this was cleaned up a while back.  Instead, you 
get a linker error if you, say, do dout(...) instead of ldout(...) in 
something that doesn't link the globals.

sage


 > 
> On Dec 20, 2012, at 6:52 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> 
> > Hi ceph devs,
> > 
> > I was wondering. In common/dout.h is an #include of
> > global/ceph_context.h, but it is not used there (I stumbled upon it
> > because while playing around in the codebase, I noticed librados would
> > not link because of an undefined reference to g_ceph_context). I have
> > no idea why this include is in dout.h, but it seems that a lot of
> > different sources fail to compile (because g_ceph_context definition
> > is missing) when I remove the include from dout.h.
> > 
> > So it seems like it's used as some sort of forward include (because
> > dout.h is almost always included through include/Context.h) to make
> > sure g_ceph_context is defined in most places.
> > 
> > What is the rationale of having this here? Isn't it better to try to
> > split global and common as much as possible?
> > 
> > Ciao,
> > 
> > Roald
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
