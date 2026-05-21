Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE372621
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400749; cv=fail; b=BJ3Bfjct2Xj+8byNpbX31J/2i2KPwBRHNHBtXxDPvRGzT2qR3Vpwr63IFjhNd8PhwGNSD1+n5WAgqsctNxiVHi9qW3Z6WQnaG96/Bu6vAAREu4QksDGLoR/s5D0e7Ur3AuSsUOwOpzUkYNUE8trBs0YNxBUDlB23cgclbKDWaEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400749; c=relaxed/simple;
	bh=kEgYZCPZk75TY7zDNB3ackNw/llqf2887ZtmBH/ibBY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SMC9xWqY5rcrkZ3eEn/HYDRprXl/7yW1o8AZ78Y/HOEQzgi01tGUkt8F74Qj+SPQo0JPn4PV/MhAbza2c7vyNXw0jM7CkVVa1mei+b4yq/NCfYXnpHUQUAze1NEoL11lN1tkw7RNIlke11xuXHCii7QOO6Ov13QjneeluNsr4Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DkNj/2/g; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DkNj/2/g"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LL7H682090331;
	Thu, 21 May 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=kEgYZCPZk75TY7zDNB3ackNw/llqf2887ZtmBH/ibBY=; b=DkNj/2/g
	wID0WHZxHBPeDw4gfF8mqOGDuReOd+4XQmAOCTJOshFdVVrqr0NU0oGzEEZbkrIL
	Kj5Krq9rCxW7SWHfbG4KIG+r2XjbPJduYQGfk3d9JBf32AUG4GXjnn1xs/j/vRcr
	vI35shjuLikpKNZa6cNlEWFzCJtYWNNdnIFIchQ2UlOyrlZPbfUrG1ASQnU2qy6F
	wRDcOlqtt403WuF+s10Xe+9LOev8MIh8qjMp7qViUowa7I6CKsWORQ61qxL5LI7l
	3dz0aBa3eh6EDnbq61cHgHNN033MeZmcoMvEffz8CjJWQXz4OkEHaztcnf5jluZg
	LvTFsyw9jSG5pg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88qvy3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 21:58:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCMiKdalKC8A3ZjrbrQLuLnpQtVQy4DP/O1gdj0ji5wD3jMP0G0pFof5kc78jUQiMnDmyZk6CbdViDiTtGWr3o5MIGb2uE2JQwVb1SQMZdhFI4A+gPhNVgvj/gXYSvVPpMK1FN+Nc+MY/SuVL7GYjHEkYVtcapCVOD74mLNauIge51MXeipRaYCIu9e9LRXw1ItEf0SNxdLi2CFxDCL/z4rFrgHJTMg1lANaY17sfkDvEZjse/vrfbMRwyFeWtJE5whmrb44oA7TPoG+b7QYodKYfyMj9ARkXGZwf/HLKNbp3nIx+IRGSFs43nNsbgPdDwOOBehfVrivZ8VltRcvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEgYZCPZk75TY7zDNB3ackNw/llqf2887ZtmBH/ibBY=;
 b=L3eEEhRRGR6YxHoxmaTt8sGlORA14h25NAw8YyhonUxjlyU94klzmxmPq4Xbt8qA9dGIcpOg5ocTSLP6JOyCnmzTtwd1+t3GBhkZlo0rsO7HY2ZDb49Pcq8E6QiK4gn6Ed6Vm5EPxiQ9IdWXsk9haW/ZYEZNjySpj/sWJZw35nAbgbFQQc2iu9c26dlLrFbX03qXb6TMqjJHn9n5jzU9Z3mUbLX33PPcHIrdICUGNn+Bik0i+Uj/Q/5Cwd/ABWJER6ILx61wxnw5owT1K5/K23Dj8Brr2xgpYbRCeX9yVa+mQ1l/VwjAMGcj4w+4xpHQQx1L/xPfukvKDKXyr7ZZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM3PPF7C333E81B.namprd15.prod.outlook.com (2603:10b6:f:fc00::425) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:58:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 21:58:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3] libceph: Fix out-of-bounds writes with
 oversized monitor reply messages
