From: Rajath Shashidhara <rajath.shashidhara@gmail.com>
Subject: OpenStack Swift functional tests on RGW
Date: Tue, 28 Mar 2017 19:21:18 +0530
Message-ID: <9b700b96-668b-5086-ce2f-b75aa0b400d5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34717 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbdC1Nvq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Mar 2017 09:51:46 -0400
Received: by mail-pg0-f49.google.com with SMTP id 21so73381987pgg.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Mar 2017 06:51:26 -0700 (PDT)
Received: from [192.168.0.5] ([125.99.226.166])
        by smtp.gmail.com with ESMTPSA id 80sm7796082pfy.67.2017.03.28.06.51.18
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 06:51:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am getting started with contributing to Ceph. I sent my first pull
request a couple of weeks ago - https://github.com/ceph/ceph/pull/13908
. In testing the feature, I realized that the ceph/swift repository is
outdated. I tweaked some relevant functional tests on the
openstack/swift repository to run on RadosGW.

I was thinking that may be I can port all the functional tests from
openstack/swift to work on RGW. This way we can test how well RGW
complies with the Swift REST API. I'd like to know if that would be a
useful contribution to ceph. Also, since ceph/stack has diverged from
openstack/swift (20 commits ahead and 4919 commits behind upstream -
openstack/swift as of today), what approach should I take to push these
tests ?

Thanks,

Rajath Shashidhara

