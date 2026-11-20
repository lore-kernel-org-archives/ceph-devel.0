Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160131;
	b=mU2hV47sxV43fz6Hhl+a9GQmTUR5y7dZIAzPxB2elUoYIhcaFF5xFDQaldz66bW96PLW
	 yndMgYBCTBX2lfMuBckCcpSaI6M4vtRMs60Kfdw+Upf68PBjmPgklD76fDCDJSvSbMDw3
	 BRfupspQl7FSAq04399SXkdGHx4X2sXjbk4ffaj6liBJzB6kJbWahDvC64KN6qNF3skLB
	 xxbgoNmOjgO6psTgP/lbky7mdsNPfsgwnEuhbLFQz+4e3D5cywMfBGuNRoRzCqUcT/1pw
	 zPEHS2feF9hrI8IE3zpvnOls+JUtd/bymayV2o9pfpRFgZtziuuTA/FSwOn2pPPRDSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160131;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0/G62h3t9Jqry6wzVFlkYgPnkqakSC0vHxdOARtemus=;
	b=HR0c67W5JH1Y0COR9MY3kSG5zKNdSb6fwxeJLJuU7qStinUEHyh7OG96LNGo2nQWOuv1
	 972kVGdH0pqsmznyqSKvhwJ3PLKoGvJkyvcHekASYP2+WUqpY0dPj9r9e/pB0zYWmSBDc
	 wGahF7D6h6bYi8X2aNocVYj5G0IuYnfkY6FoafQP5F0n1MlYY3D62gerpeqFUv9I44vvl
	 uBxso+9QALK7IGirDGCW872iUifxM6vPN0nWi5zaEBBGjxl1OoIXNVcyfVt1eHHT/tT0e
	 ax4bbBjZpTXcRihnXzZhK64v0aXWTIovRT3fUYQ7LtjMXqvlHP3hogfS3VbYhM3cpmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=W8BllGVy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB6606A320;
	Fri, 20 Nov 2026 07:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FB6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=W8BllGVy
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3TRQh245230;
	Fri, 20 Nov 2026 07:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=0/G62h3t9Jqry6wzVFlkYgPnkqakSC0vHxdOARtemus=; b=
	W8BllGVy6+/lYt1sLBj5fex5QXKJwXa1LlZ79h72eO1KwKuagTBo7l/OgJGbdyBq
	zIef3AFYBWHrj6kujozrS/GyULQxfkmyqI2wElbazoIHmiY66IuWyIaP+BGWt6Ms
	YlfbAkXf4XJeL9RMiIQpbOKIEKCHTmh7fpsOaJCFbHhM+BYZFPUuNhyDYzLZ56dl
	gglvsHUE9YW03ZwGsJ97yqSe0hCx/A0DM2pH9/ZGW0W6vQqv6oXns5UOPFOJHMTA
	tSK+b7VM+W6pWvavo2/fseUgvPkCRGhd6Erip5jSyPq9qw+Zs6dCk73oTaEzdtqS
	MLgUjKKBH3AGVXPQ4PJg6A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022085.outbound.protection.outlook.com [52.101.53.85])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8b2k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:35:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXuDmLeX9/isdFKYxyDsSn7jARr3iIKgEfAWcN5Nbl3LIXQ4LLE1vsbAy5rl159UK15TGqGBXMlJp5bAgSvWdrWCvTlTvBCpsy6TBYF4Nnc1EyQPvkYU1DTPethzdSKtz7b22EOiF7MnNzofxI3TGw58+xg+k0Q96fsRo4KLzgOzJPEep09sj8CKqHfmX7/IQh4CpweLvbsRuELc6PU7KFjKFzHtSKDqxKW9pfeSnrc+f42txj98byZNepV2P3gClzuJK63ZrGU5lErMFMJAhklHzTvfqun/dAs531ixnTB5jPYPYTXr3F3ZEOawtlSpXBrRaN3H7rqq2a4NVB/dRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/G62h3t9Jqry6wzVFlkYgPnkqakSC0vHxdOARtemus=;
 b=kZOhuXlqfOU88fGvywFRVxgPUMSuCBMStLZQvi5y9dy6JYxr4h+sIl7mt2pdDth5Mo7JfDGJvkTqJDTAK+rnR7dw2sLWhSc/yOeGIMZRmvcMi69IyELGPsl5pdwn2fXifBXxoUP+iA7YJnwLwNrTXVCdZVSyJiP7HOQpQP3XA/UV0NFpGdQXp5zcxQUMiZS3vUoAM2u5BXf4yiuxlvhA1odcToVPhAantDfWkNamtjVhkRJuLv7jtEpyL5/YEeGcFKflHAFz/tswIzt/QSumHAp1jZlpgnk/fIKmUxEggrD6j1UspBhbU7/Rk7qH3XH37UKektlJJGKoCGAocnEweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DSWPR11MB9821.namprd11.prod.outlook.com (2603:10b6:8:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:35:08 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:35:08 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] libceph: don't escalate monitor hunt backoff on EADDRNOTAVAIL
