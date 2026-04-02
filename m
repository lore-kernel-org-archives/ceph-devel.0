Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC8242D70
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154694; cv=fail; b=rIdBrPTP1uhP5IWjpLIyY76D1ZqVhwXM56xMOoQNDoFNVN7WOm9fQ/v3dRVg5xoNE+CMkZlePQ437v1ptZ+KEqDq0dPr/vtDKlS1POsKJMcWU0nWl/e5bf/vGVyVjSreNv4c8Ngj+h/YP7Rtn0r3wVooR3e05/NQIPAzYZAIG4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154694; c=relaxed/simple;
	bh=PEzaV90Y1yhMYOYyjd6LL7J2W8ArmNIVy9p2N59wDOI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=PKhNywDIN+No6glBOR4SSvX9sxlB9VLxhCPwka3SCKZRxnutfRVgBIWyjWkNBUB/835Nz8xhgX8PmVAUmIrqlO35ExpHGkp4eRJCjeOqo9T/ShFHK7uz5gI9y6jHltr46MK0rkEgwumtN6mE6frDV81DpPyMnBaH/Lzj0jm47/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M18PpNhq; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M18PpNhq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Gg96R213344;
	Thu, 2 Apr 2026 18:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=PEzaV90Y1yhMYOYyjd6LL7J2W8ArmNIVy9p2N59wDOI=; b=M18PpNhq
	A1zYiBw8YZAuyqeEfVg8hrtWqoh1a3VN88BYGmoFOZwN/Mh83zalp0vCAtaZ34Pn
	tI1wqWC2FHrlCdqu+a8hd5D1R/menv0G4ivlPe9kiZ3DbGBjN0OaXkGrbIvmquLR
	6LPylzwpllUYIKsCuHfTR4jclKwAOfWwYrvbtq48WyTVcfBIyGyKVGRdUBrk1iJ6
	gpWevr/EDsraDmMrk2w32QX+49tfANq9bp56STGSFMFZrcS/F27K610xH9cLPiOG
	2TTHN/NWiPqOv6YotrowT8HKwgTabJuJ2SgeqUw1O6arA1Ytunr72cc1rB+7uBZb
	Xzx44stSK1KWMA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msd4tj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 18:31:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzXKvXhQ0ivD9Pm2VSgk83WXqvysOrsx8n4QQ4ysehjZAhPzaiAgw1olBdzLRHZiAHkR9JS448zLcSwXsa39miOd8kjkp19VlSaQ74SITXAE0JxBeYD6igugxx/f2asX/geqWUMugV0o49O8hkEEoRNiF8Ps80ZJiRyV4oBblxzfLVVv8YxjAp2IOCNmYHcXUDXchjY1VVEiK0O68Vb6jvRBTFVauiNHj6cnMnl4URjQiGpLt1UJAWdyLDmiI0ROUI4ObuQQvclpp5Jc+QJ8p0d1npwMuQdazVnFges/Nwl5cV/wBZWkH6ohdS8SfAPFPhSP7NyEDajzUQ0NhQpx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEzaV90Y1yhMYOYyjd6LL7J2W8ArmNIVy9p2N59wDOI=;
 b=KzkQgvkMtu7WKScl92IvUNeQ6m6i9ICPtHxn19YgPn/wpnId9GQpsZJOexAZhgL3oRO3dZ40fzH1IwvvRtfeSMuFLmfwxTN6lnolegu3auJ7NTyAIFDAt9thSS1aIWx3NAQxSEF7XgmN9ts8HGesTsKaUNrG1wkDp7BO9FUpCgMbfJ5j0hFCdlRufdFJSbB33GCryLA/aGJ2aZtXs67kRKgh8m+RJ/CWL6d9MkHoRqbX0rskzfOB6OW/Za4BzY5wLs6dun7PqQwGvVa2wPfH+7cqk7hKGP0+HDUgImFQqQ4mCSuNQO3/IK8cOATGki4kThJNCaeQriEPmmDQSVBalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4625.namprd15.prod.outlook.com (2603:10b6:806:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:31:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 18:31:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH v2] libceph: Fix potential out-of-bounds
 access in crush_decode()
Thread-Index: AQHcws7il2dS4H3nYkSaDdxn3Q/vhg==
Date: Thu, 2 Apr 2026 18:31:13 +0000
Message-ID: <ba62fff2f2b6f7b9544b0dfb42d1315af6b49ff4.camel@ibm.com>
References: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
	 <db5836ada81127694ebe4baec538ec6a0b564c04.camel@ibm.com>
