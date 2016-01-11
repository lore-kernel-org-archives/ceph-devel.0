From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Build failure on latest master with jemalloc enabled
Date: Mon, 11 Jan 2016 22:55:04 +0000
Message-ID: <CO1PR02MB2084E3A447F20BBF7FE1AF4F4C90@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0064.outbound.protection.outlook.com ([65.55.169.64]:55650
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760722AbcAKWzI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jan 2016 17:55:08 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
Latest master build is failing on Bluestore if I enable jemalloc. Problem is, we have to disable Rocksdb if I want to enable jemalloc and rocksdb is mandatory for Bluestore.
What's the way out ? May be building rocksdb with jemalloc ?

Thanks & Regards
Somnath
