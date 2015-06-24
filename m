From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: Monitor clock skew on Teuthology testing
Date: Wed, 24 Jun 2015 01:53:16 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01FE85AF@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27661 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933826AbbFXBxY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 21:53:24 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sepia@lists.ceph.com" <sepia@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Zack Cerza <zack@redhat.com>

Hi Zack,

I was testing on some home-made Teuthology cluster. Till now I can use the teuthology-suite to submit the test cases and start some workers to do the tests. From the Pulpito logs I can see most of the tests are passed except there was some error when aggregating the results in the last step. The error message was like:

"2015-06-24 08:41:33.334317 mon.1 192.168.13.117:6789/0 4 : cluster [WRN] message from mon.0 was stamped 0.709253s in the future, clocks not synchronized" in cluster log  

This was due to the time lag between monitors to my knowledge. I checked the clock settings in Teuthology and find the NTP server are defined in ceph-qa-chef/cookbooks/ceph-qa/files/default/ntp.conf. Is there any other settings on the clock side there?

Thanks, -yuan