Date: Fri, 20 Nov 2026 09:34:23 +0200
Message-ID: <20261120073431.53636-8-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120073431.53636-1-ionut.nechita@windriver.com>
References: <20261120073431.53636-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI4PEPF00000142.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::89c) To SJ2PR11MB7546.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DSWPR11MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: f216becc-df57-4941-aa4c-08df46d8cd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|52116014|366016|1800799024|261022105027099003|10067099003|261022075727099003|5023799004|11063799006|56012099006|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5KjHEi6ikxYrGOz+w+uE8K8BgTfoedmSW6ij3iRpu691yDlxwbPxKGVYpAHAC3lpUOsEFMqrpyheSCF7CMSH0U5lRAY326TH6WoU5s9Qae9Xfx7uZzAlSp/tc+NThfHV164X3hei3niEiz5kPu+7yq6smMeHRM2L04gVrp0vQ+F8ibxGuvU88rg6YgVVA1rkrS520wjDQiIgB24OnpgVjMOVZfX6lANLmJzJ6OMSRHQ5Nw2tvZEJsUSOPyWATy8W1SG1fOu+bVlGYtL3L9/K9AuSi3A5HykJ3QvWYpP4TJsFEtVC1M4s1UMnlRWXyPNT/CWPgEzSFeZr33YDQuDzaL/DwbORSQgyZ0C/hL2G7ZsWD9Qbau/NKyy2VijXhTBanZSLjbX9AYoWR3BJoxaRKb62tfua9QE9G1kGwV1oJjnogPk3uJR8m54MQCamaqVb+cICZXHmRImTW/LKVp6pgYgOyd471/MtclyHTZuyMF7JwFi6CFMeddtthOraaRt9VfM2RXRbgluMDwZ5KxpAdb7mhTAWcgT0KjcDKy2OJLadKmAOJHlOFDyK8Y4pY8V7w67hXr/1oR5H5qa4zNaZ5vCrO/z7iKinzcSdTqzQbFX20HkUcArj7+Jp8A6pD5o1UHjHShhq6LVtTa28m5A8HSj5tFrdS0RxVpD1XMCRXF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(52116014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66M+ybWQ55GdDiTE78lDf3mfatG7YA9NYVlffazjqMHcS1W+X6o/KedQkBzI?=
 =?us-ascii?Q?oGLYBGdeD/WgfI1PWulCURrUcT5HkdEXCr41El63BU1/hsr+VDJEZ1sLma7F?=
 =?us-ascii?Q?tTdvzxhunGdVCcgdWXZhBl/WMltX0dvXWfeH2EEZe9HmR5axItQdoexozXeZ?=
 =?us-ascii?Q?oDcvbAuDq8W6yo8xAyS9GrOyiZxP+7PLn9OYU2XvDxzHhPnorfF8bpsAPTi7?=
 =?us-ascii?Q?5UFrOoJLUR1ThxUqXujPtCYPfMtUlYbH2DspYW9e+JceWO/hjsz0AHQweSYb?=
 =?us-ascii?Q?a+myIkvN0Lq4DJLZhLDypld3rEBCusjGfEMFd6tULkYWFQpxynS4MUfXCI3T?=
 =?us-ascii?Q?S1J2qYDg2KhO/cclbdK1xuAa8Vzd884CWFJXdzYG+ONg63HC3ea1m8V+l/2w?=
 =?us-ascii?Q?gMDyVWGcS4xnDRW2CA7e3swABE5R02M9z4wawXlb9a1o8nxbb8D808FQsIpJ?=
 =?us-ascii?Q?qHXWcJAy+R/lR65eIk8unAyP5ZS8le0DuohwwKXeEtil9oQ7GkdP4rT521/5?=
 =?us-ascii?Q?p60gBY2vt/3Jy4FD+9PDY7bNPE1KULzqYhMlOnK7ktcvYfDVI+v45kRLdbYM?=
 =?us-ascii?Q?Yn82mx5oitzrKL6j+J/TN57gHi8XAKgtFT7vOu/mDVbHE8hr+eL2x3OukwTn?=
 =?us-ascii?Q?aViwiaDoWzeU/qZvU6FMIlx1/DSSLFdgDMny/yFPY7W6NvwclAjefwuuK15F?=
 =?us-ascii?Q?V0SiwjVQZrvvbHhtSaY27T8hoVQPpCvdCtc2VLzvASilNXulpEBRk4bhVoZv?=
 =?us-ascii?Q?gx46jREoTVPCxWQYiRzDUZo8kN+Vciit3kvq483soWxrViB6xnYvl+2aCFq/?=
 =?us-ascii?Q?mF33oQMxk6yStAEymeWeaW3yw+VO13Go3jQV+4hUkM1pBw3jer/wdHRQhHUI?=
 =?us-ascii?Q?wdDMW/fDU3BUGjL42bj0cAiJ87kVbwujs/UX372FUpIufRuY/ggCchDKnOtL?=
 =?us-ascii?Q?L6jzoMCiFgk+J9HhwvxYoBNPNBksgUPvu7vGwfvj+qkv2EH2GI8fdZsEn10v?=
 =?us-ascii?Q?IhfSfuuj+o7uCZJxuqTt63muNvkdRYoqonQVMEm+LfL0m6hdAFn5Cfn000iG?=
 =?us-ascii?Q?+kDuOi1aDReqUGHdVLy87IkgWvDdI/raw8ES5VmOi92xBPzeWj5Q/IGW2Mmt?=
 =?us-ascii?Q?cmtzyh+asFZeJIANXzK4A46rEvc1P8GZ/YLArGSW733nKCpPbvUGAb2OisBF?=
 =?us-ascii?Q?QhnFS1U1+V3o5cC2GMdbaTxlGqaixTdAX/P6or93qN7x4cfqTnHbi6v/l3r9?=
 =?us-ascii?Q?OsqUUh9rwBKkWwYrjmXmgx5yY2FoihDvrEFoaGUQEt18xpJmvUwPWhrJiCr1?=
 =?us-ascii?Q?1ushxsTLEkgYdrTqCVUOjKgPsiviR3Bm8/mWkAcW0ODEhZIt5jfT5dEGJ+ia?=
 =?us-ascii?Q?VbWUUHKCDOFhRM2zrBNRNmD2X4fk33GhYZchaflqZL+C+rrft+bwOISgMxi9?=
 =?us-ascii?Q?RlInfS3oG93TnUXq/mDcKjj2BG1EumQx8YxkG4938Nbpgn3qUNsO5l2+8F9H?=
 =?us-ascii?Q?If0BN2xm2/Tj2HrcfRyJy7KGpqGXeFoSGa+tFhR5+cdeczCcpnCyrQk+qAzm?=
 =?us-ascii?Q?HBZ+EPN3yDM4XP+fpg3hvMKe6zjOV4YNk73n4ugiogg6Y6iZN5ciUEHtsQJS?=
 =?us-ascii?Q?pFXI/UKOhxW/xXLwoMSGoFuhLVwhGkkXzYKZeySwV1MAxUpSFEjmHToPWp7Z?=
 =?us-ascii?Q?IzuV+9z7X0Ivg1oXqOEZcXw/nDFu1A5Csw7bnjtj5UfKqJMgNp20ZKjg5Vfh?=
 =?us-ascii?Q?plSotoEQNgZt93gJ6EEA2y1H4EfgLGvZBR+uPE3nl+Il6bzOjlNfrsa4eCuV?=
X-MS-Exchange-AntiSpam-MessageData-1: 0aFx9IJSTe3gT6VPilq0k0RGITdttFzsxIk=
X-Exchange-RoutingPolicyChecked:
	R971cn5YQg5dJYr19PrxIsjH6+a/XbimVgXB69upZz1yM4eL0NivqDQSkIc/xB3xkv10q2j0eJt8YjtNdmCW7TXntg0UHJF6sZjHDLSgd+xCmvQzVkoY9Sj1K898EY2PjrUiXJGd8R1hVB3gDtuJCWNRpzW3/9Ici+dbjGkB63U5UwYJzHUEyykBZPD4q0Mofhzv9Yr1fmA4Bg/G9lUOLnTAeuUmMYQFcOVjI2vPV9j/bNGPsWOO4pVWfxgJxIqlcJJV5fjQhp37hAbMmJivMqkpS+iJBH5xSUA4SOF4RbEoSl0H6dVdlQC+wgaYK7JAaf2ktlxWAyIsc4B9X/r4qA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f216becc-df57-4941-aa4c-08df46d8cd44
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:35:08.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOAkcev78S/1BXOptqZAKLixV+is2hVRPpg+7P4B/Pb0OeVKB+HXsFmn6wZRreQNmNxnPgMRps2zC0LLqjdYbAk6tz+dkrYiZGotNY14xFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9821
X-Proofpoint-GUID: RjMP7VXiLkSkj7Y5grlM2yERJhR0BWns
X-Proofpoint-ORIG-GUID: RjMP7VXiLkSkj7Y5grlM2yERJhR0BWns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX79XDjBtTmMYP
 19HO9WqwVLRuI8MkKm0J7mPcHPTFZK39WQr8wf7UeFjHpEVVPYh9pR/ZUhXslYFKrlSJy3mY2ae
 EdRbb5YrIQbgKcsiede049wkwzOXy87HwbJ9Ltv5UwBbRuzR1TmJIE5vBhKRnQFkX52bMxbarVI
 UIi9m2oH9QSC+4RV6+eIeupbuzncrf069zwODfpqJexIX/6cyUDpHvFWqArtHArUulCKAlqEwNH
 EZnqpnSEvhSxLYK2d95nQ4ltBA/kOBtlzQ4Pp/A6u1OckbPpGCECzfaOzxUX9laOhPNYqjSNJ9P
 q0A1k1nD80KfvG2WuDFMV/8W8UwsO1HwoQE8odzm499JPFJgZtW8gjtXKOQXutRyD76PCv5CsIi
 GXVUSJ0aiCo6LfQ7ZTjq+fciS6vbxQNPRQKuZsMxl+kEZ144NpjcAffh6oSAQPEk3gDGTcvzozZ
 uacuREAB5hVmAnc0QXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXwVY7iiB9lo0R
 zWpo0asecmZiCfnLqZrrVJV+uLmqWzKi7opIdFZlDAgmKqXoIQLJPKj9h+4QzOc3X4Xfy2dsnj3
 F8SC2KKdw374LLbpGiNC5WJLwCMljNwftDW2RqRAnQ8FDDxHeftv
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afff82d cx=c_pps
 a=jgSDuZMfJWq5ef40Xplyjg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=fGQSh6TmI2jUhFYOimAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

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

