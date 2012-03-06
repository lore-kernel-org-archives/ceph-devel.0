From: Borodin Vladimir <v.a.borodin@gmail.com>
Subject: OSD crashes
Date: Tue, 6 Mar 2012 09:54:42 +0300
Message-ID: <CAGEBRh1sg6OZpAqhCC9_dDx5mc=y=jNhQJRCKrdAegpBFU7CEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62208 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2CFGyn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Mar 2012 01:54:43 -0500
Received: by iagz16 with SMTP id z16so6638678iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 22:54:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all.

One of my OSD crashes when I try to start it. I've turned on "debug
osd = 20" in ceph.conf for this node and put the log here:
http://simply.name/osd.47.log. The ceph.conf file is here:
http://simply.name/ceph.conf. Is there any other information I should
show?

I've updated to 0.43 recently, but there were no problems after it.
Actually, I don't know, when this problem appeared.

Regards,
Vladimir.
