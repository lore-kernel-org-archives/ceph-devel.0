From: Wido den Hollander <wido@42on.com>
Subject: rados_pool_list usage
Date: Wed, 27 Mar 2013 09:59:24 +0100
Message-ID: <5152B4EC.4070700@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:48737 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab3C0I72 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Mar 2013 04:59:28 -0400
Received: from [IPv6:2a00:f10:113:0:8c8a:1c8a:11f:1b55] (unknown [IPv6:2a00:f10:113:0:8c8a:1c8a:11f:1b55])
	by websrv.42on.com (Postfix) with ESMTPSA id F1BFABF4FC
	for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 09:59:24 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

While working with rados_pool_list I stumbled upon what I think is a 
documentation issue.

librados.h tells me this:

/**
  * List objects in a pool
  *
  * Gets a list of pool names as NULL-terminated strings.  The pool
  * names will be placed in the supplied buffer one after another.
  * After the last pool name, there will be two 0 bytes in a row.
  *
  * If len is too short to fit all the pool name entries we need, we 
will fill
  * as much as we can.
  *
  * @param cluster cluster handle
  * @param buf output buffer
  * @param len output buffer length
  * @returns length of the buffer we would need to list all pools
  */
int rados_pool_list(rados_t cluster, char *buf, size_t len);

"If len is too short to fit all the pool name entries we need, we will 
fill as much as we can."

 From what I could remember it would return the length required if "len" 
isn't long enough. Looking at the Python and PHP bindings (which I 
wrote) it seems that is correct.

It also says: "@returns length of the buffer we would need to list all 
pools"

Docs issue I guess?

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
