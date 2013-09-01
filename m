From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: Random build errors - uninitialized integers
Date: Sun, 1 Sep 2013 14:37:55 +0200
Message-ID: <CAN04cT7n-4hqGo8unNiTuwS_V52U1fDnpOKWW3DUOki_qR5ppQ@mail.gmail.com>
References: <CAN04cT5F6AxJR+hNuujR4AghUQ2cFYBGbCgAA=6J0FGtYMpMkw@mail.gmail.com>
	<alpine.DEB.2.00.1308311026130.13911@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:45172 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab3IAMh4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Sep 2013 08:37:56 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so4194810oah.6
        for <ceph-devel@vger.kernel.org>; Sun, 01 Sep 2013 05:37:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308311026130.13911@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> Good catch.  I've cherry-picked the first, and just the MonitorDBStore::Op
> part to next.  I think the header changes should stay in your branch until
> it is ready to go.  It appears to be getting closer, though!

Alright. I just rebased my branch against master to see if it still
builds, and it appears to do so (gitbuilders gives a green light).

I'll wait for a while and keep rebasing this against master to see if
we hit unexpected incompatibilities in gitbuilder. When I'm convinced
it's ready to go I'll send a pull request to collect comments.

Roald
