From: Gregory Farnum <greg@inktank.com>
Subject: tcmalloc memory leak on squeeze
Date: Wed, 19 Jun 2013 09:25:57 -0700
Message-ID: <CAPYLRziqNroEtT5hhMjrBiebtVtxHzM8kgj0ty-KUtLiDDRhKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:49659 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049Ab3FSQZ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 12:25:59 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so4609290wes.18
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 09:25:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: daigo@debian.org
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Daigo,
In the Ceph project we use tcmalloc by default for its much-improved
(over the standard) handling of memory fragmentation under our
workload.
Unfortunately, one of our users seems to have a discovered a memory
leak when running the standard Debian squeeze packages:
http://tracker.ceph.com/issues/5375#note-8
Note that while tcmalloc is reporting it has an 80MB heap from the OS
(of which about half is in use), the OS believes the process has 1GB
allocated. This mismatch is not behavior we've seen before, and when
the user backported the wheezy version of libgoogle-perftools and
rebuilt the problem did not resurface.

Is this an issue you've encountered before? We'd like to identify the
cause for future reference with our users, or in case the issue recurs
in future versions of the library.
-Greg
