Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C4391822
	for <ceph-devel@vger.kernel.org>; Tue,  5 May 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007336; cv=fail; b=pOcEwIelMNbEOoci6RKNqmnXbc8rz2H98aO/Mpc8LEvRAFTZNJx7u/8/5bznV9MQLaTD8AjJ6w5BbCt9QvaZfGUsXsn7dFIMmH/SHsL2ELuMLxTNJIEAMfCdVZxQvEHqhjAKj8YTKETlbm5gztraMstLaWbuhEX0EWCeyfJUIDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007336; c=relaxed/simple;
	bh=TvfWtQTF4eDGqRWmHUT3RsG6JKrKn/ldVxbx984VyJY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=FRRrsMGwxidbFLY9S5/ddaZcoQtHN53SZUkf49AYOC3T06niq2zb3tRD6c0d0Fpaoub/BVdup9911h7VFHCPRNtbmcRuV5cz4edZWzYoW2OdyhxKzPZtPF/8x2RLTBpC7hwpfJWZv8Jw6OqAw8CNGw9mH+STUswKBFfeW/dzYO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m+zCuae7; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m+zCuae7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645E48uO1311914;
	Tue, 5 May 2026 18:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=TvfWtQTF4eDGqRWmHUT3RsG6JKrKn/ldVxbx984VyJY=; b=m+zCuae7
	2RO+BcSTjDeRUJX+9jDao9+h5FLaSbcMPOu3cklQFyQxWcQXw0Fg6xLHkjWBvKoQ
	YdXMxbixjuqWVDWu2gIrHo2ej4jXI+qiPD+NHKVoO3QSZkTy2/CwKl69t1sQvKPZ
	NGLXp6OrfT+q39AimogIDx+l40/0yuDGtgyTx2UHT6X491pt4J8p/2k3YRr8GnnK
	B3OaZ0rVN3gbTqpvEOByDT9SptRBLSc/HW0buA8QfXJKcGwTKQnGTJcAldls4cjl
	AxpcBQBz8mN729XObO+BRq+TqhaOjH3Zltjit6fAHOmYn3QRzeZELKpUcB8hUJE4
	BuaLYwni9GgSKg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4mx6e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 18:55:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpS/oekB2jXbZhI3nWTDl1Px70eLYfyouZ0YH8+y4l+PbY6h8tDbqiRrZ+/3C1vDiOLvpYcRwVPM3Yfhm2vEr4uvEvDy0dOspSlcf2iWM7wUw+s9oXL0rNKWwT9SF9ge6UPAMhTTAg9X2t4t3i4J7CBHvSMMyN2KyBd+zVSWZrk91VT8J2tsAgJgqO2n/sNb156R0+/2bBeoskPf6gwsS3xEZGTOU85WzxIoSxcntKITZnOFLlt4MPF0PwsdVy0KPse2gsoCQii1K46Blmyy7E6PjBGjMAoiqkNvOfiihs+TJSmJAzgWUblF0jokykXPoM28rKtctXhKEyBMfjZlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvfWtQTF4eDGqRWmHUT3RsG6JKrKn/ldVxbx984VyJY=;
 b=W+B5eS5nGvzjjSaCN//s1ugdBehtIxf5db9r5s4Puhx41ShfIoIde+UxWSwH6YsB09f3Xezb2+aLthbof8YwBgJb0HpBxubkmeQ3xtDrC2MrW+57fkTARSo0nqUIJHJNk2R6gJZuw9uKpWwv1ftV0qpTaRTv2vs3A72HxbUUnm+A7S/IdJrrEsuf1WsCUpDHSxnUMhe1qe3/Llag5Pdzf3O23DUYR9UWadjoyyPKxY+9VlwlBUE8nkw+pVDi2ZyY36WX+Ja6JHyYyBFdOSu5WWEAsI6I7ESp0uaOh63lp3nuZHXTaXO60shnmuh3aIGhiRsvvcW5jKp4sThbIJDCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB6171.namprd15.prod.outlook.com (2603:10b6:806:2f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 18:55:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 18:55:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Fix potential out-of-bounds access
 in osdmap_decode()
