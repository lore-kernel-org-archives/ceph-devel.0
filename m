From: Szymon Szypulski <szymon.szypulski@ragnarson.com>
Subject: Limiting specific to specific directory, client separation
Date: Mon, 24 Mar 2014 11:37:10 +0100
Message-ID: <CA+5bbP9-NGQ2sAsSwrauhKpsvqxjRjcxf4MRRNNL4gqxDO2k+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:48835 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaCXKhL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 06:37:11 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so5560296obc.27
        for <ceph-devel@vger.kernel.org>; Mon, 24 Mar 2014 03:37:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

We would liked to migrate from gluster to ceph in environment where
multiple servers can access one directory, where some should be
unavailable. Basically we need per directory access list for multiple
users.

I've found some overdue tickets on tracker
http://tracker.ceph.com/issues/1401 and
http://tracker.ceph.com/issues/1237. Is there any chance it will be
included into road map soon? If not, is there anything we can do to
speed it up? Hire C/C++ dev internally and delegate it to ceph
development? Maybe something else?

---
Szymon Szypulski
