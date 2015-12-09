From: "changtao381" <changtao381@163.com>
Subject: Filestore without journal
Date: Wed, 9 Dec 2015 10:36:35 +0800
Message-ID: <0dd001d1322a$6d3b19a0$47b14ce0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-16.163.com ([220.181.12.16]:35488 "EHLO m12-16.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbbLICgs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 21:36:48 -0500
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Cephers,

Why it is use journal with Filestore ?  From my understand, it is used to
prevent partial write.

In my view ,it is needn't journal for Filestore as to the scenario for EC
backend and for RGW object storage application. 

For EC backend, it just now only have write full and append write, truncate
operations which already has rollback mechanism 

For RGW application, it only has append write. 

So, in my opinion, it should develop a type of filestore with no journal,
and it writes data using aio which directly persisted data to disk.
And the performance are also very good for large io.

Am I right? Thanks!

 


