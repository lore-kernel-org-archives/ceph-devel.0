From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: v0.80.2?
Date: Mon, 14 Jul 2014 17:21:23 +0200
Message-ID: <CAF6-1L4Vr-yA+bUcoKy-0MxepzdjrkBCwv7ACv7W2AnhYTLJ4Q@mail.gmail.com>
References: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
	<CAF6-1L6bYp9EUidFnKZDwh1Qsf6wRrRpyL4gm7nP7aHS+VHEng@mail.gmail.com>
	<alpine.DEB.2.00.1407111259580.3932@cobra.newdream.net>
	<CAF6-1L6MHOUWd_yrzf8ZyxpVVNEm86AoasoV1Azv9iTWogGnwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64165 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbaGNPVY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jul 2014 11:21:24 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so3181768pdj.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jul 2014 08:21:23 -0700 (PDT)
In-Reply-To: <CAF6-1L6MHOUWd_yrzf8ZyxpVVNEm86AoasoV1Azv9iTWogGnwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Here's the culprit IMHO:


ea68b9372319fd0bab40856db26528d36359102e

----
    rgw: don't allow multiple writers to same multiobject part

    Fixes: #8269
    Backport: firefly, dumpling

    A client might need to retry a multipart part write. The original thread
    might race with the new one, trying to clean up after it, clobbering the
    part's data.
    The fix is to detect whether an original part already existed, and if so
    use a different part name for it.

    Signed-off-by: Yehuda Sadeh <yehuda@inktank.com>
    (cherry picked from commit bd8e026f88b812cc70caf6232c247844df5d99bf)
----

This is the first commit that, if you apply b300318113b162522759d4794b1cfa
3d1d9398e4 over it, will cause a segfault.


Cheers,

   Sylvain
