Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3112931FB;
	Mon, 14 Sep 2026 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352693; cv=fail; b=TpRN8tXIcMtRmXMpAmC0d1ceVRApfVwpThLf1W96E4G9ZnDL47tCHRo5kTbjfuAzAzzNbP6KMETPzI8uGyVnGk2hd77R2ugJt2mtDLNxkJ87pVBeHQGVvx1H2D/7iHCFMe/3trflHlQWgizD4BZ2SV3FSdl521zrUw+PPiS1QbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352693; c=relaxed/simple;
	bh=JMBejRr0zTQ/2NO8yv4Fj1sDn7IaKJBHaB1LZW/VBJ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ohIn6oHQEGXzof3V6/xDy3uxF0wP10dzlJm5g74ZuASCW2MJ+4lduydj7eXSPO17HMNQ7n76NHkfh2AZNSJdWg7htfeOJwmGNYb1OLcyYNRgGBwv57naIyofRUFk6lc6cn5U6RWULLiCdX8smt5aXKNkHU9mtEDrpAhFahk0v4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXQzfwwv; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXQzfwwv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaxXNSpI6TODkYWL9shT0vl4zVvRZsU+hApWY4o0a0astCV9Vus1mkqQFdaU6JSazBR4GgH7q+0MWyBSMWd3UpU1W40M6R4uIPO4YOSaAICjFO0WEqQQBc3uHVwY7WEYaUrTKnXIzPLd3FfN5gtT9jSts3bKxAoRseGp1j6TvpheFIGRIyi3FIV2WRaUGU/Pj3lT/ReBISrkGtYlTv9t/qmqfoi50zAun5q+paMGMrDllYG2idfidTY2CSIfkMeM1cvqCk8au5ba6x79GYn9LwafF+bLBy5KQZKT2Pm2J2Y9wm5W2BR1ucgzBjPn2P0jnbl8sBielTjYseTh35LtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+d+Fji1lSsUnU4WZ0rfh9rKpMGcZbpGtwR072r+wQ4=;
 b=hNlQCAMebmy2Owuw7vknKupQ4MyVYBduboEBx58pL5GawuCHdtimym4bsAgIr7ovfcCwD4CAJb1Eb6a5yukqyzkRSxud4tovz2KbOj4rbI3msUKOiEpOO81gKEvW+rGbNCpW6iYmXB/TeH/nGuQyuZOfwuY17XLTcvFBKkhc6EJaUKnb3ipb8q2vHrAWadBoM2NONvEd0OazhRQAvRa+rA7qjLxMOHcCCD7U0B9Ga9jPfkIRN9wwfhJ9dxIGSi0+Kpsw15iAzG3MCSi/ay/gbH/tKvC6UjcszXdh+DQxwkNxywkY91o1/4WUu2AvG3qRCVBoYEXDvqWP83RoAHsHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+d+Fji1lSsUnU4WZ0rfh9rKpMGcZbpGtwR072r+wQ4=;
 b=QXQzfwwvw2Hp7PQX8HtDr4GVw1KpPjlrQTnFYsZhMnmjwmzYgDG/niZsk+RYVbp1KyYYmRkIX0Vv86gmEC4/8nmu3slVWXb9O7TvEHGCHfFy53kOtId+I+q07TNQP9ehyvU6BCLmvriJRNEFPslpclGVhoF1+MLvLbRkG/0c/CWCoYDFt1QIK5Q0Wt2UDgqEbhMV7qGO5HhzDwHkAyZq59KG2agGxpxz+eApe9xjDE9kDIg67a3JelNNJyINnCsSkS0KG02dwVXVXoeoZJeNT90M7u1jDgp3030MXKyIBc14qRLgJQO/OeeQOLZjpQSXgqLtauYXYkkBhYdoZCUvOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:24:25 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 02:24:25 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Sun, 13 Sep 2026 22:24:10 -0400
