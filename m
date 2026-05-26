Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D4377009
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824139; cv=fail; b=XplmMKzVCKLMZ2M5V8qEqW6ZpsV+Xfi8nxde5Wo4evNT0/3Dzcj8XqmzILVFxbQ3alrs96pcHhDyKwoDRMQNy9wiF4hF70F+V4w2QorVl66DXcRNz6s03FULM0Smz5vVDwltwTeiP2Cs4qBJO7FI41AKgZJt5QeYQ4hJQgSf6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824139; c=relaxed/simple;
	bh=oEzEQ5f10dGrEFuRGLV8GU53E1dNUI1Kfl2eN8MZDMY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ULWaDbXrTKfkWK6ik/46H0bbm1cLP4NeaEwWdiT1hybevo3MA0fdkbPDLHgD2u35Zwi7PjVS8WqiibIbxxkXhRS/E6UQ9CP7llVzV3+3kCvwzeZF3fk+lHZR51Q9/MdUyRFFlqLDs3tkL2cG3m1fsjEMQhzoorm0mA8w5GnLa70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rI64aOWy; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rI64aOWy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QEqCZN139021;
	Tue, 26 May 2026 19:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=oEzEQ5f10dGrEFuRGLV8GU53E1dNUI1Kfl2eN8MZDMY=; b=rI64aOWy
	BHLYHXT3eMyzZpCDVSou8onDns+N49x1fB3/WAhpoi+gvETHXpG/so3a5QMLlc1Q
	jWs7tcFDpxlVpCnu2xvX71Zr2/xNqD0h0owWamJaMm0V2jIRJ9nFHd/BqAmAsRvG
	k97HDNt0YwQwyGGYNjZdz9tVgjBcxiyq6vkXZXx6lYDIs+Af/9JxOf3DbvZL7J+b
	Um4N6yCUn7L/W9TVubaGr/b7WORzzgFrGEpLGJ9GGH/qCpGvoGuTlHT13tKm1Twd
	SDrhiLjt+YwtjwCihuz8lrYeJ8s0Obi06CfYo/NsfYqkAf9CgtdPVw8oPyBDZA6X
	Efya3hnUpOKEDQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdcxr8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 19:35:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rjs9YoPEYo3AmN7wJ5GlR0IvZYQDtRh/mQb9qc3gEBwOB5Aqs+k/z5c1x8qxAhPIhwQO2eCfLqX7m3Q04Ru6quLKSYv0OgjNty1McuImhBGoM6FAelrBo7WLxrzXEwNuK0phKZB215GwPJdSq2QABhIXe3RgPr5hdt2NQkCx+RI7uHWHmZCkDRBDNB89LFPpO3ZD/A2TVBQms3dbdGK2tVaKn90bIkmHuMDDtMfVgfC6mPMUNHDCZocQB1ENCVUwlIirDRtmju9OydGpyUPs9GlaIOOx3VanY//jmwMMK8O67zDCp3IJj2rT5lQogkwlOkxlBb/j+gVBtcczz3xDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEzEQ5f10dGrEFuRGLV8GU53E1dNUI1Kfl2eN8MZDMY=;
 b=PnSD72fpiAgS6q9vG7LIytvpzn30xjh1P5yw9M5zM5VuUyZhLyAXo+kv8mXK3rBre05Cr3nlve9yeYsAXuKzcXw/peKL4EInoLoXTQkVZs6KSg5fH1rKmqznUm5Qyxz0iJTHcAr5kToE8O/JeoApbihq6hUYtj+bc8v+nWO3P8mhs4mM4svTBwX5MhuAvYPXCwz/YMX+rT25hhdnOIsByj6bd+Bf8Jb6//hmiy5qXpgM8U6QnPEeh/jfZolLoOEe8N1j5DkZu0WmtW1YIFR9k7sp/S8SNkm+inlOncurxxOnTBFdR4/p6CvmMvINAAMoj+qe7ihFeblasx9Tm0NZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB5284.namprd15.prod.outlook.com (2603:10b6:806:23c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 19:35:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 19:35:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Use u32 for decoding osd indices
 in decode_new_up_state_weight()
