From: Samuel Just <sjust@redhat.com>
Subject: C++11 and librados C++
Date: Mon, 3 Aug 2015 13:25:17 -0700
Message-ID: <CAN=+7FX9Va+rxRr87E6bn6djjHSvXtVZTd+f576g=n01TJ5cRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36765 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbHCUZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 16:25:18 -0400
Received: by igbij6 with SMTP id ij6so61667371igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 13:25:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Cc: "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Casey Bodley <cbodley@redhat.com>

It seems like it's about time for us to make the jump to C++11.  This
is probably going to have an impact on users of the librados C++
bindings.  It seems like such users would have to recompile code using
the librados C++ libraries after upgrading the librados library
version.  Is that reasonable?  What do people expect here?
-Sam
