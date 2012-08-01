From: Mandell Degerness <mandell@pistoncloud.com>
Subject: ceph osd create
Date: Wed, 1 Aug 2012 16:27:01 -0700
Message-ID: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42182 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab2HAX1D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 19:27:03 -0400
Received: by vcbfk26 with SMTP id fk26so7642273vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 16:27:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As of this time, we are allocating OSD numbers based on servers.  The
"ceph osd create" command seems like it may be useful, but is not
documented nearly well enough yet. Can someone please provide answers
to the following:

1. Is this guaranteed to always produce an OSD number that is unique,
with no worries about race conditions?
2. Does this eliminate the need to worry about the value of max_osd?
3. Are there any other side effects of running the command?

Regards,
Mandell Degerness
