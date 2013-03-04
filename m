From: Andrew Hume <andrew@research.att.com>
Subject: rename object
Date: Mon, 4 Mar 2013 02:41:15 +0000 (UTC)
Message-ID: <loom.20130304T033814-431@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56277 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080Ab3CDCop (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 3 Mar 2013 21:44:45 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UCLOi-0001oZ-Ba
	for ceph-devel@vger.kernel.org; Mon, 04 Mar 2013 03:45:04 +0100
Received: from ip68-231-33-29.ph.ph.cox.net ([68.231.33.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 03:45:04 +0100
Received: from andrew by ip68-231-33-29.ph.ph.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 03:45:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

i want to rename an object (at the RADOS level).
i see no API for that, although the gateway API has a copy object.

is there any (efficient) way to rename an object?


