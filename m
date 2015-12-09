From: "changtao381" <changtao381@163.com>
Subject: About rbd journal
Date: Wed, 9 Dec 2015 11:10:17 +0800
Message-ID: <0e3101d1322f$22a53880$67efa980$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-16.163.com ([220.181.12.16]:58391 "EHLO m12-16.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbLIDKl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 22:10:41 -0500
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel@vger.kernel.org

HI,

There is requirement from customers that need to continuous backup rbd image
to backup device or another ceph cluster.

As far as I know , rbd journal can be used to record all the rbd mutations
to journal which is stored in rados objects in the same ceph cluster

Is it has interface to push rbd journal  to  another storage device or
another ceph cluster ? Or is is has dev plan? 

Or anyone has other good way to do backup ?  Thanks very much! 