Subject: [PATCH v4 12/16] ceph: replace PagePrivate() with page_private()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-remove-pg_private-v4-12-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 ceph-devel@vger.kernel.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQZPR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::22) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f00df2f-b336-4c40-407f-08df12074bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	v6ra46yqbCE0QGthcSarjn/f7barJW+D+ar9eW3EGkkpT2vRkqv8njqWvw1Xpt3qvxRpN0yPikqv9ljbTIiEEwlkRybo1ZVyGuHZOBE+ALGYoClWjIlOzeAELkGBY5DkM385sRofRQd5wM1t+1oAbMgz1TAFUeIwixYHz9R8WzHSf4HPaqbP3iPyxI+DW83OLkwACAT3W/sJ9/5XR2/fYkxO2dONoAEess/A+l0akOUc/pflsJce8x14SGHzNZBreGbGFf515fX2o3SLDNXNZnYflM76jXqSN1iEvE35ljtTFACaKwgHDyV82gUkbCEARmIJbNEXT/fng67QBfjA4hzU1JytDLYSqdsm+4wBMhqn176UBjJiEm67vcIk/qqw0372iV0VNdfzcj/MFGd2UWMZt3NUJg7nO/hn/xgmX7eSyTcjJpd23h5ExnkPbWb8SmyYH0LmIrBuKqE0mmWA4AxGWrr/U8jPg8MfnyEMJ0Bz5+HLGIbFUwDVo/G3ptKeL7e8iP+liePFgpf0ugeTl6tssmhAO7EOALd5jLEuWOc9ufsmXm7BsV8vtz1xHTm9Anbspy25t5cGZLHwAwA9Q7gVbBWkvsZNDvxiRMeoIVCutQ9liDkaDDLQ5G/EnNxOQ5oeuQjelwpxcB94LmURrab8Ri+VWaXbk8GNlrCg2fPAEW2Ls49UZW5KPwGAfFk1TYQ6ZrxR5rlmlz6AC1yGQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHo1OXdJY25NK2NhNHIrU2xOQTUvTWNOVG81U20reTluYkV2MFFmbEYyMkZZ?=
 =?utf-8?B?djBDQndkemtob2JaeUtSYjQ0b0NWQ3U2UmdxU1krTWlYdFJyNjBCaVpsL1hX?=
 =?utf-8?B?bTFGYVhhYmFNQU5rQi9XZGVmTGg5dE52NVZMNlhvYnVkb0lEdDI4ZmxrM1Bl?=
 =?utf-8?B?UjJ3Sy9HTlpLZHBrTloxU1VFS3h2NmFrOE4xc1N1ajJKWDVNamxyMFQzMzVk?=
 =?utf-8?B?TVluMFlYeGkvZEJQNGwwVmZiOWFDOCtTd3pwd3pvUWlwdnFTejVReGlWVXRx?=
 =?utf-8?B?Yk5TeWZOcS9pSVhLSnZQTFBXV0lCTXhKYVA0NkJ6Z2ZsS1J4YlN6V01TVXhi?=
 =?utf-8?B?ZjBET0tPSmNsZzB4WDRpWEpYS284QXBlejRSa1F6Wm9XdlRBM0JkRTNFTWZ0?=
 =?utf-8?B?TWh5K2NoRTZKWkxVY3krWWVTb01CTHRmS3hMZUt2WEJmbTRWUUhsZEN4UCs2?=
 =?utf-8?B?ZVEzajc3SUV1b0J0SnFLT2ZxRktieUlEeEVTaXY1Y2twN3QvTjVUYnhNckky?=
 =?utf-8?B?bjZ1Y2ZEbWw5V3VjQ2xPbzRtdmlVTHA2b21WUkhVSFdzQU1OT3FaM1BONExu?=
 =?utf-8?B?dVh6NjNpeVhjbVM2Z3JuRmMxOVduOER4MS9SV3lCWExXRm1kN09IQ2JyNmhp?=
 =?utf-8?B?MUpya1YzeFdNVmk0U3JCRjVHcnJ6M3hrd2xMbmhNeUV6eTlrTWNKYndiR3V2?=
 =?utf-8?B?c2xVMkJWbzNyZkluMGdndFpIZWc5TytvNHZpTy82dXFCQ3k3TkNzQjFMOTJj?=
 =?utf-8?B?Rmx4c2RURk4yUWhaWE5hVnlJS1U1ZExTbG0wazRxU2FVRjRQWVRyNDFMTVdj?=
 =?utf-8?B?Z29qUm0zTWkyYTJmbXlvUHVsbzlMMzNkckZFbm4zamFEbjJ4STVOTFBKdEJM?=
 =?utf-8?B?WU94WDFZVis1SitzcXlSZWxwcHJEaXcxV0lPTnA0SEoveWRPRGxqdFllMXZ3?=
 =?utf-8?B?SmQrcjQzanIrRmJhZ2FZUVkzcDNNd3JiWXN3UDFNWTNlME1FQjh3Z1cyeG1O?=
 =?utf-8?B?NEpCYWljdC9FNTFRcDdtOVFGV0xxR1kzUU1SeDdicVRYdjlZRytSUlM2cHY4?=
 =?utf-8?B?NW4wNnFSaS9Qb2g5eVJPU0NabXU1cVZnbkd3aVlacW5YYml4ekJKeURRSEw0?=
 =?utf-8?B?elE5RFQweVJVSzN4bVFhQ01VZk9xN0pkRkF5eGVaOGUrZ2hGb3Mwd3pWb1hX?=
 =?utf-8?B?YlBVQUNiSG1jd1pDNGUzUklBQVRvbjAyY0M5OGZIYXQva0I1SmRlSmF3UFhH?=
 =?utf-8?B?RnFzQ0ZVNE85cFJuaXRiVUpqWjVQcDNXUzgwTkFxWWJ6VkpISEY0ZGhhLzIy?=
 =?utf-8?B?ejFJNVpaa3BDRHhEYk5uVDVhVVpCOHdNMXVyY0UrZks4VjU2WGdZdVNkd1FU?=
 =?utf-8?B?ZFE1cDVMZDNZWUJydFRlZTZqNFVES0dURk9TSzZRZ0hBcGlYVUVaSXJlVTM2?=
 =?utf-8?B?OC92TkZOd3kyR2o3T0U2R1JhcUhZZ0FHaCt1N3EyVVp3NmlEWWs4V0owMTZP?=
 =?utf-8?B?eFM0Z0ROeThDeDBjSzUyc0NmMkN6eVloSGRFWVljd0VwakIvMHcwMnpkZXhx?=
 =?utf-8?B?d3p2K2lEeW44Y1lxd0VieFlsVnlXMFdaWFEwZ0MvYUtWajVwS1NueWF4UnlD?=
 =?utf-8?B?alZocGN1MmhTKzJDMExSakYxRTNOZ2lFRFVGMlhYQW1mLzN0K3RxYU5FY01O?=
 =?utf-8?B?cjYxN2xmWUx6cmw5bGtJaFZnMlg3VmIvbkZNb1dOVzBMZ1hCQXZ1QTFjcDc5?=
 =?utf-8?B?Sk1SUG5iQzJzZ1BLcHMxREtJelh4bGoxQUFBMENHM3pDbmozWVM5VkFtalo0?=
 =?utf-8?B?WkRRcnVDTmo2YWlNNzVRSDQyN1hhbW10ZzdWTGF0S2Y1RmRzcytQeVZpYWxq?=
 =?utf-8?B?NzMwL3VBTnF3TnByU1pQbTYwUnpTdWlWeFlFSTAvV3oyNzdmRWZGNk05d2Mz?=
 =?utf-8?B?WU93V1AzbFFyODV3RzhPNmsxYXQzNXcwV2p4RUVTNThvaU45NGxkcXlFdVNp?=
 =?utf-8?B?U3A4dTFLOUZYdGdiaE9Gd0V6bnlvWUVERll0RDZJZjAxTFNYd0ZIZ3BFSHpN?=
 =?utf-8?B?ZzZJWENnZG1kWjBxZXpsQUcyUEE2TVlqK2VwVy9kNDV4TWhzcGFyZ2x5NU8z?=
 =?utf-8?B?VkZ0OEx0YjhqM2J2b21WakQwaEdDVVpkWGdGY2dUaVI3aXJhSHBxQ3NwNysz?=
 =?utf-8?B?RkxOYys4RXpyVmtBdVFIbDFhUjdmd1Z1TGFuZ0FhWHd6SnBUbFhBU2M0cTI3?=
 =?utf-8?B?OGJGbTExZFZkVlhWY283ZGxsUHltOGRjQVcvWU92enFxOWhNenJpSlFzdmNm?=
 =?utf-8?Q?hEqtmjcYTjEXGjx3Oz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f00df2f-b336-4c40-407f-08df12074bc5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:24:25.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV0da6kPseDRK56Gd2i1gI5DktRQTbIqvNy5D2Eui1HX5lRUQVxiEfVJQaAaTcpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

PagePrivate() is going to be removed along with PG_private and its
implementation is the same as page_private().

Assisted-by: LLM
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ceph/addr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 657c2cb0f8811..1aca181d28c62 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -70,9 +70,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 
 static inline struct ceph_snap_context *page_snap_context(struct page *page)
 {
-	if (PagePrivate(page))
-		return (void *)page->private;
-	return NULL;
+	return (void *)page_private(page);
 }
 
 /*
@@ -124,8 +122,8 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	spin_unlock(&ci->i_ceph_lock);
 
 	/*
-	 * Reference snap context in folio->private.  Also set
-	 * PagePrivate so that we get invalidate_folio callback.
+	 * Reference snap context in folio->private. Setting folio->private is
+	 * what gets us the invalidate_folio callback.
 	 */
 	VM_WARN_ON_FOLIO(folio->private, folio);
 	folio_attach_private(folio, snapc);

-- 
2.53.0