Thread-Index: AQHc6R7F1kAECPZhBkmST29fDvhSy7YZB8aA
Date: Thu, 21 May 2026 21:58:52 +0000
Message-ID: <41e9c36c9a05c8239177cee688cfddcebfd6455f.camel@ibm.com>
References: <20260521121424.2869056-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260521121424.2869056-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM3PPF7C333E81B:EE_
x-ms-office365-filtering-correlation-id: d77c6e3c-9886-41dc-346c-08deb7842593
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|18002099003|22082099003|56012099003|11063799006;
x-microsoft-antispam-message-info:
 dd4Ebk7n9d7Xjnddlpdu7oWI7J7ExOFUoWnXCLddd/KkmCe3jIbquAaxcQMRLDVuI3hnXx3FfwlQ1USQHwDPaiNC3NsLnY68LvJXCsrWE/3O/xMQ7qMq0y9BUGvsYYTU18pQdeR0/ZmGOtWEy9PzQ40ZBTUy83wrkQpNncC/PXGdmAS2aFJnd8HdgZM5HiP+tdHP9QY3UbvjIb+qfAV/O4ClMY/7LN2n0CiLaAg1A341gc0hFKZRAcC45w4chew75KaZVJKMjYe7r/Vk1P17SCn4FBrOYRH0SUlX72EaEeOXxnc9En9aZ5uNK5Jk49jOEYm+9yY46j8MBZFnErnVgcV9M8wpnvc7qzRGSCSDQ4Lurd5cBEGVxmj7PBZqp5fwKQ8YiFPjZLTk+m+PeCt4fpRVCNHHE6QYdO654Op2sX2jOC8fTommxjMXQ5cLZOxTNOQ4E/eS1nluGHIz2VKSBvV3KHUqnIdLoIfysNowNzmjK/VWIo085QmRJ83m/E3TCGIFBXp2ul8xZ4kAZjui6dA2aes8I81J9hU/nh4SAbfgEynFiXcikDYUVCPfQO9di+ZD4y+u7BgXFKZEXxCaPnDY8coYu3gx3PAanIEu6kBqlIs+3Py9Pkpv7QzHC+eCWYD/Xip/mHOD5IMeAQkHkjaWe5KbM8GEwqqo71RAx5oSZ6ZngJaIGxIGTCKdUi1kd/+KbOCrwCJ9PCID+J/j9MmoRyK/bZwkE9HIix5+g0/eCZ0RaU3qoZCreCYzqp0f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmN0WjQ0b0VqU0Q5OUFvdldZQm14YmM0VnU5Ty85OHJMdlI5QjlTbDgrTEJI?=
 =?utf-8?B?ejE4K3d5R012YXRoblFqeVRPMXlxYWpVc0laaGhuM3ovM2ZyeDFHbEJaMDZF?=
 =?utf-8?B?SWFxTE5QR09GQjZRM1Y3bTN4YlY5RXlFZHN0V09wenN2T0tvZExDclgxT2pT?=
 =?utf-8?B?RUhzWWlEUDJhMUhqUnV6NitnNE5wcGl0NVQvWDl0dGFrRktlcjlxQnNvRTJJ?=
 =?utf-8?B?SElEd1ZCTzVzZEhiV3FNTDJHRk5wcnhzWmY2NEZtQy9lZnhmOW5kYUhsOTR1?=
 =?utf-8?B?K0lDZlJQSzdiVThqS3FLRXRPZGEyYnp4UjZRU0syanZHOTlSRktoVG9qRDd5?=
 =?utf-8?B?YmRMOTVhUlBYQ0tSd3N5SzMzRWFGUVVFOFVzcVkyS2VpU2pPUHkwZ1FCMU9M?=
 =?utf-8?B?L0JQVlZ6MGhEMHJzM0NXc1R5ZkZYem9uUlQ4eUNtRjlTN1ZHSitCSVBZRjJQ?=
 =?utf-8?B?QU5seEpqWTExa2l0RHVzNnB6T0ZON2NncWtEWG5CUUFkOU5YUjNSZ3N6RWRU?=
 =?utf-8?B?Z0dTcGhQZ1JabFNqd0kwRkc0OFRQYkc5Z0RmVE1xMFhXVnRZTk1Fb0lpbnNU?=
 =?utf-8?B?aEhFK1Y4N0hjNFF0ZnphRDV1bHNVMUFUeTRZN3dvMjZzMVVnbkhDZkZma3dS?=
 =?utf-8?B?UXRNdzNDdmw5bC9Eb1ZSem0wdlR3TC9VUFp1Y2JsbzYybXlEMzBnWUlWaHhI?=
 =?utf-8?B?OHRCUmdEVDlWM1E0ekZSdHViSjdaWWM4ZCt3QXBXcGVocHFrUGl2eVVHdWps?=
 =?utf-8?B?YVkvTmlUa29EN3pDQXBtRFNyZUIrcUljRklIRC9uVExoc004T3FaeWduM09B?=
 =?utf-8?B?UGdaK3JVVmxtNVNIdi9VaHQyaFZCd0dtc1FMbis4V3lMaDJrbGtJWSsyNFJD?=
 =?utf-8?B?V3RkWFV1QzZvSlR0dHI5TC9PcFcyRWFHNk00NXA5OUcrdG0yOGZMSXlEUDB2?=
 =?utf-8?B?R1A3aTVTZHV3UmR0TXcrVlpEeGdjb1VEa09icnZCS0dSU2lNMk5pdTRUNkNU?=
 =?utf-8?B?b2JnMVQwL3hESFFFRXlxbjhaaERLMkdYY0FVa09wb0FWQ3F0SnhMRUJUUEZr?=
 =?utf-8?B?WDlSYW5zWHlMVDAvVmZYS2NpTzhaWmh0SHkzQ3cxZHd5a0I5aVl0Tlh3QUc5?=
 =?utf-8?B?R2xJc0VXK0FRcjFNdVJtajB6MjdDRm5lSlZTd3h3OWVsbnJrUVN1SWFsNGtt?=
 =?utf-8?B?ZFJ4TE5Nb0RBTk9KeE12ckMwUUdqWTA1eE1DTUxnU3QxUUdSbFJPdVp5UVlW?=
 =?utf-8?B?RzZRN3JSYjlqeDZRa2VnRDhmdUtiRmNJbVlCSzlWTVNiZWNUOE9Sak9rN2dG?=
 =?utf-8?B?RVowNTJQNjk5Zm5SUWpZbStMNHRmUGQxS2V2R0JjTG5HcXBld214bEY1cEVF?=
 =?utf-8?B?RjFKQlpzbzlPeWt1V0JqOTRZbzljRmVkS29HZUs0SzU1eWd3UFY1Y2VQV1Bh?=
 =?utf-8?B?SWNxRWpTcHdaSys5SDdMM1IxNDlhbzFISDVOcy9TWFVROXJrM2thVlpCS252?=
 =?utf-8?B?VFlFbFZJQjQ4WjVBenIzR3ZZZEgrZlYwdndQSkEzUTJWOEFOY013ZzV4TkJB?=
 =?utf-8?B?OWpkZGVIdUU4Wmt0OWFhdEo3OUhyY3Y0YU5CTjB0YWJYTXNOU1dDUXBGWWJK?=
 =?utf-8?B?V3Q0TWFXYTBYbVIxRmtNWkw4ZFhXUm9lOUR6dGw3Njc0NVJyUDJKTnk2eURV?=
 =?utf-8?B?a1hLbnpxUlM3Nzh5MUFTVWhWNWlhcGdkWG9QRzBnamNJVFFjb1VGTURqNlhv?=
 =?utf-8?B?SElRQ2U2N0o5U2dLekhwckcvVlB1Q0pRdVl1UE5EQXczY2R3ZlA0Q1lnLzFC?=
 =?utf-8?B?cDdUTlc4S3ZGcERGK2JGK21tRHJDRzRmeU44Q3JJc0IxbHVZUFQrcWZUQkgy?=
 =?utf-8?B?RzljR3FsZWE3MlJyaW5OdkhGdjJZckl3UjMxKy8yTE1hOGVzYXlwazFDZXlB?=
 =?utf-8?B?WUpidFBmODRDNkloNFFUSXV0MVlBeVQwQXZCMjFJamRoQ1NtbTEyUVhOWk9r?=
 =?utf-8?B?TjFEVEFjTy9DZmxrRW9DUTZzbWlYdGJpTE5KYWZBMlBxeC9va0drUDduRFdp?=
 =?utf-8?B?VjZtVFNiRmUxb202MTNpenErTmVnY3RCaStpcDhEaExmT1hCSFpCNDl5WVg3?=
 =?utf-8?B?VWhDVHl2ZU95akRDNUFUQkU3UU4zMkdIeXI5K3dBMEdwMkU5ZXhWMWtOOTNs?=
 =?utf-8?B?cWV1NXYzbmtDcXZ4dGo0NHZZTzNBcFBta1N0ak5Ib0p5d0tkb1VneDk1bmp4?=
 =?utf-8?B?bldiM3FhNjRUNEs1L2h5ZG5SbjBVdkF1VXpZZnp4a3lsbnFndytRTGZVTzlo?=
 =?utf-8?B?MkR6SHNleXFUVkl6eXZNYzZrYkVXQUljTDF1UUtGaUswcTZ5NHZTQ1pZZFRp?=
 =?utf-8?Q?GMlpepWoaBerkkro2EkPUKz1iw2Qk/DXVWAie?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C0CFCDB083C9B4FA7E97CB0796928A7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UaSGF0o4k+omG0p/Uz8zUkp/7IDBV1uuyznHUAvhVcFjMi7gISiE040ueoO1dYFzG5FxcZwh1GqTgA26nDj+3VhTULqbEMkBT1bjlMqlfT+Wjyj9cMnBdu0uYAQOmdrf6iE/Ij/my+2jxOQVIcRpcoGcdSw6mX4ORpd5gnR8aUkJjkFjQqMR18KyvATwEEobElDwyL9ulkdCIvr9MsuULDAClF6KefVznbq7JQJonI0pLmHoLxiEly7YOnWopsTbN2Uo9GjEcAcUAHe4x5Bb6UJcLe6iN+jOB9DxOYACGGtAg4l9DzKRf0hVMtwAP0oOGhaNqnVS+ly3ikAgNDBOeA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c6e3c-9886-41dc-346c-08deb7842593
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 21:58:52.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYCl+EeSLGT7gVJxuE9YIzNdO2kdnQ7sij+S+e9C4Q2zFHYXBJEQQ9D3jZ+R94/KHQ0lWp3YisIyq8cOyVyvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7C333E81B
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ld6XxZ8tCXPoKGusFOZ3HbOIMVfieAsL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIxOCBTYWx0ZWRfX671jArTLTlCe
 1moqmHqqETqrq/tayH4sJMcUy3tpBe4P6E83shNxbyuqAQ2c+VLB38/v0myucP+nApVgXfDquzN
 yOJIv6wkpHnjaTmSEzGQ96+tDFybTk+bROAFkuQnmooYsds2f4l3awfsjVdbfL0jUjsFYiZE0et
 kmj3VKXVDcRxzETXRN3D4/ZMT1cgB53E1Mpr1bxQieya+dWpD/Z5IMf/PsYxSD5X/DnsQ/gLoGq
 VKTt6575RarLzD+yzYrzvr+Y7iSP5Ib0rx2S29XFU07XfbDFau1e0wYHr3AwR+b7+jcDyoeWhVC
 nv9wKIMK/wnjXJM9vLXio93RLKHC2AhNCfGjBqAz/BkWUSULEG+zv4+kaNvWRSO3pzRoz0bwSSm
 mMFX7TjK56QlAyEwlyLZ8XLlHAFu/VhLWNRx4yejMXO1NeTP0xfs22DLPagWHhYAHrbEBueFj6C
 n6Ll5PUeg1FdHDNT7fQ==
