From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: Seperate metadata disk for OSD
Date: Sat, 12 Jan 2013 06:57:06 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC5D36A6@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31101 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab3ALG5J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jan 2013 01:57:09 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi list,
	For a rbd write request, Ceph need to do 3 writes:
2013-01-10 13:10:15.539967 7f52f516c700 10 filestore(/data/osd.21) _do_transaction on 0x327d790
2013-01-10 13:10:15.539979 7f52f516c700 15 filestore(/data/osd.21) write meta/516b801c/pglog_2.1a/0//-1 36015~147
2013-01-10 13:10:15.540016 7f52f516c700 15 filestore(/data/osd.21) path: /data/osd.21/current/meta/DIR_C/pglog\u2.1a__0_516B801C__none
2013-01-10 13:10:15.540164 7f52f516c700 15 filestore(/data/osd.21) write meta/28d2f4a8/pginfo_2.1a/0//-1 0~496
2013-01-10 13:10:15.540189 7f52f516c700 15 filestore(/data/osd.21) path: /data/osd.21/current/meta/DIR_8/pginfo\u2.1a__0_28D2F4A8__none
2013-01-10 13:10:15.540217 7f52f516c700 10 filestore(/data/osd.21) _do_transaction on 0x327d708
2013-01-10 13:10:15.540222 7f52f516c700 15 filestore(/data/osd.21) write 2.1a_head/8abf341a/rb.0.106e.6b8b4567.0000000002d3/head//2 3227648~524288
2013-01-10 13:10:15.540245 7f52f516c700 15 filestore(/data/osd.21) path: /data/osd.21/current/2.1a_head/rb.0.106e.6b8b4567.0000000002d3__head_8ABF341A__2

	If using XFS as backend file system and running xfs on top of traditional sata disk, it will introduce a lot of seeks and therefore reduce bandwidth, a blktrace is available here :( http://ww3.sinaimg.cn/mw690/6e1aee47jw1e0qsbxbvddj.jpg) to demonstrate this issue.( single client running dd on top of a new RBD volumes).
	Then I tried to move /osd.X/current/meta to a separate disk, the bandwidth boosted.(look blktrace at http://ww4.sinaimg.cn/mw690/6e1aee47jw1e0qsadz1bij.jpg).
	I haven't test other access pattern or something else, but it looks to me that moving such meta to a separate disk (ssd or sata with btrfs) will benefit ceph write performance, is it true? Will ceph introduce this feature in the future?  Is there any potential problem for such hack?

																																		Xiaoxi
