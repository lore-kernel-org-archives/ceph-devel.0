From: Milosz Tanski <milosz@adfin.com>
Subject: Ubuntu 12.04 MDS tcmalloc leaks
Date: Fri, 11 Apr 2014 11:59:49 -0400
Message-ID: <CANP1eJGaoj6SAcMMMHGZNkZOtX5gP7sGMWXXo5Bxbzhw6DKBuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:41427 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369AbaDKP7u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Apr 2014 11:59:50 -0400
Received: by mail-we0-f169.google.com with SMTP id w62so5651414wes.28
        for <ceph-devel@vger.kernel.org>; Fri, 11 Apr 2014 08:59:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'd like to restart this debate about tcmalloc slow leaks in MDS. This
time around I have some charts. Looking at OSDs and MONs, it doesn't
seam to affect those (as much).

Here's the chart: http://i.imgur.com/xMCINAD.png The first two humps
are the latest stable MDS version with tcmalloc till MDS gets killed
by the OOM killer. The last restart MDS build of the same git tag
without tcmalloc linked into it.

I know that older tcmalloc version have leaks when allocating larger
blocks of memory:
https://code.google.com/p/gperftools/issues/detail?id=368 So it's
possible that there is some kind of allocation pattern in MDS that
causes this behavior or exposes this tcmalloc bug.

Last time I bought it up there was resistance to tossing tcmalloc,
which is fine. What I'd like to see is not linking against tcmalloc on
systems that are know to have a buggy tcmalloc (in this case ubuntu
12.04, older Debian systems).

-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
