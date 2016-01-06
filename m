From: Dan Mick <dmick@danceorelse.org>
Subject: Docs now building again
Date: Tue, 5 Jan 2016 19:15:48 -0800
Message-ID: <568C86E4.5070106@danceorelse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dnvrco-outbound-snat.email.rr.com ([107.14.73.228]:62207 "EHLO
	dnvrco-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751809AbcAFDXI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jan 2016 22:23:08 -0500
Received: from [10.17.96.100] (unknown [206.169.83.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "danmick@gmail.com", Issuer "StartCom Class 1 Primary Intermediate Client CA" (verified OK))
	by brix (Postfix) with ESMTPS id 37583C801CA
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jan 2016 19:15:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

https://github.com/ceph/ceph/pull/7119 fixed an issue preventing docs
from building.  Master is fixed; merge that into your branches if you
want working docs again.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
