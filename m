Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96E4A3412;
	Tue,  4 Aug 2026 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873562; cv=fail; b=Jteunrmlx+WFTEKT1UBbI+7/LjBE1xNOD7IsVN1zjhGEskW3xmr/0w2Y+OKYFBGcdFZvurWY7a5VTguBF0GShYoVZAi4gaGfvmHlJR5MrHNvc3nGgT8ZVmUFjxm8CGScplODKPl4Z74ObCzFYmu8U2oTo3BvtupnBfPS81gjiaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873562; c=relaxed/simple;
	bh=x4KPBp+nA8JG9c4p7475gsSQh7DjAAQU5NGW6x+jRmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iq0ryvucbybnnpBM5HG1CE5ZfQWWelGdYP7qTlLhcRgesDXSsrofnW0AXVPrqeRcSMsQIZFXGhlPSID4Vs4BXLWi07RtcOehjUctUs6N8yTSuXkq+7mXrl9J5+P3zuyPwB6NuMUPKyy0kTRGU3kd5UYoP5cr9PV4telQy5bTpiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usw2EYWa; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usw2EYWa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kylcZZICfvEOtzjAtTUsZf+A85Hc6CzX1GsCZPPBhg0qQabLjB8FZS14EMPZchU7bFz8RCi0kCJPSRieZbiSHD36YaMgppzUEVt7j/c7beXMplUpN9ywNSki8mfmMud8nNv2XtKd+0wzQTeTVMG9xDA3xQaNJUrciYS3O2vNqiaB5OGOHEqfVAiL0hJxmax6+X4etP6vdXKV2rR++K+gkmoHSswTu/52qRzIbBHAalfpyZXBn9n1qQ63CkxtM/Zu9m+O94jF+DiRcDi9yfSOx2cC19WHSIGTu7DEWlwKdPzyX2KqOOoQh6Ko19HGNhre/Xd/OO8a0NJDYm5KLK73tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmJrYLNemZq5eJzgebwoj4EhazKrM7Zp5K32QI3gFL4=;
 b=NPD9N79asGKZ+kA3Tg+gvw+3zH+/0/LReAD4v2sMUVs16TJ2i6eIxtiOf2FB/wMi/iqwePFrrcp2Vho9WnSf2armVjAJ691Z3C7hRJUAHa+oucsGfyP9yR5ijLOcdTonuF+vhtAMXXVmqSauf6tLXwar2jnBiJsF70OYAAOQ3aC+M2y6VCXug3i9weRRDkWRf7kV/1NrF20moUUx76AbjB6jxjdyGIy0mWxNqPEuGYLmlvjb96NWf126Q1u6DQJECqtX7Ehg2BifzStx77hLx8i0lTw+EiVn0+PqkYaxBTYcI95n77GXwzOm/9pohvtjbu5r3HJOj2ixH4udA+FKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmJrYLNemZq5eJzgebwoj4EhazKrM7Zp5K32QI3gFL4=;
 b=usw2EYWaxWW1JTbt2GQuR0VUG59aMknGeZONCAa3bUzZDFCYiXJ8n9HG7Sczgsr5AhG8xG30Bp2lIj8yVVq4PsKARYBfuz8g/kV4ihUBIdEzHwTHf2g265ENd3lMpa6U7tKnSOWr2u4wZvOVYUQAsP7VkCcnncJIyDOoDzOH5G1np4zZyugJzML/xgHvljsYenDLvaz2+LCMd43El8PPDF0AGTVllCKvKMq+lzjaBQTSUszcMq/vecqv5dE3pi4RElRlGv541kApppRlWOuf/CsPPm57mlWVK0RxwqNjHk5+OI/IqLvX20hxTDeUCA8l06+nr7kSxfz7aV6Zl55eGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) by
 SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 19:59:17 +0000
Received: from DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a]) by DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:59:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2 01/10] ceph: add ceph_folio_snap_context()
Date: Tue, 04 Aug 2026 15:59:14 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <F6B9E1A7-D812-4F28-B9BF-CAFEBE68915E@nvidia.com>
In-Reply-To:
 <20260804-remove-wait-on-page-writeback-v2-1-81f0ab065284@columbia.edu>
