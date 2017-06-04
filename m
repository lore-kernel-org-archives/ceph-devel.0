From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Missing CMake compilation for different OSes common/*_errno.cc
Date: Sun, 4 Jun 2017 23:52:59 +0200
Message-ID: <8ce3c764-c4aa-c1c7-75bb-85c14639c0ed@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:23863 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdFDVw6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 4 Jun 2017 17:52:58 -0400
Received: from [192.168.11.152] (unknown [192.168.11.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 29D3E42F7D
        for <ceph-devel@vger.kernel.org>; Sun,  4 Jun 2017 23:52:56 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I found the following in src/common/Makefile.am:
if SOLARIS
libcommon_internal_la_SOURCES += \
        common/solaris_errno.cc
endif

if AIX
libcommon_internal_la_SOURCES += \
        common/aix_errno.cc
endif

But I seem to be unable to find its counterpart in the Cmake files.

Is this an "oversight", or part of thet code that is not excersized
anyways on these platforms?

--WjW
