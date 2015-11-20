From: "changtao381" <changtao381@163.com>
Subject: journal alignment
Date: Fri, 20 Nov 2015 16:33:25 +0800
Message-ID: <019801d1236e$206f12e0$614d38a0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-16.163.com ([220.181.12.16]:45638 "EHLO m12-16.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162159AbbKTIdf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Nov 2015 03:33:35 -0500
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

HI All,

Why it is needed an entry of journal t is aligned  by  CEPH_PAGE_MASK ?  For
it causes the data of journal write are amplified by 2X for small io

For example write io size 4096 bytes, it may write 8192 bytes

prepare_single_write 2 will write 98304 : seq 24 len 4324 -> 8192 (head 40
pre_pad 0 ebl 4324 post_pad 3788 tail 40) (ebl alignment -1)

Thanks!


