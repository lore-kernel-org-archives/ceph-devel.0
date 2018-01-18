From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RGW S3 vs S3 signature
Date: Thu, 18 Jan 2018 14:39:30 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF124E0505@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24255 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756446AbeAROje (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Jan 2018 09:39:34 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello,

Trying to some tests with Hadoop 2.9 + Ceph S3(Jewel, 10.2.10) and ran into a multi-part uploading issue. It looks like the new S3a driver(aws-java-sdk-bundle-1.11.199.jar, v4 signature) in Hadoop is not compatible with Ceph S3(Jewel). 

I find there's a doc on S3 API support status, but lack of the corresponding S3 version info there. Is there any info on the detail supported version, v2 only?  
http://docs.ceph.com/docs/jewel/radosgw/s3/

I also find some commit to enable the V4 support here, I think this should be ready in Luminous?  
https://github.com/ceph/ceph/pull/15965/commits/82a7aa9e3eabfde4a82046d78aad2dadbfc0d8e1


Any comments would be appreciated!

Thanks, -yuan 

