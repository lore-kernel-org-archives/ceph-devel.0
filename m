From: Nick Bartos <nick@pistoncloud.com>
Subject: How to delete a mds?
Date: Mon, 25 Jun 2012 17:09:18 -0700
Message-ID: <CAPud5_4V=7U+OsVy7cyTwW3_dU8cEBhjw1bpEtM75WczyYvCqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40805 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757244Ab2FZAJS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 20:09:18 -0400
Received: by pbbrp8 with SMTP id rp8so7244386pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 17:09:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We decided to stop using the posix filesystem, and as such have
stopped running ceph-mds (and removed the mds things from ceph.conf).
However we get warnings about the missing mds when running 'ceph
health'.

How do I delete all the mdses?  I tried 'ceph mds rm <mdsname>' but
that doesn't seem to do any good.
