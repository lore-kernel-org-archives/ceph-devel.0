From: John Spray <jspray@redhat.com>
Subject: Crashes with new encoding
Date: Thu, 20 Oct 2016 11:33:27 +0100
Message-ID: <CALe9h7frgSiSV0YkaP4h0nK0Z2p7R_QXe=xwf9ujvCg01ZusxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33783 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbcJTKdt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2016 06:33:49 -0400
Received: by mail-lf0-f48.google.com with SMTP id x79so80807622lff.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2016 03:33:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Latest master has the MDS crashing on startup:
http://tracker.ceph.com/issues/17636
https://github.com/ceph/ceph/pull/11577

My patch is kind of dumb, clearly the intent of the original code is
to avoid any constructor overhead and it would be nice to do so, but
the original code seems to make the assumption that no encode/decode
implementations deferences the object they're passed.

Good motivation to go and immediately familiarise myself with the new
code this morning though :-)

John
