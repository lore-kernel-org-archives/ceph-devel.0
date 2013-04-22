From: Scott Sullivan <ssullivan@liquidweb.com>
Subject: Authentication question with RBD+STGT
Date: Mon, 22 Apr 2013 14:09:22 -0400
Message-ID: <51757CD2.2070404@liquidweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.liquidweb.com ([209.59.139.27]:54282 "EHLO
	email.liquidweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3DVSpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 14:45:07 -0400
Received: from data.wks.liquidweb.com (data.wks.liquidweb.com [10.30.104.4])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by email.liquidweb.com (Postfix) with ESMTP id B4420FA40
	for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 14:11:23 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Referring to this: http://ceph.com/dev-notes/adding-support-for-rbd-to-stgt/

I compiled the latest tgt with RBD support. My question is when using 
this method to access RBD volumes, where do you tell it what user to 
authenticate to the cluster with? I do see the above linked page 
mentions it will read a local ceph.conf.

Say I want to use cephx for authentication; how do I tell this:

tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 
--backing-store pool0/test-image --bstype rbd

to authenticate to pool0/test-image as user testuser? My local ceph.conf 
(that I run the tgtadm command on) contains:

[global]
         log_max_recent = 500

[mon.a]
         host = c01-m01
         mon addr = XX.XX.XX.XX:6789

[mon.b]
         host = c01-m02
         mon addr = XX.XX.XX.XX:6789

[mon.c]
         host = c01-m03
         mon addr = XX.XX.XX.XX:6789


