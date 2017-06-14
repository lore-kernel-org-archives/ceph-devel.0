From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Clang does not like constexpression
Date: Wed, 14 Jun 2017 10:49:12 +0200
Message-ID: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43692 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754763AbdFNItc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 04:49:32 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 0EDDE4379A
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 10:49:29 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I guess that in Clang strlen is not evaluation to a constant.

--WjW

In file included from
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_keystone.cc:22:
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:29: error:
constexpr variable 'META_MAX_SIZE' must be initialized by a constant
expression
    static constexpr size_t META_MAX_SIZE = \
                            ^
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:172:7: note:
non-constexpr function 'strlen' cannot be used in a constant expression
      strlen("\r\nffffffffffffffff;chunk-signature=") + SIG_SIZE +
strlen("\r\n");
      ^
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:175:29: error:
constexpr variable 'META_MIN_SIZE' must be initialized by a constant
expression
    static constexpr size_t META_MIN_SIZE = \
                            ^
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:176:7: note:
non-constexpr function 'strlen' cannot be used in a constant expression
      strlen("0;chunk-signature=") + SIG_SIZE + strlen("\r\n");
      ^
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:204:41: error:
non-type template argument is not a constant expression
  boost::container::static_vector<char, ChunkMeta::META_MAX_SIZE>
parsing_buf;
                                        ^~~~~~~~~~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:204:41: note:
initializer of 'META_MAX_SIZE' is not a constant expression
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:29: note:
declared here
    static constexpr size_t META_MAX_SIZE = \
                            ^
3 errors generated.
