From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/3] libceph: clean up some code involving CRCs
Date: Tue, 28 Feb 2012 20:49:18 -0800
Message-ID: <4F4DAE4E.4000903@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48723 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2EtT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:49:19 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 38A7F24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:49:19 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2DCC024314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:49:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rename a few variables so it's clearer which indicate that a
CRC should be computed and which hold an actual CRC value.
Separate CRC calculation from byte swapping to improve
readability.  And move some code that runs on only on
the last pass through a couple of loops outside the loop
body.

					-Alex
