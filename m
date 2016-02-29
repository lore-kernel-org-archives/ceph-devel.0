From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD testing with ./test/osd/osd-markdown.sh
Date: Mon, 29 Feb 2016 02:17:42 +0100
Message-ID: <56D39C36.8000408@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57510 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbcB2BSL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 28 Feb 2016 20:18:11 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiaoxi.chen@intel.com, Ceph Development <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

You have submitted this test.

Below are some of the criteria. And I wonder how these values are
established? 
I have the problem that the osd.0 is already down in the second
itteration in the first test.
Where I think it at least needs to take 5 itterations.

Can you shed some light?

Thanx,
--WjW

commit f9a230aa528da550013f089b45b382168b1d3d5f
Author: Xiaoxi Chen <xiaoxi.chen@intel.com>
Date:   Tue Dec 8 14:58:05 2015 +0800

    test/osd: add test case for shutdown_when_flapping

    TEST_markdown_exceed_maxdown_count :
      down N+1 times within period, should be UP in first N times but
DOWN in last time.
    TEST_markdown_boot :
      down exactly N times within period, should be UP for all N times.
    TEST_markdown_boot_exceed_time :
      down N+1 times but exceed the period, should be UP after the test.