X-Proofpoint-GUID: uZhdShgYL5HtyQZKhBXbuN-8GknIWxdH
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0f801f cx=c_pps
 a=a2CzU9h33xTdk3q/+L33yA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=KhCgcTnWa4wjtVPZodkA:9
 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH v3] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210218

T24gVGh1LCAyMDI2LTA1LTIxIGF0IDE0OjE0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gV2hlbiBwcm9jZXNzaW5nIGFuIGluY29taW5nIHJlcGx5IG1lc3NhZ2Ugb2YgdHlwZSBDRVBI
X01TR19TVEFURlNfUkVQTFksDQo+IENFUEhfTVNHX01PTl9DT01NQU5EX0FDSywgb3IgQ0VQSF9N
U0dfTU9OX0dFVF9WRVJTSU9OX1JFUExZIG9uIHRoZQ0KPiBtb25pdG9yIGNvbm5lY3Rpb24sIGFu
IGFscmVhZHkgYWxsb2NhdGVkIHJlcGx5IG1lc3NhZ2UgZm9yIHRoZSBnaXZlbg0KPiB0cmFuc2Fj
dGlvbiBJRCBpcyB1c2VkIChpZiBleGlzdGluZykuIFN1Y2ggYSBtZXNzYWdlIGhhcyBhIHByZWFs
bG9jYXRlZA0KPiBmcm9udCBzZWdtZW50IHdpdGggYSBmaXhlZCBsZW5ndGggb2YgNjQsIDUxMiwg
b3IgMzIgYnl0ZXMsIGRlcGVuZGluZyBvbg0KPiB0aGUgbWVzc2FnZSB0eXBlIGl0IHdhcyBhbGxv
Y2F0ZWQgZm9yLiBUaGUgYWN0dWFsIGxlbmd0aCB0byByZWNlaXZlIGludG8NCj4gdGhpcyBidWZm
ZXIgaXMgcmVhZCBmcm9tIHRoZSBtZXNzYWdlLiBJZiB0aGlzIHZhbHVlIGV4Y2VlZHMgdGhlDQo+
IGFsbG9jYXRpb24gc2l6ZSwgZGF0YSByZWNlaXZlZCBmcm9tIHRoZSBuZXR3b3JrIGlzIHdyaXR0
ZW4gYmV5b25kIHRoZQ0KPiBlbmQgb2YgdGhlIGFsbG9jYXRlZCBidWZmZXIuDQo+IA0KPiBUaGlz
IHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBhZGRpbmcgYSBjaGVjayB0aGF0IGNvbXBhcmVzIHRo
ZSBuZWVkZWQNCj4gZnJvbnQgc2VnbWVudCBsZW5ndGggdG8gdGhlIHByZXZpb3VzbHkgYWxsb2Nh
dGVkIGxlbmd0aCB3aGVuIHJldHJpZXZpbmcNCj4gdGhlIG1lc3NhZ2UgYnVmZmVyLiBJZiB0aGUg
bmVlZGVkIGxlbmd0aCBleGNlZWRzIHRoZSBhbGxvY2F0aW9uLCBhIG5ldw0KPiBtZXNzYWdlIGJ1
ZmZlciB3aXRoIHRoZSBuZWVkZWQgc2l6ZSBpcyBhbGxvY2F0ZWQgdG8gcmVwbGFjZSB0aGUgcHJl
dmlvdXMNCj4gb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhh
ZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvbW9uX2NsaWVudC5j
IHwgMTMgKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9tb25fY2xpZW50LmMgYi9uZXQvY2VwaC9tb25f
Y2xpZW50LmMNCj4gaW5kZXggNjZjMGQ2ZDZiMzNkLi44NTJlZDBjYWU2NjAgMTAwNjQ0DQo+IC0t
LSBhL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9tb25fY2xpZW50LmMN
Cj4gQEAgLTcxMiw2ICs3MTIsOCBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbXNnICpnZXRfZ2VuZXJp
Y19yZXBseShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICAJc3RydWN0IGNlcGhfbW9u
X2NsaWVudCAqbW9uYyA9IGNvbi0+cHJpdmF0ZTsNCj4gIAlzdHJ1Y3QgY2VwaF9tb25fZ2VuZXJp
Y19yZXF1ZXN0ICpyZXE7DQo+ICAJdTY0IHRpZCA9IGxlNjRfdG9fY3B1KGhkci0+dGlkKTsNCj4g
KwlpbnQgdHlwZSA9IGxlMTZfdG9fY3B1KGhkci0+dHlwZSk7DQo+ICsJaW50IGZyb250X2xlbiA9
IGxlMzJfdG9fY3B1KGhkci0+ZnJvbnRfbGVuKTsNCj4gIAl1MzIgZGF0YV9sZW4gPSBsZTMyX3Rv
X2NwdShoZHItPmRhdGFfbGVuKTsNCj4gIAlzdHJ1Y3QgY2VwaF9tc2cgKm07DQo+ICANCj4gQEAg
LTcyMSw2ICs3MjMsMTcgQEAgc3RhdGljIHN0cnVjdCBjZXBoX21zZyAqZ2V0X2dlbmVyaWNfcmVw
bHkoc3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uLA0KPiAgCQlkb3V0KCJnZXRfZ2VuZXJpY19y
ZXBseSAlbGxkIGRuZVxuIiwgdGlkKTsNCj4gIAkJKnNraXAgPSAxOw0KPiAgCQltID0gTlVMTDsN
Cj4gKwl9IGVsc2UgaWYgKGZyb250X2xlbiA+IHJlcS0+cmVwbHktPmZyb250X2FsbG9jX2xlbikg
ew0KPiArCQlwcl93YXJuX3JhdGVsaW1pdGVkKCJ0aWQgJWxsdSBmcm9udCAlZCA+IHByZWFsbG9j
ICVkXG4iLA0KPiArCQkJCSAgICB0aWQsIGZyb250X2xlbiwNCj4gKwkJCQkgICAgcmVxLT5yZXBs
eS0+ZnJvbnRfYWxsb2NfbGVuKTsNCj4gKwkJKnNraXAgPSAwOw0KPiArCQltID0gY2VwaF9tc2df
bmV3KHR5cGUsIGZyb250X2xlbiwgR0ZQX05PRlMsIGZhbHNlKTsNCj4gKwkJaWYgKG0pIHsNCj4g
KwkJCWNlcGhfbXNnX3B1dChyZXEtPnJlcGx5KTsNCj4gKwkJCXJlcS0+cmVwbHkgPSBtOw0KPiAr
CQkJbSA9IGNlcGhfbXNnX2dldChyZXEtPnJlcGx5KTsNCj4gKwkJfQ0KPiAgCX0gZWxzZSBpZiAo
ZGF0YV9sZW4gPiByZXEtPnJlcGx5LT5kYXRhX2xlbmd0aCkgew0KPiAgCQlwcl93YXJuX3JhdGVs
aW1pdGVkKCJtb24gZ2VuZXJpYyByZXBseSB0aWQgJWxsdSBkYXRhICV1ID4gcHJlYWxsb2NhdGVk
ICV6dSwgc2tpcHBpbmdcbiIsDQo+ICAJCQkJICAgIHRpZCwgZGF0YV9sZW4sIHJlcS0+cmVwbHkt
PmRhdGFfbGVuZ3RoKTsNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYg
RHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
