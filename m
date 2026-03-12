Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38F3A6B67;
	Thu, 12 Mar 2026 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343584; cv=fail; b=uXw7UKlW5w65jPQzIzaVAMUtPqobCzoAma+xECBbFzbqm+bq991s8IaICs+ZmmgIAO1WBaasFDXthkFGdtURzQyNAAMYXCM38x6IjcmG5DZjcgkwH2WhZsl1RBT8w3ns71c8RiRpBgqTs+k7rk76HqlzS3T8JoQaaZIFO/viawo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343584; c=relaxed/simple;
	bh=Ofv1Q3z5NpLMOT3dNLepj3caufAfjjO8VA8MUSI/R6I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RO+t9pkGtDqCbIGS5N/a9GAzwiZFbPWBwQ61RRILbp3CyGH+OS/LBcFTHxLz9ajDvmRQnA08N6QFs688mux1a/95MH4h8JaxWu8pKiSQYB8RkS98xIdwejh3iOh8jL+Lb7ZxByligEAaZieYsq8udmIO7pvE5lQbtyAbA1UAZW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ROFWrvpy; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ROFWrvpy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CENFJQ2582047;
	Thu, 12 Mar 2026 19:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ofv1Q3z5NpLMOT3dNLepj3caufAfjjO8VA8MUSI/R6I=; b=ROFWrvpy
	AUWsAqIMa4HURbqpqxbKWQicS8HHZ6PNs2aGMQW0BBptLvvkbguMoLBLVRuCy71x
	0B3j6aPwTajhWPb3+MGjZNsnj/t5KINKDacjepU5fJzcLRyzs/OK/vBnR40J2McT
	X5+3Q+753XhhK/uiCiVRO3c6w1d9Ctr67bNMmFQk1uHKLTazDIiCUj5Lldjw/DgQ
	xH6j8E7uPhfQaaLbn5xnC/ufNtV+q3vMG6cpxpABHwTHgmgEC4v/Qe7Tp00kV86d
	hX2J0xSMBn9Bssbsi2m8zqmg5eXIYARprekBJLpOD52ajm+6FKkqkQx4mMxoVrR/
	zab3BlgQ/e9oFA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94vjcq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:26:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spGNdvcElpGRb2lkybxLCtfGpg4/62G77SU/UTq6C9Ie3kvTmhpT8/KKopNtYWFK+NQvplK6scQCLU0pMieVcebCbFxj/hz7khnUbAU14nj3ZxVAtbi6CkXWggXIR2I1y/7Re47ZmIRR8ol0DXet02czn23RvTNhKn6ecaQVWx8FOXm3WReWAzY+VQIbDavJHnmYoCS77fnWiINlsY/iP+ODVwlJQHnaqFgMOGHmDeTqIAVNQSzS70iVKeSgdDq5M784jKLSWG/79aga4fcB51m5lp5v5/x7JPAQRamLPcSlRuOy4LYz8qZYOqocUfTkH0+e7VVOf3q4xZMYKdvtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofv1Q3z5NpLMOT3dNLepj3caufAfjjO8VA8MUSI/R6I=;
 b=PI6Oxbi3hSOwQbtZVlZnCvtQYNdqJB4gxEKtcuxyFa4ecST0xQe4hjeEG2dXzSAFjhoX29xM8GeYxLkkBoZKVN8VM8FC3lEzdYI9VrKTtZWAkO/9G/2FXaBT5iak7osYpPDVkiLHt+iEjb8AKM1WPihmSx8pkSHrj0wGSzJPr7mpJrQ8a2AY53o8dvTlq6JjrX7RVtcFP8NcaCbuIbAuTqWp5MXWonyncGJYoU09Nu17Zn7HjPycNnGgLssMQixZZiep6xo/YxkZNL6Uyy4MoHIQrqbJWGc6v6/L95GZ4+7oj+HmJk2RABEvwR1QoeLUrN/+oL11en7Rl0sUR9JH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PR15MB5620.namprd15.prod.outlook.com (2603:10b6:208:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 19:26:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 19:26:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 03/13] ceph: add timeout protection to
 ceph_osdc_sync() path
