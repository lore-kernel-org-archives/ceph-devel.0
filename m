From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Jenkins trouble.....
Date: Wed, 26 Jul 2017 12:26:18 +0200
Message-ID: <643ec0f0-6eb8-731b-4372-d6cf3654bf34@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:48732 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbdGZK0W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 26 Jul 2017 06:26:22 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 2CA4D458E7
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jul 2017 12:26:20 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I have 2 PRs that report:

--  Using EventEpoll for events.
CMake Error at src/CMakeLists.txt:668 (add_subdirectory):
  The source directory

    /home/jenkins-build/build/workspace/ceph-pull-requests/src/lua

  does not contain a CMakeLists.txt file.


CMake Error at cmake/modules/MergeStaticLibraries.cmake:21 (message):
  liblua not a valid target
Call Stack (most recent call first):
  src/cls/CMakeLists.txt:269 (merge_static_libraries)

And I claim to be inocent.... ;-)

--WjW
