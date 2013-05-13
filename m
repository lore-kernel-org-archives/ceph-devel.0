From: Wido den Hollander <wido@42on.com>
Subject: RBD image format in rbd_stat()
Date: Mon, 13 May 2013 13:55:48 +0200
Message-ID: <5190D4C4.6060400@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:57874 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab3EMLzu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 May 2013 07:55:50 -0400
Received: from [IPv6:2a00:f10:11c:ab:9e3:1c10:a3ff:fc5b] (unknown [IPv6:2a00:f10:11c:ab:9e3:1c10:a3ff:fc5b])
	by websrv.42on.com (Postfix) with ESMTPSA id 855E6BF650
	for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 13:55:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

While implementing the RADOS/RBD Java bindings for usage in CloudStack I 
stumbled upon the problem of finding out if a RBD image is format 1 or 
2, due to snapshotting and layering.

I found out that rbd_image_t doesn't contain a field "format", and you 
gave to use rbd_get_old_format() to find out if a image is format 1 or 2.

rbd_stat however also has a size parameter which isn't used right now 
when looking at the librbd code.

Couldn't a 'format' field be added to rbd_image_t and maintain backwards 
compatibility by actually looking at the size parameter? That wouldn't 
break any existing code.

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
