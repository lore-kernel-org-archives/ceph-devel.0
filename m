From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: broken init script under debian squeeze
Date: Tue, 22 May 2012 12:05:35 +0200
Message-ID: <4FBB64EF.70402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51142 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab2EVKFc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 06:05:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

the ceph init script seems to be broken - at least under debian lenny.

It does simply nothing on a configured osd / mon server, so while system
start the daemons won't start. Ow do i have to configure the hostname to
match anything special in ceph.conf?
[root@system123 /etc]# /etc/init.d/ceph start
[root@system123 /etc]#

option -a works fine (/etc/init.d/ceph -a start)

Greets
Stefan
