Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6A3A451E;
	Thu,  9 Apr 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753776; cv=fail; b=eCFRknMWZ28epAFTVDi2J+mgbbBpGVyEbhhc7utn61zsJELeerT1+MsidVsQ2zsSmIBopsfrmm51cWD9MhrmF6FGcPG/NvZjDrw2XY3Vqf4l9669mCRbbjYIGyZUoXxqnCYKeuOrjXmE2EIPOJu4VneGA719G+R1W0kch2rFrDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753776; c=relaxed/simple;
	bh=il26xi1LLmbi/2M3OMQQoQkao1uCCbHxhosWIyzXWQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/dNWMmFSuvC8IiOMvejCw36l5wd7LUQQ8zrllSNUTfpEibd0mF0WJa1Po6tH4Mxj1aS/m3u51rju0fOI0K7ix/v3cBKzYnL9+mm5GWMZAR9DEjnruw9rgHnfXxeSwLr2dsLFDQ6EXExBrOwioeiDduD/BiGtQoGyClFl2sDvzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eK81hg/K; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eK81hg/K"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639A47gU2210133;
	Thu, 9 Apr 2026 16:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=il26xi1LLmbi/2M3OMQQoQkao1uCCbHxhosWIyzXWQQ=; b=eK81hg/K
	YoBBFrbcamSAiiocZGcC+KgUJ1L+8cXTsGmjFZQv9vQ/RX5D7Lf+HENS32TEFyHh
	y1kmRepjwMCmkPCAtaYzzBEauOlyn6Jw7iJp+rGxhI1+WO9vHTFkOKOh25FssP44
	yhYDQ6omxIabcxDKzqe9cTzAXGZQXMGxd+RWKWuI+q3o6yBfukMvELkg1g5+g8Am
	7T8Aq69fHEd9pcr2Wxx5hdR8TxYFqtjV+gETEustb8Cn3tMi2QqI30k0AOP8tiQo
	buYDCkRKOoqXrbUjmBFdds9VRevXrnEPnMalE+Q6p4+U+etCIU+r8i1QqrKGh5Cz
	BoQeAkfzg1YJgQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hn626-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 16:56:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGOSfh764GS6ELFQc/bXUvHRArYyMtxUnl7YDvtnF8TAfwf0gXlKNGSlOkUDmD4HmxGFnZ+8w0GTbf8LQUgdUEJWLh7G3FMTRMdiX0JpLxHptismc7w3mXdVaU71cmlYoPpAQz2E/Lemo6OQ5WI5m42zk/8itXqg7+Fd6JCzgndLnQiSRnjxzTJVVAcEVUbTxndvaVsDuzYGq5zRGSnV8BNcql9B2vVJtm2kYgLIrX+sLcfK6yW9B5T4RdMKM1kNpMZMbMiurqPCGhmKgKBngYwMkm0qDOaf3doVB7hs/OhradxKBayPUYZRLMnqbNmCt+sgBczjyOZSMDzK1wsF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il26xi1LLmbi/2M3OMQQoQkao1uCCbHxhosWIyzXWQQ=;
 b=JK0PxEhHtf6K2NR/lpdas9s/zhh6iub2+UuJOPUjvS1DOFwUJNBtiiEwcDFO21J1M0tUXG9nlb+xuWzUS9EXBVE3tUO6AHYCoqJUlwsohZjyuoPk9G5WbwXb+XoJDRrYLNN7O6Ah9r4/AQk3CxbB5GKTtV9zzM+09+3cz6kz/DQBo7N+A7F6JjewsnX7zK5NZ1bJkdHRKNj+CnhU2PiJmhmimlB+yQ9N2hvt0NA2F0ID2FfpCBkUr/J7hTfIIOxbJ+Oe39hqztjzOOuDOAhcdqa2muqi8pOtZ9bJan7FRiiOBHVsKOj+cDkSSZEjO1CIN4uFw7Zksamn4Wdn5EGFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by SA3PR15MB5679.namprd15.prod.outlook.com (2603:10b6:806:314::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 16:56:08 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 16:56:08 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] ceph: add ceph_has_realms_with_quotas() check into
 ceph_quota_update_statfs()
Thread-Topic: [PATCH] ceph: add ceph_has_realms_with_quotas() check into
 ceph_quota_update_statfs()
