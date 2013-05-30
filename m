From: Wido den Hollander <wido@42on.com>
Subject: 5GB object limit in the RADOS Gateway
Date: Thu, 30 May 2013 19:42:28 +0200
Message-ID: <51A78F84.1000607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:57126 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965710Ab3E3Rma (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 May 2013 13:42:30 -0400
Received: from [IPv6:2a00:f10:11c:ab:8de:cb16:103e:7f1d] (unknown [IPv6:2a00:f10:11c:ab:8de:cb16:103e:7f1d])
	by websrv.42on.com (Postfix) with ESMTPSA id 5CA03C181C
	for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 19:42:28 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I was checking the source code today and found this macro:

#define RGW_MAX_PUT_SIZE        (5ULL*1024*1024*1024)

Why is that limit in place? Was that to mimic Amazon S3? (Which is at 5T 
now).

I know that object size limit something that should be there, but just 
trying to find the reasoning behind this limit.

Couldn't we make this  configurable at least?

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
