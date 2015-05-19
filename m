From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: Jobs of a teuthology run
Date: Tue, 19 May 2015 13:17:25 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489E8212@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755819AbbESNRv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 09:17:51 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I was running teuthology on sepia to test proxy write. I used the command like below to start the run. Somehow it generated 1143 jobs. I see from pulpit that there are usually no more than 300 jobs in other people's run. So my question is that should I go ahead with the 1000+ jobs? Or Is there some way to filter out some, so that I just need to run 200+ jobs?

./virtualenv/bin/teuthology-suite --filter-out btrfs,ext4 --suite rados --suite-branch hammer --machine-type plana,burnupi,mira --distro ubuntu --email zhiqiang.wang@intel.com --owner zhiqiang.wang@intel.com --ceph wip-proxy-write
