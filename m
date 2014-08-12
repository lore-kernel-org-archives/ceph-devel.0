From: Adam Crume <adamcrume@gmail.com>
Subject: Re: LTTng unfriendly with mixed static/dynamic linking
Date: Tue, 12 Aug 2014 13:30:53 -0700
Message-ID: <CAFu9Dv0SyShvzK_Eh8ck9XNXNkz8ytAB43CCPLQ-cgEiWz8PDg@mail.gmail.com>
References: <CAFu9Dv37reLPuQ_9fHkgqwDWtKiwQk8FCd4MAqY6wk75ASs07w@mail.gmail.com>
	<CAFu9Dv3FY=RkC9cAqt8p5oB0FNHsLUnK=1Nx3eh==C8Q4-i1Ww@mail.gmail.com>
	<alpine.DEB.2.00.1407251507160.22752@cobra.newdream.net>
	<53D38300.2050009@inktank.com>
	<CAFu9Dv1owC=qjte+bgDuq8N=7ykuyuytwEZLdNL+71-oOxc0ag@mail.gmail.com>
	<alpine.DEB.2.00.1408121246500.32572@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:55250 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbaHLUax (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 16:30:53 -0400
Received: by mail-oa0-f44.google.com with SMTP id eb12so7796204oac.31
        for <ceph-devel@vger.kernel.org>; Tue, 12 Aug 2014 13:30:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408121246500.32572@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Noah M. Watkins" <noahwatkins@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

With the version match requirements, I think it would work.  Will
automake and libtool let us have a static and dynamic version of the
same library, or would we have two similarly-named libraries?

Removing the tracepoints from libcommon would be an appropriate short
term fix.  Besides just this, though, I need to finish moving the
tracepoints in librbd, clean up the branch's history, and test the
whole workflow again before it's ready to merge to master.
