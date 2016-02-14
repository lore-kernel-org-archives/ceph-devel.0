From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Help in analyzing Jenkins output
Date: Sun, 14 Feb 2016 13:50:42 +0100
Message-ID: <56C07822.5080600@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:13046 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbcBNMvM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Feb 2016 07:51:12 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 5C8B215340A
	for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 13:51:10 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 723F31534E3
	for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 13:50:42 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I'm having a bit of trouble in finding the actual error in

https://jenkins.ceph.com/job/ceph-pull-requests/1419/console

The first few python warning/errors seem harmless, because the tests
are actually run.
Then 'bash -x tests/ceph-disk.sh' is run, which generates a lot of
output. But I'm missing the point where that generates an error.

Could somebody help me point out where the error is that makes this test
fail??

The test ATM fails under FreeBSD because of other errors still in some
of the scripts and programs..
So testing it there doest not even get as far as this point.

Thanx,
--WjW