References:
 <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
 <20260804-remove-wait-on-page-writeback-v2-1-81f0ab065284@columbia.edu>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To DS7PR12MB8371.namprd12.prod.outlook.com
 (2603:10b6:8:e9::18)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8371:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ca4e3c-93ef-46df-e50b-08def262dd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d7oGf2cmpDDFYRStVrPxxU4ZQzA50HmbZu9pbjlCO1V57HhtHs0xMGYsBJx2keo4thp6+I/S9tfmVqq3guYPPFRgUR26AvkMNI/F0aSg7U/XXX4c68VtMoDGDAR8yEm6zk3/l/u85qAUebSj++16OyeRxPJm+ZxxwzFv1mYLIHBoXyRIlA4Kuck21WDHBMqvaHEUL1RSizSnRF3q8KG3Q22akUoTTn5pIv3LTGM/mbVGoSWSFD8Kp/7OzPDN/rx+4cuqttGEjlJLtXExLkNrurqIWvUDnEYkGiSuLznDKg7Uz+mxG3gVipnHxh7E2athrrXd0Qns73IK9a3jOKSIBPhgQAtsrM0H4fVbCmTQg1ErGe7Co9c0tCdccYi8+y7rVZ9Uxq0yiqOxEJJQn/gXZt7dwbElt/xbDnNbC7g+k4jawUHHEfARC+nuRwhjkcRYTYAjvnoSoDH9PsuayR+ugJ7t1MZYKNVOZTPKwWR7W1jhyx4cx/ciGHMTy9rowELLchyEnd0LpASfuTXWmwQv5OzylYrZyTdysHUHOPNVDA7hoMoe1d/JO+PeMZzukt8kS5H/z7yH9CeL/yTgznChYlY0Xk8vvupFOkBQ5P+yrki68AaHaUajiqB+me4BkkRqyLQHngjCvPiCngeNrs+Z1l1/nYNRhJoe5ubiL20y7N0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SjfNn05A9cd+OCEYQYh5L7LVuYj9ppmso1jv3ukvzjg25NbeqkizMjCkS5am?=
 =?us-ascii?Q?f4rWkuGcnmG0L4g1JQnS4PctGlRJHXp7CPCjXRFzpiSOGMzyl1G3P2+0VyB1?=
 =?us-ascii?Q?dog6n4BlG8G3xSh5cwJMChFcYTl+x6p7kioTsNiqb0U9EVeAarevpkMjpUIT?=
 =?us-ascii?Q?S5X9srVsVJoYTqWiiAaSFEGCzQelWwTS9q5MjiHs6rLLg4MWocGN9YNNlt4R?=
 =?us-ascii?Q?Y0WpKgg2OGw1RNahSGb8h/C1EkIe3npzV6gQPCNGsEEydz/0APEuyaFujbzs?=
 =?us-ascii?Q?JXTUvLIy6xK8cTVDKtXu/xEIyQmBQ4hR+NeB7HDtpcnpPEdMVQBGtB63VpSD?=
 =?us-ascii?Q?a+dxPWF/PnYxvs9lGKz0X1F56SYFNyZtNGGiciefj3u7PRGJBPsEdKW9MZRg?=
 =?us-ascii?Q?fK6+Yx3ABORodtXPa4ygDGqiC19CXyTA2wTnr/3wBnaTPp/ZVZNbcsdymPQj?=
 =?us-ascii?Q?oYo7owjWsDlumWFd5v3oxFfe/2vQ6oTOsSIq9ZWgOlSaznKPZ6JC8+k5daUj?=
 =?us-ascii?Q?4C8raURZ0RC14vuhgqwEhLZP+kYBGgWnxH8Lxl9MCKwk+DKCvAjNxe+tOaqW?=
 =?us-ascii?Q?PQg0+YndKiU35BJoyKfkbm3BqMUul6T8qNlzdn/9C6oOCin+dhMF5SVOWeUF?=
 =?us-ascii?Q?OJ/mYUM2/+UNyfE3GBdJSZfO5teWUMRXYhvf1rXAJyCzhLHXIsP375mNlIHL?=
 =?us-ascii?Q?RKRe5CqfmD5uMLnIFa7IqA2UmIMhqkZrfQmwNaGOX8WulpVvRlrvg7q6meeL?=
 =?us-ascii?Q?SlB1DKNgPvIFgnEFrjK/F8az6emmPAHnvPu5E4x50S0WkSyVegrQTlf/TkJL?=
 =?us-ascii?Q?xH4+AIwjeGPMcCgyDRjV4nGF0eQGzuk9nGCRIskgS9QqOevaJbinNFu74cCI?=
 =?us-ascii?Q?kATlNtw8Kg/w4E74OmRREnCOtB+0bH8sQEVUW4KvdsxYeO9yu10IODK+L57t?=
 =?us-ascii?Q?Ek++025cSuc8aPf/rXrWDniDTYMgbwp8BQcZLGqKjkcfCDgLwCHcYyAKRyvU?=
 =?us-ascii?Q?V9ZksGUInNimWv+nasxap6miUvb/5mriURUSpL0PH87nqSWE43AIpalKs6NW?=
 =?us-ascii?Q?YSuStpC6yf+hvoAPPVTTqfX5+jYGAm1eHpgz5CJ1AUqo5Z82p8m5MSgIEJP5?=
 =?us-ascii?Q?jug8yNNWdiVfLp4c9wakRxRwDgzHdllNLYIt3W73W1XdrbF/E4iainAoHJmS?=
 =?us-ascii?Q?SQhACu9W/t3Nj75mjE9ShgA9El/0xoGO57yIqiL12PIXDx8WAESVS1uF0i7Y?=
 =?us-ascii?Q?RlntV9azdA8xUugVv5Y4K2qTfuVJJlNFRGiOExv2VrYY+VSCodMfRDJA+mZ+?=
 =?us-ascii?Q?Uv9oR4+H3X8DTjiISFuzh066rJdxK3Nj7qNy92kK6gUPgUVDYLyX3BZ38gnS?=
 =?us-ascii?Q?XWZ7D3E/pXkOflDwG5OT3aij5PSFMcIRQMg3NVp/8GAeO8J8TEiLLx4s6h+K?=
 =?us-ascii?Q?Q1MvgOY/GqQQO960t9o+7rhev+dMeDVByHWQ/+E9Un1zG1x3VTufu0pzZ4bE?=
 =?us-ascii?Q?C19JsOiBBsMx7QlaCyWj/EoaygKImndQT835lXZj4L0WhIH83WSqtbP4ymeQ?=
 =?us-ascii?Q?3ACdivykil1CCY8ldrtsSg3BVaJpc1x3x2an71ESx2NXH4xkoL9cen3cP9My?=
 =?us-ascii?Q?qVf+Y6QjJp4Ow33lpcM1h8FbZfvGBrDv2Mmj5NRK9gpKOwbH5NFJFJAV+UmF?=
 =?us-ascii?Q?mSanMr69RdrhtARgxtQjI6yRxXqfFAx/hFY7LzWSL055KfN7kwZ52mJzLeGm?=
 =?us-ascii?Q?/FRjrvd4gA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca4e3c-93ef-46df-e50b-08def262dd61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:59:16.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiyhydHK1olWm2+4nGF9FBkx9kYOcl+d3m1cEarw9yqrQfOox86hjilohAIN5HIy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274

On 4 Aug 2026, at 14:52, Tal Zussman wrote:

> Add a folio-based counterpart to page_snap_context() that reads the
> snap context from folio->private directly.
>
> Convert the three writeback paths that passed &folio->page to
> page_snap_context() to ceph_folio_snap_context(), removing three
> open-coded folio-to-page conversions. No functional change.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
