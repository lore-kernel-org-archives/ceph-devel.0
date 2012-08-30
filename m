From: Tommi Virtanen <tv@inktank.com>
Subject: Review please: wip-create-admin-key and #3065
Date: Thu, 30 Aug 2012 10:37:08 -0400
Message-ID: <CADvuQRH5T+-PHbSi4UKSNCHydx+e-Kb6Xdekg75MgUU6VfrsEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43954 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2H3Oha (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 10:37:30 -0400
Received: by vcbfk26 with SMTP id fk26so1978659vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 07:37:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

Hi. I'm trying to improve the admin key management, and change how we
use client.admin. I'd appreciate if you could review the branch and
the somewhat unrelated ticket http://tracker.newdream.net/issues/3065
.