Thread-Index: AQHc7TDtl+h2XVHH2kqqqiIYZl2zcrYgsycA
Date: Tue, 26 May 2026 19:35:13 +0000
Message-ID: <7f56749df89d5f665e27098d4b47d8aaf7fbd468.camel@ibm.com>
References: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
		 <20260526154533.3467475-1-raphael.zimmer@tu-ilmenau.de>
	 <a1588473555d3b8887ad755fa7c3ddaeac508675.camel@dubeyko.com>
In-Reply-To: <a1588473555d3b8887ad755fa7c3ddaeac508675.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB5284:EE_
x-ms-office365-filtering-correlation-id: 26606203-f3aa-476c-02c2-08debb5de880
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 B6kMeEZusR8sunzkht3yWn3cfzbEqadfPU0sJ3qNdykSEcHeb6Z7sj8M/s4E1xpldFMVOsGc/S/aM94UUJ2he3IUl2jb/sAPoNFEnrdisSyW5jqnO/VuaSXOV/f/QfUJ/xlWStpWHVxGx83o4lnumwOxBllAZh3RtD93w6nTeXH3B6hEwNScJuykkCAawrHncSbH06ZMMBvxd7lNpf4vFOdT8oEF+KYzIQwmyfzQdBDt398ZmAXuS4Fa3haGUCCQzIxsUTHYwRQj/pv70zyYwh7vv045YKtYcwMWMsZrh3a6qspXKA7v8RjAAYuANrMwBlUqW4fS/Mlt47EpogmE6tXqNPsqOMFsMeD5cBfBSQIKKfa8Gs/MvBQqbiDMQ/5J/IlyNzBV834ljmGvo/gsCqg5GgCriTnkP4ZDRMIfZGKTt1bBfuygP9bibTNUhA7xnLafKYrZ4t+DiMqUcOMfz9FpMUs4euP2U0Id0pe+Op+FVZZmPRWyQbCZHWVYtUDO9xAIRCPUmxletRYUUsL1biYEW7Vmi/PtGe4G/0G4hg+szLCZ8Z0nkNWE1C5zS3TkQaYet49tNNoj45JE/+LpI/MUb5of8SD1X+jGhnkYd59jzdZeF3iFgqNwQ75upVB3fZSdTeYWVVaKuzGWLzTPgRA3QwGyJTj5do0It0dOzsN8BnQb+O1NlbYNTVHQ5Obk9NVmX3LokVjTA4HRMrnyiU9DWQSLbcO1QO8rYj2yxxn0cNNY5tA6ISZD/cLBU07D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXVkWDZPc21GSm1QZlBRZDFjVk1tVXFWam5Db2wxZFNsdWJXMzQ5VzVmdjB1?=
 =?utf-8?B?TEZmMFJreUovOXZaTjNlUU5CRUtWa1hXV0FuUWxCLzlhY243ZjdDT3R6SHYv?=
 =?utf-8?B?cDBBaUp3UERITGxBYnE2TEd4dFZrMTJGenRCTGpqZUpZQUNDdk5lVkZlQWZM?=
 =?utf-8?B?Yi9pSjN3OFIvUm1ET05ydHEzRjBlN3l3bEFKK1d3aFhMb2hlNm9wVHErS0x5?=
 =?utf-8?B?czRDK0R5b0xZaTlJcUtxTXVuVzVzWXhqMFhqbW1MWUhkZStZN3lTZjdqdTcw?=
 =?utf-8?B?OU9CeEM2WDdtMG91R2FsY0M2K1FXQ2xldStDMG11ejNJSWtDV1FyYWxDSWZt?=
 =?utf-8?B?Z1VtOUIvM0VvbDZuN0RxUzBVN3gwOGxTL3ljMFNmL3BpNy9mbWRTeFcvSUFH?=
 =?utf-8?B?STc5ZmxBR2FjRmFwS2ZBb0owYURXSmhBeVczYWgxZ2NBZWI5VjV5aWZhMzZH?=
 =?utf-8?B?cXlLeDU4OFRucUxnYTJhTFVnTWh5b2pWZVNNM2NMdUxZQUR5V3FUbGtsTXN6?=
 =?utf-8?B?NEtXMXZYTTQzN29GelhINWRrNmg3MklhQ0NxdG9PMXg3MkhIWXhxd3c5Y0RF?=
 =?utf-8?B?QXQ0MCtBSHh5bVkwZlgwVmZLQ0hReFFRUHdHS0lEWDhDemFiUUJCMDkzQmFZ?=
 =?utf-8?B?OVcxbGJyTExMZXdseUU5anR4SXZCVE0xOVVhaWxiQ2ZYTUcreEFXS2lrVmR3?=
 =?utf-8?B?b0dBaUZsRmZjWThLclpQL0hHWjdqQVpET1gvWUkvVThUY3RLQ2RBTmw3RmxE?=
 =?utf-8?B?NDZ5eXI1VHlYSXM3WU1lbFo3UGYxR3VBalN3b2wzbXl2a0FaWmQ3dmw1Q1Yv?=
 =?utf-8?B?d0lDc1hZMXRvMXZhTEpXaUwzaFlsRmhiV3pucmU4YTRueGE0K3JCL3p3eGhr?=
 =?utf-8?B?UGF2V3h0VG9qYVRKL2tDcGUvMUUwRklZd1NmTDRVcS91dS82bXNXdzEwVFdQ?=
 =?utf-8?B?K3U4MXlRVjU2dFg0SWtXQ1VOMGFycFVlOUJsQ2Nlcm9xOHZ3dzliYy81VFNl?=
 =?utf-8?B?dFR1M1pDNFZjOEJoanY2SGYxYXg3dkVBdXBBdDRmWks2bFY2QXc4cFQxOHQ5?=
 =?utf-8?B?NGx2M1g4MGRGRkNSQ2JFYjBUZEJJOVhQYkhIaVlXRW5LVGZQUWtxY0RGUm1o?=
 =?utf-8?B?U0szUXJ3QlQ4eHVMOExYb1FNRk4vbkU5MXErVTdlczRkYnk5V0Y1TVlUY1Br?=
 =?utf-8?B?Y2lWdEc5WTVnaUZrTXZHVUtOdUJvN01ka1lvNk1peVVkMlovY3dFTjIyTllG?=
 =?utf-8?B?Q21oaDBEdTB4aUR3SldhQ045TytGT1FwdzlaZGFFU29IN3ZOc2pVcHYweWVW?=
 =?utf-8?B?R2FTNHZGaEhISEpVU0VrTDdyWVphUVZDUDVvQWIyMFZhaWF6ZUkrWkpFQmFV?=
 =?utf-8?B?cDZyMVpuSkdCUnROUkM3M2lNSlhtTURMdU94NVByckQxaEVBMXplM1o4a0k5?=
 =?utf-8?B?NDUwS3J5alM1M2VXcm8rZU9yNloxbmlJemZneFZMVTlTYWhTR0lIMm8vYnJQ?=
 =?utf-8?B?ZGQzMkZEK1hXdkhzc0xXVHh3eEF2WjkyanRKRWx1Yi9wWmJoNzJCR0Y1Y3FY?=
 =?utf-8?B?K1FDaGJINys1dVlackVIT2s3clZ4QjJpQzlkSFNvQWZOdkR4dzNOTFhpUWRo?=
 =?utf-8?B?cnlxSm1Fd1Z3MWEyWXpFanl4T0VrNG84aEFRcnRCK3RrTnQvQzJ3ekJ6dFdl?=
 =?utf-8?B?emF6cUhGUUNwNlh4NS9GNC9PKytqbkFUd2tSZTRmU0RRRkVEb2RiSmhiQXpi?=
 =?utf-8?B?Sk5NOEV2TWd6cEo1elJYd0x0QjJXeGdTMkxYbDR5ODVSMktoaGJZQXdTRkt3?=
 =?utf-8?B?T3A3K25OZW9mNDJ4K2xjUit6V3VucHZxampOVXBjaUJRY2JsSks0V0RMRGti?=
 =?utf-8?B?OGZkWDZmcDkxZlJMTUZQRmYvbXZVQkVvWnVCZ3dKRmxCSmQ4YjE2M1pHUW5I?=
 =?utf-8?B?dlBVVkhqL2M5MVJaWGYxMUovcDh6ZlR3RlVHeDdhL3lFdEZuSEZKYmlqMnZq?=
 =?utf-8?B?L1VkaCtjRWxoRnZMb1dKS2drSWJiMDJnbURSa2tnLzJvRFVBbnplRUJUVTl5?=
 =?utf-8?B?b1lRb3FGMmxaTUQvUmpIaW1YQndQM0I2bjhxTkl4M3oxcnZaZU16MlpOSlBx?=
 =?utf-8?B?cHFETDBpcWNqNTd5anR4QmhBMTJhRlNQdVZ2cXU1UVI0cEdpeU8rbU9QdkFX?=
 =?utf-8?B?SzVldXpRRXV6SU5HbVVsbjVjQXYrYVg0QnVPUmcrUWRsNFpHbGcwbThTRXNk?=
 =?utf-8?B?eitvdStSL2JZcHM0M2p5bWNMTHd4Rit4UUZaNHBXdkxYUzRlL1RjK0ZLR2Zy?=
 =?utf-8?B?NjVKNTdsVXVGdW9tZk8zTmlBSVpha1JadDdubkplMkNrSE05eXRsS3l5dHZM?=
 =?utf-8?Q?tKyAgl+sJ/YapZ5xwuiN4b7kalwsDxSj+4Abq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85340700A9378F43A0EBA8723EDA5FB5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	btVdpsGW8aLYGvGGiSfiMJJxdZhlI1fy/Ao6c9RM4LqDzG5hJDGkIWxnW2S1N3ObYxFRYUw51JuzkdJJaenmvYFtzV0keQGKmNch3qgP9nx3MsGQosek4/hVU8MwHMHb1A8qTsW/95aJ8Ego/ECMGKr97ITIpiRNsRLqbH45HeT7mmPibcwMQyNvNUB4/bLXKjQ5EfM4M8tpLoSmB4mppPDqPkpkuWSzCooXovs4XIabDYHA8Z6d8B1nhiBpgFFgdvqZebaF1Sv5gPZPI5HZgqyHJSVfXyoosI6k/tK3x7rAeWdFzgSmYDgzaaQKExT7oZII7eYDxNUvKD/+IV3nbA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26606203-f3aa-476c-02c2-08debb5de880
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 19:35:13.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJt4E0ceSdisKmKEESKhIT5RVMCHnRdlJctIjVgfWksV/ErvCEjat7q6Kzay9bVYZuLnNELAX0z59/2nPg62wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5284
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a15f5f8 cx=c_pps
 a=4PCWzz9QFLYZoRw/GV/NtA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RUXNcOBllC8Pj8p2nPAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GCwPvptCoKk3HyANkB2k_w6joeW3-RNO
