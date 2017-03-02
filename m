From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Clang not happy with unittest_hostname
Date: Thu, 2 Mar 2017 01:54:04 +0100
Message-ID: <3ae8a4ec-3cd2-6d06-8562-74a5c80f44d0@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:59132 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdCBAyK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Mar 2017 19:54:10 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 0A2423AFE6
        for <ceph-devel@vger.kernel.org>; Thu,  2 Mar 2017 01:54:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is with Clang on FreeBSD:

[100%] Building CXX object
src/test/common/CMakeFiles/unittest_hostname.dir/test_hostname.cc.o
/home/jenkins/workspace/ceph-master/src/test/common/test_hostname.cc:34:27:
error: implicit instantiation of undefined template
'std::__1::array<char, 128>'
    std::array<char, 128> buffer;
                          ^
/usr/include/c++/v1/__tuple:198:65: note: template is declared here
template <class _Tp, size_t _Size> struct _LIBCPP_TYPE_VIS_ONLY array;

--WjW
