Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E618258EFF
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088894; cv=fail; b=giD8ToQDC6e33oaNruMnOHMzZYpVd86ylUFDs4GyAfILyoqTfc1KK3zuw/B4xJy+rmc0jztOLmDXiy2slgvTHuR3w0vsFdS5C7lr/hRPfeMqzCw/lqWoHYYX4uKOn5cgFIpw3zowpKzoBFPxgFJBakel1eXmr32bvxYTBUFZ7AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088894; c=relaxed/simple;
	bh=7fDo6utklEXnWIHoKoavLxeaksy3pGRbLP0ULimd86E=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ORa935+0NgYGDGx9Q0+jIkoJXMb86SupRAsoZwPjEyMRJmYUt6b+mDP8zIBdrpLcegnDkQP7iRI6uGjvjNxxzAWns8ZUQRXcNiacw5r822qGY51z8BrGlgXSl6lQMfhT6MU6T59WKWU0kEZi755gjA8PqiK8Hz2mYPX0teV5dhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnCpTnkC; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnCpTnkC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FcsDi1499195;
	Mon, 9 Mar 2026 20:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7fDo6utklEXnWIHoKoavLxeaksy3pGRbLP0ULimd86E=; b=cnCpTnkC
	dpY3cQLUEf3QkWd1dRn/fMbSgQ3iYyXN4HXNbtcCVHSz+S3J27YfNoeDNRMEsR+Z
	mpLKRXi9s6VswRDiJxQjMIQgTOJpbJ98KLyS4cl0x3TaWDqokenacKHYCuhvKUru
	4xqQvegX1XhWWLZwKc0phFVMiRT78zjfaLwGFV021THNa4cH+7KMp0gjkEgTG1T0
	x+c2iEqyCjL9FlzRMrpl1BGly+yF+iJ8rhRT8WvWt/JpR1WkFZzaVHP/uHecITOo
	tZMBX9EK1ZH6espsNRpEGj4D3ibrRXHf/cqoOFVb6pPI+UN3swmd6oexUbYcktCr
	gvuiiftipH4XEg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mg1j5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 20:41:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMhq5Tm+zhW1rtATYoMroNlTpL2DUTu363HDqkF0xtWSNUFHhyHf8sXOorOPUhixCp3MkTU8fMOzS89m/lsAifvqnioI0JDaaff8Aiq4qmeWPhRLviDaUDUVw7R1FTmpZRyHVt/8smukxUWRTl/B6Flc7LW4bsM3tFuI/yLRB4Q16zoa0rESNNN1ea/ZldbN8p/dLmLeU/WjwnaJp5BCtf1bPapIBJUQY6CII4N6/tRqmcHPKwAcmsTjNLrlvLFkvb/TDhmefvyB4D4Qiy/s8YuaKG8ILH7xQJsZs1IHsVEgZDeL+2WHPw/qeCPdowgg52BOrGoc+UIG3NPytOMLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fDo6utklEXnWIHoKoavLxeaksy3pGRbLP0ULimd86E=;
 b=MAL6VEkq6CNNab08FhqzUN0BGsKFNsJyRbQPvaca1ZBrWQknYM8wfuDfGjiShxSVGQa64VixYzqAwkkgYUdVjSKupy5j6vy5ejZ7txCUuoAlR7vEjekfAXarhdw/wiojzZYhJITVqxr7vbCDs6n9glbx5joppYxMcrqwWKEJV0akt9B8hrOX2IZlvI1P4/rzL1O12ayIudngtJYWFSAdTqIW2hq5hJ6YOU1fQIwqBv8V7TT+u6AiorZC7W5UMZbs0RTze4PecSROCcmuRwWe9zPmHGKnWSBFCTqSFWbawHfBX5kzsHzcFtsUm0LrYVXJDm8A3wJknjYEBw0F2wXsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CHAPR15MB6976.namprd15.prod.outlook.com (2603:10b6:610:2f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 20:41:25 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 20:41:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: admit message frames only in
 CEPH_CON_S_OPEN state
Thread-Index: AQHcsADX93aumGcTWUy25Xv/4QB6SLWmqi4A
Date: Mon, 9 Mar 2026 20:41:25 +0000
Message-ID: <0868d7e3a4f4417c8e6a5b64814007f9a87dc7d0.camel@ibm.com>
References: <20260308220942.694505-1-idryomov@gmail.com>
		 <3a512051f8108770e4eb79c486ec5692fe894bb5.camel@ibm.com>
	 <CAOi1vP8YxxP1NJdY1yNP=Py+h77PRqGnXbCgf=bk7RnrkEWikQ@mail.gmail.com>
In-Reply-To:
 <CAOi1vP8YxxP1NJdY1yNP=Py+h77PRqGnXbCgf=bk7RnrkEWikQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CHAPR15MB6976:EE_
x-ms-office365-filtering-correlation-id: 7c456d47-9642-4d42-4e06-08de7e1c3b6f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 tyWhTEB5XiuuSssAAYYLOpIjdS3yjvANUUuNrkCHWsutqDRSUQFThhyn1eyoKKw++HQBMUfdpVb/3VQNEy1vRiWYqAA9HoCJIL7UdgEldLVa7OCG5tSqL5dDK2OgU5fx0Rc0GmN+8JdHJ59DssJb/RLfx3wZLkYt9RWXQ4tYqpWuAImnKIrMNnZpJSlDmAa8iq2CMkGenHhfTGYcSEC+pubBOX2KoSDhWaPWKbF/bfPt0+CKHiMxZTILegb/Tk4UJwbKDy03+PEUlADFQiT6tQqy7VGzl9f0g579dWhdjgSz2diwP5r2/VjSlZD7/LqHvM+iEH8d/Yub9G8DgVIFM1vZ3m+MZ3A1dXBcYkK6Azz2lgvDt3T/fa3CnYCnoPE2cAYTqJuQ2n0gywrctdQBsqGIny1HmNj33wGZ4K2vWPao/vDxa0jofCgelVEWe4OYU4B0cN8AriLYTLARwx+VP9ifmT66+ZYrSEyWutAKNTyJCX1HBzCkar/ft7qPc9DO52JSC5h5yTNwkwVqkNIE42nmzm3eXCZAdZt1rNe+O4fIDLPxdBrIzfZFBwHJYjhpmbYvzYBWzG6hZW2mnKcWPxJxJ3Y40bt932Zq9+rHCkaH/NmPTd9hT5UKkpACxyAZbthMeW3uU2YqaWUPLEbsTUNetSnhZCTtudk9zzRJHpMXRsqQWyEbdibD6/dsU4KrtwX14YYDxW1IXFCVKVauoAzhOmtpY/MaaFk1vr3TxY6W3sALGAMabmrcq93+KGkhItgrDFFcaBoZYlD0bDe3dGezWrM71kLT62VakvP3+Ug=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFJPbkxZR3FWU2JwREFFbFoxQTlsMXBlWC9KRE1FVFllNHRFNHYvelp1Y2pY?=
 =?utf-8?B?YXhlOGt5NlRyUjJNM2cyL2M2aG1lc3VIZnBveCttVENiTVI5Q0RUV1Yyblkr?=
 =?utf-8?B?MVBYRXNFb0hXbTEvNHJtVFRIVzFSc0g1NGFYWGZjL1A4M3F1b3hoY2RoSitz?=
 =?utf-8?B?dkY1VXlaL05UQ3lVaWZjVWgreExYalpiVThNcVI3bmw1TVUveW1rOVpOcXZw?=
 =?utf-8?B?Z2lHdUhSanhORXRLZ1U1MlRsVmxRQVNiRVllMzJ5d25CQ3pYa0ZIdFJuc0Np?=
 =?utf-8?B?djQyVzlDSWx2RzRLdkY4MGx4cG5HZ0ZGZWVicXY3d0sweGo0S2RVL0xadW4z?=
 =?utf-8?B?TTd5N1FOcGRPVmhzbDZaTlc1Z2hpOU5zOFRWeVFHVHd0ajVQYkIzZ2VuMWtu?=
 =?utf-8?B?bENRNi84aWNObUx6YWJnSlFmek5VVi80V201MVVWL0N1OE9LVUlCQmMyWFVs?=
 =?utf-8?B?ZDVWN3BIS3ZhdjRTYWFIYnRXbzJRanh2S2I0cFBBTklDb1dFUGxER2tWQmxy?=
 =?utf-8?B?RWVjSkpPSW5qVDIzbytBTno0Uko5TGRLYlZZZnhpclFoaG13NUY1Sy9rcWpP?=
 =?utf-8?B?Rks4Z0Fqa3hBQ3JwcVgybUdtUkJmTFA3akdZWG0zYzNFNkZLNE9RRE93ZkVY?=
 =?utf-8?B?QkJRWnhpSDlVSlhwYlU5eXp2WW9JQmhvaERLZlgzWHlIQTREU2RReUNWQjNU?=
 =?utf-8?B?Z2UwU1lDRGxSR1pjMWZSR1B2czNmSGk0N0laQy96NXFKTUtUQVo5eFNSMlRZ?=
 =?utf-8?B?eDVncjFqbnlmVVBlSEZTUzV0TXhWVndHdkRIWDJFamhlYytrMktQU0RMUHpX?=
 =?utf-8?B?Rlh4aWZCOTNXT1N4SnVXa05ibFp5b1pHL0xNYkxDeVZJMmgveENtS1lNd0VD?=
 =?utf-8?B?cG5FQ0k1MEs5NW1GaWl1R3JrT1pxZUVUU21Hay85TUhHRHBaWGtPRTk2SGc5?=
 =?utf-8?B?anVtcjRpa1A5b1d0SnQ0YzNmQzVwWnFua0tyTENScE9WNjZ3MU5SOTBJVTBw?=
 =?utf-8?B?SjY3TUowSjlJd0JtUlVncTZXVFpsN3ZWanF3UzB1dnJWZnU1eGgyOEZpWHlK?=
 =?utf-8?B?b3IyMW9lUWNJeTYvVUc4NGZQU3ZFcmhoc3pRRTAyaVgzS1B2SXRGUWRJandK?=
 =?utf-8?B?OWdicnpKaFVUU2lqbHJSTFJnOVI2bktZWC9xTFJ4NUFZbkYrakkwYjYrbnV6?=
 =?utf-8?B?RkhXb291OURLZEZSZU1vempWdDN0MC9OakhHSFplTHMybUhtU3lCREo5MVlh?=
 =?utf-8?B?d1JONnBQNnE3U0k3K1BwbVZYc2hGeUV1R2VxRGR0ejJicDVnSFJodzJ0bFh6?=
 =?utf-8?B?bXFpRTZ6am5ZSERNN3VpSVBROHZ3TEZLZGZYNVhtNS9ZamlxelpaODJ5cUNS?=
 =?utf-8?B?WWZ0K2pBMVdlUDNOc0hjWmFsTjV4K25FMEthUmorMkczYTJVTitRcnNuT0Rt?=
 =?utf-8?B?T0xnTGlkaitERlZLTHZINnVxZnVnUk1OYU9kc0M0NjJqWVhndEJxbkNlUTNF?=
 =?utf-8?B?OWFwK2p1MHROdUwvM2xIUitvZEYxYkVyVStOZGJaTjdraFpmMmRxRzkwb3hK?=
 =?utf-8?B?UkJJemZGUmRESmJqSW15QnB0dS80U0d5SUZRZWpxVTFYamNyTU9QYmtUdUw0?=
 =?utf-8?B?d1h5Z0VDTWJVTjE1WWFmazlmUjVMSUpVbno5NWprQnVLMHdZamlndG5aSUJv?=
 =?utf-8?B?RlVvWVI4S0g2YXRySFdlb2dOWlcxeVFTQk80aEhUSUNrdDNsdG9wVFZIVlRI?=
 =?utf-8?B?UVd6TkJGK0xVeXNoYTZhd1VIOWZCcHkzMDVGMlhwVmZFZVJlZmJpUWJtUW9F?=
 =?utf-8?B?R2lhWCszUWI4c3VDaXFOUk0rOTZoMlhyZWh5L0FjaEdualdkYWZTb2NYTWs5?=
 =?utf-8?B?djhMbHorSmN2dk5TcWl6eUc1SVpHZkZPMzdDbFVUNHdjdUIxZE9mSEJwSi8y?=
 =?utf-8?B?Wng5ejczbHB4YSttMlNaTW0xNGdkZm1DczNTUEk1eUR5c0xxVXppempwbGY5?=
 =?utf-8?B?QksyaC9oUUpuU1RzcnY4cVEzc0p5RzFIMlJ5WW41TnROSFl2OWNwMGFrQkxB?=
 =?utf-8?B?ME41aktFd1dFUWZPQlZjMFEveFFEbGFQMGVBNWh2ckxCWWxieVV2bWRQUUpn?=
 =?utf-8?B?UWFzUDFaT091OHd0eWYzc1JzMFE0OE5WMlhyY3Y2dGE3VFkybmNFQWFSNFJH?=
 =?utf-8?B?aGMyQXhieHpZTkZUOWJiYUVKdXZ2K2tKSFNWMnhlcWZXUEYwQTV5NFJEaEJJ?=
 =?utf-8?B?bStVYVlyNC9OaFVjSkVNWWd4Tk84TG85ZFpZTHJUY0VBUW1JUUJTQk5wVW0y?=
 =?utf-8?B?Tk56d0lmN09nTnp5L0wya3FJcm55MFB5RzNHV21XbVRzaEdDQitRNi9WbkhT?=
 =?utf-8?Q?Jvr1ch8IpQSoPUa0pa3IWNSbykiuhHPJTsLlT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24384D95BF628043AD272BD4BA151249@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Oet4Vq0i/pR5XXtWc9ijjPPtU69BJWrWc6fIbAqCLO9MEWbcgwBh0Vzpz5UvLo6viARXmW0mOunaUgNvePD/zY85aZMK4TPkA/HfzTWILI07HdRhw9o/YzUQnvs0OEjNAjxbHjJOzwXAvTzeidy66Vr9YI5uOXiyVFEHX0FdpKpK/M0a9Doj71ER9omhdg0E7M39zmSTRRaAArUQ/14+jZwRqRUwx7NeL1Gyy5EMFuzEUgS87HS4DGU7B7SZoKu9LbtF+TK5pfdEnrF9Cf9dyxjpTraFeVp3ZcshPzd2SGVmfX+GbDtsh5Ljal9zhfBxCBPN5ylFhV/wtLTQELYeMg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c456d47-9642-4d42-4e06-08de7e1c3b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 20:41:25.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JfdnAWhzS3mDBE1taZaKeps5C1vc7Zs3OMomEOh9k3jmAZxUx5yApE2SDLmEdVSTdD1x52G8cI3mBfJsF+7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR15MB6976
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69af3077 cx=c_pps
 a=SEJ8dOKVafy+qjyLYqUPAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=0MQjfBrxJ7jDPLBlDeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4MiBTYWx0ZWRfX/a/Jwy0jUCsP
 Iyc4FoMNG91VHM2cHOWaLH6aPV5nurYU0sJNCBr2sHpr4S6MGFN1eeNuzsxPTj8ntUSDcgM8PWs
 MgkrpxYRkth/Mb8iSwJgtAnDY5rLyp2o3krJjEjIiCa9ciWL+dEVQBhukhOhyQMSaauI6zpm2D9
 NvNUWIDs3Pi/bbSrcgFAQWWf7vsuvlNeUCJojYYgPiaIRe5onYaTCJ9u07VQa5MzbTwt/PliBfJ
 yP3ML2ZImRoyjYop3ixT8NVJFEAGgGiQbQFoK6RmlSmXQlR6f5IBtOGt7uHppqNEhZBW3kxgNYE
 g3tWToSDa9yZlf4a86Am/pXKoluXswBE7QX6UjXhFtRKnjQASch8BCO1tD114VIGrLW4aQxj7ee
 iCY7BbQoFaJ3QZJQcFVlHhlt3QN4f5jcJ7/uJJ+q07zByfJPuDMDpxRWhJb7HxGjfU5RLDxNGU8
 XIPKcwRZEKTdJvx3V7A==
X-Proofpoint-GUID: M0lNc0P_y5BVGqDsjEujX1VcZtK_3FDG
X-Proofpoint-ORIG-GUID: nkFtPkbj3sTmlkA4LAqOqaLrjKAiTZQ4
Subject: RE: [PATCH] libceph: admit message frames only in CEPH_CON_S_OPEN
 state
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090182

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDIxOjEwICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIE1vbiwgTWFyIDksIDIwMjYgYXQgODowN+KAr1BNIFZpYWNoZXNsYXYgRHViZXlrbyA8U2xh
dmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjYtMDMtMDgg
YXQgMjM6MDkgKzAxMDAsIElseWEgRHJ5b21vdiB3cm90ZToNCj4gPiA+IFNpbWlsYXIgY2hlY2tz
IGFyZSBwZXJmb3JtZWQgZm9yIGFsbCBjb250cm9sIGZyYW1lcywgYnV0IGFuIGVhcmx5IGNoZWNr
DQo+ID4gPiBmb3IgbWVzc2FnZSBmcmFtZXMgd2FzIG1pc3NpbmcuICBwcm9jZXNzX21lc3NhZ2Uo
KSBpcyBhbHJlYWR5IHNldCB1cCB0bw0KPiA+ID4gdGVybWluYXRlIHRoZSBsb29wIGluIGNhc2Ug
dGhlIHN0YXRlIGNoYW5nZXMgd2hpbGUgY29uLT5vcHMtPmRpc3BhdGNoKCkNCj4gPiA+IGhhbmRs
ZXIgaXMgYmVpbmcgZXhlY3V0ZWQuDQo+ID4gPiANCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWls
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIG5ldC9jZXBoL21lc3Nlbmdlcl92Mi5jIHwgNSArKysr
Kw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jIGIvbmV0L2NlcGgvbWVzc2VuZ2Vy
X3YyLmMNCj4gPiA+IGluZGV4IGVkNjE4NDM1ZDMzYS4uYzRkZGY3OTExZjdkIDEwMDY0NA0KPiA+
ID4gLS0tIGEvbmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMNCj4gPiA+ICsrKyBiL25ldC9jZXBoL21l
c3Nlbmdlcl92Mi5jDQo+ID4gPiBAQCAtMjkwNSw2ICsyOTA1LDExIEBAIHN0YXRpYyBpbnQgX19o
YW5kbGVfY29udHJvbChzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sIHZvaWQgKnApDQo+ID4g
PiAgICAgICBpZiAoY29uLT52Mi5pbl9kZXNjLmZkX3RhZyAhPSBGUkFNRV9UQUdfTUVTU0FHRSkN
Cj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHByb2Nlc3NfY29udHJvbChjb24sIHAsIGVuZCk7
DQo+ID4gPiANCj4gPiA+ICsgICAgIGlmIChjb24tPnN0YXRlICE9IENFUEhfQ09OX1NfT1BFTikg
ew0KPiA+ID4gKyAgICAgICAgICAgICBjb24tPmVycm9yX21zZyA9ICJwcm90b2NvbCBlcnJvciwg
dW5leHBlY3RlZCBtZXNzYWdlIjsNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4gPiArICAgICB9DQo+ID4gPiArDQo+ID4gPiAgICAgICByZXQgPSBwcm9jZXNzX21lc3Nh
Z2VfaGVhZGVyKGNvbiwgcCwgZW5kKTsNCj4gPiA+ICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ID4g
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IA0KPiA+IEkgYW0gc2xpZ2h0bHkgd29ycmll
ZCBhYm91dCB0aGlzIHBsYWNlIFsxXToNCj4gPiANCj4gPiAgICAgICAgIGlmIChjb24tPnN0YXRl
ID09IENFUEhfQ09OX1NfVjJfQVVUSCkgew0KPiA+ICAgICAgICAgICAgICAgICBidWYgPSBhbGxv
Y19jb25uX2J1Zihjb24sIGN0cmxfbGVuKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKCFidWYp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gDQo+ID4g
ICAgICAgICAgICAgICAgIG1lbWNweShidWYsIGNvbi0+djIuaW5fa3ZlY3NbMF0uaW92X2Jhc2Us
IGN0cmxfbGVuKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIF9faGFuZGxlX2NvbnRyb2wo
Y29uLCBidWYpOw0KPiA+ICAgICAgICAgfQ0KPiA+IA0KPiA+IEl0IGxvb2tzIGxpa2Ugd2UgYWx3
YXlzIHJldHVybiAtRUlOVkFMIGhlcmUgYmVjYXVzZSBjb24tPnN0YXRlID09DQo+ID4gQ0VQSF9D
T05fU19WMl9BVVRILiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nIGhlcmU/DQo+IA0KPiBfX2hhbmRs
ZV9jb250cm9sKCkgY2FuIGJlIGNhbGxlZCBpbiBhIGZldyBkaWZmZXJlbnQgc3RhdGVzIChpLmUu
IHVuZGVyDQo+IGEgZmV3IGRpZmZlcmVudCBjb24tPnN0YXRlIHZhbHVlcyksIGluY2x1ZGluZyBD
RVBIX0NPTl9TX1YyX0FVVEguICBXaGVuDQo+IF9faGFuZGxlX2NvbnRyb2woKSBpcyBjYWxsZWQg
ZnJvbSB0aGUgYWJvdmUgYnJhbmNoLCBpdCdzIGV4cGVjdGVkIHRvIGJlDQo+IGZvciBhIGNvbnRy
b2wgZnJhbWUuICBUaGlzIHBhdGNoIG1ha2VzIF9faGFuZGxlX2NvbnRyb2woKSBpbnNpc3Qgb24N
Cj4gQ0VQSF9DT05fU19PUEVOIG9ubHkgZm9yIG1lc3NhZ2UgZnJhbWVzIChGUkFNRV9UQUdfTUVT
U0FHRSkgc28gaXQgd29uJ3QNCj4gYWx3YXlzIGZhaWwgd2l0aCBFSU5WQUwgaGVyZS4NCj4gDQo+
IA0KDQpPSy4gSSBzZWUuIFRoZSBwYXRjaCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogVmlh
Y2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZh
Lg0K
