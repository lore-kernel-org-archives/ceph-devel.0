Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420968;
	b=A10VOqK+QLj0z1tV/lr7+IGfRq4od3rusqv2TpyBNLOMx2G1i+7OqNPe5+8t7rxFQxuf
	 Xn7iL1ZzauguE2Vw3n2lM48JLnOjt2ybQEh1LlgAhK1oYvjnEvDVtreMZPidutxZgYewY
	 i+tdSDPuHuu9pRMZQrHnMA3djPAAVPWcnqiG3zNc45Gfv20jWfp9PIobuRfVXdL7PNgYc
	 pqpy+zkug3MwVkqgqEi3PDwMpr05S/VPezyU5M+40+mVGHQ8mf5ECy2AHFS8sz2p1ouLs
	 jGTw7O8PB0nrc1LklwxwrZyaXqfC/XGgriqs4vBUn5CjSDXv3aebrWXq5oUOsmmcseg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0/G62h3t9Jqry6wzVFlkYgPnkqakSC0vHxdOARtemus=;
	b=Gc5EHHw66skyvJ5NUPbygJJ04tl/z60BtqWJmYtRigEuyLNSw0BGYPdWmVM/LhwL8O9v
	 NWxrGHVOhi9kl9UIaGLYHpARtW4EKN6zhIpTEvFkpXalLzTtXHm4jHprXPlBRYF2w/FAl
	 L0WhpziWvy5uqITHsTZ6IzhEkGV1qeaNGsxrXrAg21fkbZmYsdP94ZTFH4xlpva7cQIpu
	 TvZQb8k+D4TK5hw390ifPgOoeM+VcahnVjXxaCcD3ImuefpZFA8bXcRb/YWEJIkpWMACg
	 o2psrh3nsk45QuU9/vhocpK6aaxO82x1beMgeZfP4RNZv7hCu/fseMu4HpdaxQYlwpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b="Vrz+ZO/I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58560A262B;
	Mon, 23 Nov 2026 08:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF58560A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=Vrz+ZO/I
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6kQae3025693;
	Mon, 23 Nov 2026 00:02:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=0/G62h3t9Jqry6wzVFlkYgPnkqakSC0vHxdOARtemus=; b=
	Vrz+ZO/I/G3YHQayxQP7pU6n7xqN4AYSqfQ520Dwf1WKDp/CrefPL0mbt2/MZv1y
	XeUVS5rO/iRYowhKUjtdlwRk8HYBxC7UXEOgCnZJTP8LmHJrRUhFL29ifySuGuFv
	yPHnUsSodDVrvQZggozN1KKLgcYrn+TndAVZRpaDdi5O5SU+sjOLpdQxJV6Q6j+6
	lnGic/rO9qfvliiBHU0N26PMVSIHvNeO7VnJ+eeeduMBDzrzLtvc4ZBTt/lgYbZr
	N7FZSYA0ABC+PLILiCS53KSO/wvVLBQgHIDFZsw7t5pEUlbNrJY5S8ovZx2zVLuK
	X3jWhauoZ3sss1d6BEXUhQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020099.outbound.protection.outlook.com [52.101.56.99])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j3bpjsr51-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 00:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDG5C6wOFlRz/rrrwLVnU9dGTktG9q017m4H6l3NNnGMmOXE3ULIQyF/4AscREOSvOwA9dMccCYdBZCuqx852ubaSni76ZDuPswKJm5nu1nm7eq+3+PktOhmFDKmrlzy/P0M0OglhwgG/b0DNIPs9SeDHH68jkHVjiJ89IuTwWQ0uJ1pd72dxw4ES8Bjh2Bq7wiavs2ff2r5PJsYMMZXiu0dCIWPWQZ46GD08uTRnllz4wlXUIezP8iDehW/larstB1o9HoVAYN8xzHEl1SLstFYfPTK9cDjilom8mzskWVUPUTb9q2BgHy19MU4Ba95L/ZUwH3ZVg14QdJwntgR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/G62h3t9Jqry6wzVFlkYgPnkqakSC0vHxdOARtemus=;
 b=L9ACqNMbl8+s0hky4ylKp4+Y39sJ4geB7RZvpCn8EWen4NxQLJkdS4lFajtdKpZEvbXzLN6d61YXrpXuOO8Nke9+oHSDMaJJnYyLhPZvQKjG6zqgiMbHDgrFxXYS+bKI9CuArrIxOhzUPDlz9Dvk5r574gJYLLZmLW9KIDAbNbRt9AsY3UfAHbkVhD4cNBEUzKXuYv/uvQg8GNqzR67vOvAwEH+plsWGdRFfARSbnPD43IKy5egBDgxpf7gJ7rCzPAw3aQM1kKGCtFKmGuGbSAFtKuNrUybi/MpS227bGKLb80Omk+fOy/FIq0vhEjKhKZ3MRwr0frEgqIheFAXadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:02:24 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 08:02:24 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Xiubo Li <xiubo.li@clyso.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] libceph: don't escalate monitor hunt backoff on EADDRNOTAVAIL
