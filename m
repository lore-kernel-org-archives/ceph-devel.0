From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding op_t, local_t
Date: Thu, 19 Nov 2015 01:54:02 +0000
Message-ID: <CO1PR02MB208676EEBEE4B862DDDF769F41B0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0092.outbound.protection.outlook.com ([65.55.169.92]:36640
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932461AbbKSByG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 20:54:06 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
I saw we are now having single transaction in submit_transaction. But,
in the replication path we are still having two transaction, can't we merge it to one there ?

Thanks & Regards
Somnath
