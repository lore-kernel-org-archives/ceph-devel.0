From: Xiaoguang Liu <syslxg@gmail.com>
Subject: rbd create command fails to create image
Date: Fri, 6 Aug 2010 14:50:45 +0800
Message-ID: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0HFGuq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Aug 2010 02:50:46 -0400
Received: by vws3 with SMTP id 3so5851638vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 23:50:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

unstable branch,  build on Fedora 13.


[root@ceph-1 mnt]# rbd create foo --size 1024
failed to assign a block name for image
create error: Operation not supported
[root@ceph-1 mnt]# rbd list
pool rbd doesn't contain rbd images
