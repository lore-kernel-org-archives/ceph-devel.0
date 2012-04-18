From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/6] rbd: updates from Josh Durgin
Date: Wed, 18 Apr 2012 09:36:04 -0500
Message-ID: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:32947 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2DROgF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:36:05 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2C0B5244A7
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:39:08 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id F370F2444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:39:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am posting this series on behalf of Josh Durgin, who originally
created these at the end of last year.  I've updated them to apply
to the current rbd code.

The first two fix bugs, the last is a documentation fix, and the
others are cleanups.

					-Alex
