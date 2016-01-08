From: Samuel Just <sjust@redhat.com>
Subject: ovh hammer runs
Date: Fri, 8 Jan 2016 11:40:56 -0800
Message-ID: <CAN=+7FXzHqeDrLYUhYnG4kMr+aBmmipPOsAHUkS5pgbg+3BrVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36788 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbcAHTk5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jan 2016 14:40:57 -0500
Received: by mail-io0-f171.google.com with SMTP id g73so99091865ioe.3
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jan 2016 11:40:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weinstein, Yuri" <yweinste@redhat.com>, "Meno, Gregory" <gmeno@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>

We're still seeing ENOSPC hangs in the hammer runs, which are making
them not very valuable.  I filed a feature bug which should help
(http://tracker.ceph.com/issues/14312), but in the mean time, I think
we should move the hammer and jewel nightlies to smithi.  If it turns
out to be too much load, we can reassess.
-Sam