Date: Mon, 23 Nov 2026 10:01:50 +0200
Message-ID: <20261123080152.163172-6-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123080152.163172-1-ionut.nechita@windriver.com>
References: <20261123080152.163172-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0051.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bd82a7-9d58-41ef-a515-08df49381b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261022105027099003|261028144727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1WKwLrCYzvY9E7M6QA2LrfEnh8skyI880IHUzU0ja7j4N+U/U1jB8Ws9AmcRHAQ8W/el9YvCO2Ag+c1lnaDMm05ByYH9yvdagwAC6Pc0+9YMuhaPs9gvgAytQBgPwU/5N/4JHH8e2Y9Fuis/l7fnP3AWowrrEJ7p5HbsRZcnkNtmuttl5Ml6xb72T+y79EJzkNFt4GGuXdF8QlhoOqKOVWRqMSJnEa3XvFEXHhIrwEhxKTWYqpqJ6+AtPg5Ja6GazozAvqJwTm/WceOpW7ri+jcw1A4QhTjlK9IGi3sKJFHhuu5YU9JUN+nqpWXTx305JGdUWEJgkk+/dNjHAQgKSBAq0qDvGY8LlqHhAL+LrmsXblBJZqVHhVfhTD5r4OWQ2pKgZNHVgESQ1B+ImgDGURiyirw/7bV7qD5byh1j2TiNLDGkVCKXtKNcJSpb9XOK/qxaiKG6Iidb+jkSGiAI48oqkUDJNY98PneDn26yPYAoc21eY4P5Or6OAIuoluuP2APDm65A6Sc5Y8j5txU7n41iJvf7MJ6s3Oa5Y/xqqykuISK3/B9dn/Gz8OI/c99WJ4SutrFPEp4gu5AJbS3LpYY1X9kkF5f/5GNF7XX4uFCp5H4kduLbrcVvg3tuah7D3jadBttGrQN9gPOg6d7r6teU+MyG+/ZtMODvhzHaO54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261028144727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+io0cNwOqC/vMoIBXbZD1IvSaCboB7PaHKuISRqXHzFzSyf8DSgfVkcUCRAJ?=
 =?us-ascii?Q?YTNL1ozOhKEcJVSWftUppTMcaJYQxYOa9wZmuKiJ9dJGNkPaygHQqvRj6JBF?=
 =?us-ascii?Q?g1UaRV/iwVY+5zK5UvxUdSqE5Y72uniUH3ZEbJSKeBitYJ9GpspAcbzecUtr?=
 =?us-ascii?Q?7Xi7U4xPkMvMFoFMiPkwAmK8eobmCtWa5m/Na1S1yg7YeTJpkqz0yGzHWAZi?=
 =?us-ascii?Q?TVYGd0yqwyESnF80x6UIY8kOs5ILxbc+7R78yZ9uzqzNJE2/d7kNfkn4XQ6l?=
 =?us-ascii?Q?GxYJay8Bv+qCoilun50qS832vnDBwCMuNgiQHAA/lvv5BWVllyLFi47S+e3m?=
 =?us-ascii?Q?GuQtk+EOs5yO0zcswPdD/zFm+svs2SysdJIKnKxIFqwD1ms8u9muy4eRUhk9?=
 =?us-ascii?Q?dDaUQNNW5q7nRe+QkkZ7LNe5+XK5/610pG8M4QwYNP1UOxrCZ2NhWQMXgtsq?=
 =?us-ascii?Q?aJOQMCyHCjRfj5UI42g5jjQ2TwU92hiIeK8usdYS96Mh2eBnwsRl+w0ECcOR?=
 =?us-ascii?Q?gXawYyFg5qPCPghtbMGAIgW0ZsaZbj0C0BE+TPO+f/givPbJrWMRRxLYy6R+?=
 =?us-ascii?Q?2yVjzPNI7WcN49PuWdsf8OEUINzhEu2yIFN9mWzNDOhsV6myCMgBKneHteGw?=
 =?us-ascii?Q?m7DT+PpwW0YSeyvmHN7YYUBcTfcmyofDQrxu2Gc6SKxnYu9NUuTF/QtMSBor?=
 =?us-ascii?Q?uITjR6FQQ62MPeGGhbnQAMLH/QdPdmdMYcpF/+wWCzPdCN7wXIgqVxMgQiHk?=
 =?us-ascii?Q?2c8dSm6qWYbyVARelyJUrx0KFtlLRY8W1+c5whS0lpfzWP0Cy9bLQooqej77?=
 =?us-ascii?Q?b/Vmft0/dDj0gagPsC/mwH9z3b524ux1riT9ASnjw9nFdDaYicTUSn7udj8K?=
 =?us-ascii?Q?/m0CR0ix4BZecECvYjIwJTF4VsPkiV9CsoVCdZ/thMmqJKpnHWaVkuH96iQj?=
 =?us-ascii?Q?Tv430qVd2pizoiKyldcXtSHYQQIptiJ3f7DNG4ezY/h04pDVX22IbbmzXG0x?=
 =?us-ascii?Q?wv1QgNKFU0lItrCWSnaQ9D+QhYtktAJD5JG25zV+QRWhDdKPHs5hP1VV9r2F?=
 =?us-ascii?Q?EUvMpkWB1Mp5HDEV2C0UegKfI9+r/OBEGjTC9XSRKxhmR3EJSrWyvjXyq+Fj?=
 =?us-ascii?Q?LX+XKR7xUQ+opVZkZSlqZyT1raTQva8WSO7hTsK9izo2C1Kh4uq/vjG+7rYP?=
 =?us-ascii?Q?z6mNfZpBED7v2kvUdTXvK5zo6Bs4u5Oaybk8Rb7m0C+2gGvmo0Nfs7C+kE/k?=
 =?us-ascii?Q?eLUsSU250WTVYQIwrygrBUKRgDdxRCaYo6qn0zyzyQ8eRNzj2h76b9ok/X5k?=
 =?us-ascii?Q?krpUJv7mXw6Klx+oUJDYETFrq7s/aVJ+Jl4HCPxQF37hQwkpFwnnbEbcceC/?=
 =?us-ascii?Q?Y4LQ2dXjNtPwvuvonC2a1XzNKVDyVnDsndXA5dZLTkBCqq7PTinwDuqTdp5b?=
 =?us-ascii?Q?lfRWNOf6X7pr19lYTInFocauwHiFh4p7LI+HEgj4qgkM65Up00JoXrXqgSAW?=
 =?us-ascii?Q?IVnT9BRGAy4XbNbp/RjL/CJ1V+qZQo43zFuzyEI+Jum8+8AQ1KpnS6D54Ia5?=
 =?us-ascii?Q?+RTCizariZF1eauMOIrUhjaTtLQZLOkNUqustS5ZbSK5D79z52T7aF+/1oRE?=
 =?us-ascii?Q?s4NKXlx03atM7qU9wC0yku1z5iSvdAr7IXms69eN13fNUY1RnR89uuYojzG+?=
 =?us-ascii?Q?BhtkW/MfALNARlNI1LZJQLGPsYpgxqhWIo1WCeINSB9xbUCrhzI6Eg/J0pQe?=
 =?us-ascii?Q?PzHeGLX5QkWxPhFJEdMr2tim1X/WibLYUJYCYXN1hiVjmNOMVAH7nfWiaGgT?=
