Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DA248893
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028300; cv=fail; b=YwxJzINAFWrzFW4Koqf38/gK5BcXc7gogFSh9nNnutE8ad/Dqw3R3Fd9HXvn20h+XlzX/Iqw62H3vcLc92CweJqrs6AwgmYhNkM63Zt7csXm6pMomcs1LgIXmDUHCcAb57Z2lkSHlcH7CRNgT/kuMQaq0liKDtlQLKus6adxU5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028300; c=relaxed/simple;
	bh=AgDNMUSAnOh1kSG3dKCAApTtjkTY5K4WzOHfTurRPDE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=QHB26PdYuf5ND/bha2tRltz5nEkUthTpfpQPEdB22c20/1PfVkKVYPm0hOU/OErml0jDqlM47EkZHgirqaCYWMvkXrgbaA9oSXpWw/tozgEIYdeGCyXrfzGucLQgO8BQLF4k3c8uBtbziYnjxJ90pXQMTnyvWyAcL8vQRiIX660=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ke04r8Su; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ke04r8Su"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LBdh0k019548
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 20:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9C/EhWJ1D5vVw+0tpehZJt3mPTan0CJXiawR38+PSlQ=; b=Ke04r8Su
	AwWmOPL4Z5v/TGHJr4ejN79l4025+8vVev09P0mCSLBCUOyOZx/eXOlLNFW/XBTY
	4CxVDdhcfNKKJC6ifZpDi+yZ2DIE4hRTluPsZ9y2hkb+/u2I+qjIwgOZpwKt3dlR
	FcJ/Vw2IIDkQjFosHbRS30Ue6diLNr/D79obv2UnmZMw5DsFzdGENQJNt/fw1vD8
	8G8hFY5cCDZOsp0Spmvuq6YVgQ++y5HDPQQwYWdmScKxz4rHWtweusU3QooZZXxa
	6V0rcH/S0P9Ul9krWpN5lwbPsmUC6yMsUI4NvPPZ43P+NstGgaZHW+PhJkgRD1Pc
	HaU9i85/2QYL8w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2566c14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 20:44:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LKi5vN003879
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 20:44:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2566c12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:44:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LKWjuO014846;
	Wed, 21 Jan 2026 20:44:46 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2566c10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:44:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYWwC170Go8Lc82MET+PKDOFGgHWPLPIo+eEmAJW9gHECEihZ4sLa1OQ3b9UJt/yghuSUCEJoAbElLUNeGdc4nNRG6XLARF1C8dEmTCcsGG0kQozAMEVh53XbzK67XB3hEBJ/Iae0arHLtX0pqucrxayS/p1V6pOfiJSwIdTjzwo99UPVpY+2wX/b8UaliVtU93zlEUay/FIEbC0yO+9FAcGC50btMV+BFYhVOWuc4Dp8gjnV2kP54NmsuW7XSLUCyLgHXTelO6YrRBuPeKEmmWayi8+DGUY1xcbLuCIbLjwBvWH0Nq1pdgQc7Ijmvba76ce6ag3YcnHmJvhZVklog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfLONecXd1eP1bXoUO9MkxUSWLuus7vQTLM5DMzL+LE=;
 b=iMGj+fgV5FeJZp6LHsn1OHHj9EZEkPlVwmhghGZQL2o0OyYgU4CuqHKtCFdMqfRHogMl76Z9eFre6rOjrZLGOM9RpmahjjlLnwRbTNdwX7bOgaR0ildq929iYIw6dNm88JAHrED5p+gjkH480ahvFAnXjOM4G2Szt1R8LftMDQERvS+vSeZfGfZy1C7oJTaokndU3q3g5S/OEfmFbiC0BGc0beuSvGit9E/j3+az05KwqS7WuToRgVwtP5v72FuNHiwALt91J0C0IwXkBm40XD0xI53f/SewTubrefJgrKuZFY6kIES7orclrgjQwYEzocRH9naWK2tpwL6YkYNxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CHAPR15MB6998.namprd15.prod.outlook.com (2603:10b6:610:2f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:44:44 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Wed, 21 Jan 2026
 20:44:44 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "daniel@chaospixel.com" <daniel@chaospixel.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Xiubo Li
	<xiubli@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] fs/ceph: Fix kernel oops due invalid
 pointer for kfree() in parse_longname()
Thread-Index: AQHcc4m7/8ZhY6GLjECGBMIwypwZdrUv1b6AgCtoTgCAAghpAA==
Date: Wed, 21 Jan 2026 20:44:43 +0000
Message-ID: <0efe1bf76b0ee85fef60c1508e0e2877bce752cc.camel@ibm.com>
References: <20251220140153.1523907-1-daniel@chaospixel.com>
	 <62924ea8997fb174034e6333db3a52b2f30f0e68.camel@ibm.com>
	 <95555273-fa9a-48fa-855e-ca1e71f4c903@chaospixel.com>
	 <180a7f3f6965b69298fbfd90806aee3102c5abb8.camel@ibm.com>
	 <4ubz2itqxjbq4ubpqcwgv6hsaszbxo5tqjjucfpfrpkho4gc5a@xhzucdi5eepg>