Thread-Index: AQHcyEHC3TdMKFcCtEaDa0d1bw/cPQ==
Date: Thu, 9 Apr 2026 16:56:08 +0000
Message-ID: <ffb57bd74275412022cb323439a6841a7c46e5f5.camel@ibm.com>
References: <20260408181123.310291-2-slava@dubeyko.com>
	 <CAO8a2SgeDwVzdKphHYQZJMV_z5Sg7Mc=jfPY3q1RZTvCWaUDkA@mail.gmail.com>
In-Reply-To:
 <CAO8a2SgeDwVzdKphHYQZJMV_z5Sg7Mc=jfPY3q1RZTvCWaUDkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|SA3PR15MB5679:EE_
x-ms-office365-filtering-correlation-id: c672e891-48ee-4162-7e39-08de9658e56e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 NWQiaA+cxWy0frqJlRELewXl6ZRGKBRWHTqMVy1IS+asZ93pSZ0GUOv7SWW/zqcAZzS5fDnQYO3bsdjw43R2UmOPyrDjcokF9OHyLsPu3ra656NbI3ckWVAr9QKZ5jtYi3MO+tVMNqq/zdq9EZ7KCBypIFPH4hUcYroHtIZs5WzpPI9o0U4JUwXm+zFDYCx0eYoxy94TI/8Giu6y7RUz5QgefKDEm3+De2PBmUxJh57h9ZIwD70ztC6pL8kwPiYnciXjKq0YqhRjbddSBXYyodpO5N3HFmkLsrXYog855OONcS9d2wAckXB1c+o7+uLzjBZLLu+iTBmrU7OoCRtyy3yszJAHLqVmBgoAVRs/fsZEA2SpXNSTUviHPzT2h4HXhTt/v469pO/dt/n9Z8bvhUh5jefSkbxw0ltw2IA4oe/iWV74aq4U2fazsouTyVL6lNVVNP+ZzJy2Z42D6XiairxzWNDoNvEE9nCcpp+mJPwNlkQZVlJqR1YgPtmbrcI7RBe/TLmelUb/pRTMmuuq2Lk15bX7SmT+S3mM+qU8o+d79jwqNHEr81XuFs+PFUZ8gX63/DLwu7azjJQLWhmJJJDVItXKcAKjdvzyeyjqVMWuESIUUKUk5ghO+fF65XWC1IRW2F4fOQHB2NUUEJ1twlTZVZPrgxWhG5qWTlbm+PAX5T2qd0cROOxpOCkoBgFVYGXpPhFZoqZbEwxrxTCcQJlEbipT+ncp6OYdmyXbjmmQRvH7CkRTk9PjE2q/7fxTov7261WB6CFb+tIfTW1lbstFQ2NDZbH5JPwjFknQ0pA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3doRDlsWUtSNW1wd2p1ZmlZdnViYnFGYXV2WjN3VTEvMEpCZlAxV2x3dnR2?=
 =?utf-8?B?R2N6MVNBSmtOa1ZRUFFEMnBzZFNHZ29udnJIUi94N0FyZG01cEhiQ2Fkc0NI?=
 =?utf-8?B?WlZKNExiOGJUTitwS2NaYWhhSnNuQ3dJbWRhVHkvWDRXMG1TTStQVEIza3ds?=
 =?utf-8?B?WFZ1aWRQdzhPdTR6OVdMb0RBNFVGczhQY1FFYjQyVXRBZW1CaXhmZ3E4QXNw?=
 =?utf-8?B?eUo1MThGTGFwRitKMzVVd2pEWWJqMHpMY1FObk81N1VxZW1uT0RxRVJteEgz?=
 =?utf-8?B?cXZGOWJJVEpEK2Rpa2o3dFNQNnQweFRFU3BIQk5SaGdDWWljazNZdHN5ODB5?=
 =?utf-8?B?MmVIVktxQ2NhK0g3cjBxN1czV29IM3ZQNmlOeGsxMmx3K1lKV3N6UlpaWWJO?=
 =?utf-8?B?UWw4S1J0TEwra1ZKTWZFcEJBdHdQaFpqUmlyVXVYUEpFSERjRVlRc0tvV3g5?=
 =?utf-8?B?UGFra2IxdE1iVHZTSU9wamJuUzIvaU16WERpYWVydjVZb3VBTXFJK2VjNHNW?=
 =?utf-8?B?cHpVT1dWVGF5SW1iUzIwTk1wWFNqcWNDWWhJcWlFTktJS1plNWNING9mNVVQ?=
 =?utf-8?B?Z3lGUVNLVWMvWUtRdTh3bzBZbzVWdzF5UjFGUDZNbkhHVnZ5THZhb2t5TGxu?=
 =?utf-8?B?YWpCZWwvbXNnY2RhTDk2SXp5cGJST29WTTRsNllsQlVobXpESzlYZ05oTTdk?=
 =?utf-8?B?MnhTOTA1d1hrMjBlbTdBUmRIanpHd2FPbG5JaXN6ejVBS1l4amh0UlNnUzlq?=
 =?utf-8?B?ZXBEeTk3blpINUtxbHcvVEFDQXh1bmFjMndlSjZybzhHUG9qTHZHMFVHVjYv?=
 =?utf-8?B?RU9QcnVWbVp1Z3ZiMWY3ckZPVk54bEk4NzhSSWRNUndPcWY5TFVyckJVSk9u?=
 =?utf-8?B?c3lNUi9PRExuUDJmYUJuY0x0bGZuM3gzSWovTkE5MmZ2Wk55KzlCajRUYlM3?=
 =?utf-8?B?ZVhkenlCUHpGbFNxZno4cmVJV1FyWGVqMk1kcGF6TmZsQzJOdmppZGx0SWpz?=
 =?utf-8?B?cXBpTmhLdEFYQjZtN2RnTFY4ZW1ITjNWVGluTFpLQVJSVTNHRzN2YVpzMlBr?=
 =?utf-8?B?T1pmS2tpS3JVMnE2Vi9xdlBpTnJwTGViR3gzc2FMQlMrcjdxWm5wU3FZRkZ5?=
 =?utf-8?B?anh3WTBkMzFxUTVmRnhCdGMxdDRLWHFVMHhTbktTblpWQW5vMWxiSFRrcnZo?=
 =?utf-8?B?RTFOejIyU1V0NFNqY1k0Nlc2NVR4V2VBaUg3aEF0UFlhMzJ2Q3VMNmNWYldP?=
 =?utf-8?B?cFdNSG45UVN4aWFHd3YzR01vMWgyOVMxZ1lFNU0wcXovWWpFREV3am4vV0pt?=
 =?utf-8?B?dnpOYWNIVlQ5VmkrNm1yZUpsY0h4NFpMMk1STS8wT0FUS3l2aDBKY3B0UFVj?=
 =?utf-8?B?aG9FM3dOUDVXWE5LUjQ2N0N1TGh0cnJTWTdEY1RHR1doVG42TWtGMWpEMjMw?=
 =?utf-8?B?M3UyTHliWUYxWjhrZmwwM1Nsb0tpQVpYNDg2ZG5tK1hZTHBoc1BXUktubzRZ?=
 =?utf-8?B?ZVVPcFpnNkVic04wVG9Lb25lR0RhYVowbFk2b1RsenM0WmpDY0RqckpGY1hN?=
 =?utf-8?B?ZzZySjA0U3NlR1ZRQmcraC90R1J4RzdNVjJoNWYyZ1E0MWw0b25VMWVoM0NC?=
 =?utf-8?B?aUIxcmljMkdtVHRsVXRmNVhSZW5HcFBLUGUvaDA2cTBTZGYwWXJYUHNXaDlw?=
 =?utf-8?B?WWxwNTBBTHF2Ujh4bVBlOU85L0VMZWxmRW5jQVZUSVd1SHJETUJ1VTMwUzB4?=
 =?utf-8?B?cTVxZm5VbkJubm9OcTJlOFlLSnZ5MGsveFkvcGFGTldJTFN4YlN6SjUvN3Vy?=
 =?utf-8?B?TVBQeHhqelp1NzhabkJ4SG5talVMajJXT0kwb3dMQUprYTRuWG1TUDZKN2xW?=
 =?utf-8?B?czhBeWRRNjdDSFVMMVo4SHFpQTUyWGdaTEIvbkppUGZYZmlHdTdBN2lpRjUz?=
 =?utf-8?B?aUFMRW9rS3BCaDZvRC8ydXI4NmFNY0IrQU9CQWVRYWtFVitLcmdQQXdXc0pl?=
 =?utf-8?B?SFdXeFAxUWwrZlNDWGN4SjFVN2plYmhXN3YwbHV0MHVQM3h3QktVS0tURmdu?=
 =?utf-8?B?RHB6aDBGTW9OQ0FMSmdLUHdYdkk1WTYyNnhmT2ZYOWpmaVdtSG1KTTVSenZC?=
 =?utf-8?B?VGxxOVhNcFNBcVRseGdXTk1KSWpLMkJpYkY3N3dmT3ltMnIxa3pDV1AvSERk?=
 =?utf-8?B?QWhEYWRYVmZMMHRpWTA2bzNWZFNCTC9MSk9rTUd0T2dQS3NMNTNRNmNqQUov?=
 =?utf-8?B?aU5udVl4UVllbVNIWGFDQkl3bTNMQ0t5aEpGNmZGdGVQTFZrczU1ZkNFTWRF?=
 =?utf-8?B?YjRLWjZDSDgrUmQ3blJIZDNWQnd3TTd5MFpsZCs4YnZWYjhDbjkwTkdPVHpG?=
 =?utf-8?Q?1Eiao2epP+1R9WT4DdvmyVrV/a6mmnjXNz6cx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFBCD226EEA1C94DA4CBE7396A0D4012@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZS8bmvGPYnjsdfxKCKlju7OnOWnK0MFodevEswXtr3EC/wIDavMu0Put+8ZteBFaNK5UWcp1KyMRv6xH0LFVo/wWvGMlK896NWha3BD+yUnfyXQE4RSg4AzSAMyM8sSupm57R0CnEQvN3bUSZtfPgaQ0RGDTtlxQSwC12iBxmxxN71EIBYo0sMscsuwAkORTgieHrFAyhmgfqClCQVZR2P/5ycAMkPQOjuX+v+Mi1kj3fqpHImqcaIqNArLQ09puJuhzAFtKb2y2smoAQUGAvG5BPJiu4ZkjFBffNMlliaQc28tuJlY0wSHBDrMGOOlce7VlXGeMGb5UAjHvNqahng==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c672e891-48ee-4162-7e39-08de9658e56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 16:56:08.3682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BehSG4hS9xGQklm5nJS5YXGMm7csWtLeUoyIoFta7l6QB9cwc4w4EtFFB3kC0KWHZ6yanhI4du9a7u2qokwrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5679
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE1NCBTYWx0ZWRfXz1T+1z/5cTAC
 8ueLjWp9JohJ+cP9kBFIG8VmOyivFeGbA2pddvqFsQwzNFpywmaZdjeVLevWDsIl4Qvkvr01baM
 hoMUCM5ANIj+etAwUkJXUmiAZ5eANO1vlowBQ9hg1IX70FQvFUDmx64cSwVxcAyUj4ZlwLcs5yf
 DVXFFENIVQBG4jkCGAu21d/4i5HEF8qK8sxe10UFzrqgCNfHZ1V9T5RuUsRPhgGQvnQuoPO/kR4
 VapcNVbjY0h0NR21v4IOCiIsj59X1SXRN8vCddk0Zjv0DSlYxk5U/5jJ/FfKF+MBi0IYVgKVdQ2
 XvuVTKZ9yC4ryR3iqyCZvudNFNMCCO38hJKXKlVrG/yNZ7O5HFumUva2xJS8R8ejl47egmxUppk
 jP4WoY6D7m/nK/3NlWsIVZUtYBGK2zbGbGEW5e65wVuTNgsbPUUXXm6vOMOEjbizWdF2m8Mn6Kl
 RTgMkJOq+joS/R0Ok2w==
