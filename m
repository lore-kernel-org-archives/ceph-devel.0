From: John Spray <jspray@redhat.com>
Subject: warnings in rgw_crypt.cc
Date: Mon, 14 Aug 2017 17:38:06 +0100
Message-ID: <CALe9h7cCO+ZLHysdHr8AueyfkHLMvj1Wsy7CO0763cD3ydcJ3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35470 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdHNQi1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Aug 2017 12:38:27 -0400
Received: by mail-oi0-f48.google.com with SMTP id e124so89264779oig.2
        for <ceph-devel@vger.kernel.org>; Mon, 14 Aug 2017 09:38:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

These have been in master for quite a while now:

/home/jenkins-build/build/workspace/ceph-pull-requests/src/rgw/rgw_crypt.cc:38:2:
warning: #warning "TODO: move this code to auth/Crypto for others to
reuse." [-Wcpp]
 #warning "TODO: move this code to auth/Crypto for others to reuse."
  ^
/home/jenkins-build/build/workspace/ceph-pull-requests/src/rgw/rgw_crypt.cc:247:2:
warning: #warning "TODO: use auth/Crypto instead of reimplementing."
[-Wcpp]
 #warning "TODO: use auth/Crypto instead of reimplementing."
  ^

Is anyone working in this area?  Otherwise we should probably just
create tracker tickets instead of using preprocessor macros as
reminders.

Cheers,
John
