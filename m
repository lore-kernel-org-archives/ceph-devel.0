From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: Inline dedup/compression
Date: Thu, 25 Jun 2015 22:01:29 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:48914 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbFYWBb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 18:01:31 -0400
Received: from ssiexch-casht1.ssi.samsung.com ([105.128.134.172]) by mx2.ssi.samsung.com with ESMTP id yO3nMRI3STTY4HQ3 for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 15:01:30 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers,
    It is not easy to ask when Ceph is going to support inline dedup/compression across OSDs in RADOS because it is not easy task and answered. Ceph is providing replication and EC for performance and failure recovery. But we also lose the efficiency  of storage store and cost associate with it. It is kind of contradicted with each other. But I am curious how other Cephers think about this question.
   Any plan for Cephers to do anything regarding to inline dedupe/compression except the features brought by local node itself like BRTFS?    

  Regards,
  James