In-Reply-To: <4ubz2itqxjbq4ubpqcwgv6hsaszbxo5tqjjucfpfrpkho4gc5a@xhzucdi5eepg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CHAPR15MB6998:EE_
x-ms-office365-filtering-correlation-id: 474a65b4-d3fc-4a87-27d6-08de592de864
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXJ6bDdzdUJzT3hGYndoR040WGI1blhTQlVWV2ovWGE0eElkZGJpc1QwODI5?=
 =?utf-8?B?anZFRnNlemVrMXl2WExFcFVSaFdEeUZLdG0zSjRCbW5RR1ZSMFFieWo5S3R1?=
 =?utf-8?B?NkxxVW5RSnV3dmVDTWpzbzV3QXhLWUpMcWVCbVV4UjJONjhnRHZzYWQwbzYw?=
 =?utf-8?B?OTN1Ni9WcHNxanRZeGYveHVFUC9zaVpkWlhCYVB1R3NxT25qZ3ArV1doNm1q?=
 =?utf-8?B?K25MR25qaDBvOCtsMGZZdjk0NllsSlBpbmF1bVkreHJybDNhamhvWWNYeCtV?=
 =?utf-8?B?NDVDbzQwWEFkdEY5OEkwNWpLSy9wSUtGY2F6UERSaGROcGxHM3NKaC9FejRQ?=
 =?utf-8?B?TXBmcnhkWjJURWJ0RVdqLzhmMmNvakNMall1WW1tS2F2b1pJc2ZmaFV2RHhM?=
 =?utf-8?B?Z2RTMnFHYnlFUEhWRGdadU5CcVE3bGF3WG9RTThJVCtoa3JBUnU0ZkowM3FV?=
 =?utf-8?B?VnlPOXNuN252aDdXWlpUUWh1dDUyTWRRMTd4MzJOTHZMVGcwVTVSU3F0UXBt?=
 =?utf-8?B?Y2hrNGNVMlRNYkt3bTNqcnlGOVNWa3N4UXVFZU92N0FvYTl4MzdOZ0xVQ0ls?=
 =?utf-8?B?aEYvTmZWU2tsbEt5bXF3MmpqNDRzdnVIb0lFMWRnR0hKSTdKYk1TbDdvZUtx?=
 =?utf-8?B?bUdQZHp3UlpVVFBibkVheW9CYkhVWUhvWHdkQ0pvRndqU3EyeU9ZYVdlUW1J?=
 =?utf-8?B?UmdsY0ZidkNDWlVnS0lpcHZHWFNuVnk3NXJLVFZWbDZidTRNYlZTSFJOcmVQ?=
 =?utf-8?B?STh0RjRpcUtxMXorZitCd251ZG02SHdRQ1F0ck8wVlJPVGdzWXVyenVDd1Zu?=
 =?utf-8?B?VHNIbWZPVUZrWlVOQ3FnZGg5SzNqWnpjbEdDVlRycjcrK05GUjhwMENvOEph?=
 =?utf-8?B?ZVZ5Q0o3Y2Q0T2Z2WnlqQm9kQjJYM1BieU51VEc4NXB1djc1R0lKeEVFSHc1?=
 =?utf-8?B?UWIyTVIrbGM0T2FJeG9NZldGdDVyOGNFUE9IaW9pNlo3VHQ2YWdreDlXb1J5?=
 =?utf-8?B?ODVtVkk2anhGMjE5b3NyNVNpYTlnb3hYbzNuWVA4bWpKbXlGVDgvSWcvWk1h?=
 =?utf-8?B?WDVCdlU2MkFLWHoyZVlkQXNGbGF2UFhXTXNnYkZSb0cvd0lCSFhudzF0a0pa?=
 =?utf-8?B?OEJYR2sxK29lWlA4dDJKZzlOenkyTHlUcGMvZUtORlRmVnk1elM0QndpSjEv?=
 =?utf-8?B?SkRWUUR1akZWVDJmZzBVYWd0aVBRLzdJK1VrWS96V1Y5VGZmV1R0Q205dGdk?=
 =?utf-8?B?d3VCZlZaWkNNSHplWEY4N01qV1QrQVducG45VGpud050K3VJUWdZbEY4UzRP?=
 =?utf-8?B?bDA1Y2tkcm1yMnE5QUViUlVFdGMzbS9pVWY4UFk1MUNZbURDS3FJYXpLMXFm?=
 =?utf-8?B?cEFQQjZnODFVR0FMMjlVSkJZaThhb1lPZE4vd243WjFzcXdwRDVaMXU1TnJV?=
 =?utf-8?B?OXJlWEJoTnFMM0FtOGZ3RFdQY2h2L08vanpFNU9ZU2NCaCtEaXVPRlJacXRL?=
 =?utf-8?B?Q1ZPR1FjRW5YRmx6dkYyZWxHR1pReU9aTzhjcHUrbThGa3hJbHprVncrRlNR?=
 =?utf-8?B?VlFPaTFaSXUyUUJ0WjFUZlZPY3dva2ZoYlJZSU1mOEJnOGJxVnpDRXJkR1d0?=
 =?utf-8?B?dnk5ejU1R0RhUEFjZDJ3VUdWQktHMFFVQytaTGVSclBlTFlXbDc2T201RFNz?=
 =?utf-8?B?dFlONWVQeDMyYWR0alo4dXFKTnlsN2t5UmFNVDE1S2tpdUx4SDFJdGVTd0lo?=
 =?utf-8?B?SktCUkJYSmF0dXpPUnRKcE9rOHZWZkczMVhacWlnOWxOeC93UGRoWkUwV0Z1?=
 =?utf-8?B?MGNlYTUrTUlBdXlYRGtHR2hJb1AreVNkUjVGWGhrUWVkZnpqbVlJcXpxNW9l?=
 =?utf-8?B?L1d4TTg1eThoaHdLZ2t6WGFpOUU3RUtOdHhyc2lGcHNlQ1FHM1VrNVBWcE9N?=
 =?utf-8?B?MEZYaUdrTDJCODBka24wbkxlTlpxWTZFWVZLbDYvV3pUL3grSndzTlJpWEcv?=
 =?utf-8?B?MzBFV2dwTk40ZUdCNGhWNWFOaDZ5WDJYWjFJUlB5WEF0cnB2YmZGRW5Lb05K?=
 =?utf-8?B?Uk9ydG04NE9BZDJpT1p4Wm1mYkdNZ012TjFUaDNQeStYM2hsdytyNXZwbUZS?=
 =?utf-8?Q?kYWU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YktLMC80TWdhaWRGdUV0Nm1MamY4bTJHbzVkLzR0NHpBUmIrMWZKSnoxbW8v?=
 =?utf-8?B?TEsrMm0xYmVnQ25JT0NuK0tLUmk4NTNyL2JHMnlLRmxhQnpVWmxYdStnbGxv?=
 =?utf-8?B?MmF5eDZma0xHTzk3NGk3UVhMVFNRVExSN2JPbEJpOVhvdmo3UmNyc1BiQUhE?=
 =?utf-8?B?T0JXUjA3ODYxdTBqNXFUUkNnenZmQWh6SFo4OFJSSjFndFF4S3piQmdmZks1?=
 =?utf-8?B?ZWdkRlc0bnVmWUtETUtTSmFwTUdTRlEwSjhwNWNNRkROenIxVHVVcGVEQXVs?=
 =?utf-8?B?VUxmOHhnckJobzJ4aDB5eVEvSjJzZ010MUp1U1crU0hTcXBKZ3ZXUkdURDk4?=
 =?utf-8?B?MGlqNnErYTJ3MnY3cTZKM2x1akdNS1BkSkhUV2dzcVg4SC9lVTQ4MlRpdTkr?=
 =?utf-8?B?MVAzZEpTaUVVcmVOTmNydUd0Qlp1NHVPQkRWRFQrZHlUS0NxL3BqU2pKdDdN?=
 =?utf-8?B?dFhXQkJFS2hxR2N2ZGI0anRiUnUwM1p5aEZuRnZwZEhkd2x2N0hPZ1lPa0V2?=
 =?utf-8?B?djVWTHJNTU9oa3ZGM0pjTkNWalRCYWlOMkdrTGRESk9HM0lCRHB2MHdLdzN4?=
 =?utf-8?B?WEZHUTNzbWM1bmU2VlhMVHpUem1IVGVMckpLMmpkQ3cwWFFyVURoWFB0MkN6?=
 =?utf-8?B?bVFHTkVhdGQ5SHpJMnFHSDYyYTZDYTByeFNGQ01wTzJJdWNiMVI3cTlzQjFW?=
 =?utf-8?B?QVROVVRRQk5IR2xIR05hY2c1anJ4WGpDQldTTDZUS1EzTWJxV2ZtQ3BxYUR1?=
 =?utf-8?B?T1N5VGhNYmJuYjY0UlFHb2lCLzdxdjhXMGlsbmhOYXNOdWJscWlnZklxN0VG?=
 =?utf-8?B?UDJaOUhSQ3Q4a1BPdVNueGltdWlVTmREb0doSlo1eVBpQmVQN2xValpDT09V?=
 =?utf-8?B?MUlIa21yd0VQNi82R1FjVHdVOXJhUG1ab0hTeFhGY0Y5V1ZpL3BzWndmTEJR?=
 =?utf-8?B?SUxyRjdkbms2NDlvQWVtcFBqZHRHSEJGUzVSWmpxWlJlTGFZaURuQzVXUE5E?=
 =?utf-8?B?RHZPaE51eTdBQVYweHplNVg0WVJlNklmcTl1UndMRVlLMm9pQWNoenpUWDAz?=
 =?utf-8?B?K0JFR3lWUnBKWVdvOHI5RmNncHpIRUxhWm5HUnE3RkRlZnNXMFRicjJBS012?=
 =?utf-8?B?UTlMZTR3V1Nka3BxdWt6ZGJSNTFkVUtlQ3lFYldxZ1M5NzdOYnlJMk5VdEVx?=
 =?utf-8?B?NS9JaCsxQVRhZm1POGdHNFVYeTFlTitBbVZPVE1XaWJEVjFHTUJqUUlRbXcz?=
 =?utf-8?B?azNXNStXVVFVbDcwYmxTOHVITWJhYTB0eGlFVEp4SFk4QW5Vd1Q3YzBpYTlK?=
 =?utf-8?B?M2tta1l5VnoxamY4ZmtuSWZUU0NDSTJ5bS93dGs2d0NiL2pKTXR5V2I1bHhh?=
 =?utf-8?B?aFlxa2pWRlRSWVJRNE9SNy9HZXdkN2JEWlQwcy9CVHZQcis2ZkhidHI1YW9n?=
 =?utf-8?B?N2MyVlFLL3N1SlZ4cGJQejRLV0FjaWNHdFFiUUwxOHZ6WG9lTkUvS0h3WkYz?=
 =?utf-8?B?YXVBUG5yRnJIclNwMXM5dEIrbDUvQ2k5SzFkdFBwYzI5cTh3QVh5ZHhxdlRj?=
 =?utf-8?B?ZDFLQ2x2UXUweVN3QzFKbjhsdlNONW1yMHFuY1RhZ0Z0YXFRdGVaUXFIRnA4?=
 =?utf-8?B?NmdLTVFyNDJ0bmwwTVA0cGtqWEFUN1NSRTBGL1BNdUQ5OFhwYXdmUnN4cUIz?=
 =?utf-8?B?a0NZZVR0UzBYU0RWeERkVlUxR1ROa0N5OEE2SVpUQm5QVDQ5WUcrV1FydmRt?=
 =?utf-8?B?VkZKWkNQcjFLYThkRkVmU29zdktmUUJBcFowMFdtR1pnNjYvd1dIdTFhS0d2?=
 =?utf-8?B?TUJYQjVxbVhvNFJNdEM4VXNvandCTkplL1doWWNtc0N1b05TWkJOazBoQWpn?=
 =?utf-8?B?UGRzdFVBMTRHbjVqWFY1bXhiMjRTYStUeXdTTkY4bFFOdUFPSmtTSDRFZlIy?=
 =?utf-8?B?VUJEZzNOSFpEUThGUkJuaGJmRCtFTnNrRVJ0N09ydDI5MlUyc3hBTmgvY3F0?=
 =?utf-8?B?cUJYZWJKbllobFRwcFhkYWV2UDVJVUthV2FoVUI4c2FIbXd4WWFvN3hKZzkv?=
 =?utf-8?B?cThGRThNTDVyVG1WSEc0TGorSFE0b042MjhOaUxSY3Q0NlM4Q1ZnSVg2SWRW?=
 =?utf-8?B?dVZNU080THhVaXBRM1JuTkdyUlRWSWVZWDdGeFlPNjMrNnpHUkVvSCtWRnRl?=
 =?utf-8?B?dk85SmR4NUJ3Vi9VZVpMT3NSaExHTFlDL01IZExYQWdtU1llSzRRNFFMVk1G?=
 =?utf-8?B?VERCbk1KNmFCOXFOTURwOTIvczN4dzQxZXJCcEhOazlwWjI0eno5L0I2aWw2?=
 =?utf-8?B?NmpmcCtzRGJJY2NsMitualViSk1pZkkxa2JNMlVzU0p6T1NsNE5xVzVCNElt?=
 =?utf-8?Q?Wg/nJ7fU/Man3d28yRBxh8+OWBnZP0nqwvnF6?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474a65b4-d3fc-4a87-27d6-08de592de864
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 20:44:43.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG0/MBikxo57k32MozHxjz+UDth40eNiXSljdrnSzJ3ghuwYMdhi1hs0P4DhWJ/QhmLWEtEUaM9JRkWWaPgx0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR15MB6998
X-Proofpoint-ORIG-GUID: U_E7K5A8h1HbkjdxnZLVtF2CPZSRRuRG
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69713abf cx=c_pps
 a=0RQO2klDQ5fyV1VIsLBujQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=4u6H09k7AAAA:8
 a=Zv-iYU-hAAAA:8 a=DeqIkG4PGbVdvWTrDjsA:9 a=QEXdDO2ut3YA:10
 a=5yerskEF2kbSkDMynNst:22 a=7POGK4OykCGyYpN2cFti:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE2OSBTYWx0ZWRfX6e29V/P9G3No
 RDYS5Omi5zVKYidNqXlvA01AAaNifYqsrg5lEH84Cwiw1Nfijtb2iTfpCJmWbug34ljCaKJCHpe
 IlHxcK9q+4fIk2B9XIjchVoSyX0UJC6Cgcf0/typ5w9shjVmGjIxiNC4hYwhXPwFiyjEx7gdbvk
 LSQcWnZF5FDZgFUU4GxpB8xaOZWdusxtmp0/6xPZTYKkzlQ8H+YtZ4SfFRI7DIpTP6qvL9A4l3c
 R44ln5Vx7YeruyVwkMdEhVuGjJy8N6PimJd4QFyAT01JOdqp4uH2KNwAVTpFSzPPvws/bkXAI0K
 dgUlF/KIV+qtDAW98Yr08oROqQxxtL8V0d9x55KW25owSf2N9B1PkxkQbWIru8uyoEO/Orzh5rx
 pZTPYkRS5GNckZiqHv7wYZ2y6wSNUdrqPeoy7xd31dlQVoDIk0EWEAq9hMHVlDvK8JxYD5qDE7F
 HgEShB1M2kSLn02j/ig==
