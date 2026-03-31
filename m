Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EC423146
	for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978121; cv=fail; b=JAtdMr4jydvBWBU9InE6orNiSvlyHxzrXgKwUxFzsZFFWR8XlpslJVpDbvEJo+38I7VbzF5eAe3clXMPBC0d3pjL5bh+t0OMZE42KGZe5gfZlhnHzq+QsYqT7IPRoTmUFNIgheuZPwi0UFScYf7ItFv1l83FRynUr6a4IucOX3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978121; c=relaxed/simple;
	bh=PQ65ARXm9V08zlMdsvzn5DjWn40p05v6NWF0FIZTF0w=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lFshpnLnz2GzGtivp++EeHlonpMsKpMwC0/ixn55J8wgZFqGtkhiCkP8Ot5RUBw0j8gMisOLNiTQYktFYiWjadpnliwgepM93CJnpUT8hf8zP8bsLWT8Frx6ELRsB7ZZPQ3CpBbycmPRzcq0ygXg5SfOrzKlcspjlUyDAEFvdU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H+Ju0Sba; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H+Ju0Sba"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V7oWJL108414;
	Tue, 31 Mar 2026 17:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=PQ65ARXm9V08zlMdsvzn5DjWn40p05v6NWF0FIZTF0w=; b=H+Ju0Sba
	C5kIbny8cJ97fPRLvcyxVSdRrVBsHcVOdubWDE9TUlGtTnMhhgJ1JE8lA4ns1hUv
	dQsEBNL5Sz3PNUzVIYZquq4/fDw12lkppunWzS+65OhYttucMRbvIrEVQIcGTp30
	HcuITqUmjxeyBV66n1t1JA/1lXEdU3dkW9BT+tMrcZlJMflFTg+3ICQD7U3FDBoL
	3UxQ1ZmuUGxTosQnX1llvkAtkS6F+rFf9jxcLEooDzm8N8MXW/7pLmgh22WiySUM
	11ljkDhRnnAt8DdQuEwzzSmhCRrnNJRQKlCiuRpS3UxEcItSSPh1BEkTYuXgW2ko
	2ETsVxF7MtTaIg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcc38e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:28:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wclGqzVIGM+qZAZZ0kr1B4CRzJ0XM3OVylJKWuMfkYs6yzqsEzzlPEmzrjbfRYOZcT4TJAuQ5BphcZ9i8+PrVuyEs3zXUjeeNXfpcwAmQF3xRcCamrV3Ilo7xgVFc681sMa0WYWqfuyKlhwoBr9NLdzeRf0g/1vTDwyjojhJb3QA3A+FGrNal4QBunzyYEw04qahVHbTCFvm6L1BFMpomji+WUgaoHWvvTMZk9iuF1ki0l4ttCQOvEWVOXCcqQod2qRCBnnthCuPDhSfCTi7WiS4nrNnBNX22QHSv4iF4GHopQ6T/wwycHM5BopJo3v3arH1ugKVVopoB/VYZqfD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ65ARXm9V08zlMdsvzn5DjWn40p05v6NWF0FIZTF0w=;
 b=CUloCvlaeUsfR/OuEij+0UK0sF8phOsGW1ulBJ8CzUp8oyKNqVM1kSliIZfifp4SZBxWUUTeC+mGL6DF0Gjgm35aGdRShI3pd2vjl5af1UpTX/U26jHr76mAZ1NAOxOEsnrP/JMpNwR2O/0Ekp5i/Y9WZmL05VEa0qCVJLyDRQVUl58kmIWbjZh4sLDnWfR9sG0atCA3B4g6trYN4tTzgAYXW/rlaVJeHPuoH2OxIgMpCtZtWbEmjTH79s8e8+WTTvdRoS0TA1quvLE1aGW1ui51bVSZqxsfpljKPVqPBu6cLG1z3UgBwrm4kn+gUHuX12cUFTqvbip301o8UZFzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA6PR15MB6814.namprd15.prod.outlook.com (2603:10b6:208:5e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 17:28:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 17:28:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        Patrick Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: cleanup in crush_do_rule()
 method
Thread-Index: AQHcwTKfELdg2L2bXkGcsUm1MLjWxLXI5S6A
Date: Tue, 31 Mar 2026 17:28:31 +0000
Message-ID: <d81eaee640f20cc8a166ea2d8b4dfc0518aba7fe.camel@ibm.com>
References: <20260330204652.178736-2-slava@dubeyko.com>
	 <CAO8a2ShjuZaizXGptVMnZ2NKS1vixNpGRN5LT8cyGO5b1ktuag@mail.gmail.com>
In-Reply-To:
 <CAO8a2ShjuZaizXGptVMnZ2NKS1vixNpGRN5LT8cyGO5b1ktuag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA6PR15MB6814:EE_
x-ms-office365-filtering-correlation-id: bac2669c-99d7-4f05-a9e8-08de8f4aede4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 fnK8G6mBTJt2Cu9otVFqXELwA2fJ7n8+zoNBol4ei0Lj4rlI7+5jHO2yP6cVqRK6KZhzrhou83witiOdpEE/3T1QdtWWA7WcKa4v4I4IvhMKjK2wSpLEzLRxRbZWFxxikrqHMqlUiesntVbNh/K+TkJ+9fe6y1O6x21tUd8PBPDRdEUrvERb0YKCq668vGTKN62cojaech5mNQdWwY0aPTGqGLnQqblfPoLJX4kr1eSLIX0msVew4RhqInYqtPmIE5iyLxnxN1WRpj6QBlMGI8msah+v1fuOyixzhwXdALmZG6qlo4mwouKhzCwQjh6kseB3L4z1MDA/LOjEdR7VuJF1JMR2vqY8eYpZRsEEdWeyGtQ26ZnICywiCUvlFJdOT3bUFHXIWazftrd5WyWOTe3bea3/942ymrCbyxFSM3tQBjkfojzXsTSX3FiaWAdyDp5Gzh/jM1gtStbQNCFvN9oSmEwOoNZKRMG61vKeI+myHQvTsPQeoFy8rZp/SJGCeSjb0x6YiEb4fVUd8FZu5s6lEhDMp4Wwf/mAQOqNqVy9sULeL3lbzTWicw5ObUXpSQNbL+X3amK6miCmWr/rnV4IdArHF6r6Uge5aGwesOWMS7uOfaxNKJ/nviEKxp+niv0wdg7gh01Woomi7+hcK+bSLF5EDurxcrs9uEoH3z6wMmKUtYhNbSdtY4qvMvg9Qjp3T4nuGBrCGUR1ugs+irDbokE9bAw5GucZ2xM64mq/f0wMw+C/ybzeiuMfD3KLqbnicjqZJnS1lnCjHVOPSudZXoyPJk/PoXLInXnrbgI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXEwWnRxcUdHNS81UDAwQ1ZPVjJDNGxwSWpIWVRDWUlJSkdjbVBjNzg0dFNk?=
 =?utf-8?B?MSsyaWpIdXB1Tk5sbVVtQUV2cFVwZzJGYnR5TGpZMVM1VU5DN2dpdXl4Rkpj?=
 =?utf-8?B?TEVHWndaUHV0U2hKWjdqSVB6anRUK0VqanpBcWI2c250TXptRFc0Wmc5UWE3?=
 =?utf-8?B?M2xibE5aMVZLZzlQMysxZ3RPYUhrR090aUVxNnBRSWpJNE9yVGhnWDVxdmpX?=
 =?utf-8?B?Wk5HOUpMVzFubFBYSnc3dGN2cStmVjM5QzRFc3pqczlSSjR4a2hWZnBDZG9B?=
 =?utf-8?B?VTA2MUJuNHlFa3lKcXJDYkZPSVJZN09aNmQ5VGhoOGVuSXk4S3liQTZXQWdz?=
 =?utf-8?B?d0o2MDdGRzZKdkJvSU15TFZtczNOMU9KbHF0VmRiZWtYancyNGxESW05SGtj?=
 =?utf-8?B?TWJWL1FlSDkzOTlCdTErS0tpc0NvMThzd2lFbGVhOEdNWGRXM092M1d2bWwz?=
 =?utf-8?B?TkhWS1Zya2RKNlZUaEdRV1I5SGkzWi9VL3JoTG9CTkJJQmUxKzgzd25HWjhn?=
 =?utf-8?B?T21iSFExSEcxajZ6bTJQSk9aZjBlMGl1ei9Ra0pISDJZQXBtWlJnbmdWS3hz?=
 =?utf-8?B?N1JHWFF6SnBwRHBmOFp3aUZRcjRMMnRkeFhrZ3dYYkFvdGlYNGN4TWdYbFkx?=
 =?utf-8?B?TnVmb05BRmlnUlJEY2J5MFBEak5UTmpTZG8zUStLbWFTanJJMWtLck9RdHk0?=
 =?utf-8?B?ZUt4aVRnSDIydWI5SDR4ay9OUklRWVJPd1RHa2hQb1YxUWRyaUxjV3FQbE1i?=
 =?utf-8?B?cXpDSHFOSmF6RENMQUJobnJiWEdxejlJb3BGUkJDWE8wRXY5cmlFdW0vOXBa?=
 =?utf-8?B?V3FUUmJEbVFleFB2SHpIazNCRHdaOTMwUjhjbnFNcnhiZy8vRnNQQ2luazRS?=
 =?utf-8?B?K0dQU1dJcnQ4bEVMSnJaYWhtZS9IZGRFeFhEMUxLTmdHb2s2cnZ2MXdDRE5a?=
 =?utf-8?B?WlFXZVVZQVhqd3NkZkJ0aWwyOXZzZFhNSm9sdk5oa3hrR3JQWEtIMTlSNkNn?=
 =?utf-8?B?dmNId0hCMkVDNUR4dkJZTDRMbDRYYXVoTjdyZllWdzh0UFk0YXdaa2VFcGM3?=
 =?utf-8?B?SXhuNlJwd2tiQlpHNmxlS1hsd1FEK2FMbVVZSmFKbnM2bkFONDIvWGNMdkpi?=
 =?utf-8?B?VzNYMnJHcUcrT1lXYkxoWUlLZGFFMVNxTHV3R1o1SWNuTW4rMWlsMmtNdnhF?=
 =?utf-8?B?YTJPcHhpd2M4ck91SVRYZHFCd0E0ZzRIcHJaYml3cUt3d2RRY3ZLaXJoSlRO?=
 =?utf-8?B?ZVQyVnJkaG9LWjBGejJ4TS9kRC9wTnMyU2F3K2cxUmpZS0doenhZbWw1YVlq?=
 =?utf-8?B?RndENjlmNytPWXlmK2EwVnhPM1FKZ29WT1FQak1hUW9Qc0o2T3R4ejA4cXNk?=
 =?utf-8?B?U3NOV05SUVY0R1puT0ZVM0VFU3N0UWt4SGJsT0VaQ0hQWjQ4cDFacUoxcnE3?=
 =?utf-8?B?SUdOSDRFbHVVN1N2NzVHb3B1KzEva0t2My9IZ2ZETk9DZTJlVlFsR3Rpb2Rk?=
 =?utf-8?B?U2R5VmtkUldrWHI0N2lIUkZkdyt4S2xGWStpV05mRWF1U2Qyck1QTDhadi9Z?=
 =?utf-8?B?RUh5NmpFSWI4UldNK2pFdGYvUkNaYklaWXhjRHlEbDF4cmVveldNSUF1Y1M5?=
 =?utf-8?B?YS9NRWxGa0dPSnQ0Y0tsM0pqLzU1TFRqeTh1TXM4cW9Rc051RXVJOEg4eUhS?=
 =?utf-8?B?T3ExZ3dOMmxrMmdYekc1SmZIcCtjUm1zMzM1ZUFBNXVxczg0WHk0cmtmekY2?=
 =?utf-8?B?ME5ySkluTmVmeHpTZG8raVovdkV2aVo4ejNjZ0pLSkNYSGwwNFpRVEZGN3E4?=
 =?utf-8?B?UXpkVW1sQ21aamswVjFyTUxYdVVYOXBsVVFGcUw4ZEJKMVNjRU9LZ2k1b1pD?=
 =?utf-8?B?WTg0ZkZiVzVSRlFFRk5LMkxRdTNlYWNKcEFGMHptQmpldmtNdVVCTExxMjY4?=
 =?utf-8?B?NjhJMUlIcllYZUowZWJVbVVvdXc5VGxHLzFKZnVPcVZXcG9Pa2FqeDJoWlJV?=
 =?utf-8?B?eUFQN05xNFk1WTU4MjBYSWltM2JIeGpjSHFiaDlpbDA4WnVpcFFjUGVDYXQ2?=
 =?utf-8?B?WmY0MS81dHQ1bXN3OE5CNC9lVno5ZkllUHhkdktKeEZpV0lyZXY4WU1PZkR5?=
 =?utf-8?B?bHhBY3lVZkFnZExUZ0VHZW11SW55TzBtMEdmak1hU2hkQURnNG5KUlljdlBL?=
 =?utf-8?B?YnFNNkplSmN2S2gwRDl1UFlvNEI3RWszK3RDY01WMWNZMTR0YWJmUEJvY1cz?=
 =?utf-8?B?bmlsWnliQTZkQzJYTVQ0ZDMvYzRMaEMrRThvTy83TEdDMHNpaXRZc3BKSzk0?=
 =?utf-8?B?OHlRMk9WaDdXWU1tbzFVYzdJa1hrK2FtL01FSjVKZ0sxYVFLRlFjUndHQlBS?=
 =?utf-8?Q?ivlw+GO5Xhvbgdx5J22VC8m6H19Gpk0mVhL//?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E0648899A956E4E87F28E8473F30A16@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	udD1QCkLvJywmOL/RZyTeiFhpi8IFsnbBWiL8t5LZepvXXhgmtdTiVYJnx061sT3Hmph6FucXoMiz5MgwkRBrVqTsHiMFXBZrnSnVNk/8VNWQaukvMkVPA351gJmDWJOEukacHSxNn8hy+JlsrFrc88gFUq+blEVFF8IzANViGwtApOrD9s0gyeeaYHUBKHugacSx/NQr1UlUgjwwcHQ1H93QjmcNvCdsazowGMkmQwfCL2Lb3WbZzMpDX/eWobLoTGiGhI8APUIqIQgup5SQFzgGnKQk3qxLaNW/9ZtEacCoIs+AeKMvnRjt7bcieJ8+SPDEVgMQYp+2cjN66ADHg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac2669c-99d7-4f05-a9e8-08de8f4aede4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 17:28:31.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJeaC0yQkIvi9+8/LnjI9l02GUbVZGddHlcT0mPwm9EQMmTs7v2jQyqhmRd71PDJ5SgiQ6uJrAoVvolMHWFaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR15MB6814
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cc0442 cx=c_pps
 a=F3cLoQkZAZJ9C40TIYDoAg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8 a=wCmvBT1CAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=uWCx6A8KNNFATYZXb0IA:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: y7Y3kEYJj-WYj_0aDME5Lu4hIX4u82uM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2NiBTYWx0ZWRfX/KZHzNPNkF6v
 Nh+bxk3Gxz3vtWm9/7CT2cBDggQPQKYdoiedPrcsRfikW+ttQ/Tginpzkd/XBBQBWtN94vSiNFX
 lA1Fyjl/5syvc4ztQrosggYYQGBL9X3I1GeUrw5nyG6r0u87/2wyCANH6ebiIM7aSpEl0sNkiXR
 7M0v8XeJI8GevZ3DTXjvNgFOLJG3uPCj0ltP00ar4sQ6gFRr4n1dQ8Q792oI7V3YJKtlLwbCB7T
 1UPONjfwNALHvLXZIClkDTOWZmQ87DRTmhja8Uyoct+QE+XFzt3R2GM5VNU4lDnrL4+c6hq+RcU
 s+z5Rusv6yzlL1PTXem2q67B3Zu4ibK+LbNSFHavU3GzVY4UEQFdQCEEf2W2RtSk8cA+tz8b9vo
 8jNvkygEDC2orBKpXdgNU9WHnXExcmWq5y911miLtA4TfZke3385dHyxiKdsau8I7Xvkeub5Dnv
 38L45bXeY0r5iZOWKMA==
X-Proofpoint-ORIG-GUID: lzrRmou7_svaSpX0IB1fjqLZwshCud5J
Subject: RE: [PATCH] libceph: cleanup in crush_do_rule() method
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310166

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDIwOjE5ICswMzAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IExvb2tzIGdvb2QsIGJ1dCBoZXJlIGFyZSBhIGNvdXBsZSBvZiBuaXRzOg0KPiANCj4gICAxLiBU
aGUgc3ViamVjdCBwcmVmaXggdXNlcyBsaWJjZXBoOiBidXQgdGhlIGZpbGUgY2hhbmdlZCBpcw0K
PiBuZXQvY2VwaC9jcnVzaC9tYXBwZXIuYy4gVGhlIGNvbnZlbnRpb25hbCBwcmVmaXggZm9yIENS
VVNIIGNvZGUgaXMNCj4gY3J1c2g6ICh3aGljaCBpcyBhbHNvIHdoYXQgdGhlIG9yaWdpbmFsIGNv
bW1pdCB5b3UgcmVmZXJlbmNlIGluIHRoZQ0KPiBGaXhlcyB0YWcgdXNlcykuIFNvbWV0aGluZyBs
aWtlIGNydXNoOiByZW1vdmUNCj4gICAgZGVhZCB2YXJpYWJsZSBqIGZyb20gY3J1c2hfZG9fcnVs
ZSgpIHdvdWxkIGJlIG1vcmUgYWNjdXJhdGUuDQoNClByb2JhYmx5LCBpdCB3aWxsIGJlIGJldHRl
ciB0byBoYXZlICJsaWJjZXBoL2NydXNoOiIgYmVjYXVzZSBjcnVzaCBpcyBhDQpzdWJzeXN0ZW0g
b2YgbGliY2VwaC4gQnV0IEkgYW0gT0sgd2l0aCAiY3J1c2g6IiBpZiBldmVyeW9uZSBjYW4gZm9s
bG93IHdoaWNoDQpzdWJzeXN0ZW0gaXMgdW5kZXIgdGhlIGZpeC4NCg0KPiAgIDIuIFNtYWxsIHR5
cG8gaW4gdGhlIGNvbW1pdCBtZXNzYWdlOiAiVGhpcyBwYXRjaCBzaW1wbHkgcmVtb3ZlIHRoZQ0K
PiBkZWFkIGNvZGUiIOKGkiAicmVtb3ZlcyIuDQo+IA0KDQpJIGNhbiBhZGRyZXNzIHRoZXNlIGNv
bW1lbnRzIGluIHNlY29uZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBpZiB5b3UgbGlrZS4gQnV0IGl0
DQpzb3VuZHMgbGlrZSBub3QgbWFqb3Igb25lcy4gU28sIEkgYXNzdW1lIHRoYXQgSSBjYW4gbGVh
dmUgdGhlIHBhdGNoIGFzIGl0IGlzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiANCj4gICBSZXZp
ZXdlZC1ieTogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiANCj4gT24gTW9u
LCBNYXIgMzAsIDIwMjYgYXQgMTE6NDfigK9QTSBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1
YmV5a28uY29tPiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBWaWFjaGVzbGF2IER1YmV5a28gPFNs
YXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gPiANCj4gPiBDb21taXQgNDFlYmNjMDkwN2M1ICgiY3J1
c2g6IHJlbW92ZSBmb3JjZWZlZWQgZnVuY3Rpb25hbGl0eSIpIGZyb20NCj4gPiBNYXkgNywgMjAx
MiAobGludXgtbmV4dCksIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgU21hdGNoIHN0YXRpYw0KPiA+
IGNoZWNrZXIgd2FybmluZzoNCj4gPiANCj4gPiAgICAgICAgIG5ldC9jZXBoL2NydXNoL21hcHBl
ci5jOjEwMTUgY3J1c2hfZG9fcnVsZSgpDQo+ID4gICAgICAgICB3YXJuOiBpdGVyYXRvciAnaicg
bm90IGluY3JlbWVudGVkDQo+ID4gDQo+ID4gQmVmb3JlIGNvbW1pdCA0MWViY2MwOTA3YzUgKCJj
cnVzaDogcmVtb3ZlIGZvcmNlZmVlZCBmdW5jdGlvbmFsaXR5IiksDQo+ID4gd2UgaGFkIHRoaXMg
bG9naWM6DQo+ID4gDQo+ID4gICBqID0gMDsNCj4gPiAgIGlmIChvc2l6ZSA9PSAwICYmIGZvcmNl
X3BvcyA+PSAwKSB7DQo+ID4gICAgICAgb1tvc2l6ZV0gPSBmb3JjZV9jb250ZXh0W2ZvcmNlX3Bv
c107DQo+ID4gICAgICAgaWYgKHJlY3Vyc2VfdG9fbGVhZikNCj4gPiAgICAgICAgICAgY1tvc2l6
ZV0gPSBmb3JjZV9jb250ZXh0WzBdOw0KPiA+ICAgICAgIGorKzsgICAgICAgICAgIC8qIDwtLSB0
aGlzIHdhcyB0aGUgb25seSBpbmNyZW1lbnQsIG5vdyBnb25lICovDQo+ID4gICAgICAgZm9yY2Vf
cG9zLS07DQo+ID4gICB9DQo+ID4gICAvKiB0aGVuIGNydXNoX2Nob29zZV8qKC4uLiwgbytvc2l6
ZSwgaiwgLi4uKSAqLw0KPiA+IA0KPiA+IE5vdywgdGhlIHZhcmlhYmxlIGogaXMgZGVhZCBjb2Rl
IOKAlCBhIHZhcmlhYmxlIHRoYXQgaXMgc2V0DQo+ID4gYW5kIG5ldmVyIG1lYW5pbmdmdWxseSB2
YXJpZWQuIFRoaXMgcGF0Y2ggc2ltcGx5IHJlbW92ZQ0KPiA+IHRoZSBkZWFkIGNvZGUuDQo+ID4g
DQo+ID4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9y
Zz4NCj4gPiBGaXhlczogNDFlYmNjMDkwN2M1ICgiY3J1c2g6IHJlbW92ZSBmb3JjZWZlZWQgZnVu
Y3Rpb25hbGl0eSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2
YS5EdWJleWtvQGlibS5jb20+DQo+ID4gY2M6IEFsZXggTWFya3V6ZSA8YW1hcmt1emVAcmVkaGF0
LmNvbT4NCj4gPiBjYzogSWx5YSBEcnlvbW92IDxpZHJ5b21vdkBnbWFpbC5jb20+DQo+ID4gY2M6
IFBhdHJpY2sgRG9ubmVsbHkgPHBkb25uZWxsQHJlZGhhdC5jb20+DQo+ID4gY2M6IENlcGggRGV2
ZWxvcG1lbnQgPGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICBuZXQv
Y2VwaC9jcnVzaC9tYXBwZXIuYyB8IDcgKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQv
Y2VwaC9jcnVzaC9tYXBwZXIuYyBiL25ldC9jZXBoL2NydXNoL21hcHBlci5jDQo+ID4gaW5kZXgg
M2E1YmQxY2QxZTk5Li4xN2IwNDE3NzlmYjkgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2NlcGgvY3J1
c2gvbWFwcGVyLmMNCj4gPiArKysgYi9uZXQvY2VwaC9jcnVzaC9tYXBwZXIuYw0KPiA+IEBAIC05
MTEsNyArOTExLDcgQEAgaW50IGNydXNoX2RvX3J1bGUoY29uc3Qgc3RydWN0IGNydXNoX21hcCAq
bWFwLA0KPiA+ICAgICAgICAgaW50IG9zaXplOw0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IGNy
dXNoX3J1bGUgKnJ1bGU7DQo+ID4gICAgICAgICBfX3UzMiBzdGVwOw0KPiA+IC0gICAgICAgaW50
IGksIGo7DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gPiAgICAgICAgIGludCBudW1yZXA7DQo+ID4g
ICAgICAgICBpbnQgb3V0X3NpemU7DQo+ID4gICAgICAgICAvKg0KPiA+IEBAIC0xMDEyLDcgKzEw
MTIsNiBAQCBpbnQgY3J1c2hfZG9fcnVsZShjb25zdCBzdHJ1Y3QgY3J1c2hfbWFwICptYXAsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChudW1yZXAgPD0g
MCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGogPSAwOw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyogbWFrZSBzdXJlIGJ1Y2tldCBpZCBpcyB2YWxpZCAqLw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm5vID0gLTEgLSB3W2ldOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGJubyA8IDAgfHwgYm5vID49IG1hcC0+bWF4
X2J1Y2tldHMpIHsNCj4gPiBAQCAtMTAzNiw3ICsxMDM1LDcgQEAgaW50IGNydXNoX2RvX3J1bGUo
Y29uc3Qgc3RydWN0IGNydXNoX21hcCAqbWFwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHdlaWdodCwgd2VpZ2h0X21heCwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4LCBudW1yZXAsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Vyc3RlcC0+
YXJnMiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBvK29zaXplLCBqLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG8rb3NpemUsIDAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVzdWx0X21heC1vc2l6ZSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaG9vc2VfdHJpZXMsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVjdXJzZV90cmllcywN
Cj4gPiBAQCAtMTA1OCw3ICsxMDU3LDcgQEAgaW50IGNydXNoX2RvX3J1bGUoY29uc3Qgc3RydWN0
IGNydXNoX21hcCAqbWFwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHdlaWdodCwgd2VpZ2h0X21heCwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4LCBvdXRfc2l6ZSwgbnVtcmVwLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cnN0ZXAtPmFy
ZzIsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bytvc2l6ZSwgaiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBvK29zaXplLCAwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNob29zZV90cmllcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjaG9vc2VfbGVhZl90cmllcyA/DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hvb3NlX2xlYWZf
dHJpZXMgOiAxLA0KPiA+IC0tDQo+ID4gMi41My4wDQo+ID4gDQo=
