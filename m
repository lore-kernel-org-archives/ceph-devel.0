From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Haven't been paying attention: Gperf missing
Date: Mon, 22 May 2017 10:16:14 +0200
Message-ID: <9cc2b255-f617-e109-b9b9-23a32ea8509f@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50147 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbdEVIQR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 May 2017 04:16:17 -0400
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id B2E2E42313
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 10:16:14 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

But from the things below gperf is now an essential requirement?

--WjW

-- Check if the system is big endian - little endian
-- Found PythonInterp: /usr/local/bin/python2.7 (found version "2.7.13")
-- Boost version: 1.64.0
CMake Error at src/rgw/CMakeLists.txt:30 (message):
  Can't find gperf


-- Configuring incomplete, errors occurred!
See also
"/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeOutput.log".
See also "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMa
