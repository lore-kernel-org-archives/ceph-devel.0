From: Samuel Just <sjust@redhat.com>
Subject: jewel upgrade and sortbitwise
Date: Thu, 2 Jun 2016 20:39:34 -0700
Message-ID: <CAN=+7FWd5c=ZrD2WQXKtkzr4-Q=-nWQRrEKf-w7OFpTioOrB2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36431 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbcFCDjg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 23:39:36 -0400
Received: by mail-qk0-f176.google.com with SMTP id i187so42853958qkd.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 20:39:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Due to http://tracker.ceph.com/issues/16113, it would be best to avoid
setting the sortbitwise flag on jewel clusters upgraded from previous
versions until we get a point release out with a fix.

The symptom is that setting the sortbitwise flag on a jewel cluster
upgraded from a previous version can result in some pgs reporting
spurious unfound objects.  Unsetting sortbitwise should cause the PGs
to go back to normal.  Clusters created at jewel don't need to worry
about this.
-Sam
