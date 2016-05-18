From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RGW blind bucket
Date: Wed, 18 May 2016 14:50:53 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF0235A7BA@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65490 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932250AbcEROvK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 10:51:10 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Yehuda,

From the code looks like the feature is already there. Is there any docs on how to test this? 
I can do this by changing the default bucket index type to RGWBIType_Indexless. Is it possible to create a blind bucket thru S3/Swift API dynamically?

Thanks, -yuan
