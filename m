From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: Numerical argument out of domain
Date: Mon, 27 May 2013 19:31:09 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA56045030CBB3@SMBXKO5.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:58686 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab3E0Tb4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 15:31:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by SMXKO3.compugroup.com (Postfix) with ESMTP id 43BA815724
	for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 21:31:46 +0200 (CEST)
Received: from SMXKO3.compugroup.com ([127.0.0.1])
	by localhost (SMXKO3.compugroup.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jslzvQMFaAAN for <ceph-devel@vger.kernel.org>;
	Mon, 27 May 2013 21:31:46 +0200 (CEST)
Received: from SCASKO1.cgm.ag (scasko1.cgm.ag [10.0.0.81])
	by SMXKO3.compugroup.com (Postfix) with ESMTPS id 1787415722
	for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 21:31:46 +0200 (CEST)
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

i've set up a rados cluster, but the second of three mons will not start:

[19057]: (33) Numerical argument out of domain 
failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i d --pid-file /var/run/ceph/mon.d.pid -c /etc/ceph/ceph.conf '


Added a 4. Mon, same problem. 
Tested with Ubuntu 12.04LTS and Debian 7.
ceph version 0.61.2

Also when I type in "usr/bin/ceph-mon -I d" only, I get the error message and the mon service does not start.

Do you know where the problem is?

Thank you very much


Regards

Philipp
