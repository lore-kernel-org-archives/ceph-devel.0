From: Nick Bartos <nick@pistoncloud.com>
Subject: ceph 0.47 libs3 install problem
Date: Mon, 21 May 2012 13:14:55 -0700
Message-ID: <CAPud5_7UKKe-=GNfWnJEut179Nz6oBdegrKX5Xoyo4Vj7oL4cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48532 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758485Ab2EUUO4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:14:56 -0400
Received: by pbbrp8 with SMTP id rp8so7381715pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:14:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to install ceph 0.47, but --prefix isn't getting passed to
the bundled libs3.  I installed libs3 separately, but even when using
--with-system-libs3 (as ./configure suggests) or
--with-system-libs3=yes (just for the hell of it), it still installs
libs3, and outside of the prefix it was given.

Anyone know of a way to either get ceph's libs3 to be installed in
--prefix, or to get it to use the system one instead?
