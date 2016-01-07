From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: scrub test assert
Date: Thu, 7 Jan 2016 09:17:56 +0000
Message-ID: <D2B36D43.A56C%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0084.outbound.protection.outlook.com ([207.46.100.84]:61952
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752446AbcAGJdw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 04:33:52 -0500
Content-Language: en-US
Content-ID: <48BDB5B71EAACE448E2E2655D81911B8@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Devs,

We hit an assert while doing scrub test.
Can you, please, verify if the test case is valid?

The test:
1. Start Jewel cluster. 2 nodes, 8 osds each.
2. Start fio, pure write workload.
3. Delete data of random pg: rm -rf /var/lib/ceph/osd/ceph-7/2.185_head=
/*
4. Stop workload
5. Do a scrub on that pg. Cluster active and clean after that.
6. Restart the node with that pg.
7. The OSD with that pg fails to recover and asserts with:
     osd/PGLog.cc: 382: FAILED assert(objiter->second->version >
last_divergent_update)

=8B
Evgeniy

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