X-Proofpoint-GUID: DXComOyBpNZo9M2iNnG7fYNPw5xRRKcx
Content-Type: text/plain; charset="utf-8"
Content-ID: <04B17523E512214084517AC83BEFF183@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] fs/ceph: Fix kernel oops due invalid pointer for kfree()
 in parse_longname()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2601150000
 definitions=main-2601210169

On Tue, 2026-01-20 at 14:42 +0100, Daniel Vogelbacher wrote:
> On Tue, Dec 23, 2025 at 10:49:36PM +0000, Viacheslav Dubeyko wrote:
> > On Mon, 2025-12-22 at 22:26 +0100, Daniel Vogelbacher wrote:
> > > On 12/22/25 21:08, Viacheslav Dubeyko wrote:
> > > > On Sat, 2025-12-20 at 15:01 +0100, Daniel Vogelbacher wrote:
> > > > > This fixes a kernel oops when reading ceph snapshot directories (=
.snap),
> > > > > for example by simply run `ls /mnt/my_ceph/.snap`.
> > > > >=20
> > > >=20
> > > > Frankly speaking, it's completely not clear how this kernel oops ca=
n happen.
> > > > Could you please explain in more details how it can happen and what=
 is the
> > > > nature of the issue? How the issue can be reproduced?
> > >=20
> > > All I need to reproduce the issue is to run `ls .snap/` on any mounte=
d=20
> > > cephfs mountpoint that contains scheduled snapshots. I've one prod VM=
=20
> > > (KVM) where I hit the issue after a Debian Trixie upgrade. To isolate=
=20
> > > it, I've created a fresh Trixie VM, dropped the distribution kernel a=
nd=20
> > > built a vanilla kernel to isolate the buggy commit by using git-bisec=
t -=20
> > > and to ensure the bug was not introduced by any Debian patches. If th=
at=20
> > > helps, it's a Squid 19.2.3 cluster.
> > >=20
> > > So basically the steps are:
> > >=20
> > >   * Setup a Ceph cluster with 19.2.3
> > >   * Create a pool and cephfs
> > >   * Create schedule snapshots for the fs
> > >   * Mount the fs and populate it with a few files on any kernel versi=
on=20
> > > that contains bb80f7618832, that is >=3D6.12.41
> > >   * Wait until there are scheduled snapshots created
> > >   * run `ls /mnt/my/cephfs/.snap`
> >=20
> > It will be good to see the particular command that everyone can run to =
reproduce
> > the issue. You don't need to share the command for setup Ceph cluster, =
creating
> > pool and CephFS instance. But the rest steps are really important becau=
se mount
> > options and details of command that you run can change everything.
>=20
> These are the steps to reproduce on a new VM:
>=20
> # echo "samba-fileserver@.files=3D/volumes/datapool/stuff/3461082b-ecc9-4=
e82-8549-3fd2590d3fb6      /mnt/test/stuff   ceph     acl,noatime,_netdev  =
  0       0" >> /etc/fstab
