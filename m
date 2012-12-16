From: Lorieri <lorieri@gmail.com>
Subject: radosgw: partially uploaded files never reclaim space
Date: Sun, 16 Dec 2012 01:05:55 -0200
Message-ID: <CAPHxCcQ8mF6Zv1v4g9Xx0T_e6aOoWf6JJ+VrbHhhbJhOs1z4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39242 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab2LPDF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 22:05:56 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3286748pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Dec 2012 19:05:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


I was doing some tests with radosgw and one of the tests were
interrupt a file transfer on its middle.
The result was to get some disc space that is never reclaimed.
I run the temp delete command, then waited 24 hours, then upgraded to
0.55, then removed the radosgw bucket (not the rados bucket), and the
partial files are still there.

Is there anything else I can do ?

bests,
-lorieri
