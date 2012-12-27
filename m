From: "lollipop" <lollipop_jin@126.com>
Subject: Any idea about doing deduplication in ceph?
Date: Thu, 27 Dec 2012 10:16:24 +0800
Message-ID: <000001cde3d8$2c61a410$8524ec30$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m50-112.126.com ([123.125.50.112]:45399 "EHLO m50-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab2L0CRG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 26 Dec 2012 21:17:06 -0500
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Nowadays, I am wondering doing offline deduplication in ceph? 
My idea is:
First in the ceph-client, I try to get the locations of chunks in one file.
The information includes
how many chunks the file has and which osd the chunk(object group) has been
stored.
Then the ceph-client try to communicate with the exact osd to ask the osd to
return the chunk hash.
After that, we compare the returned hash with the already stored hash table,
If the chunk is duplicated, we try to change the file meta-data. 
Can it work? 
Can you give some ideas? Thank you 

lollipop

 


