Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBF3B8924
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169749; cv=fail; b=tF+Ray7xeeW0tFeQJf02ILT3aLx5yc2MKLMdwOt+whE/yosUQVnxL6AqSBaMe+TpxGB0r+KYIN13rLLpN68nBc3rd6vbuIwjCdh2OaN9L9UqAiD9uNCBOkcv9TKThWnwblW1PCpv+M1YpWYnJUJ0zyix36jzudw6aM9J308dr/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169749; c=relaxed/simple;
	bh=y0hyNpf3pk8ed9mJPXZja2EB86pGtvDxOAeWCM/yZ7k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KEkDx/f0iEgkeqgb/LsHMuGX0SFOOHicau9sN23vYxWt0oYy234i2d2qUuwpOpiUfMRI/ehy6VTsKHD6LALfHBlH9MtTaL+FQA4u3ZpfSpUZbJjPAHHx6ii26nSxGJ04CI07qi1kXUDGY+Ms+wLjKda2VHjudj1vedqQ7qbg17E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YxI3lggo; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YxI3lggo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A95V4R1388081;
	Tue, 10 Mar 2026 19:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=y0hyNpf3pk8ed9mJPXZja2EB86pGtvDxOAeWCM/yZ7k=; b=YxI3lggo
	osnktl2rZGj4xVkHWZ6FIDV/NQg14RVjwUBooYxe0hg2KCCiCkYZI+3mU6VLccYh
	oLNgXrp7balFkSn20tEr5o2gP6P5g5WJbX8ZsuU3yVEHT1A+EyyJbfBJH/ygDdTB
	FUe0ThIR20f4M8Xw9Vuomb81x+gAiBWxCCWJhZOWpj8OM4G1ugr55aJzkLwOe/EN
	gFTC0uv3A/YtLtN193KZ2lOX4kZ4QCrBKE8wQZs0qWRhSKlsuloC/sfXDB6N1nvr
	TLHEpNX5N80vSuscdf7jNPoUYC3TEftH6/QM0NMeyqRs+ErfRmJw9sjZjpTbK0pX
	4MrdUqNofnbaEg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunc579-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 19:08:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izQjgn1sdmenB5lhuw3156XNug8m8o0uMbYZKU2pdlZgK5tWnvYRK1kgs2+yaXxlzPM7AMF9aJHAm77PnAksMf79pOa5hOQ/j9AWyZ5ugl4tZZSOcFEOm3kmjAf4M0vqBPWfU9YaBSgLMWxA5KS2si10MHsOVRAl/5e79EAeV5X71C912JLW+z0kuarPXcN1qy+I6hbsNxY/WrsCY2sBu1PsiQp1u+EVaZWGfuWkkb/nJ5C806rfhK8mWLGAC1AuZCGT7Pvk528MXzE5kR1+BGnTQhm3okBHw+wCXmXtvBCXnu5Paiu31EbEmfC20CE9CujYkuW9XAezmIuo4MJ1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0hyNpf3pk8ed9mJPXZja2EB86pGtvDxOAeWCM/yZ7k=;
 b=U9b0g3VxOUTTm7TJuupzkohh3ZxcaLqGWEjhYPqYjj1h+GKN1LLZiYfLlyMzV6VA5fsgPf8q/trC/quj7gBINu3Ph+EEMZ5zlzZP/y1wgS6jMbIHx7d/8uKTHVbTFreNH+IhLQJk146RCpFl8dmt5Y/iX9juuzjd6JXO8xnl4aFd7Z4VxxM0s7QbfPnkP3hAo3wmSue1varwEoLcwwQrjFfH/JRYcNPVyE8ZxKoH2kmlLwgQK50VjyC8SGPIy8j1EezmTIn9kYA1OV2ZWA5q55Fre3fjU6ScjupqrsvPOAo0S/d6gRcB9gxAe7vNQBjE8ILApjPNkvnzO3/UjjMtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5393.namprd15.prod.outlook.com (2603:10b6:208:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:08:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Tue, 10 Mar 2026
 19:08:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: reject preamble if control
 segment is empty
Thread-Index: AQHcsAXhHgJjq4bq6EufLCw+gmQv0rWoIp4A
Date: Tue, 10 Mar 2026 19:08:52 +0000
Message-ID: <72ec1d6227ebf4a07e3fa4c487ec274bc3e20e1a.camel@ibm.com>
References: <20260308221142.695096-1-idryomov@gmail.com>
		 <a02c4542718e9647072bcb7661f4d7834c64fcaa.camel@ibm.com>
	 <CAOi1vP8nUc_H_WAc=iGxcQAwsJBD1AtXp0gyMekm9W8U3boa8w@mail.gmail.com>
In-Reply-To:
 <CAOi1vP8nUc_H_WAc=iGxcQAwsJBD1AtXp0gyMekm9W8U3boa8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5393:EE_
x-ms-office365-filtering-correlation-id: 24f30026-ee4d-47e4-af92-08de7ed87837
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 T+aZIPd8NRRghFWqLqt4abVokF6PP3X51+8zZFuIfPBViDvcPnJlBdOkhPpiXP2kR9wHNt6MtMnmJNsf6d9oR0DXpwMEYZt5GEpJO/8da8yON3qknWX0GxVLWltK5JfkAyOWS0+0RvQY8onSbBE6t7az0V4fsECy5mD//HyLiC5yUpTgWsdTSBRtw1r/wNGgVQ0vyPY4CJPsoFIzr62OK8ov/nRsIxGlbvZLEUVQmQGeJZYECldho/qHgYV6q3ML4ZcJ9lrFYq2vsKUvm/bKo8Cydgr97uMsmjYCcRvAY32VJC1+bFpyHtETmuS9UKT9u7bzQtMEvMthwF5zDSMpCLeBjy16FVgiUsfpP+p4bdTYWVI9orVcSmDuUFeFWqHWAi9Jz9/jfxkEV8XCrQxrlfZGjYjtxNYeMf/0Qm5tdFcn/THc3q5vL53uUlKBROTElruzMqizZn4Ok8MasyIDWBclh3ghfJckTi5nSlgpVcqSFmr8OryBYt7ArpMuc+UvVb4xgAXf+tssxxDnomQAR5FOeY+Zh/K+E727Pr4stIGc3ioWmB43Fq8h7K191yHSajv+9rtx+vsP4W7QP9VU51Q2hSxA9uub+OGXyUzo52oDiTw4BcTNECcURQNc3Jz6ZNKHE8R6EheA7P+HnjujYq+Mh2fkMVzkKkH+qWiGWyv03UnE0ndoU9qiGqt3I684e39vnqlAIjhE9H8DhbUfPhkxGV+8uDtuQbdswwJ2YMF7ObjLUdrofw70bt8MTyvoVC4txMWUczgflWT8AE5JnKtMUm5yu7EdfhMy394Q+1E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDZVOUtlTk12R3Q1bHM3MU1TMjdSTDVkVWF0QzlTZnFZN3hHTU9RVXJ5RWVP?=
 =?utf-8?B?Wk84bmpGVDEvVUdTeGNQeC9aclVtZnVFWXR4NGV4V2Iyb0duSXZwSklBSlBV?=
 =?utf-8?B?ZHA2RE1idkRzNDcvQWJqRkQ3RWVjUHJGMG1lbzFZQ0YxVEZ6T2huUHJzUFE5?=
 =?utf-8?B?TUdlUmo1eitFbHAxdHpURHIxUy9MQWluMVVMUFN2bHM1VktrTFdsc3dZUFlL?=
 =?utf-8?B?eFhWNnF0NDU3N2VpUDhqOHNvbDRCaWVvQkNKWElsckpuV1JEK3RkV1pQdDQ3?=
 =?utf-8?B?WTJQUGo0K3FyaE1BUllmYWlSTXZNaWxGREVhaTJGTStrTy9rVTNzbHVqV3J1?=
 =?utf-8?B?V3Q5SWdNeHN1bWtPVkg0MW9xdnBEYzBwMnAwck85R2JKbWxKK0xHTSttTzlO?=
 =?utf-8?B?czZ1RC9Ub0lqVVZjRmhldnk1KzhvQkdFMlZxODlnc1cySFE2TS9nYXlwUGhR?=
 =?utf-8?B?RHI3UFd1Q1YyckVVc0dwRzNTeElnQTE2UDBuNFJmeW9abnlUWDFvaUNmV0R1?=
 =?utf-8?B?aytXSDdqK09xNC9lRitMQ1R5QmpHNi8vRVlVbUtEdmVqQVozWllRYzVRR1p6?=
 =?utf-8?B?Z1JKbWlHYUhpdkRJWmdTckRENlBubm13Z2dOZmlwTmh4aHVkZ3M1ckdyRzQ2?=
 =?utf-8?B?WXlsbXM4enJDdjRKbVNxRGxpZTRjaVRFbVM4eHVZMHRPZkU3aUUxaDY1STR4?=
 =?utf-8?B?QUpkZTFwRUpIY29Wb2UySldhV3NxcG5OZ29oMDhsamNNdVJoOGlhK242ZWZt?=
 =?utf-8?B?YWw2dW1yR2lqb1FEM0JNcXhtOW5CUzk5NWFxUjliaVdRaEJWN1ptdDhKWkdO?=
 =?utf-8?B?ZFZHb3Q4bTBleVhQWjdHbUNkaUhiSml3MlloOVB1SVNzbmhrcE9XZGM1Z3hR?=
 =?utf-8?B?QURxVU4xK2VNZUlsUXIrOGRpM292MDFGaVAvYkovT0xaME51dlNXZHFWRHdO?=
 =?utf-8?B?a21CR2JRSWdjY2ZHZnRmU0MxdUxvU3hxSm5Bb2dNMXJLeCt5QXNzRlR0N0k2?=
 =?utf-8?B?dkFldDFZa0JDRXVwOHZVaTVIZGF4a1NKamFsTWVQV2lzRmNoTEJyOGZaRDdn?=
 =?utf-8?B?UG5FV0s4TnB5UGNXZkVNQ0tRU01uY0czM1piZWxucHVHL09RVWNuMk1ITHFD?=
 =?utf-8?B?NEhvUG9BLzNkTnMwR3l3ZVJ6ZU5kNEFITXRCSEZoR2ZmTXhab094Z3pUWThV?=
 =?utf-8?B?OGgrOVU5YkRJWmpLSXQ1TFBjcjc0WjNPMFFZWk43UTBjMUQwaHZoNFZVM090?=
 =?utf-8?B?Y0NTOUw5OCtsUzk4Z205c1lSb0k1OEdmanZSaGFOZW9OdkE0NU9oTjdqT3hn?=
 =?utf-8?B?aElOVXlaOTlSTUwyRzZjd3A5elhaV2ZNRThMdHZXdG9EQ2tXaEQ0eG1QTldY?=
 =?utf-8?B?N0JaNjRpZys2SW1nN0psS20zcUtUaUhlOXVYbnBJUHNISFRETUVTb0Fjei8x?=
 =?utf-8?B?ZUZ4OXZ5djkzRjl0N0JodmpmdHJxUkh4N3pmK1VyYTRWV2UyaEprVElvVEtj?=
 =?utf-8?B?dDlIalR5L0VoYkRuTmRTT3JJOURxOEdITTlOcVQxczhZQXEramo3Rk5DbTBl?=
 =?utf-8?B?ekk3aEZXcDV5VmFwKzZVZWtVWEh2K0IvWW9hMktDZzFDYkZ1azhoU3dpTEh6?=
 =?utf-8?B?YjhkWTNiR0FuVWxrNi9WZmtJWllHbFdmd2JGVHpHbW1IcWNlbXhDTW45VDdM?=
 =?utf-8?B?UTdxRkdreFV4emh1K0tna1lEd2JIWWlCT3BGU2ZwWHFiQm1TMFdPdlRNaGNi?=
 =?utf-8?B?LzlmaTdUY1pzbHdQd2d3M29xWmNqMWZ4N0xreVh2RFJCS29pVDFpM2NGTHdV?=
 =?utf-8?B?SCt2MlM4eGZralBkWmgzU3ZPbnpUbGdoY01YRTZPTnBsS1pUTlZOazd3Uk1J?=
 =?utf-8?B?SDhsSm5xM0VyNVdXV0hKVytqeExJRnFCdjFQbXBxOGxDdDNhdFcySjVRMGdE?=
 =?utf-8?B?VzRxSHdoUXJMS3E1STQ0aEw3cTYxQnBQWU9HdkxBbStmcW9kNllaRm5YWlpE?=
 =?utf-8?B?M2lQd2dhS0dNbnU3VVQxMFVkMUp1OWxTNnpvSGFFeWRFR0IzRFFqSHVqdXMz?=
 =?utf-8?B?M2FST2gwcXI5RThtMSt4NHhzYiswZ1BNcFVVVEhVcGtjZEZDQjUwNWFUOWRE?=
 =?utf-8?B?ZDZSQzc0WkVQTm5DQUN6T0RpWm1HZ3JzRkU0OStLbFlzOEc1aFJXb3VDWERw?=
 =?utf-8?B?cFcwUmZqWGVHMTFJV25qTTZkSlhmcmxoMDYyWEFJcy9saTRuaHB6a1J2RmZM?=
 =?utf-8?B?blZwQlBqQUk3WXdzMEpmZTNET0pKdEJCU1dYRU5CYmpQR2xOR1dESVR6ekox?=
 =?utf-8?B?M0VuVW5qRVlaL2puKzltZ1N1algwVnVEbzQrTThUZnArZUJ5V2wzc3ptRVp2?=
 =?utf-8?Q?NOm/91q3+YKNrQI9ka959zK+viELE4CoT0mC9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207D51079657774E85C9A1C292574563@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YHmRJLXjAr6vEjOl9QIIff/fXVnL4R3eFtwSpeUh4ejQegTVCud8h3jDu7zowogtfN5Wv+2tR+9IGIw5Eycx7eBm2XVOxAcxu3ue1Op9YUdI1X+Z3PV09QldTA08yms/ztiMkq5pJxMD6fr9z6dJzoo3m90WCJF9Ho9fY5mdE7xaiUDT9naPoQrsrWCfl08s29dDhLl3pVzbhNJAI0CulnbqAld0XDprYfBUcx76hGu2lxQxaMpRj3SsxH2KhdgZCgzFDE/m+Qp7tarHq2Htt/iDCMtOuYIP29QHaAcTDeq8z48E+jSH667l6C4Ppxid/uTpSu2jLm+UEoSdopquPw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f30026-ee4d-47e4-af92-08de7ed87837
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 19:08:52.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/ghpRhwm/n6tCxWSvchrSVGjZARgFWs6q7xsgSH+cUK5eRn3QOxcWFfQF6LvY6FJhGSs5fASscEySm0xNl3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5393
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: m3USJE5RXH7Dkv4u8XpZOr0dj9Yv13Cr
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b06c48 cx=c_pps
 a=XnoXs6g8SJkBXVwgXvPJGw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Op2JijI83tqRCOzjMnkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE2NiBTYWx0ZWRfXyMXmmdNat5ZW
 HKYR/GQqIJoOPjPoZSHoXtsTxsU2FpMbd5AZc1iYMqOkv9q405+WxBTbZjFMf07JuFjKnlcpS4C
 8kYuUXH0EnjXDgwin6cPReST9RVfRvdYfpnkxZtBUqIkgLr4s6GTx2fV7nNI2jqFMel4FINxnbx
 i2PHEdduEYhdxcHmIIGHOA/unhHVr5CJJTm+1/ggCV2snD9IZVRxg0vpH9uzQtB6TNTTWR1hk1/
 9A7QzzIpkrlQNl02lAO60e8d04MYQMgB9RAzI6bmFacKtULRF99xKVsY8Y+XICAPHT6EKJw6A+X
 bhgPGblN4GMetoyqm+dUqyOymPvAxX3+qQS5LuHpNjdJZe3ZazUxuj+v5hhQCkfoNW2Ln1erUxj
 4n2/OkAp17U1Baal2DnKeCqWKuhFFgZsfMCWj3kXqWdFen9x6PMcV5OXdSaf9hztgrzFnXEbtSZ
 Igl9u66g0Dk5OaumEHA==
X-Proofpoint-ORIG-GUID: Z_hquj1CYVOlB5KiDbjcKurRzNVfWNY3
Subject: RE: [PATCH] libceph: reject preamble if control segment is empty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100166

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDIxOjQ2ICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIE1vbiwgTWFyIDksIDIwMjYgYXQgODoxOOKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbyA8U2xh
dmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjYtMDMtMDgg
YXQgMjM6MTEgKzAxMDAsIElseWEgRHJ5b21vdiB3cm90ZToNCj4gPiA+IFdoaWxlIGhlYWRfb253
aXJlX2xlbigpIGhhcyBhIGJyYW5jaCB0byBoYW5kbGUgY3RybF9sZW4gPT0gMCBjYXNlLA0KPiA+
ID4gcHJlcGFyZV9yZWFkX2NvbnRyb2woKSBhbHdheXMgc2V0cyB1cCBhIGt2ZWMgZm9yIHRoZSBD
UkMgbWVhbmluZyB0aGF0DQo+ID4gPiBhIG5vbi1lbXB0eSBjb250cm9sIHNlZ21lbnQgaXMgZWZm
ZWN0aXZlbHkgYXNzdW1lZC4gIEFsbCBmcmFtZXMgdGhhdA0KPiA+ID4gY2xpZW50cyBkZWFsIHdp
dGggbWVldCB0aGF0IGFzc3VtcHRpb24sIHNvIGxldCdzIG1ha2UgaXQgb2ZmaWNpYWwgYW5kDQo+
ID4gPiB0cmVhdCB0aGUgcHJlYW1ibGUgd2l0aCBhbiBlbXB0eSBjb250cm9sIHNlZ21lbnQgYXMg
bWFsZm9ybWVkLg0KPiA+ID4gDQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSWx5YSBEcnlvbW92IDxpZHJ5b21vdkBnbWFpbC5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+ICBuZXQvY2VwaC9tZXNzZW5nZXJfdjIuYyB8IDE3ICsrKysrKysrLS0tLS0t
LS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jIGIv
bmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMNCj4gPiA+IGluZGV4IGM0ZGRmNzkxMWY3ZC4uNTBmNjU4
MjBmNjIzIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMNCj4gPiA+
ICsrKyBiL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jDQo+ID4gPiBAQCAtMzkyLDcgKzM5Miw3IEBA
IHN0YXRpYyBpbnQgaGVhZF9vbndpcmVfbGVuKGludCBjdHJsX2xlbiwgYm9vbCBzZWN1cmUpDQo+
ID4gPiAgICAgICBpbnQgaGVhZF9sZW47DQo+ID4gPiAgICAgICBpbnQgcmVtX2xlbjsNCj4gPiA+
IA0KPiA+ID4gLSAgICAgQlVHX09OKGN0cmxfbGVuIDwgMCB8fCBjdHJsX2xlbiA+IENFUEhfTVNH
X01BWF9DT05UUk9MX0xFTik7DQo+ID4gPiArICAgICBCVUdfT04oY3RybF9sZW4gPCAxIHx8IGN0
cmxfbGVuID4gQ0VQSF9NU0dfTUFYX0NPTlRST0xfTEVOKTsNCj4gPiANCj4gPiBGcmFua2x5IHNw
ZWFraW5nLCBJIGNhbm5vdCBmb2xsb3cgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5IDAgaGFz
IGJlZW4gY2hhbmdlZA0KPiA+IG9uIDEuIFNvLCB3aHk/IDopIEl0IHdpbGwgYmUgZ3JlYXQgdG8g
aGF2ZSBtb3JlIGNsZWFyIGV4cGxhbmF0aW9uIG9mIHRoaXMNCj4gDQo+IEJvdGggYnJhbmNoZXMg
b2YgcHJlcGFyZV9yZWFkX2NvbnRyb2woKSBzZXQgdXAgYSBrdmVjIGZvciB0aGUgQ1JDIGV2ZW4N
Cj4gaWYgY3RybF9sZW4gPT0gMDoNCj4gDQo+ICAgICBhZGRfaW5fa3ZlYyhjb24sIENUUkxfQk9E
WShidWYpICsgY3RybF9sZW4sIENFUEhfQ1JDX0xFTik7DQo+IA0KPiAgICAgYWRkX2luX2t2ZWMo
Y29uLCBjb24tPnYyLmluX2J1ZiwgQ0VQSF9DUkNfTEVOKTsNCj4gDQo+IFRoaXMgaW5zdHJ1Y3Rz
IHRoZSBtYWluIGxvb3AgdG8gcmVhZCBDRVBIX0NSQ19MRU4gYnl0ZXMgb2ZmIHRoZSB3aXJlDQo+
IGFuZCBlc3NlbnRpYWxseSB0cmFuc2xhdGVzIHRvIGFuIGltcGxpY2l0IGFzc3VtcHRpb24gdGhh
dCB0aGUgY29udHJvbA0KPiBzZWdtZW50IGlzbid0IGVtcHR5IChpLmUuIGN0cmxfbGVuID4gMCku
ICBUaGlzIGFzc3VtcHRpb24gaG9sZHMgaW4gcmVhbA0KPiBsaWZlIChpLmUuIHdoZW4gdGhlIGNs
aWVudCBpcyB0YWxraW5nIHRvIGFjdHVhbCBDZXBoIHNlcnZlcnMpIGJ1dCBub3QNCj4gd2hlbiBp
bmNvbWluZyBmcmFtZXMgYXJlIHRhbXBlcmVkIHdpdGguICBUaGUgcGF0Y2ggbWFkZSB0aGF0IGFz
c3VtcHRpb24NCj4gZXhwbGljaXQgLS0gd2Ugd29uJ3QgZXZlbiBhZG1pdCBmcmFtZXMgd2hvc2Ug
Y29udHJvbCBzZWdtZW50IGlzIGVtcHR5DQo+IGFueW1vcmUuDQo+IA0KDQpBcyBmYXIgYXMgSSBj
YW4gc2VlLCB3ZSBoYXZlIHNldmVyYWwgY2FsbHMgb2YgaGVhZF9vbndpcmVfbGVuOg0KDQogICAg
bmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMNClsxXSAgICAgICAgbGluZSAxMzQ4DQpbMl0gICAgICAg
IGxpbmUgMTM3Mg0KWzNdICAgICAgICBsaW5lIDE0MDkNCls0XSAgICAgICAgbGluZSAxNDM2DQpb
NV0gICAgICAgIGxpbmUgMTQ4MA0KWzZdICAgICAgICBsaW5lIDE1MTcNCls3XSAgICAgICAgbGlu
ZSAxNzg3DQoNClRoZSBbMS02XSBjYXNlcyBoYXZlIGN0cmxfbGVuIGFsd2F5cyBiaWdnZXIgdGhh
biAxLiBBbmQgb25seSBjYXNlIFs3XSBsb29rcw0KZGlmZmVyZW50bHk6DQoNCnN0YXRpYyBpbnQg
cHJlcGFyZV9yZWFkX2NvbnRyb2woc3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uKQ0Kew0KCWlu
dCBjdHJsX2xlbiA9IGNvbi0+djIuaW5fZGVzYy5mZF9sZW5zWzBdOw0KCWludCBoZWFkX2xlbjsN
Cgl2b2lkICpidWY7DQoNCglyZXNldF9pbl9rdmVjcyhjb24pOw0KCWlmIChjb24tPnN0YXRlID09
IENFUEhfQ09OX1NfVjJfSEVMTE8gfHwNCgkgICAgY29uLT5zdGF0ZSA9PSBDRVBIX0NPTl9TX1Yy
X0FVVEgpIHsNCgkJaGVhZF9sZW4gPSBoZWFkX29ud2lyZV9sZW4oY3RybF9sZW4sIGZhbHNlKTsN
CgkJYnVmID0gYWxsb2NfY29ubl9idWYoY29uLCBoZWFkX2xlbik7DQoJCWlmICghYnVmKQ0KCQkJ
cmV0dXJuIC1FTk9NRU07DQoNCgkJLyogcHJlc2VydmUgcHJlYW1ibGUgKi8NCgkJbWVtY3B5KGJ1
ZiwgY29uLT52Mi5pbl9idWYsIENFUEhfUFJFQU1CTEVfTEVOKTsNCg0KCQlhZGRfaW5fa3ZlYyhj
b24sIENUUkxfQk9EWShidWYpLCBjdHJsX2xlbik7DQoJCWFkZF9pbl9rdmVjKGNvbiwgQ1RSTF9C
T0RZKGJ1ZikgKyBjdHJsX2xlbiwgQ0VQSF9DUkNfTEVOKTsNCgkJYWRkX2luX3NpZ25fa3ZlYyhj
b24sIGJ1ZiwgaGVhZF9sZW4pOw0KCX0gZWxzZSB7DQoJCWlmIChjdHJsX2xlbiA+IENFUEhfUFJF
QU1CTEVfSU5MSU5FX0xFTikgew0KCQkJYnVmID0gYWxsb2NfY29ubl9idWYoY29uLCBjdHJsX2xl
bik7DQoJCQlpZiAoIWJ1ZikNCgkJCQlyZXR1cm4gLUVOT01FTTsNCg0KCQkJYWRkX2luX2t2ZWMo
Y29uLCBidWYsIGN0cmxfbGVuKTsNCgkJfSBlbHNlIHsNCgkJCWFkZF9pbl9rdmVjKGNvbiwgQ1RS
TF9CT0RZKGNvbi0+djIuaW5fYnVmKSwgY3RybF9sZW4pOw0KCQl9DQoJCWFkZF9pbl9rdmVjKGNv
biwgY29uLT52Mi5pbl9idWYsIENFUEhfQ1JDX0xFTik7DQoJfQ0KCWNvbi0+djIuaW5fc3RhdGUg
PSBJTl9TX0hBTkRMRV9DT05UUk9MOw0KCXJldHVybiAwOw0KfQ0KDQpTbywgd2UgZG8gcmVzZXRf
aW5fa3ZlY3MoKSwgY2FsbCBoZWFkX29ud2lyZV9sZW4oKSwgYW5kIHdlIGRvIGFkZF9pbl9rdmVj
KCkgb25seQ0KYWZ0ZXIgdGhhdC4gQW5kIGN0cmxfbGVuIHZhbHVlIGlzIGRlZmluZWQgYnkgY29u
LT52Mi5pbl9kZXNjLmZkX2xlbnNbMF0uIFdoYXQgaXMNCnRoZSBndWFyYW50ZWUgaGVyZSB0aGF0
IGN0cmxfbGVuIHNob3VsZCBiZSBiaWdnZXIgdGhhbiAwPyBEbyB3ZSBoYXZlIHByb3RlY3Rpb24N
CmluIG91ciBsb2dpYyB0aGF0IHByZXBhcmVfcmVhZF9jb250cm9sKCkgd2lsbCBiZSBub3QgcmVx
dWVzdGVkIHRvIHByb2Nlc3MgdGhlDQplbXB0eSBjb250cm9sIHNlZ21lbnRzPyBJIGFzc3VtZSB0
aGF0IEJVR19PTigpIGltcGxpZXMgaW5jb3JyZWN0IGxvZ2ljIG5vdy4NCg0KVGhhbmtzLA0KU2xh
dmEuDQoNCj4gDQo=
