Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277673CF030;
	Thu,  2 Apr 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154767; cv=fail; b=e8M5Vf9kanBdfaM73tB5WvI6Y0F/Qey4KJ5LI7xQvnVcGGI1kSMdsWtBZeyFtMpVXeJ7iXKUck1hJc2WCSzR9+9ZPxm+kCb2R7WRbpD9VDdPNMAuT/CA6dmTvoCAU4rxOzWwHVZ9Df0dmjMlEhMIsih44OsGZsMR7JhwusKRwVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154767; c=relaxed/simple;
	bh=8Cxei97ufz2fff8pInIPcKv7apMMvwLOBQxI8nVBBoY=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HoIDZo34vpwPNv4WHNP9diaZPfXtd/CxmU1o2B57M8akLM2QDHkPeVKcy5jQKaipAeBm5kBb+FLCrzrihYOZOXqY9VhJpT/v+iOv69+YWJSZL3EhGqB85LGqzHt/wGEdAhTvfVlhT6kOQR9ujKTwMb0ylgTTj2hgyuY2PxkWFrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EntxPHBJ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EntxPHBJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632EYJCG4004654;
	Thu, 2 Apr 2026 18:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=8Cxei97ufz2fff8pInIPcKv7apMMvwLOBQxI8nVBBoY=; b=EntxPHBJ
	OZgrTKa0hxpcqgv1R0GoAWnYXL1frGHyuqMhYsRcFzpQDGyThkpIzJEluCiB2B/o
	BZ1bepM8Jl1EJNhOPb76nk9pGl+ppp8pUuVQr3eCNmG9HKxR9LQj4HIjV2Kt7rcF
	r/AWP9egLggbpNL7X/z+nClrxHXZfOnZIHQWI0b0C+apfvRwCEiEJgsikOPn1Shi
	rd6WMtN988aMlICPaGjB8c2TiQBY+SvJsS+E/91M2vQWwDG+mSlke4XuccWpowM8
	2oUaPNNzxBpmGPgUKCNY90fFCVj+iN/zmpYZkBGu4nIZ8mC1krVdEKfJ1sMdLkcD
	N94ohoFJXMd68g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcn70n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 18:32:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+Ip4CFP4Jw5O2/40J+39RRd3PddbPLhpWrR3eKfd9igHHwbZK4td7GvttBpLrr+oQrXVxcXpna23ThjO89tjvZgQV/QkiMnWn+Y4GALlngSR/5EnD5nbfugrKJ/+hwJfjvxkkNw/F38aa8T6HVZwaHxEqIzs9D/SQSAvhO83XbuL7qBN0XBh/wO+D9hIymqymHi+YVes6ehkorNn5X3muxWLfHObrgPBZYXXYMDDUE8j4NhAB6gY3cnvKeBUqfazSKCUr2rO1byY5h9C1kn7MtaFqNkKtawYHe+5JLsFSV8NLb5nn6PpTzpsltMszaaHftzF/x7V/CDgaTiP6GJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cxei97ufz2fff8pInIPcKv7apMMvwLOBQxI8nVBBoY=;
 b=t/jwmR10HH2ITPYPZUKReVByUIPXLn/G/P/N727p3T6WF9SoGdRr7kZvmliXF79hO4Dol6taAMcdT3TWaDqLR9P6v/Q2jAXhjMEkj7IQ9E7+mIwh4lZ+aCqVgaJDx19OC9H6UaUHGPUr8GPxQ1bfk9Saf5Rz19+9hpgVgeTsROKbWMkv7yDP6w4Fga4GznerFB5UbdSSGSJKkbadiRABO9M6QM80QISXAJd4/TM2nCD28inPMH+GcHMoxdqU2MdS8eMYc8RQZFQxpGZ1RD/PImXzjkbxm0P607P9uI0qGAfKb6+M5GFga+8pFb61oHDQLSUrqDwVfj3nAKxWmnoPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4625.namprd15.prod.outlook.com (2603:10b6:806:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:32:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 18:32:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: clear `s_cap_reconnect` when
 ceph_pagelist_encode_32() fails
Thread-Index: AQHcwsxSIC0sOA105kqRvjIc+xq7qbXMGJKA
Date: Thu, 2 Apr 2026 18:32:39 +0000
Message-ID: <9579b7451acedd9a189394f863f489d46c13ecd9.camel@ibm.com>
References: <20260330084319.1357751-1-max.kellermann@ionos.com>
		 <edbc43fe2e234c41e1c72275c176fc22dc773a58.camel@ibm.com>
	 <a14adf2a0b021ca604d1de2252b3c63593b4b001.camel@ibm.com>
In-Reply-To: <a14adf2a0b021ca604d1de2252b3c63593b4b001.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4625:EE_
x-ms-office365-filtering-correlation-id: 5a2060c8-e619-4e96-4113-08de90e63898
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 faffl//LP79LTWCuoUG8aKXj1G58mFYDWZyyW5lbqHqme1Hf/TWIYcOxe/FhQHlpK5VtZ/k9lgaTPmxRu2+eqUicNCtCWwRoaAM1ruc7Usl1YijFPAjQ5libVxOM9/SV3gNQmkinNzluGEbAzoQ9bXl00D2C4tWc90pEBCpagZtlOdEjvlQpM6B8CU8AfYBxwtWyth0msvW9MrTmGTmSOlxIQzD6JKgU+GhTlcUwEQzFExQAgxvZVa4zyX7Rv9AW5165MDuplvfInf3PRbZ1GgU6SP/u3aAqRUzn8G4cSR1YU1I+7bpl/QD0gb/nYYQApjBeNH/ijXwcx5Vyc0d52NKAimmOM2bRn22QmThwMrR/ZjFqGM4zaae2J/mrYXm7ku41e4jw66ZFilqpnpiWfj5TvKyk0A0RUfAY7fNsqsw/wPGmC21nJdZPhE5SXvxzQXPEdWJzy9dIjkqQZIO9ePhZwJ43FJSdzR+/CSTTbv2wGKKsy1R9W5o4DFc+JjFrjz6WPls61+N8axUyweGJx1I80Ovwjfj0KTiP15XKjpgPrLEqqlEp6/ayUF+4ujplsN/e/qG4D9yLsj8WJxbX58YGAXP84h7OO1s2I6yCd5IaxOwt7ttmQHRpaEaikJ22/M7uUwuRqv3+9hDaKBFLkHvoA4cxCAIU76Rrky5nyk10iVE2uE9yZPzw0K48RQaX1qq18iLCPF+6FeFbbssHvLSKqBVjFfl6K0bGwbDLbVfTSZX74vjYQE0PvGdFXZw0z2i2TU0qvMiXGu7bQc3WROuEBPORuKZrCh+COsCwqXs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXlVSENmVGtvM2tGaFE4ZWZzOEFjckZPQkRHMWhkYjVGYk55a2RWYzRVN2pQ?=
 =?utf-8?B?Ly9LUmhKLzk2VXVLVzBVa3VWYW80cnV6Y3pvc3Z3cmliSnFqSFVQelhNeTJY?=
 =?utf-8?B?cEU2YVZpUllabEZ2OVRFNEtEWWU5bXVrYXNJS3RCcWRUOTgwdW52b0M3MHVR?=
 =?utf-8?B?UGdJYTV3UVI4c2l5UklwUURkNkNGLzNWRzd0R0k2QTBybDIwZG1XbFZVOW8z?=
 =?utf-8?B?cXRmQXRWN2NDU0RpVGhHVFlRNU0vTVcrd1UrMHBqbzYxVVFIVmFmZFgxME91?=
 =?utf-8?B?Vkcxd09Vc1RqUTJJcjAvTHhNUU9DYk11L1lYR1lQM3lPSXRCV3JWT1J2RXpN?=
 =?utf-8?B?SzF0TjRHQnNuZ3h2S0cvL1pQT2RKQ2VrcnUzendVU3k0bndCaVA2amVpV3dz?=
 =?utf-8?B?aEE0bUxCbUZBSEh0N2NjL05kNlJUelh5TDVNUFVxR1dLcFVDVUdoR1JwQVB2?=
 =?utf-8?B?c0FuK2VNWjNEcVNkdUV3R3ZoSFY5bEFzL2NEWXBSOG9nQzNUWTFFV2lUbDQx?=
 =?utf-8?B?RTJFVnNTV3hvOXpIOFFUbzRKVEVYMzgxSWxSUjBtakNjVWlHdWdJZU5ZL2kx?=
 =?utf-8?B?bnp2ZkdxcmNCVWxESHhscFRrNHBSZEVEYmlIWHNwdFFld2ZpZi9tU3BRMDFi?=
 =?utf-8?B?aGJOWHd2YWwySFFjaXMwVFZYQTJhbU85ZWtmS0l2SFJIcGlDbzB2V2c2QlZ5?=
 =?utf-8?B?QzYxU0pJZzE3dEVBRWlkeWFKSmlyRHZnMnRIa1JMcDNkWHJieHBDbXVDbDh5?=
 =?utf-8?B?QnN1a05iejJnZ0RaVnR1ZWY4bWJiNm9PNzRMc2dnOTZGcVNMVzB6R25lLzI0?=
 =?utf-8?B?OVVjVGMxWFhzTi9wMjdoYkJVRHFIazZDQXloUWhwaFE5Slp5YXZ2SUFzRUpR?=
 =?utf-8?B?YmM4WTJJS091cUUxSVlBZHIxTEl4MGxJUUpmOXVwamdjemJySmcwL2FPRzY1?=
 =?utf-8?B?OFJnOXIrVEZZR0VManRSWkd5cjVOenV5Z3h4dXUwK200QXZrdWRMWC9CZ3Rm?=
 =?utf-8?B?SlRacHl0OStWWU1Ob2FxWWJDRzZqUnNyK1NTTmttdUNwUmZLMkRORWFoY0JT?=
 =?utf-8?B?VHpRSDl0SWNmWTdKdEVsdXVqN1c4UUFwTVpTSDRhYWlKUGVQL1Y3dVovR0JN?=
 =?utf-8?B?SGhpOForbDVHbGExcTd2Y0xzUFJCN0FpSEVPdXFDMlBqdzJSZVJtY2tjVU1Y?=
 =?utf-8?B?NEpSQXdZcm55aVV6KzNxWVRFTUJuejZhNHZVUjZQVmsvZWtwSXJlQ3hyYjE5?=
 =?utf-8?B?c3FTeFRERzd0Sy9BRlJaVklnMTVTcmlWbGI5cEFJR3BPNndxc0EveU5VWVJZ?=
 =?utf-8?B?MWZ1aE5vN3kvMlZ4UGVLRHprTDRSaDEwb25oNEJaSmpwTWlRYlcwTWdCalk3?=
 =?utf-8?B?eUg0WktnTFlNNWVFeFJBQ3JVNktwREVCZTdnRzVyZFhHSmVwYjkyc0VzaE9l?=
 =?utf-8?B?N2EvNm1MK25vMUtGc1NoZWoreVg4V045N3ZNSjVBRWduMmxpUHNkcGlNNVdP?=
 =?utf-8?B?dDY0aEk3TUpXZHpYWTdDMHpPS2dzRjY4TFFRaVZxZUZsOE8ybXlWOWEzazlT?=
 =?utf-8?B?TExMbFUzaCs1TTc5d3oyRnJOVjczMnpsdHpDb3JKdVFlQkYrU1hEcmNWMWx5?=
 =?utf-8?B?TnJUVXVURVFQUVJSYkgwNWJrdWo3NkwzbkNseUpTbXgzV29QQXIyTVQvN1l2?=
 =?utf-8?B?RGRxTjlrdXRVZW4rWE55ajMvVGV2emt2VWttaHp0T3VwL0I1d2c5angvbDZZ?=
 =?utf-8?B?Ym8wVFA2b05vVnIzSll4TStNQ2k4T2tOVkJZMEtya3ZFMHNqcjkvUms5bkVQ?=
 =?utf-8?B?b2VMbFVtTVlLbzZxUUs2RUt1aFovMFhsQ0hsU01vT2h2Y1ZKMk4rTzFzR2Mw?=
 =?utf-8?B?M3gvRjhVRzFrMGphb2ZaTEIycDluaGZxOXIzMFdLTVp0Tkh6Zmh2K01HUmdT?=
 =?utf-8?B?ZFd5UzZ4TXZDMVlTcHRIOE5OeXNKTlNzMS9nQk54V2s3VS9HL0ppclBFeGN4?=
 =?utf-8?B?UjcrNEJjWWNCdFVsTitUdzRQVFJqbENmTU4wUG13dFFybFh6WVAvczRpYVlX?=
 =?utf-8?B?NUg3QWJTcVh2R1JISnk1NkhOcUVERGJMV2M3QW42K2JQS3hMV25vbS9pb0hl?=
 =?utf-8?B?R3ArL25maVZleGRoTmp5WjdtY1dYU1VsdkM3NVNoenc3Ky9vWDE2eXFXbGFx?=
 =?utf-8?B?QzNlWWx4NmRaeHk1emlnVUhscWdnRWpleW9pVFBUczRGcWw2U1c5NlZwSG8w?=
 =?utf-8?B?dEZOT0xVTStmS0NMdjFmMGk1M21TbHVNazM5anBjV25ZMlNQcDZkbEpaMEhC?=
 =?utf-8?B?SUhha1l1OFJRbjdSN2ZJbGQ2NVk3MXZZbEh4SmJkNXNlbW1Fak1zZEN5Rjc0?=
 =?utf-8?Q?BM4oHepUYLI7JSlxvcCJ79UJzEgGYxoIvT5Hq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EB1D648713FDD419787FB5B00EE0B2A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qDQiIV1J5YeFWMAjUeixdYeVp99z3zxMi245F6DdPMLTCNl+4XMv/u4W7xuGpqL9TI5WxGQc+4B4/1lvJN2ITG5tJZLgdauxxe/u7Li1kzTDkcIbq/33LXHFmG0gfJsY8Xb0T3qcCV/l2C2nmhSYK2NtRfAGEnryBlwPka1meM3bxY7ZE/sFYsLZ38Gfp6To86B/E2N5g7wluJzAjZpldLzBaiXUZsmBUF1cfIZBQD+Ar+BJDiurbYnNQClWUSHuPf0EVZbwYgVKENX70t5mCzWM+hdBV4gkFOEh9UoHBETtstFt6m/4ZqC2xgNJfTWbvbwEg9NpngtLjuBQ1wkK6Q==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2060c8-e619-4e96-4113-08de90e63898
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:32:39.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgwspSVQGWfJ1KSBkMnE/WCMI+5QRFloDdfoQ8qtS8LzjIZcaLRpWhqgtsNCsHglyHxuGKf5F9alx2q9waPPng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4625
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ceb64a cx=c_pps
 a=z/rjtr9/JqYX5j7IdmSYkQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8
 a=PJjUM5dyAkjedQeajawA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: YytQq5np010QpY-yR52oxaPUk8YTGL9H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE2NCBTYWx0ZWRfX6IzvgNckigqi
 bx+hZafwI2MrLBZMh57Yolqo5OAkjgw3c79ss3ewsspeLYslttRSJXwKbfUAWz4RrQjvxGd87M/
 pbcizbR67cxX9j6fGaqagi9BaBpZbCMrYZXzxCGLEXb94iyaV7wXE52J/M3kskJksBnGW4Td9Nv
 yzRZNGdQprbrKO4i7fqkm98muamMij9c2mNwNWTgofGQTK5lCBfJNxZlNMlxQKU/kaNZhAqCC1A
 11tCUVhhj23h3psA9rSVp5jWmEUQYIWRFI818elww93mMUUKCh+R0Meub8ohQPHCtKJcQ+0aEh3
 VyrvAUajT0ujFomA98oJVGArXxPiv89BNZ4UiWlsT3FmjxaDA2EbhmI/R9apYMFuJkO8gSiJRYt
 UJNCTRW7DabL5fx+dQuEOBa6qb/oDX6kquy8pfwDJKVkTudw1VLFv0bFiMw+TZw9ckR331wnPxI
 /0Y3rO5INx441nBf2eA==
X-Proofpoint-ORIG-GUID: jMml_nwEv80FDoTg1BJiI0O7uQvcGEL1
Subject: RE:  [PATCH] ceph: clear `s_cap_reconnect` when
 ceph_pagelist_encode_32() fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020164

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE4OjEyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIE1vbiwgMjAyNi0wMy0zMCBhdCAxNzoyOSArMDAwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNi0wMy0zMCBhdCAxMDo0MyArMDIwMCwgTWF4IEtl
bGxlcm1hbm4gd3JvdGU6DQo+ID4gPiBUaGlzIE1EUyByZWNvbm5lY3QgZXJyb3IgcGF0aCBsZWF2
ZXMgc19jYXBfcmVjb25uZWN0IHNldC4NCj4gPiA+IHNlbmRfbWRzX3JlY29ubmVjdCgpIHNldHMg
dGhlIGJpdCBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSByZWNvbm5lY3QsDQo+ID4gPiBidXQgdGhl
IGZpcnN0IGZhaWxpbmcgb3BlcmF0aW9uIGFmdGVyIHRoYXQsIGNlcGhfcGFnZWxpc3RfZW5jb2Rl
XzMyKCksDQo+ID4gPiBjYW4ganVtcCB0byBgZmFpbDpgIHdpdGhvdXQgY2xlYXJpbmcgaXQuDQo+
ID4gPiANCj4gPiA+IF9fY2VwaF9yZW1vdmVfY2FwKCkgY29uc3VsdHMgdGhhdCBmbGFnIHRvIGRl
Y2lkZSB3aGV0aGVyIGNhcCByZWxlYXNlcw0KPiA+ID4gc2hvdWxkIGJlIHF1ZXVlZC4gQSByZWNv
bm5lY3QtcHJlcGFyYXRpb24gZmFpbHVyZSB0aGVyZWZvcmUgbGVhdmVzIHRoZQ0KPiA+ID4gc2Vz
c2lvbiBpbiByZWNvbm5lY3QgbW9kZSBmcm9tIHRoZSBjYXAtcmVsZWFzZSBwYXRoJ3MgcG9pbnQg
b2Ygdmlldw0KPiA+ID4gYW5kIGNhbiBzdHJhbmQgcmVsZWFzZSB3b3JrIHVudGlsIHNvbWUgbGF0
ZXIgc3RhdGUgdHJhbnNpdGlvbiByZXBhaXJzDQo+ID4gPiBpdC4NCj4gPiA+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWF4IEtlbGxlcm1hbm4gPG1heC5rZWxsZXJtYW5uQGlvbm9zLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgNiArKysrKy0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9mcy9jZXBoL21kc19jbGllbnQuYyBiL2ZzL2NlcGgvbWRzX2NsaWVu
dC5jDQo+ID4gPiBpbmRleCBiMTc0NjI3M2YxODYuLjRmYTQ3MWQ5YjNiMiAxMDA2NDQNCj4gPiA+
IC0tLSBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+ID4gPiArKysgYi9mcy9jZXBoL21kc19jbGll
bnQuYw0KPiA+ID4gQEAgLTQ5NTYsNyArNDk1Niw3IEBAIHN0YXRpYyB2b2lkIHNlbmRfbWRzX3Jl
Y29ubmVjdChzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLA0KPiA+ID4gIAkvKiBwbGFjZWhv
bGRlciBmb3IgbnJfY2FwcyAqLw0KPiA+ID4gIAllcnIgPSBjZXBoX3BhZ2VsaXN0X2VuY29kZV8z
MihyZWNvbl9zdGF0ZS5wYWdlbGlzdCwgMCk7DQo+ID4gPiAgCWlmIChlcnIpDQo+ID4gPiAtCQln
b3RvIGZhaWw7DQo+ID4gPiArCQlnb3RvIGZhaWxfY2xlYXJfY2FwX3JlY29ubmVjdDsNCj4gPiA+
ICANCj4gPiA+ICAJaWYgKHRlc3RfYml0KENFUEhGU19GRUFUVVJFX01VTFRJX1JFQ09OTkVDVCwg
JnNlc3Npb24tPnNfZmVhdHVyZXMpKSB7DQo+ID4gPiAgCQlyZWNvbl9zdGF0ZS5tc2dfdmVyc2lv
biA9IDM7DQo+ID4gPiBAQCAtNTA0Niw2ICs1MDQ2LDEwIEBAIHN0YXRpYyB2b2lkIHNlbmRfbWRz
X3JlY29ubmVjdChzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLA0KPiA+ID4gIAljZXBoX3Bh
Z2VsaXN0X3JlbGVhc2UocmVjb25fc3RhdGUucGFnZWxpc3QpOw0KPiA+ID4gIAlyZXR1cm47DQo+
ID4gPiAgDQo+ID4gPiArZmFpbF9jbGVhcl9jYXBfcmVjb25uZWN0Og0KPiA+ID4gKwlzcGluX2xv
Y2soJnNlc3Npb24tPnNfY2FwX2xvY2spOw0KPiA+ID4gKwlzZXNzaW9uLT5zX2NhcF9yZWNvbm5l
Y3QgPSAwOw0KPiA+ID4gKwlzcGluX3VubG9jaygmc2Vzc2lvbi0+c19jYXBfbG9jayk7DQo+ID4g
PiAgZmFpbDoNCj4gPiA+ICAJY2VwaF9tc2dfcHV0KHJlcGx5KTsNCj4gPiA+ICAJdXBfcmVhZCgm
bWRzYy0+c25hcF9yd3NlbSk7DQo+ID4gDQo+ID4gTWFrZXMgc2Vuc2UuIE5pY2UgZml4LiBCdXQs
IG1heWJlLCB3ZSBuZWVkIHRvIGNvbnNpZGVyIHJlZmFjdG9yaW5nIG9mIHRoaXMNCj4gPiBmdW5j
dGlvbiBiZWNhdXNlIG9mIHN1Y2ggaXNzdWUuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFZpYWNo
ZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiA+IA0KPiA+IA0KPiANCj4g
VGhlIHhmc3Rlc3RzIHJ1biBvbiA3LjAtcmM2IGRpZG4ndCByZXZlYWwgYW55IG5ldyBpc3N1ZXMg
cmVsYXRlZCB0byB0aGUgcGF0Y2guDQo+IA0KPiBUZXN0ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlr
byA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiANCg0KQXBwbGllZCBvbiB0ZXN0aW5nIGJyYW5j
aCBvZiBDZXBoRlMga2VybmVsIGNsaWVudC4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
