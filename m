From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: libceph API
Date: Wed, 20 Apr 2011 12:02:08 -0700
Message-ID: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35891 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab1DTTCJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2011 15:02:09 -0400
Received: by fxm17 with SMTP id 17so576663fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2011 12:02:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Brian Chrisman <brchrisman@gmail.com>

Hi guys,

I pushed a branch with a revised libceph API. The main changes:

* similar appearance to librados. It should be intuitive if you've
used librados.
* The new API allows multiple ceph clusters to be open at once
(although the implementation doesn't support this yet)
* ability to pass a "root" argument to ceph_mount
* add support for reading configuration files and choosing whether to parse argv
* simpler ceph_getcwd
* unmount can't fail (the library always cleans up after itself)

The branch is at
http://ceph.newdream.net/git/?p=ceph.git;a=shortlog;h=refs/heads/libceph_api

Let me know what you think!

cheers,
Colin
