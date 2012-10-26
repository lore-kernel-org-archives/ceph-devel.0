From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Tracking hadoop-common for file system shim versioning
Date: Fri, 26 Oct 2012 15:29:43 -0700
Message-ID: <CAPrxi584NjBoo1qA-2YpqMt9p+6g+SooeR0Y1fKetGN55Fchdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50247 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966768Ab2JZW3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:29:44 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3591213vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:29:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <buck@soe.ucsc.edu>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Development of the Hadoop shim layer is best done in the Apache Hadoop
Git repository, so we can track up-stream and build for all the
different versions that exist. Is keeping a clone in Inktank Github
something that is possible / desired?

Thanks,
- Noah