X-MS-Exchange-AntiSpam-MessageData-1: 5PiKEuvuiePQ5wur/M91x2R3Ly5cm+wZdSg=
X-Exchange-RoutingPolicyChecked:
	KnwEVqhx7/4X7xWELabxXTzEWB0GsY2RhltHdgK2DGvpIOPEHeJBm+8s5H7uK0S2yd7eu12eMYIvfwJrieRhDBB74GaV3/zNu5kMdbUjSSrZhHj6Le9RycC6hkwyqvzeRsDhWVEpSxYOnDv/DORfaCrEYvhDM4hL+9VnKajuXiaCwvW5IHQ0pPnvsQ039wb0QwAnbp/tRqJXhrP7B9FQvjm/p5iSafhuvXhy0Od0QHATheEEx1Untk9ehleVLRbZClo9H1rCa3hlwxR8Cu2nauvpEjfZVrC/i/oeiHw5sWuLJhMgsmZoM9DFM9G+5EXylOANrG8it9P7xf+DfopPRQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bd82a7-9d58-41ef-a515-08df49381b8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:02:24.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHhLTcp/lF5Q9LHlxn8IrZz0wMIUUE2DrNejBPivy53emmA9+Htc6SxepQhYBNzWPrWYSSOdrsoawPZ33u6EMqU0fuqxv0CVyGM/tIfzIA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX/HsD7zYxSfJR
 gGMMmjbzAsTLmgHS/C8QhbpPaXJYeMFjA4Yu6lj0A7FORD2himdQyvbP1CQgZxgzmR0oeps8sWc
 Bq4VKPc3JTSVCzJaevJhnBfbz7FZ4HsWUQaCo9clE72ONhG07YZKAuPawZaKmzDl2nfCXQIJ3QX
 laPICTiQobEaV46h1tUujB3vM4+P10dSR4iGjvA46d3OC447ZUinMR8y9+dojIOphlBUB4fa6lq
 RsUq3s0s4cjCoo3OUoz8AptDUSWreu2+eeUvm2fnJPJpJ8koxCrZMFpEybR5ngsIKoxrpFnjaNm
 qBSSnQi/XeJ/bM3i3weSFthA+X4g4wxaBiJ2RBj/bZVjEM37A1kcQAKQ4XFpb5FhmTNvNGZ6+os
 jUlW+5rNqlkYXNdHJRLtGLHyFO+7CyAwUC5mIb8EbghOYHHsSabQe7ESEZTs0Pn9JCiJmefLVXL
 tNR9jcf59Ry4902hX5A==
