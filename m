From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Python 3 a blocking requirement?
Date: Mon, 22 Aug 2016 16:37:34 +0200
Message-ID: <2ef48fae-b971-3983-2488-c3181607dae3@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:33694 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756002AbcHVOhv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 10:37:51 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 08F2825440
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 16:37:41 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I was trying to do some tests on my Centos box.
And ran into:

-- Found PythonLibs: /usr/lib64/libpython2.7.so (found suitable version
"2.7.5", minimum required is "2")
CMake Error at
/usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:108 (message):
  Could NOT find Python3Interp: Found unsuitable version "2.7.5", but
  required is at least "3" (found /usr/bin/python)
Call Stack (most recent call first):
  /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:313
(_FPHSA_FAILURE_MESSAGE)
  cmake/modules/FindPython3Interp.cmake:146
(FIND_PACKAGE_HANDLE_STANDARD_ARGS)
  src/CMakeLists.txt:274 (find_package)

Now is this due to me not being synced enough with master/HEAD, or is
this an actual problem?

Thanx,
--WjW