In-Reply-To: <db5836ada81127694ebe4baec538ec6a0b564c04.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4625:EE_
x-ms-office365-filtering-correlation-id: 3d52b25d-2c12-43e7-f571-08de90e60520
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 CnEdQzCxRjycrjE8j+cHW1IAAKCxAqUEGZBSNIDcQSpzwi28x4MrcZcfg+6/kxRgNrcMRoBBABpvRRnWNf6LSyyFjzWYWjQ8oa6ljSxcGpC4KmTC/fzGa0Pnou8KYxd+wqGHreqrIwV2D1ih9I5hHgLTI9uqLPpheTiNezDEm0hIEz0nlD2WnL7SvsYozrHv6tCP4Rs4gj1s0xO8B1Tbq64d2T53gD09Ll7qPWG9VAN3Sfke2HnDzyLNZ+K1blR94l/YEQedVktpAdKNKCpd1Y1GuZKf1zEsQqO+p1GJeV0AsIbsK69uXYzrB/2jLUtc74gHxLJ/EjOAa0ObiAO3qLGJoIFGz6N2u807n7z2oVOYiYN1OCa4TaXNQLdjRpRfg922wq8trM1Tk6RgrzR2rohmA5ZNxq7FVVLJ7P6Vip8xf1IVKqpf41yr2aDQ4a3O3M1jPZd2WbSeyN7XNfZ8LaBWm7l31r1JVpQWXkPFc+h/5o9aB7Yt2MpzdmrbkVcKbCNTyXr2ndIdbB1Syzj6ApH9zOxyk6FOs89S5W1dzPMlxqsOiDUkTfONo4cUrs46xpI/JMHKdXGagX1ylX4E3vlPDc3GYmI9d6NEXROxoNxN+MFJZGJwWy2SId21aS4gi3T7vqLSyhbowoNWnEezvQeMsbXFEMqXNE+/n46JlyNeu6Y01UJr5a9bWDq7LKILwOItFJXiTXxuWcDaOO1V4YGGnUOBY2oxi6L66KdDAgvhf/5as10nvO8d6/6yZrqeg6XjjVCpDDdM0p5EfhxRkplWvt7EQ7i/q16joZXw70g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TS9xWjFYb1NadUhMZC9yTnFrWlYxZ3ZnRk5JVlh5VGZSY3pUcDJ5eXJMaGUr?=
 =?utf-8?B?M2I5citpdXBEbUYxbXZTR0lXclhoTFU0SnFMSGdvcFdUUGtmeko5cVBjb1V0?=
 =?utf-8?B?RDhTZU9Qc1RaeDl4WnM5elI0S2FBREFBUlpMYjkvY204VE9zQlZTWFlDT0sx?=
 =?utf-8?B?R3p1aWRpTzI2blFBRjE0Z3pmSG12WDVYU0c1SWVHQjN6MGtBTDBKVktIRkRX?=
 =?utf-8?B?aVF5ZTcwd1IzK0E2bVdySmFiVjJ2Z2IzYXRhR2NlSkZ5eHZPVy9BcFJ1U0VT?=
 =?utf-8?B?RjcvYm1iS0lsQlo0ZWJJODJsY0UwS3E2NlNrT3VOc2VqT2RMSklDQ3VTZlJm?=
 =?utf-8?B?MWptMzM4eVFjNzhTd1dpeWhBYTg0MUFLQk00c3p4MWQvc0pvWU1BVXA3QUdP?=
 =?utf-8?B?MTlOM2ltS1hjMktqdllOMnNzZ0VMWFVjY2dVRzR3VXd6VFpqa0pybzZWZ2k0?=
 =?utf-8?B?NUs2THpuVkVTczBxaHF2QjZGSnA3elppanZxU0JwbGdPOFk2Q3Q2Q3FjQWZS?=
 =?utf-8?B?anpjMEdmOERZZWhaVk50NGwrc3RoYjhWZmdEYXQyRlhvYklTT2RPd2l2TEdG?=
 =?utf-8?B?YmZKQnJrVkpjQ0FmVmljZmhHeXcxNHhvL2dZcFNzWTlKemt2QjFRZ1B2MURo?=
 =?utf-8?B?REUxTnZVaHJrQXpmUGkyczl0NVlzSXN5bkgrb1RoL0p3R0VCcHBzYlFhcXp3?=
 =?utf-8?B?c3hQL0toeFJLYmx6MkJoZGMxQzBXbFp0QVdUK05mOWF5K2RrQUx4WVZtN011?=
 =?utf-8?B?ZXJnVFMyWkNzWkxTaTY2QmsvSGtEOVpZT2RGRE9KbXA5cjdaWXN6UEZLTVVZ?=
 =?utf-8?B?SEZVMVV1T1IxRUxFTzd5Z0lrbUhOZXNjSkFjak9aekJURGdFUUw3VkM2RUZR?=
 =?utf-8?B?bTBwTFZ0V3BuTExqSGJEVWltd3dHVDk5bEpqbC9YR1cxU25DbytQM3hwN01j?=
 =?utf-8?B?NzlUVXBHSmhWeTdmNERJUHJQdDI4M2tXR0s5QkRTdUpkZGhROWowVlc1VjNT?=
 =?utf-8?B?cDNlUTh5TGhheElRS0lZS0RRSFlROHJJVi8wMTB1UHF4VVlBMUQ0WmJ3U01L?=
 =?utf-8?B?bzJlTnllclNMZ3o0aFJ1T1hKYTllb0E3N1lvTFdaNWRsdWFxWk9WUnZuQmhF?=
 =?utf-8?B?YS82SDY5MFU4Q1pYdjNjVTNWVU9qdTF0elZXMVlnbThnT2hsSTlsYXRSS2Fi?=
 =?utf-8?B?ckdLZW9yTE5OUnlzVittQm5DQVc3ck9MaW9oclRTZDNwOVJtS2NpOVRqeUE5?=
 =?utf-8?B?Tk0xNGhqR1dQV2VlMjRJczVtNk4xaVpiaDVSdWVMY2pXMDVmOEE5VXJIbUUv?=
 =?utf-8?B?c0tzWHdRYk8xSXd5MkJ1d29UTk9MWlRMV2htdUtFNy9wdVVzS2JNTWFJRjFE?=
 =?utf-8?B?NGR5eVNidDdiR3E5WnMwWUJKWnNMWHlJV0swZTRzNTFtWVNDd1UwakF4YXor?=
 =?utf-8?B?VExLZmh1Z3hFc3ZYNm43bzRHYWpSellSQ0RVeWp1OUtleTZmYzRrSk1IZ3c0?=
 =?utf-8?B?eld3TjdMSDZiSTN4MDQvU0xOQk52eHp1U2U4ZjBZVkxWaFRodzNNYzYrQkI1?=
 =?utf-8?B?M3FseC9vdit4SWxQQitaT1FZd1ppVW8vNDNiVVY2dC9aeld5cDZ2KzFxMzZl?=
 =?utf-8?B?OVZENy81NWthUm9rcmxXQTMvZU1RVk0xazduR2NMTHdwTm5EdVJWbmIzNTNl?=
 =?utf-8?B?OHZWM1MwbzRzU0cyTGowZGxza1NpNER5RkJ2a2FHL3BTVTdHTXVMWGJzUkhH?=
 =?utf-8?B?bzcwRHNYQlVLZDV3UlI2MFlLUXJWR2kzc2pZc2ZBbkNPS0hRYWxtTU1hbTZo?=
 =?utf-8?B?VzkyMHVyQUphVWtHQy9uNklhWWhXZFBBUjIrRzJXd3BGbUtBN25RWU9BYW9z?=
 =?utf-8?B?eU5rU0xnWVh5enc3Vyt1dVBKM0FUOWR1UzJQL01ZZldwNHptbzYvWlVoTytq?=
 =?utf-8?B?R1BIQXY3WmF5dG55MHhqb3RDUk5TVjd4endGNlNPUCtNa2UrRFlEdlIvQ29h?=
 =?utf-8?B?Ni82bzFCMnVUU0tQV2RRNHB3d0JVeTJjU0Fqd2o4NThKbDU0YzFPSjZyT1l1?=
 =?utf-8?B?RTFCOWN3UUtLMVRyK1NWdjhWY09URDYrWVd0Qm1EQXVnWGcvRE5Wc056cVQ5?=
 =?utf-8?B?dmx6aEVzM1NKWWFSR1JDU3d0RTVqd1hQTFhjU1pWOFRRcDdhNDdseWl4SzdP?=
 =?utf-8?B?TTVrMUhFU0Z3MnhqWGczV3k0YlNvMm5RN1NKYW0wNEpPT0pCUXRIY2NQaytU?=
 =?utf-8?B?ZWlPYnJxTEpXV25oalN2Z0ZzeUZEVWdjZCtEYVJsaWF0dFRNcWJpZ1huTmxT?=
 =?utf-8?B?UXVkMS9uTHRia3NuRVFiWjBqaDlrMG9IdGNtYkEwOUhPVzhCbjE4VGpLY1JR?=
 =?utf-8?Q?wMKkPWEGbANloUsaGnBsw+cGr5ru5OE/c3B3v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <034E43A9453E0544823B361C5769196C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LfCFXoQ89VPfOq1wTIzWBFec70sp2Trfwac67Rh9xg2szQzCtfj3W/ncNzivRoFR8yplyUuc7cVaIT4pM68IuKiwuR85I8Ii46EED5Lfvw208nd+oWk7KRTO0qctlzULgPNroFztcjW00hElxuhIoEuTpC4WBqAAYdRMgZSyBIX3P4PgbG+KVuBI3Y5xyPJpQxMlgQs4yo6euOGsrgjtHB1YxobBawF0nWjDd+sVVK+HLSV8AR5Z8+vAVthzmvHIPBNpOJfOic/JSEonpfNX0W52Jf84TS9F7OG4urIoFOyVZIxuWbnPFLSBx71aDGkXewENYaDM0Pu/XEBSpvp5rA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d52b25d-2c12-43e7-f571-08de90e60520
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:31:13.5674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ylLPq5uLZjrBMpcacvMkkjmNcKcF8JSGE9VQ4yHF8HTf1WAyEeCajNgbhperCCcrA88ZtyhQ0W0HGR+z1AnWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4625
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ceb5f4 cx=c_pps
 a=41oIdeUvPxzefjUhlJkc5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8R3IA0hL97sv23HNzUMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE2NCBTYWx0ZWRfXzQ1BU3sWl7tk
 qdGg3pcv+/qM2NCAkRUTyFfuD3TxzLIJBOLanDVcYTTWyJqadIMDpn4m+rwzdakqf094YuAEcPe
 0SkI0yZsYDQ1f6IpQRIHhvQi9KxEhGsBH/+MRL441mHZMoUGA8Ra8sCUJly4Ab+6XMtPvAZn5k8
 kiM139eKZ3a0ZFKpsJVH9zG876GEhKwVxdt2htBH3iy9/rVYgbHPeL0olmHAUyBiStKRjBaKyKC
 oGBshdq+8KkmRZQlVAF3K+QoipcaaRK9HkVl0HGKI7MVRiJqVCtPimOSo2mFOvN6WPQNraVLqEU
 GIKanxB2qyaBkv0TrRqR9MUB1BxAEw7qbP+I2ZtR11oCvVu0N53/Kc4luWA8hUUutrqwOo6l0xf
 FLFrvyBZcQWFBHQJkZ3c7+METhNesnKpgXesawlzc1sks0rnFOzS3Y7ySkI6wIdzaY5ocz2aOHY
 TATlq8dBhPCeyIxk9KQ==
