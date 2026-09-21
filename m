Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10A34752E;
	Mon, 21 Sep 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957730; cv=fail; b=HTB9nAshlmzwUKBcGlpSirT5j0OCKYuEVCLfIeiMHeSRk21zsEBIV1fX5Vuz29zJ8mP8XMB4qMepOl2TYnyUFz6Htb4oxP9bxHVHnS7H86sVpatT23encWQhAC/v1F/rFlxbUQ2sU0pmDuPx19FngMy/jMLZJhIJxLAGSNw+yrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957730; c=relaxed/simple;
	bh=cKhxfvW0j9d1HgCVXJDh9eTBtUyOGuS3GVNUvr6J1JI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tgI3CsedvC5XWLR6b+gfEwnyZ0Sxwi8+b7/dt0wRjSWwGH2MW2A3Q5GfHa2qv8tJfIOrTqkPPBtgG0yfjXMIfKrsqVB/5IbT3ZITjee3nWZ2YwcXGbgx1uhDO6rFAVSwwjgOsKbiok/M8Y9N1eMkmmVbTnmkUy3SXkvAMI/RFNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jfdyn+lS; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jfdyn+lS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QprOmjD6+8FZ5Kelci6St8kk0l4lqPvrv74lEMANtVg8F03bUaksvCUAfu4H8AHQGiv3q13CyzcK4sR4UMjEBVQaY4+QI1uTjHoTez9eXoJnzvFVsNy09sdFL+/P42XrfqmFqXvLExQJNsnpGz1Zg/c7wVZVVI4978HIOngQSm20BTSxJB6TsxQ5la/LYLkCgspVU27zkG54/bHUAG/dieifHkV4gKfkmuHRNks+rtDxqeVC4FEy6FAsh0fmO/weuCJsVg8xXi6KVXaCOwW+Fj3/8Eu4JcCDDkK1WsQ8B7U+fhFJ1xGG8b9OHkdWmNsuj+1TcG2kRPqNbDY6Jrhmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eTALpAQfzanx0Wt/brzqMsVsOXGlL8Z/l1Df3SIQbQ=;
 b=GUcb7xSu+xBRYJEOzDTzscPEGtekuJD+go924ybs5GAhYL1xNMEsJLugpLHz2ozW8f7g3QWrlRRc3/2+7m5yxp6H7lJcASIotrcz/y1LpJaJcdQ7kUUHPNX77qPTsAqMIBFjHAIyVJvq9d0RZDhl1mmoXl0t/Vl37NVX2HsN4Ij9xZ/cehbHH7lwE45+IVnpyjNGFk5OmvOs7BVWnQFZAIKzKAW/uLoOk6JNBrt/QA5Ku1uA266qIHbAZ1vJTOFNaEg5VDaQJ2Q5HFn62FyzKPLeP7WIN6E3Ywo3ISFcQq14USE1sm4MWbI1LZEfL12cxTFL6Ou1BFzTJRHFC0MtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eTALpAQfzanx0Wt/brzqMsVsOXGlL8Z/l1Df3SIQbQ=;
 b=Jfdyn+lSZfdVz/dlqJi+CdesaoENFoft5bQVYS5FJ0yOSPgvbGP+IWVfz6RwnxTUQFE1imrAd8d6KPT/Dd6fnpKWSzNsQOLFpQrNay+MOb65oTjRrZFnvlFCi9p0XGLua7t587wu5p9So8o4hPqjbL6XUduRznTB99elQ+aEF7gFRyIZ5prtODNzvOvGCilIc0+jc7fN9EhhNrWOAHXpS35P9XlN11mYsTsE3NrjySyWy1CLXXeVAvuUId1+xMf7wjPrlNUpvy5aic9hKbgcUB+/35yS0YK+/VjKMRNfFSPG/TN5TUCpX1UsbnOzTt0+SOVrkAyY4lyNN3h+WIKUDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 02:28:37 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0428.014; Mon, 21 Sep 2026
 02:28:37 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Sun, 20 Sep 2026 22:28:08 -0400
