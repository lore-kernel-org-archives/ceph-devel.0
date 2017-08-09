From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: How to run ceph_test_rados_api_tier?
Date: Wed, 9 Aug 2017 22:00:33 +0800
Message-ID: <CAJACTueQZG9mjF1OYD3D3MbM=gsjMDsvv8t+-EEA4aAahHw37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35798 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdHIOAe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 10:00:34 -0400
Received: by mail-oi0-f45.google.com with SMTP id e124so62188369oig.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 07:00:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, everyone.

I'm trying to write a new test case in tier.cc. However, when I try to
test that test case by running "make check", it seems that "make
check" only run ceph_test_object_map, no other "ceph_test_XXX"
runnables are run including "ceph_test_rados_api_tier". Why? And how
to run other ceph_test_XXX runnables?