Thread-Index: AQHc3HAZqAACOBxmfUGpwKCeIJvigbX/yIcA
Date: Tue, 5 May 2026 18:55:14 +0000
Message-ID: <ba35c81180e74517613e3dad41e5f5a938be4137.camel@ibm.com>
References: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB6171:EE_
x-ms-office365-filtering-correlation-id: f0ceba61-f390-41ce-b1d0-08deaad7d779
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 4faIEkph+EMiIYjiJ2tIg3dHYH+KKP0TQm9F94HXRd5IkpZrMh/48b7t3xiBiVo+26lQ8rMP0s1I5TkFbUs5JS5XDNJ3UHuAf5RveWbqYhFSHsrRf2Nx5IkybMbs8hnSMQcWqNFYvVHaTHJgZWfUPy+eZfc+b7BvXn1pRyY+/FdDZAeS7OQn+x/p1txqKgeQIu6FG+HMLL44o7fgC6MFtuXVb/DDa/KFjgKy7oj1veHIXufAHh5PsWGcLT67X5xbE9//JrAtlc03uegHTEFETemapxVihG09zFZRwwGtStUa5BvzMzbh8HNlkYvQtY9oT61hpwvtBdXE5pCqeYMfX2+SNoraxqkecW9cvZQliFFXWCVmwbOD7ijGsht4EZlsOe62puLG09v0ebQkKsXuftzD17JONpmeIio7VRWNhX9wu4Vi55oAoNhXPI11Ep2hNfFc9blpPnAH38xhmkv0WamklgKz5dbGn8RF9rKKgbQTkM9dAJcHUwlxFcxhHD/DMXYBg63iM2bVeZJYakFOWphOaU4sGn1m/hIUxUWuPRvhcqvBX0sAdfqn9tj50JvUR5f+R+fVvernAaghh8fDljcxZ0KosLphArEZqOOv3Mej1iaudRNW4MELasrXFuiOp0T6RgERCoFy1NTg6xTQfKFMNbf31riBMNihY1WUouSqq5R7FJTjZhQVW9O6pa4k1/7/sBtYO/89Ilcci7rx0/XR+dwZ1SobWjk0IYHyXuOh2X3mimycbuTRyfUygmTQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWhUbDM3a1lsTFgzRHJqbHlSQjNEazdoRHhqTWRCaUxkN2wxZGhXY3drRSto?=
 =?utf-8?B?dVFRMWt1N3dUQzdVK3RRK2lSZithOC95SlF2TmVRVFo3ZFMzeWJHSEp5Q1BD?=
 =?utf-8?B?Z2NHTnVNRzdPWHRIYk1HdWVXRTM3aUsrRTFzK3g5OXMwMkxLWHNJRTk3d1p3?=
 =?utf-8?B?UWp1SDB6YTNYSzIzYU00K2crK1JRa3FHTkQ1U3ZRTVFjSTdtbjFRT1JFdG1E?=
 =?utf-8?B?cGRUdU5tRElZTjAzNGdkQndjK0xHKzFxWWlTaWdKS2ZuTHJjUnl1Q0JiS1p6?=
 =?utf-8?B?Uzg2akxickZIVGpMUmM0dk11VURaemhDREhXaldtSm5SWDRmbWxNQXFaczlQ?=
 =?utf-8?B?dnpHdytlSmNyVjlXbW5mb1BxbWd5QXg1TmVidHBQWURWRFR5QVViNlY4VUFY?=
 =?utf-8?B?ZGVrR0lkVnptU3JqV25xSzhxYlhVWHgrdWdBNXdaeTdSajdvendGcHNubGIz?=
 =?utf-8?B?bTdHUURDQnVKbEo3eEZTZWhwU0JXWFkyQ05sUnpFYWJHUkZibjJRaHJUdkc4?=
 =?utf-8?B?MENyQXZ0dW5Xam1FQzJhcHJoSDlxbzM3QmozOVdRM1p2NWhWK3F4clByellS?=
 =?utf-8?B?QXFxbTlaOWxNUzNpLzVrNnRkUk9WWUd6dEo5WHNRUWt0REdOOHhtZ0hUd1Ev?=
 =?utf-8?B?ZGNMMzBua2FsSzFsK3hQUTVoSWdRWnByUE51Yk1ORjRWQ1lDc1NsMjI5Mmpw?=
 =?utf-8?B?bWl2d0FvZFdnYVJBOTRyM0RPd01IaGtEWUlSWEt0Zldxb3Z5V2FOQXVDMkxE?=
 =?utf-8?B?WUpEd1EwZ25LWnVVQmNWMUlGOFhnTUs0WU8zbWE2N09acVQ5UHh2dHBid0hX?=
 =?utf-8?B?VTZGQnpBV25XMHNHVGNpc21EMWFBQS8yQzgyTUp3MTVkb2xoSE0ycitXbHVr?=
 =?utf-8?B?alJuVE5leExlNHV5RDhQZFJuRHp6SElTSy9KY2pDK3NhYjVCS21LWmZyVU5j?=
 =?utf-8?B?MHB1UGVuMGpXN3dFSFRqdXlHUHpwelVjOGlZNElvbURSYkJOR0hhMFNZMUJY?=
 =?utf-8?B?SnNxNEsyOFEvM3lpeStSNDk0ZVRkc01rVjFuSHFFVHVNZ3Q1bmUvSVRUTGI0?=
 =?utf-8?B?cWFOUmZNN2NFM3V6a3pLbnhrZEpHaXVJMDNCV1RhZldsTlM5SXBEbkhDekdn?=
 =?utf-8?B?KzhwUVNiVVRZdWxHV0RKa3ppRWJsbndJVEo1bTFQQ1U4ZEs3SU1pVk53V3lu?=
 =?utf-8?B?SHgxbjJTMk01MDNTQlJNd21DSlRJNTFFdXRIbFp5ZzJ4bWE0NEF4azFMV2RP?=
 =?utf-8?B?d1BNck9rSk55WjJnWmxZbGNMLzZlcXpUT0pkNWJQZXVPMytQUndtN1ppeEU4?=
 =?utf-8?B?VzVhemZEcUhuSXR0by9IMlV5SlRKQW9UTDFLVnNlNDNRMWdCSXlkajMzYWZr?=
 =?utf-8?B?eHRFVnFSYWNJWXNjZjMzbGgxamRocS9Lck9NUnN6OHJlUDkralJ4VmFsRXBT?=
 =?utf-8?B?Skx5UWxvbTBQYVVwazhnZytrSWt5YXVqZ25IZVlyZFJzR3dQVWxuTDVpUjVv?=
 =?utf-8?B?Qi8vUFN1T2VmSGJRMUF0YUhmVU52QzVhRHVBQXd0WFVPTlhTdlpGbUdhR0pP?=
 =?utf-8?B?cnhodmVpR1orelVHeFpINFB6Tk5RdEo3NlZUTkhrcjBWNGI5WWVOVTM1cjRX?=
 =?utf-8?B?VmVmV0dWZkt6RkJvSmpxcEdiT3VyU1l5QXFKUFAzUi9EUldBNDlTSmpCYzQv?=
 =?utf-8?B?bHFleUJOVTRWTmE5KzJ0eUVqT2VsNzlwK1UrUi9QcDJkY0JwUFBnT0daTmJW?=
 =?utf-8?B?aS9oMHN1R1RSclpGcEdtdERZS3hJemRtaTRwbkxwOXpwak5uM3Y5VW04U0dM?=
 =?utf-8?B?WlUreko5N2JITzJxM0ZKRW1JeGFodlp0Q2FORFlvMCs1dHBWc1drVnd5YUxr?=
 =?utf-8?B?ZUdhQVRwbjFaNzQ0NDRGd3pFd2dnNFF3RU56VktQdlhIUUFCMWVtcllDUXhR?=
 =?utf-8?B?U1FLTWNkcVkyRUN2bElGMWJRTzV4TzZQa0htSFA5eGN4ZGhBMWY4Sk9NbTB3?=
 =?utf-8?B?Vm9velVWVzBkSWEycGRvZUJCSDAvUXhrUWR2TmhvcnpFQU1tbnRCMkRhd1Zh?=
 =?utf-8?B?Qko0d2JTNmF2L0d0cnVsblZ3d0E5aGxHaUtNdnpLdE9ESE9RYUthUHNtYjBZ?=
 =?utf-8?B?U0pKYVJaRjlmSDNyaWJGY3ZJV3diOUtPVVRVRVRSN1RuNTZXb1VraGZJeWxN?=
 =?utf-8?B?bUg1RG50eDBGOVcwcHBsRFBEa0phdFd2U2F6WFRTVGpRK3hSYm4vTVpTWFlS?=
 =?utf-8?B?NkQ5TDZZNzRrV1V6ZlJQdndEbS9CYXFRNnlrYk40dzRJbVFSQWlsUjBOWDF0?=
 =?utf-8?B?YXdFWEtoTm8xdTI1ajhKMEdXL0JZTDR5Y2c0RDNicWJGcXFreDdTTU5PM1FI?=
 =?utf-8?Q?+wZrn+DaeDr1PXcBzYZkRrQK+QdHgt7n8t6Wn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC4EEA0623DD1E49A524C7346E53D3AF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IVJjiSYUId93AROfxFoykH+oaWlVFZCFIhJgC9qMoKNcLJmTPmGmLLgGpZwQ/a5Ovbfb2CD++HuZ4lUsVsq+QfTgUoy9RnNcuWahXPGZUHWWjmN8clbIW+w3LM9aadXDuT0n0qbRgLHB9n2KZ/oXBmIGbRbEzk3Os1+vEiQnHnx0tHxVeposVAsBRq0JLuaQaGBiP2U73fHn46lqHw7heXfI3crN4R/5w71Ws3/pttRtYygF0HeaE/Xdyi7SApKTY5Okjq4dcTjVm5NFZA2nSgzZ7fwNKMGR9X8vEPf+Ul+dR4XTD7lT0yg210BSl8iWOxx6glPUidFhenpj4poxbQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ceba61-f390-41ce-b1d0-08deaad7d779
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 18:55:14.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cc/77NmMIPoZgQYQLlzbQxvqWNqpx33TlXegPcFpF4a7S9VJmqaTLnXnHqeRz6Z/sk2XAbNQEYBO+It+EnQTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6171
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE4MSBTYWx0ZWRfXxXD7JqgKq7CQ
 hix4AoJdQmxoacRZfUdFymyNTKmUy0nFdl76LvuoUGfLcRlD4ql6T4XTiHSS9nyPkXKGaEvQzAU
 Y6L/YGQurZfwHGpNp0i1NNDaiQTxmuLJ8BLPdLVB+5Ik/jPFR2+0flK1IPRKgpV5XaMKqxOrClQ
 c2HAv/IQsRVdAmekYgW1uPmchJsQkqpTtIJfYUE82bG5Md0AmDz0PfEs35pJrj0cHTQ3aytUKSZ
 7aosz5snpJkhLpPjDm3UYE1Iqg9TzRP7yJnFVfMTN05LVftYIvbD/45LhNsuQgQErz5SSFYN8K0
 Ens6ECRqu8fRYBVGBxicy+dWWAhaPVP1UAEPjuPSapr2mzdZIDaoBk1zJvoUdVNgFzxc93GrIUn
 0z4yMUxuQEFxgpfjt56KPb6+PwZv8Zfu1bKv/623LbGC2YW5HYJvH9MY3MIRtxVsEwQQUMaG/T4
 YRck/VD8IdEZVn/tqqw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa3d16 cx=c_pps
 a=Z+ESqgFbrcYkgT1kPBc/rQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=cCJFDH82_4lKpW8F4BoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q7bN4dtzKZwBVj75JCeNG1Ch59LMS_E3
