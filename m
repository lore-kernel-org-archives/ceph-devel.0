From: David Zafman <dzafman@redhat.com>
Subject: standby_count_wanted
Date: Thu, 18 May 2017 17:10:48 -0700
Message-ID: <062f5224-fe69-ca4c-9180-5964cd6609b0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754072AbdESAKu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 May 2017 20:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A05761B83
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 00:10:49 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pdonnell@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Patrick,


     It looks like a commit which tests the standby_count_wanted option 
has been committed, but it fails and I don't see the implementation 
anywhere.


2017-05-18T22:58:43.585 INFO:teuthology.orchestra.run.smithi161:Running: 
'sudo adjust-ulimits ceph-coverage 
/home/ubuntu/cephtest/archive/coverage timeout 120 ceph --cluster ceph 
fs set cephfs standby_count_wanted 0'
2017-05-18T22:58:43.725 
INFO:teuthology.orchestra.run.smithi161.stderr:Invalid command: 
standby_count_wanted not in 
max_mds|max_file_size|allow_new_snaps|inline_data|cluster_down|allow_multimds|allow_dirfrags
2017-05-18T22:58:43.725 
INFO:teuthology.orchestra.run.smithi161.stderr:fs set <fs_name> 
max_mds|max_file_size|allow_new_snaps|inline_data|cluster_down|allow_multimds|allow_dirfrags 
<val> {<confirm>} :  set mds parameter <var> to <val>
2017-05-18T22:58:43.725 
INFO:teuthology.orchestra.run.smithi161.stderr:Error EINVAL: invalid command


http://pulpito.ceph.com/dzafman-2017-05-18_15:46:40-rados-wip-zafman-testing-distro-basic-smithi/1193530


David

