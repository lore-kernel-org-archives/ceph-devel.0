From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Running ceph-helpers traps a python error
Date: Wed, 1 Jun 2016 15:05:11 +0200
Message-ID: <26fa35d5-17c6-87f8-bad5-375c6547b23a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:15954 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcFANFx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Jun 2016 09:05:53 -0400
Received: from [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2] (unknown [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id E555F153401
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2016 15:05:23 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Looks like ceph doesn't like the response it is getting from the cluser.

--WjW

...:237:test_kill_daemon:  ceph --connect-timeout 60 status
Traceback (most recent call last):
  File "./ceph", line 948, in <module>
    retval = main()
  File "./ceph", line 852, in main
    prefix='get_command_descriptions')
  File "/usr/srcs/Ceph/work/ceph/src/pybind/ceph_argparse.py", line
1293, in json_command
    raise RuntimeError('"{0}": exception {1}'.format(argdict, e))
RuntimeError: "None": exception "['{"prefix":
"get_command_descriptions"}']": exception You cannot perform that
operation on a Rados object in state configuring.
