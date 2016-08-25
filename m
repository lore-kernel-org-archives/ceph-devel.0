From: Loic Dachary <loic@dachary.org>
Subject: rgw/s3_bucket_quota.pl failure on the jewel-backports integration
 branch
Date: Thu, 25 Aug 2016 15:45:43 +0200
Message-ID: <57BEF687.80805@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57067 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758718AbcHYNpu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 09:45:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Casey,

http://pulpito.ceph.com/loic-2016-08-25_06:41:52-rgw-jewel-backports-distro-basic-smithi/

which runs against the jewel-backports branch has a number of rgw pull requests

http://tracker.ceph.com/issues/16344#note-36

and shows a new failures which look like this:

http://qa-proxy.ceph.com/teuthology/loic-2016-08-25_06:41:52-rgw-jewel-backports-distro-basic-smithi/384799/teuthology.log

2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:user qa_user deleted
2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:bucket delete succeeded
2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:Bucket Created: buck_2016_07_25_11_16_51
2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:quota set for the bucket: buck_2016_07_25_11_16_51
2016-08-25T11:16:52.377 INFO:tasks.workunit.client.0.smithi042.stdout:quota enabled for the bucket: buck_2016_07_25_11_16_51
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:adding file to bucket: 10Mb.
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:upload file successful
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:readding file to bucket: 10MBfile1
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:readding file success
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:Test case:  FAILED - set max objects and test beyond max objects failed
2016-08-25T11:16:52.378 INFO:tasks.workunit.client.0.smithi042.stdout:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Our focus in this run is to make sure https://github.com/ceph/ceph/pull/10845 passes. I don't know enough about rgw tests to figure out if it is related to the commits in this pull request or not.

What do you think ?

P.S. The error also seems to be incorrectly handled later on but that's another issue ;-)

2016-08-25T11:16:52.489 INFO:tasks.workunit.client.0.smithi042.stderr:Can't call method "err" on an undefined value at /home/ubuntu/cephtest/workunit.client.0/rgw/s3_bucket_quota.pl line 199.

-- 
Loïc Dachary, Artisan Logiciel Libre
