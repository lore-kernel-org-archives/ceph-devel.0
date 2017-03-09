From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD/Clang reports a missing function during linking
Date: Fri, 10 Mar 2017 00:37:20 +0100
Message-ID: <92b31a40-6475-ae01-13d5-714d1d6a53a1@digiware.nl>
References: <fd678506-4fa6-05c5-fb19-445a9cd38e7a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:20602 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754618AbdCIXh3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Mar 2017 18:37:29 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 8C2383BAD8
        for <ceph-devel@vger.kernel.org>; Fri, 10 Mar 2017 00:37:19 +0100 (CET)
In-Reply-To: <fd678506-4fa6-05c5-fb19-445a9cd38e7a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 9-3-2017 22:00, Willem Jan Withagen wrote:
> Hi,
> 
> FreBSD Jenkins complains:
> 
> ../../../lib/librbd_internal.a(GetStatusRequest.cc.o): In function
> `librbd::mirror::GetStatusRequest<librbd::ImageCtx>::send()':
> /home/jenkins/workspace/ceph-master/src/librbd/mirror/GetStatusRequest.cc:(.text._ZN6librbd6mirror16GetStatusRequestINS_8ImageCtxEE4sendEv[_ZN6librbd6mirror16GetStatusRequestINS_8ImageCtxEE4sendEv]+0xcc):
> undefined reference to `cls::rbd::MirrorImageStatus::~MirrorImageStatus()'
> 
> c++: error: linker command failed with exit code 1 (use -v to see
> invocation)
> 
> Not sure why Clang creates this reference and then on how to fix this.

Attempt to fix:
    cls/rbd/cls_rbd_types.h: add missing destructor #13910

--WjW