X-Proofpoint-ORIG-GUID: 592Yj8AuxG-IwxaYyCMozS34sYSpEI27
Subject: Re:  [PATCH] libceph: Fix potential out-of-bounds access in
 osdmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050181

T24gVHVlLCAyMDI2LTA1LTA1IGF0IDExOjA4ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gV2hlbiBkZWNvZGluZyBvc2Rfc3RhdGUgYW5kIG9zZF93ZWlnaHQgZnJvbSBhbiBpbmNvbWlu
ZyBvc2RtYXAgaW4NCj4gb3NkbWFwX2RlY29kZSgpLCBib3RoIGFyZSBkZWNvZGVkIGZvciBlYWNo
IG9zZCwgaS5lLiwgbWFwLT5tYXhfb3NkDQo+IHRpbWVzLiBUaGUgY2VwaF9kZWNvZGVfbmVlZCgp
IGNoZWNrIG9ubHkgYWNjb3VudHMgZm9yDQo+IHNpemVvZigqbWFwLT5vc2Rfd2VpZ2h0KSBvbmNl
LiBUaGlzIGNhbiBwb3RlbnRpYWxseSByZXN1bHQgaW4gYW4NCj4gb3V0LW9mLWJvdW5kcyBtZW1v
cnkgYWNjZXNzIGlmIHRoZSBpbmNvbWluZyBtZXNzYWdlIGlzIGNvcnJ1cHRlZCBzdWNoDQo+IHRo
YXQgdGhlIG1heF9vc2QgdmFsdWUgZXhjZWVkcyB0aGUgYWN0dWFsIGNvbnRlbnQgb2YgdGhlIG9z
ZG1hcCBtZXNzYWdlLg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgY2hhbmdp
bmcgdGhlIGNvcnJlc3BvbmRpbmcgcGFydCBpbiB0aGUNCj4gY2VwaF9kZWNvZGVfbmVlZCgpIGNo
ZWNrIHRvIGFjY291bnQgZm9yDQo+IG1hcC0+bWF4X29zZCpzaXplb2YoKm1hcC0+b3NkX3dlaWdo
dCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJA
dHUtaWxtZW5hdS5kZT4NCj4gLS0tDQo+ICBuZXQvY2VwaC9vc2RtYXAuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL25ldC9jZXBoL29zZG1hcC5jIGIvbmV0L2NlcGgvb3NkbWFwLmMNCj4gaW5kZXggNjY5
MzQ4ZDg4M2YwLi4yMDk1ZTczY2NmNmMgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL29zZG1hcC5j
DQo+ICsrKyBiL25ldC9jZXBoL29zZG1hcC5jDQo+IEBAIC0xNzA1LDcgKzE3MDUsNyBAQCBzdGF0
aWMgaW50IG9zZG1hcF9kZWNvZGUodm9pZCAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMiwNCj4g
IAljZXBoX2RlY29kZV9uZWVkKHAsIGVuZCwgMypzaXplb2YodTMyKSArDQo+ICAJCQkgbWFwLT5t
YXhfb3NkKihzdHJ1Y3RfdiA+PSA1ID8gc2l6ZW9mKHUzMikgOg0KPiAgCQkJCQkJICAgICAgIHNp
emVvZih1OCkpICsNCj4gLQkJCQkgICAgICAgc2l6ZW9mKCptYXAtPm9zZF93ZWlnaHQpLCBlX2lu
dmFsKTsNCj4gKwkJCSBtYXAtPm1heF9vc2Qqc2l6ZW9mKCptYXAtPm9zZF93ZWlnaHQpLCBlX2lu
dmFsKTsNCg0KSXQncyB0b28gY29tcGxpY2F0ZWQgY29tcHV0YXRpb24gZm9yIG9uZSBzdHJpbmcs
IGZyb20gbXkgcG9pbnQgb2Ygdmlldy4gSSB0aGluaw0Kd2UgbmVlZCB0byBpbnRyb2R1Y2UgYSBz
dGF0aWMgaW5saW5lIGZ1bmN0aW9uIHdoaWNoIHdpbGwgaW5jbHVkZSB0aGlzDQpjb21wdXRhdGlv
bi4gQWxzbywgMypzaXplb2YodTMyKSBsb29rcyB2ZXJ5IGJhZCBmb3IgbXkgdGFzdGUuIFdlIG5l
ZWQgdG8gaGF2ZQ0Kc29tZSBuYW1lZCBjb25zdGFudCBoZXJlLg0KDQpUaGFua3MsDQpTbGF2YS4N
Cg0KPiAgCWlmIChjZXBoX2RlY29kZV8zMihwKSAhPSBtYXAtPm1heF9vc2QpDQo+ICAJCWdvdG8g
ZV9pbnZhbDsNCj4gIA0K
