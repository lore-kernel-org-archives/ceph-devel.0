From: Milosz Tanski <milosz@adfin.com>
Subject: tcmalloc
Date: Tue, 17 Dec 2013 19:15:28 -0500
Message-ID: <CANP1eJHzHfB+S2enWm80MkLAHvv53A4Pm36X7rU1ro=Wd2QQ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62248 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab3LRAPa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 19:15:30 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so6722879wgh.23
        for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 16:15:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I wanted to bring up an issue with Ceph's use of tcmalloc. I know that
in Ubuntu (12.04) Ceph uses the distro version of tcmalloc which
older.

I've personally ran into issues with tcmalloc for our application
where the amount of private space for our application (analytics
database) is listed in 10s of gigs but the heap profiler only reports
a couple hundreds megs of use.

It seams like tcmalloc while fast does a poor job with fragmentation.
In most cases I rather leave more memory to the OS to cache disk data
leave it in case the app needs to use it. I've observed issues with
the MDS when it's grown to a few gigs and it doesn't grow down even
after I've removed a 2/3 of the tree.

It's possible that this is fixed in newer versions of tcmalloc
(https://code.google.com/p/gperftools/issues/detail?id=368). I was
curious if anyone else audited this / ran into similar issues and
bring it up. For us, we moved to jemalloc which does a fine job
returning the memory back to the OS.

-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
