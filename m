From: Wido den Hollander <wido@42on.com>
Subject: Finding out via librados if a cluster is near full
Date: Wed, 29 May 2013 10:14:38 +0200
Message-ID: <51A5B8EE.5070801@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:53963 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965132Ab3E2IOl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 May 2013 04:14:41 -0400
Received: from [IPv6:2a00:f10:113:0:e9:af4b:b4bc:3103] (unknown [IPv6:2a00:f10:113:0:e9:af4b:b4bc:3103])
	by websrv.42on.com (Postfix) with ESMTPSA id ECAFFC181C
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 10:14:38 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Is there a way to find out if a cluster is near full via librados?

The reason I'm asking is that I'm working on a deployment of the RADOS 
Gateway and one of the potential problems I see is that the RADOS 
Gateway can keep writing and filling up the whole cluster.

It's obvious that it's the admin's responsibility to make sure that 
doesn't happen, but what I'd like to do is make the RADOS Gateway deny 
PUT requests when the cluster is near full.

That way normal meta data operations (thus writes) can continue, but new 
objects won't be accepted until the cluster has enough space available.

This might also be useful for librbd. Refuse the creation of new RBD 
images so that existing images can continue operating.

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