>=20
> Reboot the system
> # systemctl reboot
>=20
> Check if it's really mounted
> # mount | grep stuff
>=20
> List snapshots (expected 63 snapshots)
> # ls /mnt/test/stuff/.snap
>=20

If I will do something like this on my side, then I will have no snapshots =
at
all. How have you created the snapshots? How many snapshots (1, 2, ..., 63)
should be created to reproduce the issue? This explanation completely misse=
d.

> Now ls hangs forever and the kernel log shows the oops.
>=20
> >=20
> > >=20
> > > This should result in a kernel oops like:
> >=20
> > The commit message could include oops details.
> >=20
> > >=20
> > > [   53.703013] Oops: general protection fault, probably for=20
> > > non-canonical address 0xd0c22857c0000000: 0000 [#1] SMP PTI
> > > [   53.703201] CPU: 11 UID: 0 PID: 360 Comm: kworker/11:2 Not tainted=
=20
> > > 6.18.0-rc7 #41 PREEMPT(voluntary)
> > > [   53.703281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS=20
> > > 1.16.2-debian-1.16.2-1 04/01/2014
> > > [   53.703317] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> > > [   53.703424] RIP: 0010:rb_insert_color=20
> > > (/usr/src/linux/lib/rbtree.c:185 (discriminator 1)=20
> > > /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
> > > [   53.704503] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 =
48=20
> > > 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 =
74=20
> > > 05 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >     0:	76 17                	jbe    0x19
> > >     2:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
> > >     6:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
> > >     a:	0f 84 b7 00 00 00    	je     0xc7
> > >    10:	48 89 41 08          	mov    %rax,0x8(%rcx)
> > >    14:	c3                   	ret
> > >    15:	cc                   	int3
> > >    16:	cc                   	int3
> > >    17:	cc                   	int3
> > >    18:	cc                   	int3
> > >    19:	48 89 06             	mov    %rax,(%rsi)
> > >    1c:	c3                   	ret
> > >    1d:	cc                   	int3
> > >    1e:	cc                   	int3
> > >    1f:	cc                   	int3
> > >    20:	cc                   	int3
> > >    21:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
> > >    25:	48 85 c9             	test   %rcx,%rcx
> > >    28:	74 05                	je     0x2f
> > >    2a:*	f6 01 01             	testb  $0x1,(%rcx)		<-- trapping instru=
ction
> > >    2d:	74 1b                	je     0x4a
> > >    2f:	48 8b 48 10          	mov    0x10(%rax),%rcx
> > >    33:	48 39 f9             	cmp    %rdi,%rcx
> > >    36:	74 68                	je     0xa0
> > >    38:	48 89 c7             	mov    %rax,%rdi
> > >    3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> > >    3f:	48                   	rex.W
> > >=20
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     0:	f6 01 01             	testb  $0x1,(%rcx)
> > >     3:	74 1b                	je     0x20
> > >     5:	48 8b 48 10          	mov    0x10(%rax),%rcx
> > >     9:	48 39 f9             	cmp    %rdi,%rcx
> > >     c:	74 68                	je     0x76
> > >     e:	48 89 c7             	mov    %rax,%rdi
> > >    11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> > >    15:	48                   	rex.W
> > > [   53.704559] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
> > > [   53.704591] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX:=20
> > > d0c22857c0000000
> > > [   53.704616] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI:=20
> > > ffff8bd0c22855c0
> > > [   53.704645] RBP: 0000000000002139 R08: 0000000000000000 R09:=20
> > > 0000000000000000
> > > [   53.704668] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12:=20
> > > ffff8bd0c3e695b8
> > > [   53.704691] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15:=20
> > > ffff8bd0c3e695c0
> > > [   53.704714] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000)=
=20
> > > knlGS:0000000000000000
> > > [   53.704741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   53.704762] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4:=20
> > > 0000000000772ef0
> > > [   53.704790] PKRU: 55555554
> > > [   53.704803] Call Trace:
> > > [   53.704844]  <TASK>
> > > [   53.704862] ceph_get_snapid_map=20
> > > (/usr/src/linux/./include/linux/spinlock.h:391=20
> > > /usr/src/linux/fs/ceph/snap.c:1255) ceph
> > > [   53.704957] ceph_fill_inode (/usr/src/linux/fs/ceph/inode.c:1062=20
> > > (discriminator 2)) ceph
> > > [   53.705019]  ? __pfx_ceph_set_ino_cb=20
> > > (/usr/src/linux/fs/ceph/inode.c:46) ceph
> > > [   53.705074]  ? __pfx_ceph_ino_compare=20
> > > (/usr/src/linux/fs/ceph/super.h:595) ceph
> > > [   53.705132] ceph_readdir_prepopulate=20
> > > (/usr/src/linux/fs/ceph/inode.c:2113) ceph
> > > [   53.705191] mds_dispatch (/usr/src/linux/fs/ceph/mds_client.c:3993=
=20
> > > /usr/src/linux/fs/ceph/mds_client.c:6299) ceph
> > > [   53.705253]  ? sock_recvmsg (/usr/src/linux/net/socket.c:1078=20
> > > (discriminator 1) /usr/src/linux/net/socket.c:1100 (discriminator 1))
> > > [   53.705279] ceph_con_process_message=20
> > > (/usr/src/linux/net/ceph/messenger.c:1427) libceph
> > > [   53.705347] process_message=20
> > > (/usr/src/linux/net/ceph/messenger_v2.c:2879) libceph
> > > [   53.705406] ceph_con_v2_try_read=20
> > > (/usr/src/linux/net/ceph/messenger_v2.c:3043=20
> > > /usr/src/linux/net/ceph/messenger_v2.c:3099=20
> > > /usr/src/linux/net/ceph/messenger_v2.c:3148) libceph
> > > [   53.705467]  ? psi_group_change (/usr/src/linux/kernel/sched/psi.c=
:876)
> > > [   53.705488]  ? sched_balance_newidle=20
> > > (/usr/src/linux/kernel/sched/fair.c:12902 (discriminator 2))
> > > [   53.705512]  ? psi_task_switch (/usr/src/linux/kernel/sched/psi.c:=
984=20
> > > (discriminator 2))
> > > [   53.705532]  ? _raw_spin_unlock=20
> > > (/usr/src/linux/./arch/x86/include/asm/paravirt.h:562=20
> > > /usr/src/linux/./arch/x86/include/asm/qspinlock.h:57=20
> > > /usr/src/linux/./include/linux/spinlock.h:204=20
> > > /usr/src/linux/./include/linux/spinlock_api_smp.h:142=20
> > > /usr/src/linux/kernel/locking/spinlock.c:186)
> > > [   53.705550]  ? finish_task_switch.isra.0=20
> > > (/usr/src/linux/./arch/x86/include/asm/paravirt.h:671=20
> > > /usr/src/linux/kernel/sched/sched.h:1559=20
> > > /usr/src/linux/kernel/sched/core.c:5073=20
> > > /usr/src/linux/kernel/sched/core.c:5191)
> > > [   53.705575] ceph_con_workfn=20
> > > (/usr/src/linux/net/ceph/messenger.c:1578) libceph
> > > [   53.705627]  process_one_work=20
> > > (/usr/src/linux/./arch/x86/include/asm/jump_label.h:36=20
> > > /usr/src/linux/./include/trace/events/workqueue.h:110=20
> > > /usr/src/linux/kernel/workqueue.c:3268)
> > > [   53.705657]  worker_thread (/usr/src/linux/kernel/workqueue.c:3340=
=20
> > > (discriminator 2) /usr/src/linux/kernel/workqueue.c:3427 (discriminat=
or 2))
> > > [   53.705679]  ? __pfx_worker_thread=20
> > > (/usr/src/linux/kernel/workqueue.c:3373)
> > > [   53.705700]  kthread (/usr/src/linux/kernel/kthread.c:463)
> > > [   53.705717]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > > [   53.705734]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > > [   53.705752]  ret_from_fork (/usr/src/linux/arch/x86/kernel/process=
.c:164)
> > > [   53.705776]  ? __pfx_kthread (/usr/src/linux/kernel/kthread.c:412)
> > > [   53.705793]  ret_from_fork_asm=20
> > > (/usr/src/linux/arch/x86/entry/entry_64.S:255)
> > > [   53.705826]  </TASK>
> > > [   53.705842] Modules linked in: ceph netfs libceph cfg80211 rfkill=
=20
> > > 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common=20
> > > intel_uncore_frequency_common kvm_intel virtio_gpu joydev kvm=20
> > > drm_client_lib virtio_dma_buf evdev drm_shmem_helper sg drm_kms_helpe=
r=20
> > > virtio_balloon button irqbypass ghash_clmulni_intel aesni_intel rapl=
=20
> > > pcspkr drm configfs efi_pstore nfnetlink vsock_loopback=20
> > > vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci=20
> > > vsock qemu_fw_cfg virtio_rng autofs4 ext4 crc16 mbcache jbd2 hid_gene=
ric=20
> > > usbhid hid sr_mod cdrom dm_mod ahci libahci libata xhci_pci iTCO_wdt=
=20
> > > intel_pmc_bxt xhci_hcd iTCO_vendor_support scsi_mod psmouse virtio_ne=
t=20
> > > i2c_i801 watchdog serio_raw i2c_smbus lpc_ich scsi_common usbcore=20
> > > net_failover failover virtio_blk usb_common
> > > [   53.708740] ---[ end trace 0000000000000000 ]---
> > > [   53.709462] RIP: 0010:rb_insert_color=20
> > > (/usr/src/linux/lib/rbtree.c:185 (discriminator 1)=20
> > > /usr/src/linux/lib/rbtree.c:436 (discriminator 1))
> > > [   53.710118] Code: 76 17 48 83 e1 fc 48 3b 51 10 0f 84 b7 00 00 00 =
48=20
> > > 89 41 08 c3 cc cc cc cc 48 89 06 c3 cc cc cc cc 48 8b 4a 10 48 85 c9 =
74=20
> > > 05 <f6> 01 01 74 1b 48 8b 48 10 48 39 f9 74 68 48 89 c7 48 89 4a 08 48
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >     0:	76 17                	jbe    0x19
> > >     2:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
> > >     6:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
> > >     a:	0f 84 b7 00 00 00    	je     0xc7
> > >    10:	48 89 41 08          	mov    %rax,0x8(%rcx)
> > >    14:	c3                   	ret
> > >    15:	cc                   	int3
> > >    16:	cc                   	int3
> > >    17:	cc                   	int3
> > >    18:	cc                   	int3
> > >    19:	48 89 06             	mov    %rax,(%rsi)
> > >    1c:	c3                   	ret
> > >    1d:	cc                   	int3
> > >    1e:	cc                   	int3
> > >    1f:	cc                   	int3
> > >    20:	cc                   	int3
> > >    21:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
> > >    25:	48 85 c9             	test   %rcx,%rcx
> > >    28:	74 05                	je     0x2f
> > >    2a:*	f6 01 01             	testb  $0x1,(%rcx)		<-- trapping instru=
ction
> > >    2d:	74 1b                	je     0x4a
> > >    2f:	48 8b 48 10          	mov    0x10(%rax),%rcx
> > >    33:	48 39 f9             	cmp    %rdi,%rcx
> > >    36:	74 68                	je     0xa0
> > >    38:	48 89 c7             	mov    %rax,%rdi
> > >    3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> > >    3f:	48                   	rex.W
> > >=20
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     0:	f6 01 01             	testb  $0x1,(%rcx)
> > >     3:	74 1b                	je     0x20
> > >     5:	48 8b 48 10          	mov    0x10(%rax),%rcx
> > >     9:	48 39 f9             	cmp    %rdi,%rcx
> > >     c:	74 68                	je     0x76
> > >     e:	48 89 c7             	mov    %rax,%rdi
> > >    11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
> > >    15:	48                   	rex.W
> > > [   53.711453] RSP: 0018:ffff9ab7c07579e0 EFLAGS: 00010286
> > > [   53.712112] RAX: ffff8bd0c2285b40 RBX: ffff8bd0c2285240 RCX:=20
> > > d0c22857c0000000
> > > [   53.712798] RDX: ffff8bd0c2285910 RSI: ffff8bd0c3e695c0 RDI:=20
> > > ffff8bd0c22855c0
> > > [   53.713423] RBP: 0000000000002139 R08: 0000000000000000 R09:=20
> > > 0000000000000000
> > > [   53.714061] R10: 0000000000000000 R11: ffff8bd0c16244e0 R12:=20
> > > ffff8bd0c3e695b8
> > > [   53.714696] R13: ffff8bd0c3b62000 R14: ffff8bd0c22857c0 R15:=20
> > > ffff8bd0c3e695c0
> > > [   53.715321] FS:  0000000000000000(0000) GS:ffff8bd1815ca000(0000)=
=20
> > > knlGS:0000000000000000
> > > [   53.715956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   53.716651] CR2: 000055667ef28e10 CR3: 0000000106cc2005 CR4:=20
> > > 0000000000772ef0
> > > [   53.717295] PKRU: 55555554
> > > [   53.717918] note: kworker/11:2[360] exited with preempt_count 1
> > >=20
> > >=20
> > > > > The bug was introduced in commit:
> > > > >=20
> > > > > bb80f7618832 - parse_longname(): strrchr() expects NUL-terminated=
 string
> > > > >=20
> > > > > str is guarded by __free(kfree), but advanced later for skipping
> > > > > the initial '_' in snapshot names.
> > > > > This patch removes the need for advancing the pointer so kfree()
> > > > > could do proper memory cleanup.
> > > > >=20
> > > >=20
> > > > I cannot follow of this explanation. What is the wrong? Why should =
we fix
> > > > something here?
> > >=20
> > > In bb80f7618832, the pointer in variable "str" is guarded by=20
> > > __free(kfree), which means the pointer returned by kmemdup_nul() is=20
> > > automatically freed. kfree() should receive the same pointer as retur=
ned=20
> > > by kmemdump_nul(), but this is not the case, as the pointer is advanc=
ed=20
> > > by one. kmemdup_nul() may return for example 0x1234000, but kfree() i=
s=20
> > > called with 0x1234001. I don't know the exact behavior of kfree(), bu=
t I=20
> > > assume calling kfree() with random pointers leads to UB?
> >=20
> > Please, see my comments below.
> >=20
> > >=20
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220807   =20
> > > > >=20
> > > >=20
> > > > Why the issue had not been reported to CephFS community through ema=
il or by
> > > > means of=C2=A0https://tracker.ceph.com?   =20
> > > It's a kernel bug and not related to any ceph packages, so I've repor=
ted=20
> > > it to the kernel issue tracking system.
> > >=20
> > > > Have you run xfstests for your patch?
> > > No, not aware of it. How is xfs related to cephfs?
> >=20
> > The xfstests is the regression testing suite that is used for testing a=
ll of
> > Linux file systems (and CephFS too). But if you are not file system guy=
, then
> > it's OK that you didn't run the xfstests.
> >=20
> > >=20
> > >=20
> > > > > Fixes: bb80f7618832 - parse_longname(): strrchr() expects NUL-ter=
minated string
> > > > >=20
> > > > > Cc: stable@vger.kernel.org
> > > > > Suggested-by: Helge Deller <deller@gmx.de>
> > > > > Signed-off-by: Daniel Vogelbacher <daniel@chaospixel.com>
> > > > > ---
> > > > >   fs/ceph/crypto.c | 8 ++++----
> > > > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > > > index 0ea4db650f85..3e051972e49d 100644
> > > > > --- a/fs/ceph/crypto.c
> > > > > +++ b/fs/ceph/crypto.c
> > > > > @@ -166,12 +166,12 @@ static struct inode *parse_longname(const s=
truct inode *parent,
> > > > >   	struct ceph_vino vino =3D { .snap =3D CEPH_NOSNAP };
> > > > >   	char *name_end, *inode_number;
> > > > >   	int ret =3D -EIO;
> > > > > -	/* NUL-terminate */
> > > > > -	char *str __free(kfree) =3D kmemdup_nul(name, *name_len, GFP_KE=
RNEL);
> > > > > +	if (*name_len <=3D 1)
> > > >=20
> > > > I believe that even if we have *name_len <=3D 1, then current logic=
 can manage it.
> > > > Why do we need this fix? The commit message sounds really unclear f=
or my taste.
> > > > Could you prove that we really need this fix?
> > >=20
> > > I've added this protection because otherwise I do pointer arithmetic=
=20
> > > without checking bounds. I couldn't give you a better excuse :) I cou=
ld
> > > simply remove it on your request.
> > >=20
> >=20
> > OK. Let's analyze the code again.
> >=20
> > 	char *str __free(kfree) =3D kmemdup_nul(name, *name_len, GFP_KERNEL);
> > 	if (!str)
> > 		return ERR_PTR(-ENOMEM);
> > 	/* Skip initial '_' */
> > 	str++;
> > 	name_end =3D strrchr(str, '_');
> > 	if (!name_end) {
> > 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> > 		return ERR_PTR(-EIO);
> > 	}
> > 	*name_len =3D (name_end - str);
> > 	if (*name_len <=3D 0) {
> > 		pr_err_client(cl, "failed to parse long snapshot name\n");
> > 		return ERR_PTR(-EIO);
> > 	}
> >=20
> > First of all, we try to create a NULL-terminated string from unterminat=
ed data.
> > If we provide name_len =3D=3D 0, then we should allocate 1 byte/symbol =
string that
> > contains only termination symbol. Potentially, we could not allocate me=
mory at
> > all if we are under memory pressure (this situation is managed by !str =
check).
> > However, it doesn't make sense to try to allocate memory at that case. =
So, the
> > length check at the beginning makes sense:
> >=20
> > 	if (*name_len <=3D 0)
> > 		return ERR_PTR(-EIO);
> >=20
> > Next, we expect to have '_' at the beginning. Let's imagine that we don=
't have
> > any '_' in the provided string, then it make sense to try to allocate m=
emory. I
> > suggest to call this next:
> >=20
> >         name_end =3D strnchr(name, *name_len, '_');
> >         if (!name_end) {
> > 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> > 		return ERR_PTR(-EIO);
> > 	} else if (name !=3D name_end) {
> >                 /* we expect '_' at the beginning */
> > 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> > 		return ERR_PTR(-EIO);
> >         }
>=20
> We don't have the `str` variable here yet. I suggest I can simplify this =
all by:
>=20
> @ -166,7 +166,8 @@ static struct inode *parse_longname(const struct inode=
 *parent,
>         struct ceph_vino vino =3D { .snap =3D CEPH_NOSNAP };
>         char *name_end, *inode_number;
>         int ret =3D -EIO;
> -       if (*name_len <=3D 1)
> +       /* Snapshot name must start with an underscore */
> +       if (*name_len <=3D 0 || name[0] !=3D '_')
>                 return ERR_PTR(-EIO);
>         /* Skip initial '_' and NUL-terminate */
>         char *str __free(kfree) =3D kmemdup_nul(name + 1, *name_len - 1, =
GFP_KERNEL);
>=20
>=20
>=20
> > If we have found the first instance of '_' at the beginning of name, th=
en it
> > makes sense to continue logic.
> >=20
> >         if (*name_len <=3D 1)
> > 		return ERR_PTR(-EIO);
>=20
> See my comment above.
>=20
> > And here we can continue the existing logic:
> >=20
> > 	char *str __free(kfree) =3D kmemdup_nul(name, *name_len, GFP_KERNEL);
> > 	if (!str)
> > 		return ERR_PTR(-ENOMEM);
> > 	/* Skip initial '_' */
> > 	str++;
> > 	name_end =3D strrchr(str, '_');
> > 	if (!name_end) {
> > 		doutc(cl, "failed to parse long snapshot name: %s\n", str);
> > 		return ERR_PTR(-EIO);
> > 	}
> > 	*name_len =3D (name_end - str);
> > 	if (*name_len <=3D 0) {
> > 		pr_err_client(cl, "failed to parse long snapshot name\n");
> > 		return ERR_PTR(-EIO);
> > 	}
> >=20
> > Does this logic make sense to you?
>=20
> My simplified logic comes with the cost of potentially allocating memory =
for a
> snapshot name that has no second underscore. But from my understanding, t=
his
> naming scheme is by convention for Ceph snapshot names, so this should not
> happen in practice.

OK. I need to see the second version of the patch. I am completely lost mys=
elf
in the discussion details. Could you please send the new version of the pat=
ch?
Then, it will be clear if it's good enough already or we need to continue p=
olish
the code.

>=20
> >=20
> > However, I have started to think... Could we completely remove the kmem=
dup_nul()
> > and to operate with the initial name only? I think it's possible, we si=
mply need
> > to use much smarter technique of string analysis. What do you think? It=
 will be
> > good to exclude the memory allocation here.
>=20
> I'm not a kernel nor ceph developer and it seems that most functions used=
 here
> don't have a variant for non null terminated strings. I assume it would b=
e much extra
> work just to remove the allocation entirely.
>=20
>=20

If you try to suggest any fix for CephFS kernel client, then you cannot exc=
use
yourself by this "I'm not a kernel nor ceph developer". :) You should work =
on
the patch until it will be good enough. :) The whole Ceph community could
benefit from your fix. ;)

Thanks,
Slava.
