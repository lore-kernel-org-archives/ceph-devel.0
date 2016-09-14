From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Best latest commit to run bluestore
Date: Wed, 14 Sep 2016 19:10:34 +0000
Message-ID: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:37753 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760345AbcINTKh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Sep 2016 15:10:37 -0400
Content-Language: en-US
Content-ID: <7C80DB1571F2B641A83E392001CD09AD@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Somnath Roy <somnath.roy@sandisk.com>, Sage Weil <sweil@redhat.com>

Hi Sage, Somnath,

I would like to see how the current bluestore implementation performs with some workload.
I am following the ceph-devel mailing list, so I am aware there is the memory leak issue 
in the bluestore code now. 

I also notice that, Somnath has used the master branch recently to generate some benchmark
numbers to generate pretty graphs. I do not worry about the loosing the data on the cluster at
this point, this is not a production setup, just a experimentation to evaluate current bluestore
performance vs filestore.

I am planning to build the ceph packages from the the latest ceph master branch to do some 
workload testing on KRBD images backed up by Bluestore. I understand that the master 
branch is work in progress, can break things,... etc. :)
  Can you guys suggest me the best and the latest master commit which I should be able use
to stress bluestore via krbd for 20+ hours?
   If nothing comes up to mind, then I can pick the commit Somnath used to generate
the pretty graphs.

Thanks in advance for your help.
Nitin


