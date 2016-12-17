From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: Build failed in Jenkins: ceph-master #94
Date: Sat, 17 Dec 2016 13:34:48 +0100
Message-ID: <93c0f8ac-a1e1-eaed-19bc-1be68b31f06f@digiware.nl>
References: <2025831951.53.1481945498160.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:20591 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbcLQMey (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 17 Dec 2016 07:34:54 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 2357A33C8C
        for <ceph-devel@vger.kernel.org>; Sat, 17 Dec 2016 13:34:50 +0100 (CET)
In-Reply-To: <2025831951.53.1481945498160.JavaMail.jenkins@cephdev.digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

My FreeBSD builder starts to complain during compilation about
the error repeated below.


--WjW

n file included from
/home/jenkins/workspace/ceph-master/src/common/config.cc:15:
In file included from
/home/jenkins/workspace/ceph-master/src/auth/Auth.h:18:
In file included from
/home/jenkins/workspace/ceph-master/src/auth/Crypto.h:18:
In file included from
/home/jenkins/workspace/ceph-master/src/include/types.h:21:
In file included from
/home/jenkins/workspace/ceph-master/src/include/uuid.h:8:
In file included from
/home/jenkins/workspace/ceph-master/src/include/encoding.h:19:
In file included from
/home/jenkins/workspace/ceph-master/src/include/rados/memory.h:4:
In file included from /usr/include/c++/v1/memory:599:
/usr/include/c++/v1/type_traits:2857:38: error: incomplete type
'md_config_t::option_host_t' used in type trait expression
    : public integral_constant<bool, __is_constructible(_Tp, _Args...)>
                                     ^
/home/jenkins/workspace/ceph-master/src/common/config.cc:110:31: note:
in instantiation of template class
'std::__1::is_constructible<md_config_t::option_host_t>' requested here
typename std::enable_if<!std::is_constructible<T>::value,
                              ^
/home/jenkins/workspace/ceph-master/src/common/config_opts.h:16:1: note:
while substituting explicitly-specified template arguments into function
template 'create_validator'
OPTION(host, OPT_STR, "localhost")
^
/home/jenkins/workspace/ceph-master/src/common/config.cc:168:37: note:
expanded from macro 'OPTION'
#define OPTION(name, type, def_val) OPTION4(name, type, def_val, false)
                                    ^
/home/jenkins/workspace/ceph-master/src/common/config.cc:167:24: note:
expanded from macro 'OPTION4'
                       create_validator<option_##name##_t>() },
                       ^
/home/jenkins/workspace/ceph-master/src/common/config_opts.h:16:1: note:
forward declaration of 'md_config_t::option_host_t'
OPTION(host, OPT_STR, "localhost")
^
/home/jenkins/workspace/ceph-master/src/common/config.h:321:12: note:
expanded from macro 'OPTION'
    struct option_##name##_t;
           ^
<scratch space>:51:1: note: expanded from here
option_host_t
^
