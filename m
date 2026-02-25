Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762038E112
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048213; cv=fail; b=JKK5D4H+MvlzQf83N7zecZiPBlInJ8nbIQd/r+k3mVfJDJPOoEaSccLWWxTriV1bhZGzjIkKf8GSshvZeLpR2kO/A8pMWeiS5omiOEgn2GZms1GGjOWLReHapwBwghp1ivxe+t6gzKd/3Y727W/TbNmz13cIg/NfGljOKxiL4zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048213; c=relaxed/simple;
	bh=8KqYqO2zXswKy4HZnNrURueJrTp3cMNA2UCUp/n7mEI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=a/HZCDCNSBgEWiA0iSKlxZ3NXn9xnbQ9IcNLC5I010qoDZlb18htvkqMZmuNqSX7o/sszJ8tJVfsc/6/pmmnUR+luPL70/GRkOTYkiNuL7eS/Mn0eVx9arVgqv3S5VMokTevKr4sWZXsBfVXu25MB9AwzS0wVAhhmgTuYFKP21M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=taK6hGNy; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="taK6hGNy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PAcnhD2283044;
	Wed, 25 Feb 2026 19:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=8KqYqO2zXswKy4HZnNrURueJrTp3cMNA2UCUp/n7mEI=; b=taK6hGNy
	2Rq8opNMfHLpyBTexUgnY4XWn9PzBq6nDGzqO2OEzLPkWQpQ8P0n8IJo3cKIQptl
	Zj1AHBViZ+0SJvIrqdt2wxpeZo/Wy31tIioKKxobwytVYA/qGhsQZzoNcPVxNfRt
	ULB9YmHIvpIXSpv7HrmX/bol2bN7ngigjfxjF16WSQfXjXzBUgvIpRjLSu8taArp
	pzOxgh1jFfvWhvS3NYOTWJ1MWHD84pzX2RnJeS0Prww8V9nka4hZZ73S635S4fdE
	G64UrCr8Ebjyb6vMdYUaP5i6QSYqxxn+19PhY0ANPWwLXIR1pVYqacPN5iA+zAko
	wYAeWLffmyOQ1A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf47227yb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 19:35:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkzwxXD3g9MvZ2zmzHLL2OYxEp/vBP8ohcpbB8GLSLnEwRANPHKb0qe+I30ENVSrAfMXWmRiP3n95BW6ms38NOPKVZh5YbZGu1RW7jCUzhz2AtFs3PE3MH2D76WG6vKAgPUs5L6RleKyuDUfjO6Po8POKWXhwiTkeSdssDwbydZU6FEK965bA3DFESAeQZZFg5V0GtBWngYgDm3JxCTojUvl0GuTw5D5IWw7Skkfr1YVrdw9szVlrNb7+WFggEPzZw7SS3S7oBWEdMnb3AzFoducAzfW8p7r9FDyBHrPIH1oRbpWM75+84RUvIMa+Cdx5jaznukf4jf/4zLTqIggZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KqYqO2zXswKy4HZnNrURueJrTp3cMNA2UCUp/n7mEI=;
 b=nKsZlhT/a/05Be4syXTAA3KY1rqcCebQ8Uala6DGGwq634s8kJHDN9SKbH89FcCgYa44/REqlKscRWVrlRVBjdTfoBc/sjo9LiaiG18ZYd/07QuOks7OQjhBQ1FRE51BqDqKIdcnmNXqdPbIbJ1n22Q1QhCTETqJ/Cqz74m7BLYM4YazlSHGaSWfnXwiOIW8pg99DJjbdO0j4UYHAcGnzv0Fix2hTlAlba4zImHtp+4s4eiBQ66lW1CMki+oQcwZYFSsCvRduCn3+jaDT0sOfbN72fwcYbihtmnolsPkJEVI/co8GP196xmK8RFENhUJEtOtbSOhbwV5f6MzwZtYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL3PR15MB5483.namprd15.prod.outlook.com (2603:10b6:208:3bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 19:35:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 19:35:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Use u32 for non-negative values
 in ceph_monmap_decode()
Thread-Index: AQHcpjBXiP6KV60K9EOUu0Reuz41ILWTz2iA
Date: Wed, 25 Feb 2026 19:35:28 +0000
Message-ID: <297c11fa7f42e2487266ec3c29e581f4ffda022b.camel@ibm.com>
References: <4d5abe5c-2f93-4359-9aae-38f21ba0485b@tu-ilmenau.de>
In-Reply-To: <4d5abe5c-2f93-4359-9aae-38f21ba0485b@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL3PR15MB5483:EE_
x-ms-office365-filtering-correlation-id: 524d764a-4491-42d6-ad18-08de74a50816
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 AjsdC1/XjISwXgr+LZFcMu38wpQNjSQF0DpbQ6jr5i2e2d6l5f1fW1ojrn1WJetUCalYaHL1geFd4iudGTbDivWNu8jyRb3toaX0rk7KAJ0bAoW5on3h3IqdgApu9jnHDAPbB6JQRMqNPAnKB8IfQjCo4fIJmH3jj/qDe9rd2ubVAo1Vshy3w64DvV2fUpdvpdi3JjPbP/w+rhEDjgzrsG0usmy6hiBF5AXWfOYNEuokSJdhAJ94rEONPmDwc3D2+DvDeuFzpD03KRHN7sd8O9oBlR2HDYXYekdiAOzrzJu84r5eyYvYCW1IICiRbiiVeOO6lV6eU4fceqq2sPY6mAXiHoIcRGItlX4f2LOtkZ7R7wK2xj9zkHlVZYeHY57j1aS7eynsSUAvDvEaVL5kEHsDw5D4vzwhQUcr/rtf2Jjy/oMbIP4Dfs0J/7o67d+k09Y1TubP2g+WbxK++EWLOyZ6t5hakCTdKG7qYy9zWOIWifnHBHp07RYrfjrnCk0QLICT7FnMkKm2TQ+0i8vZJXN8KBNcHaQ6IINuORUecVUj1n9KIgYc+VwQNkAcEySqsGHUVLQIxIeHfOA0xaGdCpB5etUckgCsW0BQ5yoxTFYcgjPROZ2TnlOx+jcFeMc0fOqY5Y2f6w+K4hyBvP1bJGHLXK3k0gGZe7ld78G+NG0rb+5KSWDZpc4/ohaX/5TH1v1LRC66pCcwF9pOgyNaroeYG/A+QwQ5xC2Xjxj/F1sW+/jSRiFmSiRnKLad0KHx4Lk/bz412Ybvdt4VrMEDhocilhmRgWmt0s1p1sWHLRw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1J1elRnc0ZpNjNNVVZWZWtENU5XcWNhYUdEbG1sZW05UVQxQUFqNVUxL0Jt?=
 =?utf-8?B?clJibHB5a2dXeXRzc0xWWFc3aWJHMndmM3gwMmgxMWxYZEFGTmNxQ3pOWjBV?=
 =?utf-8?B?bkQ0SWtnSUpIbUk2UjVpVVBGcEhIbGFwT29wS3pLMVNYY3BoS3AxSGZRVWls?=
 =?utf-8?B?bENSK0k1aHo2MjBVbEhrSlJQQ0Z3emFGRURPcDlhNU02blRTUncvM3R5T08w?=
 =?utf-8?B?SkJodEh3QmNJYmUrWHJMRmk3TUk0alZRZ3BqRFFlbmoweDRuUzdvR3EvYm9q?=
 =?utf-8?B?Q3psczU1dDlpdnl1Ymx2UkMwR2JSRDlWKzhNRTFBNHptVjVVNHlnTnVyblg1?=
 =?utf-8?B?Rjg1SGRwM2hveUJqSHd5Q3BYbHVpYVpjK0ZKdStlNjFuNFBESEdkMjE0YTFV?=
 =?utf-8?B?Qi9uR1Bsdll3YTZPNiszNnE2OTZoNFYrZmxsWi8vUDF6RU9IMFRqamdyb1Bu?=
 =?utf-8?B?ZWViU1lyRkNkSld3azJsSEV5RnZoSk12NWlWQTNZcFFkcUJCZ0xNSHRDRU5l?=
 =?utf-8?B?anE0dFhacUtHZjIzK1M3YkJmeUN2a0tMaVoyTGQwcVk0ZWRCcGZCTUFpam5p?=
 =?utf-8?B?UVZaRTVGbmdsZTJvUm9tbmZzVFFwbHNWT2FhemRqZnRKS1JhMU5HT3ZVTTM3?=
 =?utf-8?B?aGFYeTFmTWV3eTZvYnUwRzZlR2tONnlOWTlSNkVkZ3BocjJ3VE0xK1VyN2lq?=
 =?utf-8?B?RTRnU3kwcVJtZE9yT1diNGMvcjM5MWhlVm5IYU5VUDNRVFVNRFFEYnhZL0tJ?=
 =?utf-8?B?WlNDeHQ1ZEtXdkVQRENwYk85M3ZSbFNOS0RkOGFOMC81UkQzemNPYTAxMjlR?=
 =?utf-8?B?cjdXaW1lek1KdlFDc1FOQ29JZlFNaVhzRkl2T1FCZlNiZndVTE9WdGFLVUFI?=
 =?utf-8?B?M0ZKSEpwUWo4ZHA5anAva0NidzBhRDk1NExzclRFdS9JZEZKbUlTRlEwRVFy?=
 =?utf-8?B?a1hRUG5pOFdqQVhvRFdwVUtCYnRZLzdPZXNMN29hM29mOGhraitIbEYrR2JR?=
 =?utf-8?B?QmUzc05POVVRQm50WjQ5RVAwQUFMbHZocWw0V3VrNmIxRzliS0hsODdKUkpK?=
 =?utf-8?B?VkRYNnZYR1lsU1l0RU1wbW94N24raTRQZVAwZyswV2FmdmZ3VFkwY3BCSUQ1?=
 =?utf-8?B?eWxiajBtdFZYMisvVjNBM0kyc2V4WDk1SXlqbmRvcWkrUnZtQWVPc1FWdjR4?=
 =?utf-8?B?c2hIdzJMd3U0WHdPVzJMdFc2QkY0dXBxQUhHTjF0b3RabnJtUEk2MGQ4VW1Y?=
 =?utf-8?B?Q3gxdUxYd0JMQm8xM2FVZ3puVms2Q1JBdjJTZHA2Nm9YWGFLRktVellsb1Fz?=
 =?utf-8?B?YXJmZUI5NGtPZGI0Q1Z2U05pVThzWGI5TWJXcWliaDlqWHBrN1FBajYwTERz?=
 =?utf-8?B?TzcwSUlUMVF6WUhNSGM3RERnWEZGNktFcmlSSW1BeUdVSVJwRnFwWE5JenhH?=
 =?utf-8?B?aG0wTmF1OUpySzRRWkx1OERndEY4Q05lZ3ZYMXMwNWRWNDEwSkpvSWJMaEFP?=
 =?utf-8?B?cjRCOE03UExsMXZNMTlScUh1UUlLOGZFbzQvandxdmRWdFJaOXFCY2lxaDh5?=
 =?utf-8?B?d1JpUUtzRFBNdjdVVDl5VFlDSnlLNEFOeDVCdmZVVVpsdHczTnE3UnhrSXhj?=
 =?utf-8?B?czhKcElJLzlCQmxVZHBKSUVPL1dsRUVtQzV5SmhQbUNLYWF1RjZ4VEVRZmVN?=
 =?utf-8?B?NlZSY3BOYW92bnhOUG8xMEZjb2I2aGt5OGZBSWc4dDUrZmlZMXB5Z1lxM1Nj?=
 =?utf-8?B?bnFSRXQwUzFQSEVvU0k5eThaVHdQc0xubjRjZnFVRk9ISGRkLzJ0S25KVWlY?=
 =?utf-8?B?dkhYcytjZTdGb1Z3dmE0Zkh5NzFhOENaRExYMmlxY1piSmlDdlU3TDZXanpz?=
 =?utf-8?B?cWhDRkdwRDFsaEZTOWpZOUh4d29oWDlhanJZWTErcUhwN3Q0dlQ4S3plRXc2?=
 =?utf-8?B?Y3VIMW9CenNrVGxDNGRlQktEZ1NrZVU0Y01vK09vcmZZZlBjMWlxdS9lQnpw?=
 =?utf-8?B?OFZIOWwwQU1qOWNsVUFFS01ZNlFINm1jWGRIT3ErSWNySjNqcUdlVzFWYStF?=
 =?utf-8?B?dWZHdDRWQTc1b3NOVVl0ZWZDcGVRVWdTblpVeWRKdkdCY3BWbFczMTVIS3Ur?=
 =?utf-8?B?dER1amhkWlRycjJmRDRBUEFBS3VDL0pCU25oOFFsVGkyYkY0ZFRZNDZLVU9a?=
 =?utf-8?B?UHpmZml4M1JtZjRFZDNHeUJqcG1od2ZralR5aVdlK0daais1a1RiMVFHUVZT?=
 =?utf-8?B?MEJTK0J4ZEoxVWVFRm9KQ3hjOTR2S3pRTTVEVkdkWGpQb2xCYkFldlFoRkN0?=
 =?utf-8?B?Snd5VklmTDVBOFVUUDFPTTl6d05OYVRmTjNWWE9jbFpUb3MzNy9UN3k1UE5u?=
 =?utf-8?Q?edajXUMFTUYmPwUV1xDsk3OEU9Xuof2DKG4WU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50BFE443A7CF13479180EBFB458D5FC7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524d764a-4491-42d6-ad18-08de74a50816
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 19:35:28.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OfmWzo/cADr1agyaDIiTEZeTyT9bTc6TcSNyFz4zPZuLPvhzQaMpBq/6J+3UFr8o8I64fWXEHuz/me+H+IVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5483
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: c1QNdGPuKhHnwDEk3KhC3XtJ8upEqqkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4MyBTYWx0ZWRfXwHgaHJK7HdqK
 lH6o+yBGYzER4BCw2xaULCj+Z0IRiSSZPTQ/AxEPOlw+6VN/jRRimO/yZua1baudxYv6+GmEizU
 3XVFUXbyikv3z+fPcxE3SNRiyl7qiF0u1zqhiY4Wv1NrqrFCz713rBUKQVoPfW9J/fhMm7bIRwg
 ydU7eoq5pXwOKNWtXVwSY0SaxRX8GpQy2B6V/Dir98/COnonup57xw3f+VY3nrW0IcqcNqz4tFc
 Y7qtjlojCDcPu69HDCODp8VMOyW5Xb0/gWVZrnkxX05wdZBuNg4GN+DEtxrUetwLot9y5tZXpcE
 dZ6PAsT1wswcQh2k+lY2rZLnk+VTi8FKkXLKnyRTckBlxw7rVQWYlLaCBr5BDuzIxXwb+IxSPLx
 3P7HzT2z6AeCC3R1HLEDx6A1fJ5/slMvyAbouBXZICIXM6DB3c46ySxpeDd71qBfxN2sI14zuE4
 7qidMNM+hnifxk5GZwA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699f4f05 cx=c_pps
 a=/+xYJgQt7uUW31a/4HdwMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=fh1beMVxGrKVzQzo-n0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AIIveNjqPTLqr2KSP3PpLmL__j-1k71j
Subject: Re:  [PATCH v2] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250183

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDA5OjI1ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gVGhpcyBwYXRjaCBmaXhlcyB1bm5lY2Vzc2FyeSBpbXBsaWNpdCBjb252ZXJzaW9ucyB0aGF0
IGNoYW5nZSBzaWduZWRuZXNzIA0KPiBvZiBibG9iX2xlbiBhbmQgbnVtX21vbiBpbiBjZXBoX21v
bm1hcF9kZWNvZGUoKS4NCj4gQ3VycmVudGx5IGJsb2JfbGVuIGFuZCBudW1fbW9uIGFyZSAoc2ln
bmVkKSBpbnQgdmFyaWFibGVzLiBUaGV5IGFyZSB1c2VkIA0KPiB0byBob2xkIHZhbHVlcyB0aGF0
IGFyZSBhbHdheXMgbm9uLW5lZ2F0aXZlIGFuZCBnZXQgYXNzaWduZWQgaW4gDQo+IGNlcGhfZGVj
b2RlXzMyX3NhZmUoKSwgd2hpY2ggaXMgbWVhbnQgdG8gYXNzaWduIHUzMiB2YWx1ZXMuIEJvdGgg
DQo+IHZhcmlhYmxlcyBhcmUgc3Vic2VxdWVudGx5IHVzZWQgYXMgdW5zaWduZWQgdmFsdWVzLCBh
bmQgdGhlIHZhbHVlIG9mIA0KPiBudW1fbW9uIGlzIGZ1cnRoZXIgYXNzaWduZWQgdG8gbW9ubWFw
LT5udW1fbW9uLCB3aGljaCBpcyBvZiB0eXBlIHUzMi4gDQo+IFRoZXJlZm9yZSwgYm90aCB2YXJp
YWJsZXMgc2hvdWxkIGJlIG9mIHR5cGUgdTMyLiBUaGlzIGlzIGVzcGVjaWFsbHkgDQo+IHJlbGV2
YW50IGZvciBudW1fbW9uLiBJZiB0aGUgdmFsdWUgcmVhZCBmcm9tIHRoZSBpbmNvbWluZyBtZXNz
YWdlIGlzIA0KPiB2ZXJ5IGxhcmdlLCBpdCBpcyBpbnRlcnByZXRlZCBhcyBhIG5lZ2F0aXZlIHZh
bHVlLCBhbmQgdGhlIGNoZWNrIGZvciANCj4gbnVtX21vbiA+IENFUEhfTUFYX01PTiBpbiBsaW5l
IDExNyBkb2VzIG5vdCBjYXRjaCBpdC4gVGhpcyBsZWFkcyB0byB0aGUgDQo+IGF0dGVtcHQgdG8g
YWxsb2NhdGUgYSB2ZXJ5IGxhcmdlIGNodW5rIG9mIG1lbW9yeSBpbiBsaW5lIDEyMCwgd2hpY2gg
d2lsbCANCg0KQWZ0ZXIgc29tZSB0aW1lLCBub2JvZHkgd2lsbCBiZSBhYmxlIHRvIGZvbGxvdyB3
aGljaCBsaW5lIDExNyBhbmQgbGluZSAxMjAgeW91DQptZWFuIGhlcmUuIDopDQoNCj4gbW9zdCBs
aWtlbHkgZmFpbC4gSW4gdGhpcyBjYXNlLCBhbiB1bm5lY2Vzc2FyeSBhdHRlbXB0IHRvIGFsbG9j
YXRlIA0KPiBtZW1vcnkgaXMgcGVyZm9ybWVkLCBhbmQgLUVOT01FTSBpcyByZXR1cm5lZCBpbnN0
ZWFkIG9mIC1FSU5WQUwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFw
aGFlbC56aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4gLS0tDQo+ICAgbmV0L2NlcGgvbW9uX2NsaWVu
dC5jIHwgNiArKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBiL25l
dC9jZXBoL21vbl9jbGllbnQuYw0KPiBpbmRleCBmYThkZDJhMjBmN2QuLjk0YTdhODJjYTQ3NSAx
MDA2NDQNCj4gLS0tIGEvbmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+ICsrKyBiL25ldC9jZXBoL21v
bl9jbGllbnQuYw0KPiBAQCAtNzIsOCArNzIsOCBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbW9ubWFw
ICpjZXBoX21vbm1hcF9kZWNvZGUodm9pZCANCj4gKipwLCB2b2lkICplbmQsIGJvb2wgbXNncjIp
DQo+ICAgICAgICAgIHN0cnVjdCBjZXBoX21vbm1hcCAqbW9ubWFwID0gTlVMTDsNCj4gICAgICAg
ICAgc3RydWN0IGNlcGhfZnNpZCBmc2lkOw0KPiAgICAgICAgICB1MzIgc3RydWN0X2xlbjsNCj4g
LSAgICAgICBpbnQgYmxvYl9sZW47DQo+IC0gICAgICAgaW50IG51bV9tb247DQo+ICsgICAgICAg
dTMyIGJsb2JfbGVuOw0KPiArICAgICAgIHUzMiBudW1fbW9uOw0KPiAgICAgICAgICB1OCBzdHJ1
Y3RfdjsNCj4gICAgICAgICAgdTMyIGVwb2NoOw0KPiAgICAgICAgICBpbnQgcmV0Ow0KPiBAQCAt
MTEyLDcgKzExMiw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tb25tYXAgKmNlcGhfbW9ubWFwX2Rl
Y29kZSh2b2lkIA0KPiAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4gICAgICAgICAgfQ0K
PiAgICAgICAgICBjZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwgbnVtX21vbiwgZV9pbnZhbCk7
DQo+IA0KPiAtICAgICAgIGRvdXQoIiVzIGZzaWQgJXBVIGVwb2NoICV1IG51bV9tb24gJWRcbiIs
IF9fZnVuY19fLCAmZnNpZCwgZXBvY2gsDQo+ICsgICAgICAgZG91dCgiJXMgZnNpZCAlcFUgZXBv
Y2ggJXUgbnVtX21vbiAldVxuIiwgX19mdW5jX18sICZmc2lkLCBlcG9jaCwNCj4gICAgICAgICAg
ICAgICBudW1fbW9uKTsNCj4gICAgICAgICAgaWYgKG51bV9tb24gPiBDRVBIX01BWF9NT04pDQo+
ICAgICAgICAgICAgICAgICAgZ290byBlX2ludmFsOw0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5r
cywNClNsYXZhLg0K
