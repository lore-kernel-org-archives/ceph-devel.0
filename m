From: "dennis chen" <xschen@tnsoft.com.cn>
Subject: AIX client for ceph cluster?
Date: Fri, 3 May 2013 15:16:31 +0800
Message-ID: <001501ce47ce$236a09b0$6a3e1d10$@com.cn>
References: <5183625B.8080509@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbg56.qq.com ([64.71.138.45]:43489 "HELO smtpbg56.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761352Ab3ECHQd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 May 2013 03:16:33 -0400
In-Reply-To: <5183625B.8080509@tnsoft.com.cn>
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: 'Dennis Chen' <xschen@tnsoft.com.cn>

Hi All,

Recently I want to use IBM AIX as the ceph client to take use of the cephFS
and rbd service from ceph, 
but after some investigation, seem there's no support for AIX as the 
ceph client. Is there some clues about this? or is there some workaround
that I can map a block device created
from ceph cluster to the AIX system client?

BRs,
Dennis