Thread-Index: AQHcsfi2WDtDvEApb0Cha5MJbz6pRbWrSD6A
Date: Thu, 12 Mar 2026 19:26:16 +0000
Message-ID: <63cf7834a1147a423d40398f1b98cc30a427ef9a.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-4-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-4-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PR15MB5620:EE_
x-ms-office365-filtering-correlation-id: 1749369e-1fcc-4659-e1d0-08de806d3b2b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 VvilwLySlqeFQ87h6effqaRP7e/u3P9i2P1HofFY2DLawHNkXLhCaUfBjj242+zVCvQyaSdIF6GlPMUwTXOe7auLAZexHNYasJYk5+b+EW5v2L0Zl1ZypDzsOL6izGRBTB19fMmrIRufI08FhGg00lJVohRXhX6EMbQpxE7bxV3Qv9KWPWTYQzxWd9xdrny7+y7PNmM8tzInqbb4T8Q+WZ0kHTL9KNescGZA2ulN8Si1mdMzsrJwIgK27+OoFacg1Y5lskb3BRcJbohcvdcC159tUKPjbCHRcjaQVzFQ3TtR0XOgFaEtNhuDgsgk5eCnJE3kbNHYb0rf+c1jIaTxFUAaYVo8Tdv3CcA/pWxFbhWFcrOWRz7+6DgPPZ8tPUZdwkCmvNi/RoM/Y/r8kBxEo7siewQDSysakpXnZYBPDnJyigJmDwgdx3iVpSrAkc2JxdgiG/B6G7ukFeBRwblHTNAFbZMmPmb4ptXLO5ceVGou+0k1poA8yyjm5vIDd8jc752KUtEejiPFmeRdt8410iXEXaymC2Ds8+dLo1LKV1X9VQ7StXaFNT9e7VncpA2LOQG4jAXPB9qGgO0sZpP/pIEpJClDajA9aXzfN/UdO6mcvsQrlbnaIlQtn3IFTQ798551gWtJSwTaauGhsxA7nEcPy0rNJypVDFuVMMEAQShShF4Uk1z2r5vivZrN+Og0eU02F5SOQ8xOuwZE0U1M/psX6WVv59T0mpbJNuxabExrN7Aee8en7i6urDNRIF2nfa9B73ZbUe6Omt+rB0hfuclvH7wv96WcBwOBSlP8UcI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3NUY0VQWVRyZkpCbHgyOHB1Z2lMY2pNMzdtTUwwWE5zRG9LeHZKY2ptajBD?=
 =?utf-8?B?VmZmdWl5MUFtUEdoaG5BQmlSSEJ4OGVRMm5WQlZodDNFMW4zcEtSTXBFeFZL?=
 =?utf-8?B?T0RiVXBHWkY1REdrSCt2VTlzTWtXeEYvcllyamNLY3V4a1hwZFRzNXRhVklD?=
 =?utf-8?B?RXFrMjFid29RK3kxaklXWVFqS3g3OTVaMm5VdTZYQ21QWlp0VDhVem9wam9o?=
 =?utf-8?B?QnRkUUhnQjBjKzlsaXBnZW1EcDgxaDJvY285UEZKNk9hczFEejF0dXRuTDlw?=
 =?utf-8?B?ZG4xQkNkQmpVd1pUdGhyL3hSUUk3Vi9DaXFKanJGRktEeHVWL0ZWajBSUjJP?=
 =?utf-8?B?TFd0akpaRTRCTjErcmZqS0o1M2dhTmt5SmtRTXpGdXlpcU1SQ0ZkSHJ1aDJr?=
 =?utf-8?B?WDViekZ5Nk1WcFk4bFlPdzBvTWY4aWlJSk1OS0V0eUNOOVRURHZ2b0xEQlJG?=
 =?utf-8?B?bkdzOE1BRysrUllwbzZGS2VnWStwSFZSQnNlT09aa2RUdFV0MnFrNDdTYzdz?=
 =?utf-8?B?ZUhoSnQ1VnBoUmxnSHU3UC81aWprRUx1dXlGYitRMm5YZzRDQTYyOXNJZzNv?=
 =?utf-8?B?Njh0ZzZQK21Xb2hwVTlTWlE1MEN2Q0ZrTlZHZW1nZGNzZ1pTaWhlOFJBTDlK?=
 =?utf-8?B?QjVZRjBhbmREeHhQVS9sYmF1THVDcmhVa0pZZjhrVTRab0ErZWpCUXVBQnQw?=
 =?utf-8?B?dnJpMFJXejA0dVQybVFIOFd1WUswZWlpNURmK2l4YzRuSldtcXhtb3Q5SXY3?=
 =?utf-8?B?TGlIS2FNWmdLRTgwUi93TW1xUy93ZU5oVDc2aGNtbFRoRlpqUURVY1NnMUEx?=
 =?utf-8?B?YWxBVkhwTktuMzBQZ1FmZVMwR2hGYVlESXNYbmtFWVh4OUpYWURCNUVTVWRV?=
 =?utf-8?B?NVFxM2dpeGFBV0grblVMRkFjc252aWttc2oyTDVlbWxDVG8xRlBDcjlGUVBO?=
 =?utf-8?B?NE44N295b0J0YnV3TDZkZnVQZCtlekliajZMZWtJaHRWcEtGcHl2d01qVVYx?=
 =?utf-8?B?QjByVnlMTmtjcThKcHVKcTZHeFNxTmlQM3JuL3lBWWFVZXhpeWZFTWZCZEhQ?=
 =?utf-8?B?b3QxZ1h1d3AvM1NPWWFJdldXa1gzTk9GNkEvSlpDMmZ3cWQ3K2V0VHR1d3VF?=
 =?utf-8?B?VXZHc01sYXZxcTM0c2NBYXdLenpvVzdaTXpDRU5Cd1hFNm9NOHdLRlVPZzhl?=
 =?utf-8?B?djhkSXVhaTB4RVlxNmtSMVVUanFsUHVZaUI5a2E1U1YxOXBSa1huT0xxZmdk?=
 =?utf-8?B?OEthVnY4SDl6Q2FzK0lmZFRLWU1GRUVUQXZ5eTV0SDQrQlNIVjhvUk42aHov?=
 =?utf-8?B?ZklKUlJKY3RKSFN3ZDVLenNtdXFnQWRTK05MZUE3RVNoQ3JMV3lteUVLT2Rn?=
 =?utf-8?B?OEEyVm52ZWhBUGpvam1ObGh6dGtJSWYrclNhSER5ckdnUjVXRlhXemdrUnpM?=
 =?utf-8?B?eHRtUmN4SS9pS3FmbzlmYi9MdlpIMHJnVWNqWXpaSDlUZGt6R3k0TitHcFdD?=
 =?utf-8?B?MDBHQ25uejhRZUtVSDlEaURFYjJ3bVZnbEdkQnZjeUFMYTF6WkRDQy8zUXNy?=
 =?utf-8?B?MllvbWpyRTNMSnVYOUxINGR4RUV6K1dXMkdSYkZ5SjZhNndXa2ZQbnRuYXdu?=
 =?utf-8?B?eHc5N3I1ZGt5QUhSK2Y0UTVIek4zeTl0UkJlVTJwUngxQkV4dmVlQ0NCL0Vz?=
 =?utf-8?B?TnozdVlsbHlCMmEyY2RZanIxS0pVcytLbnRXNXRPKzFBWGVuOUxSd083RkZj?=
 =?utf-8?B?UDZsNjhlbUlXUUUzTnZNYS9JL0ZjTk93ZU9Ea2Y1Z0lzMksvZmFTS24zczZD?=
 =?utf-8?B?bXkrZGtYaHBBcHlMZG9wTDlpNURHaXhsRDZvN3FwQUV6anpJY3VJT0p3cG1l?=
 =?utf-8?B?bzRhdWVONG9uVVBwL20yNU03akgySVZnS3BacnJydGdDTlE5Q2RDZXpVazNR?=
 =?utf-8?B?WGF4RHZqMVo5ZzArTUlCai9JcGFWaHhnckNVZTJvcDZYVS9ZOWM5YTRiMmNJ?=
 =?utf-8?B?QnFvdk9UcmtkQnk1UGlXNm4yZTU0ZWs4YmwyaEI4VTBvQmNFNGZ6c3E1MVls?=
 =?utf-8?B?YnQyNmMrL04vMzU0RjR2OUJhU2JjUnBCY0NvNVJucEVFUHJ2M3hNVDlVSTVF?=
 =?utf-8?B?cC9Gd0QyenpnMG5ocmN4ZEJETEp3VFh5LzlJSHpsdEp6NFdhYWxJTnNkSXdJ?=
 =?utf-8?B?UFVMMnFqdExwSEVXYlNWQUxpTDNBSkxKVnFRNkFucURxRVRpWTlLMnN0M2ZY?=
 =?utf-8?B?RytGN1BYVGJaVlNyTDhSVmdwb2ZPWnhiaW00SG5VajZWU2tnSDhndW95bGRm?=
 =?utf-8?B?T2JxazNpTWZwZ2Vwdnh1MVZ5OWxaeWtXNGo3dytyQ0dmWmFxakd2d3VRYnE0?=
 =?utf-8?Q?FmpC1g03m5KCGyZXsicfaUvuRwcWexTjaYwUH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <792CA7012C171E4DBFCA29F05E7BD4C9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	T8hRfFJk5FubM83yKsBy9gDKXEkdtiT1rgi4QIR96psecCV0RPNJOjV6va37Cofkm4J8rPJeF0/Zf+gJp+TfW4wrMJbu4rEjUy/0aWcRpE4Klnez/yJ/vhxjwdvanYxck+9X5BBnv7egmaUWxXN40/bR55IqAKzUqDxiWXzMEJPpJhaTjZMIDFyYGxHkoZGlHhyHBLaf4ra7+COuubKaS5Ph5e6piDulfjAjP2XNwITWgRENU5uxeT/p7IDDHNAFgxtzfPgrTfaX/wkRaWuSEki7WfrAh6QaE4vT1T3WrNVYRn+lgMC/aPLTSaVEYbhNCCLwA2Y5aZyWzKrlg6vVHw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1749369e-1fcc-4659-e1d0-08de806d3b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:26:16.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6F/NedxSDAGsE+bk6ZB3exATh5fhz8JIIH6Yqc/ioog1Dim/t/IMQ6DhTm5jMcbVmHgw4/0qCJgcBPbV2qeiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5620
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b3135c cx=c_pps
 a=Q+OuU4uwq9JOSoz6MpkFfA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=t7CeM3EgAAAA:8 a=LhNk7-bS2a6xw73NXzYA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1NCBTYWx0ZWRfXx2y3RKYTdMvj
 2MCh/Goz5Q5aCu8s/FDi5/ftlG04eqPREwhSd8Qfg7iEL8kAYqakmesbUrci185MciU1eMTmfQN
 HOaVxnix9gc+XD0zE3mdIzZRYknT3RYmgpZxQ1oCUjpqCdavYpPkRBVQnXgyy/YIE+isHSMM1Wm
 l4gXXo5RXmEbYjSeuchIvOAdHJiukO9wDX2GIGVjsiPxRx0wVji37DxMjv/rvZST4on03bLMubq
 /UQzQBOQ5BHcM2+wr32MrHdQbxx9nGjmt/GD5dkNKaPjxQRCkfv0pZGxNtej9ueskRX1WAteyfg
 6OAnPrwZMUyaGSmvIXfaGlvE+/azoXnYOv8DYYL3quslxUspNhAFHVZZJb71R0Gp6X7ifRI3no+
 VrZSjbh8MzN/blTA8az+ZeDH2audqh/9DzSOKMp3+MnoiOJtixoQqaaDd2uHaVLHKJZWANsprw8
 qAXlGzTfRMYykHCYQug==
