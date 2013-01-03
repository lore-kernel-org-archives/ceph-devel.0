From: Roberto Aguilar <roberto.c.aguilar@gmail.com>
Subject: When to use "filestore xattr use omap = true"
Date: Thu, 3 Jan 2013 13:16:26 -0800
Message-ID: <CAJTroNqG7OA-WWL+5VxMZ-ggOuR-WKcFa4PH8UQ+tVda1jXN-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:48189 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab3ACVQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 16:16:46 -0500
Received: by mail-ia0-f179.google.com with SMTP id o25so13269436iad.10
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 13:16:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I read the "Filesystems" section in the "Hard disk and file system
recommendations" [1] documentation and was confused on whether or not
I should be using the setting:

  filestore xattr use omap = true

The section reads:

"[...] but the ext4 is too small to be usable. To use these file
systems, you should add the following like to the [osd] section of
your ceph.conf file.:"

Does that mean I the setting applies to systems that are using ext4,
or does it apply to _any_ filesystem that was mentioned, i.e. btrfs,
xfs, and ext4.

Thanks!
-Roberto.

[1] http://ceph.com/docs/master/rados/configuration/filesystem-recommendations/
