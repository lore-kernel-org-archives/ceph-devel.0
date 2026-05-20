Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADA3C3C11;
	Wed, 20 May 2026 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317175; cv=fail; b=qXXzlt343fLpXv5uOltixx5isWnqPFunq9EP0RJKXuoJQAavv2spW6XL9N4SFwNMv+VpGywgUz8QhjjEGluq262cTLMByOUWxm/Sb7Nvf1PISQFBfwuNnssfhoSuwGUZXcfHsXbSwx7r2Uo1XiRSyGp2WTSaqZNvTVGLZYJ+/S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317175; c=relaxed/simple;
	bh=vRzZ4DU/gvnGdRykyr9gyRLuqnMqYteRzQxrcwkLmxU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DDnXicuVyA35aevKNMQZ26tn/MPSa6GpMfoX2+uvWkP5O6dTnDFhwq1l+HOE1LcPmbu8Cxmg+thlF0RYmMwKDRJ2AnjgW4DJaNOJPmmDVot5JgZHCl8WTlZiqusP98HmfiWbCFWU97cEXFZi6b3cW39AjmpoDy/t6z2g8KoTQ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KYb8Da1h; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KYb8Da1h"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCF7Pv130203;
	Wed, 20 May 2026 22:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=vRzZ4DU/gvnGdRykyr9gyRLuqnMqYteRzQxrcwkLmxU=; b=KYb8Da1h
	oRIqlfROjwaove5TbtzPGpRVLOuK3gwkUVhR/lybB8eemdLe0Shwfews7qoS4O8O
	i6Z0OwUS9ADzHCGS/yIq9TGOBdhTEDx11uDY7uItSDV/mUCeDDkrWgHcBu7Fv3PU
	k+DIN+DLF5Oo6Y5P9GOat8C+ZyobUJc4iJBTICKAbGdtZEuxPgPzRApjLhaFECVS
	miiC6gYBmRIA8k1an4tqXFjdISnhVAAv52ac0bD4/yL0wMy0yg3Yv7cv40RwkrPn
	bgglKPiGlVdz7IQplvHxCSfitj+TY2W4Ry7rgJEbeYlICoj6vgfdVcNyZSoUR5FY
	o8nKwBBLBEc2OA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88k780-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 22:45:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYYrZgr1yhoONFW2bjbjqOYR9X9BNrUIsfm0ZagGH89W9Byhr0vtsYfC7kZHct8DgETSMdy1EbkYGiJkis/iHSl5A3/7LIgBJivCHMDnDz34+F1Bq7T/A7Eb5aWI+J3VPDj7VwnOwRUjnm7ceJ0AukUR56M87CiLZ35UkyZYFtD1LJjZij2eWxkQAp2vyvgzHn686USFgEm2mZwbSAwzepzvi124mi2ZynG2s6/A1m70I97iOO57S0g6zrOmfvGgC4ngYKWXY0zvUZUr+WZRGJFOsmHqcc8xiMjkTgiiM+DiRILynH3NsJ+9U49m0UdktUtq1Yj4zeKjfoAgRgxDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRzZ4DU/gvnGdRykyr9gyRLuqnMqYteRzQxrcwkLmxU=;
 b=ABI9kUNivQPV6cM+F8yFyaNa1rpoaUMRt3qnXNttb1R+olSQ0gOAC6pN/XMuYCmjwxdGN9o1ZEOi357bF4hEBBOPb0HPNrKwR/+B7WRhYYKXJLECBgta2HdWzYEsQ4J7jLFrHukIVvhAfw5JpUtn1GCGGpmu9OG9wD1cOCkf36zBQjvp1q9wwA5WSmxORdPHnFbmg+242o4LrzgjoU4ei+ObP5ZdVLlY1MTMi173Lex0AQV/ouujKcnemoO90LFfTzMUnVxxlg0KmSiaiHEFHHb0q9sZM0UWa1PVFN1oqsMfxdjoi1MK93YbJyrnVnovfpyWu3nZbm7Gn+7fN8cAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by DS4PR15MB7050.namprd15.prod.outlook.com (2603:10b6:8:2fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 22:45:53 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:45:53 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "neil@brown.name" <neil@brown.name>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "zhongling0719@126.com" <zhongling0719@126.com>,
        "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
Thread-Index: AQHc6Kng/lSlzQT5Q0qsbJ5n/nCPKbYXg34A
Date: Wed, 20 May 2026 22:45:53 +0000
Message-ID: <5feb37e5f77d29d9a41f20df8ab1162fab7730a9.camel@ibm.com>
References: <20260520095428.69422-1-zenghongling@kylinos.cn>
		<d2cd070ded01305414815248032bbfc331c392ee.camel@ibm.com>
	 <20260520234153.7a89f0b1@pumpkin>
In-Reply-To: <20260520234153.7a89f0b1@pumpkin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|DS4PR15MB7050:EE_
x-ms-office365-filtering-correlation-id: e3551811-6172-4e83-111f-08deb6c18c83
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|11063799006|56012099003|18002099003|22082099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 i/5ssVnAnnBXqlx7oysdqKHci5Fal3tVnMM2Bi3Y9W4NfmeyF1WxAfecd0lBCcQ4mM4bPBE/+D4l9Pcbhmlyg8QXvjgGrJYo5uMpD0T8dKn4lW42U2jEncu4g0VAbiA3oibojvwWYYpYw1aRdSXO57kbgwOmzW1/xyXa3vBZ0WTHVg/uobGgzeg/SYn0h6c5bzH6owqIgvvtiGYdS69dWVWfpHFUo8IEd/SgCkf6shkCm6C5Gd++HQapkq/QKr3IIztc1s4FQsMiuaCepRUs70D/I2LsROhdNVtiqOH9+X02xQooSZARWp3v5MFs3VKAMlHhAh3RzpKmAsZsmMq6QHVBVXw+333/7KojSt15i+kqUnEXHwHsq+aomWND4zWPgOGLB9mJY+7lg4oTKepVS03oYibS/EuTsc5htDGjJcDccAM/tVPd31r+ndtqakpwV95fpFF4f20pNg03OEEs71HqU2EfFwXuBgU2qIfzGdDzR3JaZZaf1YrTaYGKje74BA+OFMSj1lQnslU0OkVw/QuYq6djJxkB4MCK2yFb9Oqqr9RliudX4xrd/I/COKzay1rvse5lGhpkNnt1/YhNuIicHBo/cz2cwNsVLAmmVDgVFlb02oXlOgU2vsFQ4/tYEDSNM5F7wTltGUwWFsILOc3r+1yO+Z2ce9YCWtUmcP0MM4DKcZWndkyyVP8p/cLusVS6F7iLdN4LYyKpJjW/VmpiezxB+kh9o1WVLdtz8n5o5RtJX5wdri/oX7VKyVi1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(11063799006)(56012099003)(18002099003)(22082099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUlPYnZXbElRbWhTdldxbDIrTUFZaE54QzVrQ2hmMmhiYWsvRi9PU3kyN2FK?=
 =?utf-8?B?ZmJLMUhsUkFJWXRKT3duQWUvVzBCYTNGQUVuWTA4Q05uYzZXTjJiclhvL01k?=
 =?utf-8?B?OFNQZlUydUdJeWw5bkV2R1RNMFlabEpnRnRINEZBZkd6MmhXRnRQZlBNenlz?=
 =?utf-8?B?cGFiODNEekIzWEIzb2gzeS9QbnZiVjNkNHFCYmo4QVgwanVXZEgwa09tclJI?=
 =?utf-8?B?eVV1WGM3Z2laOXZnZ0IwQjlqcjNaWFppaUs3d2txRmd1TGJ3STZiSTZEbXAy?=
 =?utf-8?B?czBFVW9Hc2xYajUxREY1aGI4TmRveStkZ2lVQ0c2bkUvU2drYkVtNmJIbGo5?=
 =?utf-8?B?MTd3ZjdvRE14c3ZnTUxha2xDQU1EL3E3ZTIycWszNEIyY2szNUh4SXZWTkdG?=
 =?utf-8?B?K1Z4NGRLa3Y0UnZudk4zRFk4ckVzQTZJUmwyVTFzYktCKzVyL003SWhwRFZ3?=
 =?utf-8?B?WDNiS0NCMTkvaHdlNDJJa3dPK0hTdjRxdzBNRm5NbFVwZFV0RVNqYnBMdnZE?=
 =?utf-8?B?dnNqQ0lsalNQU09YSVRpLzZGU2UzanJNWU5nbXJSM05RZjJSSm1acHdSQmUw?=
 =?utf-8?B?QnVXMU5EUFNHbDRqcWJocXd6Wk54RVh5L3o2aElIak5MWVRiUjBoVWsycW5Q?=
 =?utf-8?B?RGZ4NG42ZWpjeVJlQ1MzZk1GclFqVFdWZ000eGo3QVFtMXMya0c1cnhHdUIr?=
 =?utf-8?B?L25MVFN1eHVDZ3B0MFErb2pXZ3Zza09YMEVNVk9WOGxwaHpwaEllSFlFMTZJ?=
 =?utf-8?B?NjJnVUxaS3cyc2FLcEx2SERpVGZZbzhjQzJDbUFsOVNneTlmVnR1YlN6cWFU?=
 =?utf-8?B?dEpyYVNBUWthNHNNc1VGMUQ4UkNhRGhvL21GK2R5UEdIc09nQUwvUU84YkFO?=
 =?utf-8?B?YnI2eUI0THVLQ25FYld5NTNDY25URzVsbW5hTGt4ZjR4MVF1SXIyeEIyMzZI?=
 =?utf-8?B?TGV0eWJHUnJQVWtsNFl3WDkybitEbUxubTNHMitKUmVOWkZCdkE1c3A2N0Ni?=
 =?utf-8?B?UWNRT3pNVUFKOXF2a1hlNlk2NUtXT01JMGc0RWlPcHc5WDZsVklDVUM3VjY2?=
 =?utf-8?B?eU5Da2pDcTMrV1VUQnVBU25pTjBzMkZETFp3blFLTjJLRnlDaC9DZVBNZXJH?=
 =?utf-8?B?RXJMY0lyVEJzc0p4bFAyRW5hQTQ3TnpibzRxWlFSTDVhUURrZHhZb2lpQUJO?=
 =?utf-8?B?VFhQeURSNE5pM3NpS2pGYzUzK2thOGgwOTREZlg4Z29IMG9kYmJvTTl1WEVp?=
 =?utf-8?B?ckNOM3VqMytGV3dmWCtwSVYrRHpFZ1QrZGUrelg5TUI4ZWtZVk54YnVzOHps?=
 =?utf-8?B?Tm96TUtEQkFjTUNyNEZCVkdIWTczeHR2ZEtXQTg2OGJsR2oydDNiQjh1clQ3?=
 =?utf-8?B?NzMxWUxJaGZ5QmtXdFNucU5kMnFIREY2QXJXeUUrVGd1eC8rWm0vZlhLcEVQ?=
 =?utf-8?B?aFRabHM1K2w3RlFZbzUyRThsWStoSzlOQjk5bUR6VkIzZy9pa29hK1NaMXh5?=
 =?utf-8?B?ai8zVVRwZjlXTHNaUVBHME5VUElNT1o0YnQ3a01kbGR0T080U3p3MXcxUVQ0?=
 =?utf-8?B?a1l5cDVCakNpZE0rbkpwYmV4MXlXUWd1S0RkZklsbnhMVlRIU2tXdyszU1VC?=
 =?utf-8?B?OFY0bjFtaURhVkduemYvcEpHZGZVanFGcm1TVldWREhDT2FnUVhFZVlGWW5v?=
 =?utf-8?B?TDV5cEN2REFIRU02TFZYd0pzbXV1ZFZsZFBhSkxEeWU5b3pQZnI1U2NEZW1X?=
 =?utf-8?B?aWl3SjRWTi9MdXNVZkhjQW50NWdxQm84cFJFNHpwRS9QN05mSUtPcEVodmFx?=
 =?utf-8?B?ZmwvSWlEZnVoK2Q2Zmtzd0lGYVdmdUEwb2p5ZGFyR0FyeUxPN0hmRU1IRGNq?=
 =?utf-8?B?a0hrd3pnTHJEMDVnTnd2Qk5kQlBoUXNjb1YreXFjRnFTVnhEeDJKQUl5SDZR?=
 =?utf-8?B?cnZnNzJqN0hOTHZEOVNvMkJYWmQrZ2hjQlhqSktKVHo2UmVCTmNXOXRZY2Ur?=
 =?utf-8?B?a0tPem9pZS9HTitTQmtRU3hWRXRKTVNhS2FxZGljaG5QSEJXM0tsL1doU042?=
 =?utf-8?B?cXBiZDNaTmorNFJGR2kySlBuY2JEaVdLYkk3WWFmeitldVJPZVByWGFWRXUr?=
 =?utf-8?B?czVyUjZ3dzgrZlZuM1N1ZUg2bjNML2VXRG1XVjJsNGY4R2NCVTZsN1BreHFT?=
 =?utf-8?B?ZFhrbTNpSjdZakVUL2x3MnduQ3hyT0lpUXIvYitzK0tHQnZ1bVNycEdaVHQv?=
 =?utf-8?B?Unk2clVBdlpPakdaWDZ2ZURGekVLSUp0Sk5id2Q2RCtXYVhjUzlEUWVWSHNX?=
 =?utf-8?B?Qzc2VEIwTS9hdWdidmk0L3J1NWU1VXZjL05vWG5jWTdib0V2ZndLdkY4RllR?=
 =?utf-8?Q?KBoTlgqBNZLoSdAeVHJR/BST0izs3b7KFT6P5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3B3B5C48AD7CE4ABE80E4EDED01D614@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U+n/aVxYY8n69V2iQgBlLytFsPvthqzENx2DVx37Cl7HXbkHwMQ+ZhihrhA6c7GdX44+5/WZsdac9MX6Fb+SDt5w1QNCz0Read3JEqckdLhLYLJcPyD/9H2VH1biVeM2pE+HJZhx4qo1otlZUYEAZv9jSALJtve1JiwG6663pmYHQAN74PnGe4Mr7yWv5OxYmmMt3/s67K8VM8mTm6k9ddkcyQEK1GcYY4SCguHaOzVgIoGuAdNhwFAM3RRbAqxJlGxrssSc+BcK1cBaKzu7VKaGZM4CInWWC9jEl0kC6IoyF8Y2/kXFB3oMyRjKMKfaqI0glrII/lXZoXb1Wz1Ltg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3551811-6172-4e83-111f-08deb6c18c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 22:45:53.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/ldmePmi3qzjkHhOuFmwl07dAVnmtDbVwESEr+38L4yn1N60gPInZqvhsvakPCK1MMoRkQaTxkkpKOcuMvmSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR15MB7050
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SsDpdgS8uGdTudeZwWqmpd9r3ZY7_nA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIyMiBTYWx0ZWRfX2eol+G4MpZC4
 CKDOWmB3+In0P7mxD6k0bp1owEPgPP4ijByMCjnchLyTcz/mE2RSuHrE/CCDrKN2a7opvX7xavw
 pWEP7vW6H9Im+PsFsSfGBTjAIIAagDtc10EN8fqOyZhSS+X2qZg0XZcTTKokB9euEwP0RJMxyjK
 D3PqodfJQW+wvt+xaOr640Y/BgOIKkhkzMYCOyR7ONUeu31Zr54xVW4qdZtOOZ78eQhVKq+2FFB
 cJ8WEkjP4Bq2FoT1d3Y+kCjIBV8Y3MgIMImaN1sZoJWia9Uwjdf/4nzOpVPxF60kA3Gnunj32YG
 TrFs9mPt2+laL6WOKMQwxATUfPPq0Ktg0GtpFPeDydC+XFPsmC2ycQJ7rdd8BR+AbkcQIhC1vuc
 IyaEQIMug5oRsiKNEZqHx7QNIqG1gP5hswFKh9G20J8OjfDjIIN4GrYFByQQucGunyMse2XX/9A
 uBaXxfo9QSesmWU6pDw==
X-Proofpoint-GUID: BNNiTTXZ40_UvPzBYE4V2SjbPYmy8-xy
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0e39a4 cx=c_pps
 a=xwsl9B6YvhynmxkULKMBWw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Btl0WwIcujT4cfGfzHcA:9
 a=QEXdDO2ut3YA:10
Subject: RE:  [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200222

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDIzOjQxICswMTAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
IE9uIFdlZCwgMjAgTWF5IDIwMjYgMTg6NDk6MTggKzAwMDANCj4gVmlhY2hlc2xhdiBEdWJleWtv
IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBXZWQsIDIwMjYtMDUt
MjAgYXQgMTc6NTQgKzA4MDAsIEhvbmdsaW5nIFplbmcgd3JvdGU6DQo+ID4gPiBXaGVuIG1rZGly
IHN1Y2NlZWRzLCBjZXBoX21rZGlyKCkgc2V0cyByZXQgdG8gRVJSX1BUUigwKSB3aGljaCBpcw0K
PiA+ID4gaW5jb3JyZWN0LiBJdCBzaG91bGQgcmV0dXJuIE5VTEwgaW5zdGVhZCBmb3Igc3VjY2Vz
cy4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDg4ZDViYWY2OTA4MiAoIkNoYW5nZSBpbm9kZV9vcGVy
YXRpb25zLm1rZGlyIHRvIHJldHVybiBzdHJ1Y3QgZGVudHJ5ICoiKQ0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSG9uZ2xpbmcgWmVuZyA8emVuZ2hvbmdsaW5nQGt5bGlub3MuY24+DQo+ID4gPiAtLS0N
Cj4gPiA+ICBmcy9jZXBoL2Rpci5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMv
Y2VwaC9kaXIuYyBiL2ZzL2NlcGgvZGlyLmMNCj4gPiA+IGluZGV4IGJhYzljZmI2Yjk4Mi4uYWI3
ZjdiNzAxNmM2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvY2VwaC9kaXIuYw0KPiA+ID4gKysrIGIv
ZnMvY2VwaC9kaXIuYw0KPiA+ID4gQEAgLTExNjcsNyArMTE2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
ZGVudHJ5ICpjZXBoX21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUg
KmRpciwNCj4gPiA+ICAJICAgICFyZXEtPnJfcmVwbHlfaW5mby5oZWFkLT5pc190YXJnZXQgJiYN
Cj4gPiA+ICAJICAgICFyZXEtPnJfcmVwbHlfaW5mby5oZWFkLT5pc19kZW50cnkpDQo+ID4gPiAg
CQllcnIgPSBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZShkaXIsIGRlbnRyeSk7DQo+ID4gPiAt
CXJldCA9IEVSUl9QVFIoZXJyKTsNCj4gPiA+ICsJcmV0ID0gZXJyID8gRVJSX1BUUihlcnIpIDog
TlVMTDsNCj4gPiA+ICBvdXRfcmVxOg0KPiA+ID4gIAlpZiAoIUlTX0VSUihyZXQpICYmIHJlcS0+
cl9kZW50cnkgIT0gZGVudHJ5KQ0KPiA+ID4gIAkJLyogU29tZSBvdGhlciBkZW50cnkgd2FzIHNw
bGljZWQgaW4gKi8gIA0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCB0aGlzIG1vZGlmaWNhdGlvbiBk
b2Vzbid0IG1ha2Ugc2Vuc2UuIFRoZSBFUlJfUFRSKDApIHJldHVybnMgTlVMTCwNCj4gPiBhcyBm
YXIgYXMgSSBjYW4gdW5kZXJzdGFuZC4NCj4gPiANCj4gPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCAq
IF9fbXVzdF9jaGVjayBFUlJfUFRSKGxvbmcgZXJyb3IpDQo+ID4gICB7DQo+ID4gICAgICAgcmV0
dXJuICh2b2lkICopIGVycm9yOw0KPiA+ICAgfQ0KPiA+IA0KPiA+IEVSUl9QVFIoMCkgZXZhbHVh
dGVzIHRvICh2b2lkICopMCwgd2hpY2ggaXMgZXhhY3RseSBOVUxMLg0KPiANCj4gSW4gcHJhY3Rp
c2UgeWVzLCB0ZWNobmljYWxseSBuby4NCj4gTlVMTCBpcyBhbiAnaW50ZWdlciBjb25zdGFudCBl
eHByZXNzaW9uIHdpdGggdmFsdWUgMCcgY2FzdCB0byAndm9pZCAqJy4NCj4gRVJSX1BUUigwKSB3
aWxsIGJlIHRoZSAnYWxsIHplcm8nIGJpdCBwYXR0ZXJuLCBOVUxMIGlzIGFuIGltcGxlbWVudGF0
aW9uDQo+IGRlZmluZWQgYml0IHBhdHRlcm4uDQo+IFNvICcodm9pZCAqKSgxIC0gMSknIGlzIE5V
TEwgYnV0ICcodm9pZCAqKSh4ID0gMCknIGlzbid0Lg0KPiANCj4gQnV0IEkgdGhpbmsgc3BhcnNl
KCkgaXMgdHJ5aW5nIHRvIHN0b3AgeW91IGNvbnZlcnRpbmcgYSBOVUxMDQo+IHBvaW50ZXIgaW50
byAnc3VjY2Vzcycgd2hlbiBmYWlsdXJlIHRvICdhbGxvY2F0ZS9maW5kJyBzb21ldGhpbmcNCj4g
d291bGQgbm9ybWFsbHkgYmUgYW4gZXJyb3IuDQo+IA0KPiANCg0KU28sIGRvIHlvdSB0aGluayB0
aGF0IHRoaXMgcGF0Y2ggbWFrZXMgc2Vuc2U/IEkgY291bGQgYmUgd3Jvbmcgd2l0aCBteQ0KY29u
Y2x1c2lvbi4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQo=
