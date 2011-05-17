From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: git ceph  "errno=Connection timed out"
Date: Tue, 17 May 2011 14:14:24 +0000
Message-ID: <1305641664.1606.14.camel@localhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:37288 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752163Ab1EQGOY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 02:14:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ,

Does anybody run into the following issue to checkout ceph ?
I couldn't git ceph for several days.

-------------------------------------------------------

$ git clone git://ceph.newdream.net/git/ceph.git
Cloning into ceph...
ceph.newdream.net[0: 208.113.190.86]: errno=Connection timed out
fatal: unable to connect a socket (Connection timed out)
$ 


Jeff .C.P.W

