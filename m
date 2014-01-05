From: James Harper <james.harper@bendigoit.com.au>
Subject: documentation error for adding monitor?
Date: Sun, 5 Jan 2014 22:31:07 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B6F359EEA@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:41057 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbaAEWbQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Jan 2014 17:31:16 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1VzwDs-0003ti-UN
	for ceph-devel@vger.kernel.org; Mon, 06 Jan 2014 09:31:08 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When I follow the steps for adding a new monitor at http://ceph.com/docs/master/rados/operations/add-or-rm-mons/, the 'ceph mon add <mon-id> <ip[:port>' step always tells me that the monitor already exists. Is this step actually necessary?

Thanks

James