X-Proofpoint-GUID: y7R-0ItSH6hkq-KZ2hhFj87n7J228HqG
X-Proofpoint-ORIG-GUID: 3eLvkQk4MgNc_2yIoPThsQkjVbkwGCTD
Subject: RE:  [PATCH v2] libceph: Fix potential out-of-bounds access in
 crush_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020164

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE4OjE0ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFRodSwgMjAyNi0wNC0wMiBhdCAwOToxNSArMDIwMCwgUmFwaGFlbCBaaW1tZXIg
d3JvdGU6DQo+ID4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX01BUCBjb250YWluaW5n
IGEgY3J1c2ggbWFwIHdpdGggYXQgbGVhc3QNCj4gPiBvbmUgYnVja2V0IGhhcyB0d28gZmllbGRz
IGhvbGRpbmcgdGhlIGJ1Y2tldCBhbGdvcml0aG0uIElmIHRoZSB2YWx1ZXMNCj4gPiBpbiB0aGVz
ZSB0d28gZmllbGRzIGRpZmZlciwgYW4gb3V0LW9mLWJvdW5kcyBhY2Nlc3MgY2FuIG9jY3VyLiBU
aGlzIGlzDQo+ID4gdGhlIGNhc2UgYmVjYXVzZSB0aGUgZmlyc3QgYWxnb3JpdGhtIGZpZWxkIChh
bGcpIGlzIHVzZWQgdG8gYWxsb2NhdGUNCj4gPiB0aGUgY29ycmVjdCBhbW91bnQgb2YgbWVtb3J5
IGZvciBhIGJ1Y2tldCBvZiB0aGlzIHR5cGUsIHdoaWxlIHRoZSBzZWNvbmQNCj4gPiBhbGdvcml0
aG0gZmllbGQgaW5zaWRlIHRoZSBidWNrZXQgKGItPmFsZykgaXMgdXNlZCBpbiB0aGUgc3Vic2Vx
dWVudA0KPiA+IHByb2Nlc3NpbmcuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNz
dWUgYnkgYWRkaW5nIGEgY2hlY2sgdGhhdCBjb21wYXJlcyBhbGcgYW5kDQo+ID4gYi0+YWxnIGFu
ZCBhYm9ydHMgdGhlIHByb2Nlc3NpbmcgaW4gY2FzZSB0aGV5IGRpZmZlci4gRnVydGhlcm1vcmUs
DQo+ID4gYi0+YWxnIGlzIHNldCB0byAwIGluIHRoaXMgY2FzZSwgYmVjYXVzZSB0aGUgZGVzdHJ1
Y3Rpb24gb2YgdGhlIGNydXNoDQo+ID4gbWFwIGFsc28gdXNlcyB0aGlzIGZpZWxkIHRvIGRldGVy
bWluZSB0aGUgYnVja2V0IHR5cGUsIHdoaWNoIGNhbiBhZ2Fpbg0KPiA+IHJlc3VsdCBpbiBhbiBv
dXQtb2YtYm91bmRzIGFjY2VzcyB3aGVuIHRyeWluZyB0byBmcmVlIHRoZSBtZW1vcnkgcG9pbnRl
ZA0KPiA+IHRvIGJ5IHRoZSBmaWVsZHMgb2YgdGhlIGJ1Y2tldC4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4g
PiAtLS0NCj4gPiAgbmV0L2NlcGgvb3NkbWFwLmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9vc2Rt
YXAuYyBiL25ldC9jZXBoL29zZG1hcC5jDQo+ID4gaW5kZXggYzg5ZTY2ZDRmY2I3Li5hODcyNjgw
NThlNjEgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2NlcGgvb3NkbWFwLmMNCj4gPiArKysgYi9uZXQv
Y2VwaC9vc2RtYXAuYw0KPiA+IEBAIC01MTYsNiArNTE2LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY3J1
c2hfbWFwICpjcnVzaF9kZWNvZGUodm9pZCAqcGJ5dmFsLCB2b2lkICplbmQpDQo+ID4gIAkJYi0+
aWQgPSBjZXBoX2RlY29kZV8zMihwKTsNCj4gPiAgCQliLT50eXBlID0gY2VwaF9kZWNvZGVfMTYo
cCk7DQo+ID4gIAkJYi0+YWxnID0gY2VwaF9kZWNvZGVfOChwKTsNCj4gPiArCQlpZiAoYi0+YWxn
ICE9IGFsZykgew0KPiA+ICsJCQliLT5hbGcgPSAwOw0KPiA+ICsJCQlnb3RvIGJhZDsNCj4gPiAr
CQl9DQo+ID4gIAkJYi0+aGFzaCA9IGNlcGhfZGVjb2RlXzgocCk7DQo+ID4gIAkJYi0+d2VpZ2h0
ID0gY2VwaF9kZWNvZGVfMzIocCk7DQo+ID4gIAkJYi0+c2l6ZSA9IGNlcGhfZGVjb2RlXzMyKHAp
Ow0KPiANCj4gTG9va3MgZ29vZC4NCj4gDQo+IFJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5
a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gDQoNCkFwcGxpZWQgb24gdGVzdGluZyBicmFu
Y2ggb2YgQ2VwaEZTIGtlcm5lbCBjbGllbnQuDQoNClRoYW5rcywNClNsYXZhLg0K
