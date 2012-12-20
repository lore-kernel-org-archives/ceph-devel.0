From: Dan Mick <dan.mick@inktank.com>
Subject: Re: reference to global_context.h in dout.h
Date: Thu, 20 Dec 2012 10:33:00 -0800
Message-ID: <6C8FBDB1-C946-438E-A902-83658BEE33BE@inktank.com>
References: <CAN04cT7m4umbZ_bBszWR0Q4STyjmgv5Lx4HBy=-QgZPVZAj=FQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:43944 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2LTSiw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 13:38:52 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so1660894dad.10
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 10:38:52 -0800 (PST)
In-Reply-To: <CAN04cT7m4umbZ_bBszWR0Q4STyjmgv5Lx4HBy=-QgZPVZAj=FQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

dout/err and ldout/err rely on CeohContext being available. It's possible the includes should be separated; i'd have to look more closely to have a real judgment.  But the macros really do need a cct to work at all. 

On Dec 20, 2012, at 6:52 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:

> Hi ceph devs,
> 
> I was wondering. In common/dout.h is an #include of
> global/ceph_context.h, but it is not used there (I stumbled upon it
> because while playing around in the codebase, I noticed librados would
> not link because of an undefined reference to g_ceph_context). I have
> no idea why this include is in dout.h, but it seems that a lot of
> different sources fail to compile (because g_ceph_context definition
> is missing) when I remove the include from dout.h.
> 
> So it seems like it's used as some sort of forward include (because
> dout.h is almost always included through include/Context.h) to make
> sure g_ceph_context is defined in most places.
> 
> What is the rationale of having this here? Isn't it better to try to
> split global and common as much as possible?
> 
> Ciao,
> 
> Roald
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