X-Proofpoint-GUID: HDjmhFCcpO1vadD4b2kANDGSABXGUwRF
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d7da2c cx=c_pps
 a=6XSCBLYFY2RPGp+89yprvQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=HjSdak9rjspamHn-mg8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rIGAEpiM1OEVr189XG1Mg_ukkFEIm5sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090154

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE0OjM0ICswMzAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IEdvb2QgY2F0Y2guIFBsZWFzZSBhZGQgYnJhY2VzIGZvciBtdWx0aWxpbmUgaWYtZWxzZSBzdGF0
ZW1lbnRzOyBicmFjZXMNCj4gYXJlIG5lZWRlZCBldmVuIGlmIGl0IGlzIG9ubHkgYSBjb21tZW50
IGJyYWNlcyBhcmUgbm93IG5lZWRlZC4NCj4gU21hbGwgbml0LCBwbGVhc2UgY2hhbmdlIHRoZSBj
b21tZW50IHRvICAqIFRyZWF0IGl0IGFzICJubyBxdW90YSByZWFsbQ0KPiBmb3VuZCIgYW5kIGZh
bGwgdGhyb3VnaCBncmFjZWZ1bGx5LiB5b3UgYXJlIG5vdCByZXR1cm5pbmcuDQoNCk1ha2VzIHNl
bnNlLiBMZXQgbWUgcmV3b3JrIG15IHBhdGNoLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K
