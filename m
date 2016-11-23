From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Decrease size of clusters
Date: Thu, 24 Nov 2016 01:31:11 +0800
Message-ID: <7012B64A-C2C2-4C67-A819-06220AD0C10E@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-136.mail.aliyun.com ([140.205.0.136]:52207 "EHLO
        out0-136.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933766AbcKWRhw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 12:37:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,
  We are investigating the possibilities of decreasing size of pg numbers and pgp numbers as we want to decrease the cluster size.
  We need to  move out of OSDs from clusters from time to time. Initially, the PG number probably a good match the number of OSDs underneath. However, as we moved some of OSDs out ,the number of PGs is not going to be a good match any more to the number of OSDs.
  We of course want to decrease the number of PGs to tune up the performance of clusters. 
   
   Any advices and any plan to support this feature?

  Regards,
  James



