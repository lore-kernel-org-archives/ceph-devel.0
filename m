From: Willem Jan Withagen <wjw@digiware.nl>
Subject: A question on coredumps in unittests
Date: Tue, 12 Apr 2016 11:38:41 +0200
Message-ID: <570CC221.2040603@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:31705 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622AbcDLJis (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2016 05:38:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, loic@dachary.org

Hi Loic,

You have written a lot of the unittests, so it seems.

I'm having the issue that under FreeBSD the cores are left behind from
the EXPECT_DAETH tests.
But under CentOS7 no cores are left behind.
And 'ulimit -c unlimited' does not help to get cores

Is there anything particular why this is the case...
Google tests suggest that it is the programs responsability to cleanup
after itself.

And would there be any objections to adding code like:

	ret = RUN_ALL_TESTS();
	if (ret == 0) {
		char core [30];
		strncpy(core, argv[0], 19);
		core[19] = '\0';
		strcat(core, ".core");
		::unlink(core);
		free(core);
	}
	return ret;

to the tests

Thanx,
--WjW