X-Proofpoint-ORIG-GUID: mbcODhloelo96ZiMGk209QMVp8PHYWkJ
X-Proofpoint-GUID: genQ14PFIMPV9qI2YRfGCZuRlTZxcUW3
Subject: Re:  [PATCH v1 03/13] ceph: add timeout protection to
 ceph_osdc_sync() path
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120154

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gV2hlbiBhIENlcGggT1NEIGJlY29tZXMgdW5yZWFjaGFibGUgKGUuZy4s
IGR1ZSB0byBJUHY2IEVBRERSTk9UQVZBSUwNCj4gZHVyaW5nIERBRCBvciBuZXR3b3JrIHRyYW5z
aXRpb25zKSwgdGhlIHN5bmMgc3lzY2FsbCBjYW4gYmxvY2sNCj4gaW5kZWZpbml0ZWx5IGluIGNl
cGhfb3NkY19zeW5jKCkuIFRoaXMgZnVuY3Rpb24gaXRlcmF0ZXMgb3ZlciBhbGwNCj4gaW4tZmxp
Z2h0IHdyaXRlIHJlcXVlc3RzIGFuZCBjYWxscyB3YWl0X2Zvcl9jb21wbGV0aW9uKCkgd2l0aCBu
bw0KPiB0aW1lb3V0IG9uIGVhY2ggb25lLiBUaGUgaHVuZ190YXNrIGRldGVjdG9yIGZpcmVzIHJl
cGVhdGVkbHkgd2l0aA0KPiBzdGFjayB0cmFjZXMgc2hvd2luZzoNCj4gICBjZXBoX29zZGNfc3lu
YyBbbGliY2VwaF0NCj4gICBjZXBoX3N5bmNfZnMgW2NlcGhdDQo+ICAgaXRlcmF0ZV9zdXBlcnMN
Cj4gICBrc3lzX3N5bmMNCj4gU2luY2UgY2VwaF9vc2RjX3N5bmMoKSBpcyBjYWxsZWQgYmVmb3Jl
IGNlcGhfbWRzY19zeW5jKCkgaW4NCj4gY2VwaF9zeW5jX2ZzKCksIGFuIE9TRCBoYW5nIHByZXZl
bnRzIHRoZSBNRFMgdGltZW91dCBwcm90ZWN0aW9uDQo+IGZyb20gY29tbWl0IGU3ODllNTI1MmZk
YSAoImNlcGg6IGFkZCB0aW1lb3V0IHByb3RlY3Rpb24gdG8NCj4gY2VwaF9tZHNjX3N5bmMoKSBw
YXRoIikgZnJvbSBldmVyIGJlaW5nIHJlYWNoZWQuDQo+IFRoaXMgaXMgcGFydGljdWxhcmx5IHBy
b2JsZW1hdGljIGluIGNvbnRhaW5lcml6ZWQgZW52aXJvbm1lbnRzIHdpdGgNCj4gUFJFRU1QVF9S
VCBrZXJuZWxzIHdoZXJlIENlcGggc3RvcmFnZSBwb2RzIHVuZGVyZ28gcm9sbGluZyB1cGRhdGVz
DQo+IGFuZCBJUHY2IG5ldHdvcmsgcmVjb25maWd1cmF0aW9ucyBjYXVzZSB0ZW1wb3JhcnkgT1NE
IHVuYXZhaWxhYmlsaXR5Lg0KPiBGaXggdGhpcyBieSBhZGRpbmcgbW91bnRfdGltZW91dC1iYXNl
ZCB0aW1lb3V0IHRvIHRoZSBibG9ja2luZyB3YWl0LA0KPiBmb2xsb3dpbmcgdGhlIGV4aXN0aW5n
IHBhdHRlcm4gdXNlZCBieSB3YWl0X3JlcXVlc3RfdGltZW91dCgpIGluIHRoZQ0KPiBzYW1lIGZp
bGU6DQo+IC0gY2VwaF9vc2RjX3N5bmMoKTogdXNlIHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91
dCgpIHdpdGgNCj4gICBtb3VudF90aW1lb3V0IGluc3RlYWQgb2YgaW5kZWZpbml0ZSB3YWl0X2Zv
cl9jb21wbGV0aW9uKCkNCj4gLSBDaGFuZ2UgcmV0dXJuIHR5cGUgZnJvbSB2b2lkIHRvIGludCwg
cmV0dXJuIC1FVElNRURPVVQgb24gdGltZW91dA0KPiAtIGNlcGhfc3luY19mcygpOiBwcm9wYWdh
dGUgT1NEIHN5bmMgZXJyb3IsIHNob3J0LWNpcmN1aXQgYmVmb3JlDQo+ICAgTURTIHN5bmMgb24g
ZmFpbHVyZQ0KPiBPbiB0aW1lb3V0LCBwZW5kaW5nIE9TRCByZXF1ZXN0cyBhcmUgTk9UIGNhbmNl
bGxlZCAtIHRoZXkgcmVtYWluDQo+IGluLWZsaWdodCBhbmQgY29tcGxldGUgd2hlbiB0aGUgT1NE
IHJlY29ubmVjdHMuIFRoZSB0aW1lb3V0IHNpbXBseQ0KPiB1bmJsb2NrcyB0aGUgY2FsbGluZyB0
YXNrLiBJZiBtb3VudF90aW1lb3V0IGlzIHNldCB0byAwLA0KPiBjZXBoX3RpbWVvdXRfamlmZmll
cygpIHJldHVybnMgTUFYX1NDSEVEVUxFX1RJTUVPVVQsIHByZXNlcnZpbmcgdGhlDQo+IG9yaWdp
bmFsIGluZmluaXRlLXdhaXQgYmVoYXZpb3IuDQo+IFNpZ25lZC1vZmYtYnk6IElvbnV0IE5lY2hp
dGEgPGlvbnV0Lm5lY2hpdGFAd2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL3N1cGVy
LmMgICAgICAgICAgICAgICAgIHwgIDQgKysrLQ0KPiAgaW5jbHVkZS9saW51eC9jZXBoL29zZF9j
bGllbnQuaCB8ICAyICstDQo+ICBuZXQvY2VwaC9vc2RfY2xpZW50LmMgICAgICAgICAgIHwgMTUg
KysrKysrKysrKysrKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9zdXBlci5jIGIvZnMvY2Vw
aC9zdXBlci5jDQo+IGluZGV4IGI1Mjk2MDQwMmQ2OGUuLjZmNGVlNDU3YzFiNTIgMTAwNjQ0DQo+
IC0tLSBhL2ZzL2NlcGgvc3VwZXIuYw0KPiArKysgYi9mcy9jZXBoL3N1cGVyLmMNCj4gQEAgLTEz
Myw3ICsxMzMsOSBAQCBzdGF0aWMgaW50IGNlcGhfc3luY19mcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sg
KnNiLCBpbnQgd2FpdCkNCj4gIAl9DQo+ICANCj4gIAlkb3V0YyhjbCwgIihibG9ja2luZylcbiIp
Ow0KPiAtCWNlcGhfb3NkY19zeW5jKCZmc2MtPmNsaWVudC0+b3NkYyk7DQo+ICsJcmV0ID0gY2Vw
aF9vc2RjX3N5bmMoJmZzYy0+Y2xpZW50LT5vc2RjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1
cm4gcmV0Ow0KPiAgCXJldCA9IGNlcGhfbWRzY19zeW5jKGZzYy0+bWRzYyk7DQo+ICAJZG91dGMo
Y2wsICIoYmxvY2tpbmcpIGRvbmVcbiIpOw0KPiAgCXJldHVybiByZXQ7DQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2NlcGgvb3NkX2NsaWVudC5oIGIvaW5jbHVkZS9saW51eC9jZXBoL29z
ZF9jbGllbnQuaA0KPiBpbmRleCBkNzk0MTQ3ODE1OGNkLi44NzE4MjdlMmRkOTgzIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NlcGgvb3NkX2NsaWVudC5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvY2VwaC9vc2RfY2xpZW50LmgNCj4gQEAgLTU4Nyw3ICs1ODcsNyBAQCB2b2lkIGNlcGhf
b3NkY19zdGFydF9yZXF1ZXN0KHN0cnVjdCBjZXBoX29zZF9jbGllbnQgKm9zZGMsDQo+ICBleHRl
cm4gdm9pZCBjZXBoX29zZGNfY2FuY2VsX3JlcXVlc3Qoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3Qg
KnJlcSk7DQo+ICBleHRlcm4gaW50IGNlcGhfb3NkY193YWl0X3JlcXVlc3Qoc3RydWN0IGNlcGhf
b3NkX2NsaWVudCAqb3NkYywNCj4gIAkJCQkgIHN0cnVjdCBjZXBoX29zZF9yZXF1ZXN0ICpyZXEp
Ow0KPiAtZXh0ZXJuIHZvaWQgY2VwaF9vc2RjX3N5bmMoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAq
b3NkYyk7DQo+ICtleHRlcm4gaW50IGNlcGhfb3NkY19zeW5jKHN0cnVjdCBjZXBoX29zZF9jbGll
bnQgKm9zZGMpOw0KPiAgDQo+ICBleHRlcm4gdm9pZCBjZXBoX29zZGNfZmx1c2hfbm90aWZpZXMo
c3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYyk7DQo+ICB2b2lkIGNlcGhfb3NkY19tYXliZV9y
ZXF1ZXN0X21hcChzdHJ1Y3QgY2VwaF9vc2RfY2xpZW50ICpvc2RjKTsNCj4gZGlmZiAtLWdpdCBh
L25ldC9jZXBoL29zZF9jbGllbnQuYyBiL25ldC9jZXBoL29zZF9jbGllbnQuYw0KPiBpbmRleCBh
YmFjNzcwYmMwYjRjLi43ZDVlNGEwNzhmYjEwIDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9vc2Rf
Y2xpZW50LmMNCj4gKysrIGIvbmV0L2NlcGgvb3NkX2NsaWVudC5jDQo+IEBAIC00NzM0LDEwICs0
NzM0LDEzIEBAIEVYUE9SVF9TWU1CT0woY2VwaF9vc2RjX3dhaXRfcmVxdWVzdCk7DQo+ICAvKg0K
PiAgICogc3luYyAtIHdhaXQgZm9yIGFsbCBpbi1mbGlnaHQgcmVxdWVzdHMgdG8gZmx1c2guICBh
dm9pZCBzdGFydmF0aW9uLg0KPiAgICovDQo+IC12b2lkIGNlcGhfb3NkY19zeW5jKHN0cnVjdCBj
ZXBoX29zZF9jbGllbnQgKm9zZGMpDQo+ICtpbnQgY2VwaF9vc2RjX3N5bmMoc3RydWN0IGNlcGhf
b3NkX2NsaWVudCAqb3NkYykNCj4gIHsNCj4gKwlzdHJ1Y3QgY2VwaF9vcHRpb25zICpvcHRzID0g
b3NkYy0+Y2xpZW50LT5vcHRpb25zOw0KPiArCXVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGNlcGhf
dGltZW91dF9qaWZmaWVzKG9wdHMtPm1vdW50X3RpbWVvdXQpOw0KDQpUaGUgb3B0cy0+bW91bnRf
dGltZW91dCBjb3VsZCBiZSBjb25maWd1cmVkIHVucmVhc29uYWJseS4NCg0KPiAgCXN0cnVjdCBy
Yl9ub2RlICpuLCAqcDsNCj4gIAl1NjQgbGFzdF90aWQgPSBhdG9taWM2NF9yZWFkKCZvc2RjLT5s
YXN0X3RpZCk7DQo+ICsJdW5zaWduZWQgbG9uZyBsZWZ0Ow0KPiAgDQo+ICBhZ2FpbjoNCj4gIAlk
b3duX3JlYWQoJm9zZGMtPmxvY2spOw0KPiBAQCAtNDc2MCw3ICs0NzYzLDE0IEBAIHZvaWQgY2Vw
aF9vc2RjX3N5bmMoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYykNCj4gIAkJCXVwX3JlYWQo
Jm9zZGMtPmxvY2spOw0KPiAgCQkJZG91dCgiJXMgd2FpdGluZyBvbiByZXEgJXAgdGlkICVsbHUg
bGFzdF90aWQgJWxsdVxuIiwNCj4gIAkJCSAgICAgX19mdW5jX18sIHJlcSwgcmVxLT5yX3RpZCwg
bGFzdF90aWQpOw0KPiAtCQkJd2FpdF9mb3JfY29tcGxldGlvbigmcmVxLT5yX2NvbXBsZXRpb24p
Ow0KPiArCQkJbGVmdCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmcmVxLT5yX2NvbXBs
ZXRpb24sDQo+ICsJCQkJCQkJICAgdGltZW91dCk7DQo+ICsJCQlpZiAoIWxlZnQpIHsNCj4gKwkJ
CQlwcl93YXJuKCJjZXBoOiBvc2Qgc3luYyByZXF1ZXN0IHRpZCAlbGx1IHRpbWVkIG91dFxuIiwN
Cj4gKwkJCQkJcmVxLT5yX3RpZCk7DQoNCkkgYW0gbm90IHN1cmUgYWJvdXQgbmVjZXNzaXR5IHRv
IHNlbmQgdGhpcyBtZXNzYWdlIGludG8gc3lzbG9nLiBNYXliZSwgZGVidWcNCm91dHB1dCBoZXJl
PyBNeSBwb2ludCBoZXJlLCBpZiB3ZSBzaW1wbHkgcG9zdHBvbmUgc29tZSBvcGVyYXRpb24gdGhh
dCB3aWxsIGJlDQpleGVjdXRlZCBsYXRlbHksIHRoZW4gc2hvdWxkIHdlIGluZm9ybSBhYm91dCBl
bGFwc2VkIHRpbWVvdXQuIExldCdzIGltYWdpbmUgdGhhdA0Kb3B0cy0+bW91bnRfdGltZW91dCB3
aWxsIGJlIHJlYWxseSBzaG9ydCwgdGhlbiB3ZSB3aWxsIGhhdmUgYnVuY2ggb2YgbWVzc2FnZXMg
aW4NCnRoZSBzeXN0ZW0gbG9nLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiArCQkJCWNlcGhfb3Nk
Y19wdXRfcmVxdWVzdChyZXEpOw0KPiArCQkJCXJldHVybiAtRVRJTUVET1VUOw0KPiArCQkJfQ0K
PiAgCQkJY2VwaF9vc2RjX3B1dF9yZXF1ZXN0KHJlcSk7DQo+ICAJCQlnb3RvIGFnYWluOw0KPiAg
CQl9DQo+IEBAIC00NzcwLDYgKzQ3ODAsNyBAQCB2b2lkIGNlcGhfb3NkY19zeW5jKHN0cnVjdCBj
ZXBoX29zZF9jbGllbnQgKm9zZGMpDQo+ICANCj4gIAl1cF9yZWFkKCZvc2RjLT5sb2NrKTsNCj4g
IAlkb3V0KCIlcyBkb25lIGxhc3RfdGlkICVsbHVcbiIsIF9fZnVuY19fLCBsYXN0X3RpZCk7DQo+
ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNlcGhfb3NkY19zeW5jKTsNCj4g
IA0K