X-Proofpoint-ORIG-GUID: yPCIEtAEsQu8YzlWVgEHL3kZfnDqDX8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE2OCBTYWx0ZWRfX+NXmnRtc5pxG
 hADuRedv37i0rPIAgOdWeFJ0bJRNTbnxbhvRKb9FYkYiouPFXJUgooebyiyL2Yb/gstyP4EucCX
 +ei9+8P1cjeaM8+lhh0o0wjo5BpUQvGT/8IhhX49FqLWhJ/ZpVg3JvKli5qmWTGNkanry2Tz7sx
 I/C3G1Sb2EBz4OJivDhXqwo62fNf+kMVJwXbFXEclpkl/gNASyd2cFAq/iLJmbjtgGgCKEaqEaP
 lJktZEh8myMudRwcexs4ZjPL2siOb3MTTUJQlTn2OyL0TiBEFyXjfcRs2hFc6/7GzxkiYR1Csvu
 KI5jjcx3USmI6qw36NAMgQ85w1mw2LZqzmLFkwN0IhFhHOS2qBdO+aIY1Ei3ehaLAUy7TqLyDII
 Wlp9n3kCNH3x0viFBSh/KWaF2sh4Mzg1fkHQYoUy9OSDX6YD/dTBiUvtmUHb/1Jlmwe/SSUQEYC
 r7W8IHrZKROppUxbvmw==
