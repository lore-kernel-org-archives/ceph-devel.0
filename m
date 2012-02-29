From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/6] ceph: virtual extended attribute cleanup
Date: Tue, 28 Feb 2012 19:17:41 -0800
Message-ID: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47447 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966253Ab2B2DRm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:17:42 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6763124318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:17:42 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5BDD624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:17:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series cleans up some code involving ceph's virtual extended
attributes.  Three of them define some simple macros are set up to
help ensure the attributes are defined in a consistent way.  One
makes the size of certain constant values get defined at startup
time rather than repeatedly, and the remaining two are some very
small changes made for clarity.

					-Alex
