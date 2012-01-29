From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Files under ceph-mon's auth directory
Date: Mon, 30 Jan 2012 01:24:38 +0800
Message-ID: <CANExM-N2yrdFwzv4tr7wYZ_mEh_-kSn9OrOyzqwcB2sTJh0G8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab2A2RYj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jan 2012 12:24:39 -0500
Received: by iacb35 with SMTP id b35so4151633iac.19
        for <ceph-devel@vger.kernel.org>; Sun, 29 Jan 2012 09:24:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

After running ceph for months, the ceph-mon's auth directory contains
117729 files, around 473MB. Unlike pgmap or logm, the files under auth
directory seems never been trimmed. It causes that adding a mon takes
a long long time. Is there a way to avoid it?

Henry
