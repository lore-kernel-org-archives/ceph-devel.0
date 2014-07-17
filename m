From: Wido den Hollander <wido@42on.com>
Subject: Why does crushtool send all it's output to stderr?
Date: Thu, 17 Jul 2014 22:59:09 +0200
Message-ID: <53C8391D.8020300@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:51120 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbaGQU7N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jul 2014 16:59:13 -0400
Received: from [172.20.10.6] (unknown [62.140.132.9])
	by websrv.42on.com (Postfix) with ESMTPSA id 8E7EEBF793
	for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 22:59:10 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

When running tests on a crushmap with crushtool it noticed that all 
output is send to stderr, for example:

$ crushtool -i cm --test --rule 4 --num-rep 3 --show-statistics

All the output goes to stderr while I think stdout would be a better place.

Any good reason for this?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
