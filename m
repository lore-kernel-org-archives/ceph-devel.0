From: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
Subject: [PATCH 0/3] WIP-8112 radosgw usage & man update
Date: Thu, 24 Jul 2014 20:30:40 +0530
Message-ID: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56225 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759339AbaGXPB2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 11:01:28 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so3819939pdb.33
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 08:01:28 -0700 (PDT)
Received: from localhost.localdomain ([49.32.0.91])
        by mx.google.com with ESMTPSA id uj2sm21604517pab.14.2014.07.24.08.01.25
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jul 2014 08:01:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

This is a series of patches to update radosgw usage and man pages with
all the available help options. 1/3 is a minor format fix to display
the options in the same line.

Abhishek Lekshmanan (3):
  rgw: format help options to align with the rest
  rgw: list all available options during help()
  doc: update radosgw man page with available opts

 doc/man/8/radosgw.rst | 28 ++++++++++++++++++++++++++++
 src/rgw/rgw_main.cc   | 10 ++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
1.9.1

Thanks,
         Abhishek