Subject: RE: [PATCH] libceph: Use u32 for decoding osd indices in
 decode_new_up_state_weight()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260168

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDA5OjMzIC0wNzAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IENDOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiANCj4gT24gVHVlLCAyMDI2
LTA1LTI2IGF0IDE3OjQ1ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToNCj4gPiBJZiBhIG1l
c3NhZ2Ugb2YgdHlwZSBDRVBIX01TR19PU0RfTUFQIGNvbnRhaW5zIGEgKG1hbGljaW91c2x5KQ0K
PiA+IGNvcnJ1cHRlZA0KPiA+IG9zZG1hcCwgb3V0LW9mLWJvdW5kcyBtZW1vcnkgYWNjZXNzZXMg
bWF5IG9jY3VyIGluDQo+ID4gZGVjb2RlX25ld191cF9zdGF0ZV93ZWlnaHQoKS4gSW4gdGhpcyBm
dW5jdGlvbiwgb3NkIGluZGljZXMgYXJlDQo+ID4gZGVjb2RlZA0KPiA+IGF0IG11bHRpcGxlIHBs
YWNlcyBmcm9tIHRoZSBpbmNvbWluZyBtZXNzYWdlIGludG8gYSB2YXJpYWJsZSBvZiB0eXBlDQo+
ID4gczMyLiBUaGUgc3Vic2VxdWVudCBjaGVjayBvbmx5IGNhdGNoZXMgdmFsdWVzIGV4Y2VlZGlu
ZyB0aGUgbnVtYmVyIG9mDQo+ID4gT1NEcy4gTmVnYXRpdmUgdmFsdWVzIHdpbGwgcGFzcyB0aGlz
IGNoZWNrIGFuZCByZXN1bHQgaW4gYXJyYXkNCj4gPiBhY2Nlc3Nlcw0KPiA+IHdpdGggbmVnYXRp
dmUgaW5kaWNlcy4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIHR5cGUgb2YgYWxs
IHRocmVlIG9jY3VycmVuY2VzIG9mIGFuIG9zZA0KPiA+IHZhcmlhYmxlDQo+ID4gZnJvbSBzMzIg
dG8gdTMyIHRvIHByZXZlbnQgaW50ZXJwcmV0aW5nIHRoZXNlIGFzIG5lZ2F0aXZlIGluZGljZXMu
DQo+ID4gRnVydGhlcm1vcmUsIHRoZSB0eXBlIG9mIHRoZSBvc2QgcGFyYW1ldGVyIG9mIHNldF9w
cmltYXJ5X2FmZmluaXR5KCkNCj4gPiBpcw0KPiA+IGNoYW5nZWQgZnJvbSBpbnQgdG8gdTMyLCBi
ZWNhdXNlIHRoaXMgZnVuY3Rpb24gZ2V0cyBjYWxsZWQgZnJvbQ0KPiA+IGRlY29kZV9uZXdfdXBf
c3RhdGVfd2VpZ2h0KCkgd2l0aCB0aGUgZGVjb2RlZCBvc2QgaW5kZXguIFRoaXMgd2FzIHRoZQ0K
PiA+IG9ubHkgb2NjdXJyZW5jZSB3aGVyZSBpdCB3YXMgY2FsbGVkIHdpdGggYSBzaWduZWQgaW50
ZWdlciB2YWx1ZS4NCj4gPiBTaW5jZQ0KPiA+IGFsbCBjYWxscyBvZiB0aGlzIGZ1bmN0aW9uIGFy
ZSBub3cgcGVyZm9ybWVkIHdpdGggYSB2YWx1ZSBvZiB0eXBlIHUzMg0KPiA+IGZvciB0aGUgb3Nk
IHBhcmFtZXRlciwgdGhlIHBhcmFtZXRlciBzaG91bGQgYWxzbyBoYXZlIHRoaXMgdHlwZS4NCj4g
PiANCj4gPiBGaXhlczogOTMwYzUzMjg2OTc3ICgibGliY2VwaDogYXBwbHkgbmV3X3N0YXRlIGJl
Zm9yZSBuZXdfdXBfY2xpZW50DQo+ID4gb24gaW5jcmVtZW50YWxzIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4gPiAt
LS0NCj4gPiDCoG5ldC9jZXBoL29zZG1hcC5jIHwgMTggKysrKysrKysrLS0tLS0tLS0tDQo+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9vc2RtYXAuYyBiL25ldC9jZXBoL29zZG1hcC5jDQo+
ID4gaW5kZXggNDYzOGRmN2FkMjMxLi42YzU3MmMzMmEyMmYgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0
L2NlcGgvb3NkbWFwLmMNCj4gPiArKysgYi9uZXQvY2VwaC9vc2RtYXAuYw0KPiA+IEBAIC0xNTA4
LDcgKzE1MDgsNyBAQCB1MzIgY2VwaF9nZXRfcHJpbWFyeV9hZmZpbml0eShzdHJ1Y3QNCj4gPiBj
ZXBoX29zZG1hcCAqbWFwLCBpbnQgb3NkKQ0KPiA+IMKgCXJldHVybiBtYXAtPm9zZF9wcmltYXJ5
X2FmZmluaXR5W29zZF07DQo+ID4gwqB9DQo+ID4gwqANCj4gPiAtc3RhdGljIGludCBzZXRfcHJp
bWFyeV9hZmZpbml0eShzdHJ1Y3QgY2VwaF9vc2RtYXAgKm1hcCwgaW50IG9zZCwNCj4gPiB1MzIg
YWZmKQ0KPiA+ICtzdGF0aWMgaW50IHNldF9wcmltYXJ5X2FmZmluaXR5KHN0cnVjdCBjZXBoX29z
ZG1hcCAqbWFwLCB1MzIgb3NkLA0KPiA+IHUzMiBhZmYpDQo+ID4gwqB7DQo+ID4gwqAJaWYgKCFt
YXAtPm9zZF9wcmltYXJ5X2FmZmluaXR5KSB7DQo+ID4gwqAJCWludCBpOw0KPiA+IEBAIC0xODc1
LDcgKzE4NzUsNyBAQCBzdGF0aWMgaW50IGRlY29kZV9uZXdfdXBfc3RhdGVfd2VpZ2h0KHZvaWQg
KipwLA0KPiA+IHZvaWQgKmVuZCwgdTggc3RydWN0X3YsDQo+ID4gwqAJLyogbmV3X3dlaWdodCAq
Lw0KPiA+IMKgCWNlcGhfZGVjb2RlXzMyX3NhZmUocCwgZW5kLCBsZW4sIGVfaW52YWwpOw0KPiA+
IMKgCXdoaWxlIChsZW4tLSkgew0KPiA+IC0JCXMzMiBvc2Q7DQo+ID4gKwkJdTMyIG9zZDsNCj4g
PiDCoAkJdTMyIHc7DQo+ID4gwqANCj4gPiDCoAkJY2VwaF9kZWNvZGVfbmVlZChwLCBlbmQsIDIq
c2l6ZW9mKHUzMiksIGVfaW52YWwpOw0KPiA+IEBAIC0xODg0LDcgKzE4ODQsNyBAQCBzdGF0aWMg
aW50IGRlY29kZV9uZXdfdXBfc3RhdGVfd2VpZ2h0KHZvaWQgKipwLA0KPiA+IHZvaWQgKmVuZCwg
dTggc3RydWN0X3YsDQo+ID4gwqAJCWlmIChvc2QgPj0gbWFwLT5tYXhfb3NkKQ0KPiA+IMKgCQkJ
Z290byBlX2ludmFsOw0KPiA+IMKgDQo+ID4gLQkJb3NkbWFwX2luZm8obWFwLCAib3NkJWQgd2Vp
Z2h0IDB4JXggJXNcbiIsIG9zZCwgdywNCj4gPiArCQlvc2RtYXBfaW5mbyhtYXAsICJvc2QldSB3
ZWlnaHQgMHgleCAlc1xuIiwgb3NkLCB3LA0KPiA+IMKgCQkJwqDCoMKgIHcgPT0gQ0VQSF9PU0Rf
SU4gPyAiKGluKSIgOg0KPiA+IMKgCQkJwqDCoMKgICh3ID09IENFUEhfT1NEX09VVCA/ICIob3V0
KSIgOiAiIikpOw0KPiA+IMKgCQltYXAtPm9zZF93ZWlnaHRbb3NkXSA9IHc7DQo+ID4gQEAgLTE5
MDUsNyArMTkwNSw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25ld191cF9zdGF0ZV93ZWlnaHQodm9p
ZCAqKnAsDQo+ID4gdm9pZCAqZW5kLCB1OCBzdHJ1Y3RfdiwNCj4gPiDCoAkqcCA9IG5ld19zdGF0
ZTsNCj4gPiDCoAlsZW4gPSBjZXBoX2RlY29kZV8zMihwKTsNCj4gPiDCoAl3aGlsZSAobGVuLS0p
IHsNCj4gPiAtCQlzMzIgb3NkOw0KPiA+ICsJCXUzMiBvc2Q7DQo+ID4gwqAJCXUzMiB4b3JzdGF0
ZTsNCj4gPiDCoA0KPiA+IMKgCQlvc2QgPSBjZXBoX2RlY29kZV8zMihwKTsNCj4gPiBAQCAtMTky
MCwxMCArMTkyMCwxMCBAQCBzdGF0aWMgaW50IGRlY29kZV9uZXdfdXBfc3RhdGVfd2VpZ2h0KHZv
aWQNCj4gPiAqKnAsIHZvaWQgKmVuZCwgdTggc3RydWN0X3YsDQo+ID4gwqAJCQl4b3JzdGF0ZSA9
IENFUEhfT1NEX1VQOw0KPiA+IMKgCQlpZiAoKG1hcC0+b3NkX3N0YXRlW29zZF0gJiBDRVBIX09T
RF9VUCkgJiYNCj4gPiDCoAkJwqDCoMKgICh4b3JzdGF0ZSAmIENFUEhfT1NEX1VQKSkNCj4gPiAt
CQkJb3NkbWFwX2luZm8obWFwLCAib3NkJWQgZG93blxuIiwgb3NkKTsNCj4gPiArCQkJb3NkbWFw
X2luZm8obWFwLCAib3NkJXUgZG93blxuIiwgb3NkKTsNCj4gPiDCoAkJaWYgKChtYXAtPm9zZF9z
dGF0ZVtvc2RdICYgQ0VQSF9PU0RfRVhJU1RTKSAmJg0KPiA+IMKgCQnCoMKgwqAgKHhvcnN0YXRl
ICYgQ0VQSF9PU0RfRVhJU1RTKSkgew0KPiA+IC0JCQlvc2RtYXBfaW5mbyhtYXAsICJvc2QlZCBk
b2VzIG5vdCBleGlzdFxuIiwNCj4gPiBvc2QpOw0KPiA+ICsJCQlvc2RtYXBfaW5mbyhtYXAsICJv
c2QldSBkb2VzIG5vdCBleGlzdFxuIiwNCj4gPiBvc2QpOw0KPiA+IMKgCQkJcmV0ID0gc2V0X3By
aW1hcnlfYWZmaW5pdHkobWFwLCBvc2QsDQo+ID4gwqAJCQkJCQnCoMKgDQo+ID4gQ0VQSF9PU0Rf
REVGQVVMVF9QUklNQVJZX0FGRklOSVRZKTsNCj4gPiDCoAkJCWlmIChyZXQpDQo+ID4gQEAgLTE5
MzksNyArMTkzOSw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25ld191cF9zdGF0ZV93ZWlnaHQodm9p
ZCAqKnAsDQo+ID4gdm9pZCAqZW5kLCB1OCBzdHJ1Y3RfdiwNCj4gPiDCoAkqcCA9IG5ld191cF9j
bGllbnQ7DQo+ID4gwqAJbGVuID0gY2VwaF9kZWNvZGVfMzIocCk7DQo+ID4gwqAJd2hpbGUgKGxl
bi0tKSB7DQo+ID4gLQkJczMyIG9zZDsNCj4gPiArCQl1MzIgb3NkOw0KPiA+IMKgCQlzdHJ1Y3Qg
Y2VwaF9lbnRpdHlfYWRkciBhZGRyOw0KPiA+IMKgDQo+ID4gwqAJCW9zZCA9IGNlcGhfZGVjb2Rl
XzMyKHApOw0KPiA+IEBAIC0xOTUzLDkgKzE5NTMsOSBAQCBzdGF0aWMgaW50IGRlY29kZV9uZXdf
dXBfc3RhdGVfd2VpZ2h0KHZvaWQgKipwLA0KPiA+IHZvaWQgKmVuZCwgdTggc3RydWN0X3YsDQo+
ID4gwqAJCWlmIChyZXQpDQo+ID4gwqAJCQlyZXR1cm4gcmV0Ow0KPiA+IMKgDQo+ID4gLQkJZG91
dCgiJXMgb3NkJWQgYWRkciAlc1xuIiwgX19mdW5jX18sIG9zZCwNCj4gPiBjZXBoX3ByX2FkZHIo
JmFkZHIpKTsNCj4gPiArCQlkb3V0KCIlcyBvc2QldSBhZGRyICVzXG4iLCBfX2Z1bmNfXywgb3Nk
LA0KPiA+IGNlcGhfcHJfYWRkcigmYWRkcikpOw0KPiA+IMKgDQo+ID4gLQkJb3NkbWFwX2luZm8o
bWFwLCAib3NkJWQgdXBcbiIsIG9zZCk7DQo+ID4gKwkJb3NkbWFwX2luZm8obWFwLCAib3NkJXUg
dXBcbiIsIG9zZCk7DQo+ID4gwqAJCW1hcC0+b3NkX3N0YXRlW29zZF0gfD0gQ0VQSF9PU0RfRVhJ
U1RTIHwNCj4gPiBDRVBIX09TRF9VUDsNCj4gPiDCoAkJbWFwLT5vc2RfYWRkcltvc2RdID0gYWRk
cjsNCj4gPiDCoAl9DQoNClRoZSBtb3RpdmF0aW9uIGFuZCBwYXRjaCBtYWtlcyBzZW5zZS4NCg0K
UmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0K
DQpUaGFua3MsDQpTbGF2YS4NCg==
