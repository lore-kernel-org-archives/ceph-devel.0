From: Li Wang <liwang@ubuntukylin.com>
Subject: Waiters on OSD operations will hang if replies invalid?
Date: Thu, 07 Nov 2013 11:08:24 +0800
Message-ID: <527B0428.7090306@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:48692 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab3KGDI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 22:08:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

For ceph_sync_write()/ceph_osdc_readpages()/ceph_osdc_writepages(), the 
user process or kernel thread will
wait for the pending OSD requests to complete on the corresponding 
req->r_completion. But it seems they only are waked up in handle_reply() 
and provided the replies are correct. What about if the replies are 
invalid, as the situations of label 'bad_put' in this function intended 
to capture, the waiters gotta hang there?
