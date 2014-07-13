From: Samuel Just <sam.just@inktank.com>
Subject: consequences of XFS_IOC_FSSETXATTR on non-empty file?
Date: Sat, 12 Jul 2014 18:16:54 -0700
Message-ID: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64298 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaGMBQz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jul 2014 21:16:55 -0400
Received: by mail-qa0-f46.google.com with SMTP id v10so2120946qac.33
        for <ceph-devel@vger.kernel.org>; Sat, 12 Jul 2014 18:16:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xfs@oss.sgi.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Ilya Dryomov <ilya.dryomov@inktank.com>

Hi,

We are seeing reports of ceph-osd stores on xfs of files with some
garbage data (possibly misplaced from data elsewhere in the
filesystem).  There was a bug for a while where the ceph-osd process
would set a value for fsx_extsize on a non-empty (possibly sparse)
file using XFS_IOC_FSSETXATTR.  Could that plausibly result in a file
with garbage data?  Let me know if there is any additional information
or detail which might be valuable.  One report was on kernel versions
3.14.3 and 3.14.4.
-Sam
