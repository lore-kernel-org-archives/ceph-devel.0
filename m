From: Roald van Loon <roaldvanloon@gmail.com>
Subject: reference to global_context.h in dout.h
Date: Thu, 20 Dec 2012 15:52:14 +0100
Message-ID: <CAN04cT7m4umbZ_bBszWR0Q4STyjmgv5Lx4HBy=-QgZPVZAj=FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:48102 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab2LTO6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 09:58:35 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so3784475vbb.7
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 06:58:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi ceph devs,

I was wondering. In common/dout.h is an #include of
global/ceph_context.h, but it is not used there (I stumbled upon it
because while playing around in the codebase, I noticed librados would
not link because of an undefined reference to g_ceph_context). I have
no idea why this include is in dout.h, but it seems that a lot of
different sources fail to compile (because g_ceph_context definition
is missing) when I remove the include from dout.h.

So it seems like it's used as some sort of forward include (because
dout.h is almost always included through include/Context.h) to make
sure g_ceph_context is defined in most places.

What is the rationale of having this here? Isn't it better to try to
split global and common as much as possible?

Ciao,

Roald
