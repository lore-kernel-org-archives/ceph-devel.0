From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Errors in ceph_objectstore_tool.py
Date: Mon, 1 Aug 2016 23:03:51 +0200
Message-ID: <61e37d1c-5cdb-2fb1-eaae-fe976cb448fd@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:29078 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbcHAWQ1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Aug 2016 18:16:27 -0400
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 311D724246
	for <ceph-devel@vger.kernel.org>; Mon,  1 Aug 2016 23:03:51 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

It aborts with:
2016-08-01 14:17:03.777916 7f9c00d629c0 -1 asok(0x188ebb0)
AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: The
UNIX domain socket path
/home/jenkins-build/build/workspace/ceph-pull-requests/build/ceph_objectstore_tool_dir/out/client.admin.25541.asok
is too long! The maximum length on this system is 107

And the last remark is true, it is a sort of hard upperlimit on length
of socket-names. (107 in Linux, 104 in FreeBSD)

Which is probably the reason why on most systems sockets are created in
/tmp, /var/tmp or /var/run/

So I guess that some of the testscripts need to be adjusted to this
limit and not create the sockets in ..../<testdir>/*.asok

--WjW
