From: Guang Yang <yguang11@outlook.com>
Subject: PG folder splitting proposal
Date: Mon, 23 Jun 2014 18:30:55 +0800
Message-ID: <BLU436-SMTP129A7894DB2DC7AD8C3B0B0DF1F0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s21.hotmail.com ([65.55.111.160]:57632 "EHLO
	BLU004-OMC4S21.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbaFWKbP convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Jun 2014 06:31:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,
Would you please help to comment on the proposal of comment 7 of this ticket - http://tracker.ceph.com/issues/7593#note-7 ? As we move to EC pool, the number of files for each PG increase X times which makes folder splitting more likely to happen. Do you think it is a worthy change to do pre-splitting during pool creation time with a hint as pool meta-data?

Thanks,
Guang