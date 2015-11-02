From: Douglas Fuller <dfuller@redhat.com>
Subject: Whitepaper: database workloads using RBD with dm-cache and Ceph cache tiering
Date: Mon, 2 Nov 2015 13:09:04 -0500
Message-ID: <4E0B5E66-351F-45EC-96B2-790536D4EE5D@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42763 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbbKBSJF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 13:09:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 5950EC0B8415
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2015 18:09:05 +0000 (UTC)
Received: from [10.10.50.41] (unused [10.10.50.41] (may be forged))
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tA2I94hs004145
	for <ceph-devel@vger.kernel.org>; Mon, 2 Nov 2015 13:09:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I=E2=80=99ve published a whitepaper detailing configuration and benchma=
rk results using SysBench MySQL on top of RBD with dm-cache. Results us=
ing a Ceph cache tier are also included. Questions, comments, criticism=
, nitpicking, and/or discussion are welcome.

http://tracker.ceph.com/projects/ceph/wiki/Ceph_and_dm-cache_for_Databa=
se_Workloads

=E2=80=94Doug--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
