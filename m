From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: historic ops showing up on unexpected osds
Date: Mon, 25 Jan 2016 22:54:10 +0000
Message-ID: <DM2PR12MB0556C8923853CD1A83FC44729BC70@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0091.outbound.protection.outlook.com ([157.56.111.91]:36312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754225AbcAYWyO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 17:54:14 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "cbt@lists.ceph.com" <cbt@lists.ceph.com>

I was looking at a performance discrepancy with reading objects
and I was looking at some historic ops and noticed several like this.
This is an erasure pool with k=2, m=1 so 3 chunks for each object.

When I look at the  pg mapping for this object shown below on this pool, it is [12,14,6].
And indeed when I look at the actual pieces on disk, they are on the disks that map to osds 12, 14, and 6.

Yet this osd for which this particular historic op showed up was osd 11.
And I have seen other historic ops mapped to this same pg, which showed up for instance on osd 15.
Why would osd 11 or ods 15 be involved in this object at all?

-- Tom


        {
            "description": "osd_op(client.13056.0:2691 0-ggggjbjm [] 3.a3ebd1b8 ack+read+known_if_redirected e305)",
            "initiated_at": "2016-01-25 13:01:15.824133",
            "age": 60.812474,
            "duration": 8.913674,
            "type_data": [
                "started",
                {
                    "client": "client.13056",
                    "tid": 2691
                },
                [
                    {
                        "time": "2016-01-25 13:01:15.824133",
                        "event": "initiated"
                    },
                    {
                        "time": "2016-01-25 13:01:15.824258",
                        "event": "queued_for_pg"
                    },
                    {
                        "time": "2016-01-25 13:01:23.056172",
                        "event": "reached_pg"
                    },
                    {
                        "time": "2016-01-25 13:01:23.082064",
                        "event": "started"
                    },
                    {
                        "time": "2016-01-25 13:01:24.737807",
                        "event": "done"
                    }
                ]
            ]
        },