X-Proofpoint-GUID: wOm6jTXpuJTgH0zzinXX3aaNbaBIUPvV
X-Authority-Analysis: v=2.4 cv=I8Hw19gg c=1 sm=1 tr=0 ts=6b03f312 cx=c_pps
 a=gw0jr/XWmcdhwQv4PjOuaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=fGQSh6TmI2jUhFYOimAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX01jbuG+9HDDn
 s4OBLPEEOGkdF2LcEz4eHvtkr6p2ETkNwnQwxfk/HPC7PAgDNAGBmu32y3u1FeC3GvBLeazW+9k
 jnIXVyCoYsX1CB8NQqBiIeeeP7O1EESlRLkaK24IMHkPp+x9eaMo
X-Proofpoint-ORIG-GUID: wOm6jTXpuJTgH0zzinXX3aaNbaBIUPvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031

While hunting, every reopen_session() doubles hunt_mult up to
CEPH_MONC_HUNT_MAX_MULT, so the client ends up spending 30s on each
monitor before moving to the next one.  The backoff is there to avoid
hammering monitors, but when connect() fails locally with
EADDRNOTAVAIL nothing reaches the monitor and another monitor may
well be routable.

Reset hunt_mult when the monitor connection faults with
EADDRNOTAVAIL so that hunting keeps going at the base interval.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 net/ceph/mon_client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 2f0181b2566dc..bceeaa3690145 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1568,6 +1568,14 @@ static void mon_fault(struct ceph_connection *con)
 			__schedule_delayed(monc);
 		} else {
 			dout("%s already hunting\n", __func__);
+			/*
+			 * A local EADDRNOTAVAIL never reached the
+			 * monitor, so there is nothing to back off from.
+			 * Keep moving on to the next monitor at the
+			 * base hunt interval.
+			 */
+			if (con->addr_notavail)
+				monc->hunt_mult = 1;
 		}
 	}
 	mutex_unlock(&monc->mutex);
-- 
2.56.0