Subject: [PATCH v5 12/17] ceph: replace PagePrivate() with page_private()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-remove-pg_private-v5-12-bb68b6a21869@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
In-Reply-To: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
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
X-ClientProxiedBy: YQ1P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 53474ef2-bc39-4ca9-9bf9-08df17880aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wET2D4KG6ONFhTf6tltir08ZtCTK+/xyXN9U8vx/bOtIy+eMfuUFifIUwk/Qwy8vPFi0glewsxc/XQSlqa7EXwecWcnr26bRFDKmnA7eBQRwB5hAh3D2gBJFts5ayTbe1cGOai+naJZKZH32FIgcbi1/Afw9L4/XawyLAN5MeSa4rEeACurzTCja9b08UNZhsJvmDrJUTQa60rrWepgvg+o7x9/Rq1wurQ0Qj0CXx8CdOLiE+8CdCbLDUSHPPh3cuROKyVENT65JXnhJgpWhfkPVULSAuMK0fWpernDeLzfhLuReqQJLd6pyhvG0lG7Uyzp8UfgVSq+OSF+syqlVk4SLPcMZMwqS2AB/H05gjIRIR8ZBv9z6JxNVGqC5El35bLAayx8SLyQiwnnOzi9VbHq/JAwFCAdcsPgMQxzCZPdhg+61xlYoB9tHaieWyzLrmd6NrZB1Byu+iEy2Cl/dhluUoaxru33BujIf+4+pqtM44uqRx/ES8eUf2IKE/ca6TOSFzmUOjFqU/7/2u/MgOgB3K7BHHTDsz8HCaxQr3+H3z2NPQZuLv370MlG3M3gd7qFcZjgfSgiuRsiv26OU6c5nwwe7YhnRVIOXprNSmza90UMFuDNbCrrUBLama6yIyvUovMNEAI/Bp0bVIMw4EVPEJVVUt6atj31NzuTontqfnDh/rcwvmUwuP9QSH9WzVtgNmZZlOTGChQ4q4xtuuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdHMnFsNzdtVGRDN0xGZkx5SE9XeGtUSnRsWVFUSXJjcjRqeC92QWN6ZGky?=
 =?utf-8?B?WnIvdEtkTEZtZGsybVZTQkpqc1Z5Rk1TSFBHOHJhZktyUWpxZnc0dVdQYWc3?=
 =?utf-8?B?VmVTemJwWGlGV1VWZEVQOWxIRkJqYXMxQVFkcVo5aVNRNjVGQUwwYmxONW93?=
 =?utf-8?B?NXV0Y2o4NUZNZ2xrZjduRXcwT2RjRG92dnVJSmxGMnp0U0k2TzRVZTlablZL?=
 =?utf-8?B?UWcxaCtyd3kzSFFxdHorMVJURmpyZVBJRW9lTTRaSXZzUUZTUXgzM1l3ZHlx?=
 =?utf-8?B?MUx4bS9qNDVhY3dOY04yUU1XNnBDU3NMdm54UTM1ZERsNWFFaFhWRm0zcVRu?=
 =?utf-8?B?NklzNjZVYzBMOFlUUXRGTW5qTTB2OXpPVVFUNEpPS240djdoQ3Rzd3pBRXNQ?=
 =?utf-8?B?Y1hpTVdyeG1GTng1S3VhYlNCZTNRWmJuSlY5c3pYNmJGRXM3QS93UWZZbkRD?=
 =?utf-8?B?Z0JpdHBqTjNrTmorbEVLaHhQL3JJMUJPMG5MaXAwLzJnMmJ4WEloRGwvSm5K?=
 =?utf-8?B?M2c0bW9oWGF6dmZzeE9LeVZQL2tZUDEwWERGSWIyQmN3UERVcFVTbTIvclln?=
 =?utf-8?B?Q3pGVTZvWlozMlZSZytSdVF1blV5RExXRG9WajVFMEl3bk5MRVNBR01Va1Rq?=
 =?utf-8?B?MHZIY2U3bUVmeVNyQkxXSTU1RjlHNmRVWjZ2ZkkxTXVtditpZERBRS95aThY?=
 =?utf-8?B?enpFdmNGblpET0lOcXN4SGt2MUU4TnFSazFhbnN1ZzJOUzdyd3YzOGJCSUtL?=
 =?utf-8?B?U1FzaEE3V05KYU83RXhUS25rY1k2Sjhvd0hZVkV0WFIyYmsxR2xnb0FVdjNW?=
 =?utf-8?B?ZjYxeVNQbHBJeTl4T2xhUCtpb3ZjL2MyejF4cTdsb2d1QmtOR04xczVvblp1?=
 =?utf-8?B?elpjT1V3Y1VuYnlpb2RQZDNnY1BkY0E2TTBXTnNVcDVqWjZlNDBrMTE4aE9l?=
 =?utf-8?B?UWV4TVQxNUZZUnVBeXE1YU53UHFFZEYraWtJSkVUTGNTSEUvdTY2cVZnTi95?=
 =?utf-8?B?YkNNOExibFlVaGRoRlMzU0FWS3NGZU9WSHRqVk9OcGY1a2l3bDFVSVdSS1Vy?=
 =?utf-8?B?clN2by9HVmt3Vi91dllKL1Q2TituQXpnQ3BtKytJWmN2cFBVN1pYYVh4dkcy?=
 =?utf-8?B?OXYzZUhRc1I2RllCZFpOVW5hUlpLd0IrVHhOOGdrUkV6aWhRM1o1akwxMUpP?=
 =?utf-8?B?R2tZV0ZBK3dOcWJ3MndnMGI0dWh4ZWhQK1YrN1lmeThpbENhUFMyYUpSdC9i?=
 =?utf-8?B?cmdxdVY4UEhUakJUTnFSelNJVVlhVitJUnUxVVkra05ZUUV0a2wrcEM4RWlM?=
 =?utf-8?B?eDg1YmNqcWpFbXVUYXJOc2Uxd3hIUW1Qc3lCckxYekg2OWlzb0tiYVdIVzc1?=
 =?utf-8?B?cFJEZVE4bFlPTWZpK0xZNjJDY0lKL3ZLbCtJdENQUTB2eWFZRGlrK1RrblJX?=
 =?utf-8?B?UzRlRzlLQkRybGtmL2d5aC9tSlJGUDFkVnRucmpjZUNtZVBTSjNqNE8rNjR4?=
 =?utf-8?B?dGgrbDVMeXRIUFFaUUdNYzM2dVU5RlVRTGI0bmMvRGMxRzZoWDRSYldleGVo?=
 =?utf-8?B?eVpjdkJCK3IrcmJ4TGljSmwwdWhLZDdickZyTmJZakJKci8xTFRaWVJjUW03?=
 =?utf-8?B?VGxRTGFyZGVPSDlmTDA1dXNCUTNSdWpWZUFpSnRySW8xYWRTUGxXSXlLQzc0?=
 =?utf-8?B?aHYxUXpDV2JPTm5yRDNMS0VIWjFBS25yZ1V0Vkh1T2wyZmpXRHAzaTJCT25Q?=
 =?utf-8?B?Q0lMVTBodDlzU21va3VZSWxxcWFTcitlSllFRmNHWE9CMTE3OFNlWGlXYVFm?=
 =?utf-8?B?QXRSRDBVYmhvWGtMSlBTNUt4N3JlQlgxWTR3QkgybmEzTlhyQk1XQlhCY0du?=
 =?utf-8?B?SmgraklaUUk4aTJ5d3NRbW5NVDVPQVBIMWlnQThXc1lvNDV1Zy91Y2NpZms5?=
 =?utf-8?B?cFBmS051ams0VldsNVRmeG9rUjhjYTdiU3oweno2SVl0RFhDdjFCNHdZSkV3?=
 =?utf-8?B?TnlJQ1NUSWtSTkVKVUNOdzh6dk5BU0ZWUjY4cFBjd2FveEFFckdmMGtqSzV0?=
 =?utf-8?B?YkVyaERoQXY0N295NzI5VFVDRXYrbW0zWml5RW9YcnRSbjFPb2lneGh0TDdZ?=
 =?utf-8?B?K0wyNnVOWGEwUUdPU052N3NKR2pWQ1g2emQ5MDNsZ1J2L2dTNGdZa2lYZVBx?=
 =?utf-8?B?K0NaTGxQYXJhNndVS1UrNUhPMC90YlpiZkoyVHNhZTU2dUd6NWdxQVhpcEhs?=
 =?utf-8?B?OFp0WmVyVE5nbE5hSmdCQU0wS1dzUldBZlliUXpFQVc2eWRGRlZvTUNCUEg3?=
 =?utf-8?Q?ezujp3QRE7CX6nn1NG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53474ef2-bc39-4ca9-9bf9-08df17880aab
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 02:28:37.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlxwPal1CmgQHNJg4LUJt9lfQ76mTkTAV3Yn1jVoekJv/G0r0Pg6Lmq3HmoUhaep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

PagePrivate() is going to be removed along with PG_private and its
implementation is the same as page_private().

Assisted-by: LLM
To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
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

