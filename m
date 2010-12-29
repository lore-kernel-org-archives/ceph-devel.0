From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: Errors on compiling master-backport of ceph-client-standalone
Date: Wed, 29 Dec 2010 15:18:14 +0800
Message-ID: <AANLkTinCdTdR5Fk6EJO-C2VAnR_CiskqRX41DUp2QNjn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34647 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0L2HSP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Dec 2010 02:18:15 -0500
Received: by eye27 with SMTP id 27so4480692eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Dec 2010 23:18:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> Sigh... this one is going to be a pain to surround with kernel version
> #ifdefs.  The commit that needs to be conditional on the version is Al's,
> ff8a8d20.  Any takers?

Fixed by two patches:
1. include version.h for kernel version checking
https://github.com/tcloud/ceph-client-standalone/commit/c1696dc02658ae98f2d8c94f03624b18acc8a20a

2. backport mount pre 2.6.37
https://github.com/tcloud/ceph-client-standalone/commit/704ba2ce3aac60fbdc7d10e229f8d93ffe87389f
