From: kefu chai <tchaikov@gmail.com>
Subject: success-comment of github pr trigger
Date: Wed, 1 Nov 2017 13:48:52 +0800
Message-ID: <CAJE9aOMiVa8SeXJ3Jd5Jyj0agLsoo=SMcu==ypj-i=yC2xQinQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:45033 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdKAFsy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 01:48:54 -0400
Received: by mail-oi0-f46.google.com with SMTP id v132so1976885oie.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 Oct 2017 22:48:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>

hi Alfredo,

i found that jenkins started to comment on PRs when completing a job.
for example, see
https://github.com/ceph/ceph/pull/18659#issuecomment-340964973. this
is a little bit annoying and distracting. but i checked
https://github.com/ceph/ceph-build/blob/master/ceph-pull-requests/config/definitions/ceph-pull-requests.yml#L39,
we don't specify the success-comment there. i wonder it might be jjb?
but i checked the jjb 2.0.0.0b2, it looks sane. see
https://github.com/openstack-infra/jenkins-job-builder/blob/04348c2c00657490b4712ae61c6a1bed691a3e3a/jenkins_jobs/modules/triggers.py#L1122.
do you have any idea off the head? are we experimenting some new
features?

cheers,

-- 
Regards
Kefu Chai
