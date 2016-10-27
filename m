From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: ceph-post-file : Permission denied (publickey).
Date: Thu, 27 Oct 2016 15:30:33 +0200
Message-ID: <89b95e99-73e5-474e-df5f-cbd7927924ed@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54736 "EHLO smtp0.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942670AbcJ0OW6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Oct 2016 10:22:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I tried to upload files with ceph-post-file but got "Permission denied (publickey)."

> $ ceph-post-file 17180.tgz
> args: -- 17180.tgz
> /usr/bin/ceph-post-file: upload tag 60a84fdd-b9e9-42cb-817e-5a90e0f9bcf0
> /usr/bin/ceph-post-file: user: yoann@kveikur
> /usr/bin/ceph-post-file: will upload file 17180.tgz
> Permission denied (publickey).
> Couldn't read packet: Connection reset by peer

do I need to set anything on my side to be able to upload file with this command ?

Thanks

-- 
Yoann Moulin
EPFL IC-IT
