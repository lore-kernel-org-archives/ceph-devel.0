From: Josh Durgin <jdurgin@redhat.com>
Subject: teuthology-describe-tests -> add meaning to the tests!
Date: Mon, 1 Feb 2016 15:27:57 -0800
Message-ID: <56AFE9FD.6040400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50315 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbcBAX16 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Feb 2016 18:27:58 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: ceph-qa@ceph.com

After the initial implementation [0], we have a new cli in teuthology*
suite of tools - teuthology-describe-tests and thus a cool new way to
add English words to our tests. This should make suites more
understandable to someone who hasn't read all the teuthology tasks used.

To add descriptions to yaml fragments, the syntax is:

"meta:
- desc: <words>"

as can be seen in this example annotated suite:

https://github.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/infernalis-x

Example output for this suite can be seen here:

http://tracker.ceph.com/projects/ceph-qa-suite/wiki/infernalis-x

Now we need folks changing tests in ceph-qa-suite to start adding
descriptions.

Josh & Yuri

[0] https://github.com/ceph/teuthology/pull/714
