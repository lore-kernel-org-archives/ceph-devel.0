From: Ali Maredia <amaredia@redhat.com>
Subject: S3 Tests in Boto3 Update
Date: Wed, 7 Feb 2018 17:13:45 -0500 (EST)
Message-ID: <813438902.2239780.1518041625773.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeBGWNq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:13:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAF4E8E3E7
        for <ceph-devel@vger.kernel.org>; Wed,  7 Feb 2018 22:13:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D21E25C66F
        for <ceph-devel@vger.kernel.org>; Wed,  7 Feb 2018 22:13:45 +0000 (UTC)
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CB5DC4A46B
        for <ceph-devel@vger.kernel.org>; Wed,  7 Feb 2018 22:13:45 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello Cephers,

Over the past month and change I have been working porting the existing S3 tests (written in Boto2) over to the Boto3.

This was due to many factors including:
- bugs in boto2
- testing V4 auth and V2 auth being easier to do in boto3
- Boto3 being official Amazon API, with up to date bug fixes and correct behavior

I've ported over many tests and laid the ground work for new tests to be written very easily in boto3.

There are two notable pieces of work that still need to get done:
1. Changing the s3test teuthology job to use the boto3 tests
2. Write (~150) new tests that will enable the boto3 test coverage to be the same as what is already tested in boto2 in teuthology. 

If anyone is interested in helping out in porting the remaining tests or has ideas for new tests please reach out to me. 

Adding tests are a great way for newcomers to Ceph to get involved! 

Also here is a link to my pull request for s3-tests.

https://github.com/ceph/s3-tests/pull/210

Best,

Ali
