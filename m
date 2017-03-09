From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD/Clang reports a missing function during linking
Date: Thu, 9 Mar 2017 22:00:33 +0100
Message-ID: <fd678506-4fa6-05c5-fb19-445a9cd38e7a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37976 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdCIVAi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Mar 2017 16:00:38 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id D88583B79D
        for <ceph-devel@vger.kernel.org>; Thu,  9 Mar 2017 22:00:32 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

FreBSD Jenkins complains:

../../../lib/librbd_internal.a(GetStatusRequest.cc.o): In function
`librbd::mirror::GetStatusRequest<librbd::ImageCtx>::send()':
/home/jenkins/workspace/ceph-master/src/librbd/mirror/GetStatusRequest.cc:(.text._ZN6librbd6mirror16GetStatusRequestINS_8ImageCtxEE4sendEv[_ZN6librbd6mirror16GetStatusRequestINS_8ImageCtxEE4sendEv]+0xcc):
undefined reference to `cls::rbd::MirrorImageStatus::~MirrorImageStatus()'

c++: error: linker command failed with exit code 1 (use -v to see
invocation)

Not sure why Clang creates this reference and then on how to fix this.

--WjW
