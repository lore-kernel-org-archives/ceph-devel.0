From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: building the 'next' branch
Date: Mon, 28 Feb 2011 09:23:06 -0800
Message-ID: <AANLkTikO=Sskj_zb-cdh2ouOYESLx8JY34hCkSgK_zsL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51790 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab1B1RYf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Feb 2011 12:24:35 -0500
Received: by fxm17 with SMTP id 17so3954743fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 09:24:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi guys,

If you try to build the 'next' branch now, you will probably get the
following error:

make[2]: *** No rule to make target `config.cc', needed by `config.o'.  Stop.
make[2]: *** Waiting for unfinished jobs....

This is a known bug (or limitation, or whatever you want to call it)
in automake.
http://www.mail-archive.com/bug-automake@gnu.org/msg01874.html

Basically, I moved config.cc from src/config.cc to
src/common/config.cc. Unfortunately, automake gets confused by this.
You must do a "make distclean" before rebuilding to clear its internal
state. Sorry, regular make clean is not enough :(

If anyone knows a workaround (aside from moving to CMake), it would be
much appreciated, of course!

cheers,
Colin
