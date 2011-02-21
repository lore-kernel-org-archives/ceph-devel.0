From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Questions about PG ID to OSDs
Date: Mon, 21 Feb 2011 17:05:35 +0800
Message-ID: <1298279135.1867.34.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:38491 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753026Ab1BUJGh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Feb 2011 04:06:37 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>


Hi ,
I'm reading CRUSH and RADOS thesis,from these thesis , 
i can get the algorithms:

object_id = <object_number,inode_number>;
pg_id = (r,hash(object_id) & mask)  ;   // closely resembles consistent
hashing

but i am wondering how to map a pg_id to OSDs by CRUSH .
Example , 
if pg_id = 1.12,exist osd0,osd1,osd2,osd3,
then how to map pg_id = 1.12 to these osds ?  the algorithms ? the
detail steps ?

Thanks a lot.

Jeff .C.P.Wu


