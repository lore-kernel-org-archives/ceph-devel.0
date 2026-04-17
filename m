Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92E36403A;
	Fri, 17 Apr 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448109; cv=fail; b=u+HUWqMHhOjQLv6viiQk+UnVLBvrF3N14q8MiqOekpRSysKXp0P/AFvvADnlQICvROysRO8S2ynR1yCkwdZLLXRwRtaLkusHhB9lsELBxOZqycp53ZESEx+qiPKRmVbNIBpgTqIM3uKk5OyrOVIixYAGBySxMZKJyTZLhKrOElM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448109; c=relaxed/simple;
	bh=ev4m4uMjegwlPkGFS7mICgnfKNhjnPd3g574Ug2hJkA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cndzRULAfRVnHEE42C5OFPngwsG7GPhfnyW3Qpn6dKxCF237BzqcmVxPFvbJkSTux5HicC63ZJQaBJ70zsBGJWcb0oN3kbOXSrRYQTM1Uebt+x6NDKtbnhOOOpZOoLEuwlc36w375BqLBAh1TOYxInHAGrbDuSVQaWQdmzIcRRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D9wWyws9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D9wWyws9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HBWIeR1842962;
	Fri, 17 Apr 2026 17:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ev4m4uMjegwlPkGFS7mICgnfKNhjnPd3g574Ug2hJkA=; b=D9wWyws9
	fB+QsHmdlnk49aH/BymbKaKUMcNdSmDic05X+Xev5Db/DCR20WYNs9uIhqTuCtss
	Oj7+TWQo18jendzw1FBLNWsozg8tFSTaUIvHWhQI7AmDo97WcdeLTwSbXfGJMM4J
	OwALdJV6b9bjnU0Hj0GmY5yshssRLQKg0jDNfKeCS75ff96RH/eq4HmlQdz1XYCP
	f2Nb6IU6a99QDwdcK6PnfxKa8uWs2kDEk1tODvPfBk2FBa7y1vdIfIeiMXg7SRPw
	cr3K03Tt8OjsMZyxdPbEvyqkVNcez4CCGvBg8TstW+Q7aZCdmjFffv2ffNMJ3IxM
	02gapW3RaAgAEA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n3u4f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 17:48:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yu3g3zH05hxyE5py+QeRJRnEec32Bi7LkvICI0zYn9qeSQmbe+CHLTIltOikOogv6FDYXuXCCuPPyp0D7XFAKVeMagpNPIe0YR9paJ9U8FDZF95USrS66FmrB6GyXSOZm1uuloEcZAkGu/lhp1LXhzMxOGbVV/P65aTg3S5YY44iTv3mYL/Sa8voMK26FK56jfbnfaEapHChPdbK5hFcHepRTRukLDo9AChJfn8WMlSiYsm23IvsNM2Yqzw6Nrw1BcUX7r7RXF+zuyvdsD+8iuMjzz1Q612VFQjNNObGANVx0NB2N5ALW6llMqem3E0HUXaw60V/sXCJuDr93D3UAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev4m4uMjegwlPkGFS7mICgnfKNhjnPd3g574Ug2hJkA=;
 b=s1J3XbIOWUFv7QL/7xmb8SbMDCtmRp5CXrs+Q1KoNulZaNeNtrkTzOC02RnJ+a9CjfLi3zqwtxzMLeve/wD81s8Yov8+UkxsW4kPubzvJW9eY9cF0B0ssuIzxb4LnE3R+aI9BugcabvRIP0X/NYPKqh83XbpA3RDufJVHik9ZY2wlmxQJfAwmImO+LddK2uoufGf7N+LE8HUfUOCP01K4Oo+/l0ex+Y1BnT4wnyzI+3bR06oynpJPcDvG0TXFMLp6p71oyUuZ+RtNPyPWrCh/ZDRyajVj+HVgXHeYuTaLuUDzfbG2JvqPwwYK5+9gYHavAbQZiIKXHHbDtmGcqrK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6401.namprd15.prod.outlook.com (2603:10b6:a03:56d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 17:48:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:48:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "zenghongling@kylinos.cn"
	<zenghongling@kylinos.cn>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex
 Markuze <amarkuze@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhongling0719@126.com" <zhongling0719@126.com>
Thread-Topic: [EXTERNAL] [PATCH] ceph: fix potential ERR_PTR dereference in
 ceph_submit_write()
Thread-Index: AQHczkEcOFXTjaU97UGDP9RctIDDY7XjiC4A
Date: Fri, 17 Apr 2026 17:48:06 +0000
Message-ID: <494716d7aa3fe860d89e19866fa3b59755183de8.camel@ibm.com>
References: <20260417080609.51361-1-zenghongling@kylinos.cn>
In-Reply-To: <20260417080609.51361-1-zenghongling@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6401:EE_
x-ms-office365-filtering-correlation-id: 90c5fe27-1ca0-42ae-22b3-08de9ca97b8f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 /G2+ahR9Fs9yDb8gfoU8eHl5d3XTc9b2WoY2sxrrXLAuHRyXfRbCAoEASDIflaImmIdIjB1F3jc+7U9X1ak2Ue2XmHFLT20FlC3PZk83+p//YHa338sYTC95hi2hFE9nAYjkwLeNqjO7rumRq8ZFOkVSfxgxRPUEfSEn1VK7nOKIUJSG1KAARcqdD32rlUxii8UR1z+q0Eg4xzvPTSfXFM91a1znf9jSTEJRMQdRO8bYyBmNWC9IqygmqDahQrmwgcsbDphyEUxTENx1HwEIuOP2R53PRxeWTHAEe9WJisF/g9XmaZ7GxImvVcdkGD93wjVZNzNZOXcMVcXErhdeZOcbXGZ1/RzdNc9pVUhfglE8UkQKlwpJfbyrVOt1cTQkDVh5n6LMsXF3s8JH2eY/KZ9mhVjmhPZRqK99Nyy0PZgKMja4SysdpGvipBvoKyZ/0Oc+8oYeBru29uHpTAFMRpwAOPCn8TejZWPF7h0ShNniRoL+AN6iexW4SeNLprA5Smi5NzkZrcarND8uXkUGGYwzk2MjTRb+0/3GuiDMOcnlsWr8lVN6HUilYWdzAxVoommovvYZ0r12/Cjwk9+PAR3na6BaB93Ex16IgpKoaxgOTK8Y03pp16D2ZrSHixzsnM3/Q+PqZ+0gf3DdLgo5Zlc0AJZ4SOOE9lAIcuKFxUJtyHfzPKI/4OB+37ijEJhglaJ7l6WNEcveXinsrp7hHFt3YInvIBmGhA+NnI5lSN2l17VYAhdPqzUP0VzTgJRc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1o4UnFNblVSQmtXbWtqR0YzWnU5dGFLRUNENjRocVZGbFN2b21kck1qTUN2?=
 =?utf-8?B?ckErU0FnTElqQmxZbjE2VVNCenBoUGpTckFQRVZTazArYzBzR056Y25ML0I2?=
 =?utf-8?B?aERwYjY2ZmJ4OEMyVWxyM2Z1NzVrT2wxcHpKVjlMVlBUN3U4cWtpSkRsQ0t5?=
 =?utf-8?B?MXZJWDZNcjRIZmJJcjJuU2tuUEtwZTQ2bVoybDVKdWhTQy9hcEk5RVFEYS9h?=
 =?utf-8?B?UWJoWTYrNmIvcC9zYzdCczlDOThxczZxai9SWW5nOGJKZU1NSmRvcGIwSXNQ?=
 =?utf-8?B?TnpxRlk1a1RSTTluTHVZUTM1TTN6S0RZUmZQVC92VDVkY3FTejFEZ3F6QVl2?=
 =?utf-8?B?a0dnUWRCeDByeDRUaFZyWm5IOHQwc1hDd2o0UjVSRHRhbGJlQ0dtREdrcGpY?=
 =?utf-8?B?dnJ6VUlYamVLQ1hFcytKWk1GWm8zZ2VWcUxNM3FtZHlJOFhiRWlXaTZHa28x?=
 =?utf-8?B?OUVMYTVxNDRNQlZrUnVqeGtwS0JWL0FMWGdPclRVYnR5NW1JNVBZTk0wdzhN?=
 =?utf-8?B?SndkQ3F0UjFhVHp0M3p5SEpOT2NSREY4MjVaRWlOQktOUVFJc1ZhWlZpdW93?=
 =?utf-8?B?bGZSbmhPK2ExUkFUd29vdktvdGFpdFExdXlkOHZvcVVSQ3NQZ2hzb0FPQ0Zj?=
 =?utf-8?B?U25TMk5HUUo4UWlVTVZTclJrL1gya0x4OWlzM2NjcTNZYkdESmVIcDlvUytx?=
 =?utf-8?B?RDhNbXFFbkNNajlMMUpVRnkwMDVKUUJKdFIvZld4QW93MDk0Q2FwVW5JY21l?=
 =?utf-8?B?a1A5Tk9ONldBMGZidjNoR1A0WE5uczZqUW1vdGFBaGx4eW5DdW1OL3BmbDgy?=
 =?utf-8?B?WGhaTFU2SUF2R0ptSVhLdE8yUDhXM0FYcUVPWGs5ZjFyZnB1Mmk1aE9Mc0hJ?=
 =?utf-8?B?QzNBTFlUdUxWdUtvSEZLWnU1YmZSck1vWXZtWGNzOHlVNE94clU5RU5rOVRT?=
 =?utf-8?B?emZRY0lIWDNOc1M1YjNiU1c2ZHBsY3JxY2E0MjVQWFNjSEVtalRGS0dCam9u?=
 =?utf-8?B?cE5qODc4QmRLMTkxZXRQRUNhRnVtalJpV0VibER0QVlTTFo2NGE3Y2RsS1c1?=
 =?utf-8?B?aXcxdDlKdmkyaW9raEVNSGJkL3hjZzFIeGFLQi92TkxpZXJHSTZnVW9VdTlK?=
 =?utf-8?B?Y2xBek5ibUNMZWtZcGJpT1JLMzJOajRIcVdqVWdHTVpTQ1UwdlBTWlRlbkNv?=
 =?utf-8?B?RGwwYnBUaGtqazNYMjdzSVJua3RxKzJwbnY2OENaajlvSmx3VEJsejJ6cXBZ?=
 =?utf-8?B?VkJSQU1mNFh1QURHVmpJWEV6Tk5ueEcwei9HZlNzMUFidXdLTG1oZkVnTWpN?=
 =?utf-8?B?YjVOZlVEbWpwa1pZeldTc2V1QzlETHRKdWM3bDh5VElPZzlNMlgrNzFZQVlO?=
 =?utf-8?B?cVdrVDZVbjNTQWtCNmhYOXZTb1JwY3BOZ3FOekRjVk1zb0ViMFNaanM3VERG?=
 =?utf-8?B?TW01ODhodS8yY3NVRGlGRm1yWlp1OENnOThsbWF6N3NDYXdaMWdWTXh2Mit1?=
 =?utf-8?B?QzlUcUE0VGt0a3VvWlNjYnBIKzEzcWRwNFZrZzhJQnk5cDNua0RzNDRkSjdV?=
 =?utf-8?B?WWdHSTlIY0h5UlUrbHBZUUhuSkxQQThKMUFNcHVPc0lxdE9UMmtOZ0NFTGhN?=
 =?utf-8?B?a3VyaDFpUHZST2xDOFl0dlBqYXN6aTRhUUh2K2VjWlljR3BxQ1VkdllmckpK?=
 =?utf-8?B?R1FMa1REMlh0cjRDT0NIZ0RLa3BVRytBeUNBeGRYMTMxZ1F0amhZSUsvek9u?=
 =?utf-8?B?Lyt3cDBPNzhtSzk2bFRoTTliVElJYkVBRWpyMUJxRHN6dFIzdjVOcDVCSTZU?=
 =?utf-8?B?S3E1a0NET0c5Q1hRODA3enF2TWZ4azlpd2pEZG5DZGlGc0cvc21wWlNjSk9P?=
 =?utf-8?B?RVdSMWw4TlJyWmlVeS9rbEhuQUNvS1E0UklvdmtqS01qZy9kdVVtZUtWQ20x?=
 =?utf-8?B?c1pVOStpODAwN0hKbkNSVmMzbkpmdlRYUWoxUmQ1bWZ5N3FJZ3pibjBmK0Fn?=
 =?utf-8?B?NUVlaXlMb0VqYk5qQk1WRC9zSHg1aFZuSDIyNnR5dU45TzBqa0hsWWhyR3I0?=
 =?utf-8?B?OWdXMEFCUitsWWFFTm9UenNOK2sxOElGdmprVEdZSVl0TEJlcEo4WmlzaDUr?=
 =?utf-8?B?MjhlYzJkbjRVUFAxdXNBY3VkZDdaa0d3NTNEeEV0RHEzTS9zK2hrVytBTVJs?=
 =?utf-8?B?NDRQZ1B3VWZIZyszeSt3a3hRTkVvMExmL0pXRTVHU0JSTytxZlJuTGNhT09H?=
 =?utf-8?B?dkRGemllMFdFdnk5TGlCbEhpck5nR0pjakwyQTIxUDdaTzB5c1JoSm5aYXVP?=
 =?utf-8?B?bzVXWW1KbXI1VGdLTlBlTXFaNDhRMTNRSnA3L2dJZXRXS2NhVGlKUGpyRUZv?=
 =?utf-8?Q?xlZqWSevpA9jEo5ol8ayIJsqnbwnnO8uE7lyC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462A92C6568ADB48BD69477CF5A1C3FE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lx1Z1XoAtb9PAqFe1CI7KcFUzkEyLbQWoIEMQPw8vSf03G5GnebFpM2U0lfZgMXoGBW+BbuA09hVsTC5z9cnOkFFnqzfei/tKLkvViIGWS/52OfDrJhEJ28MiXB/C9qolVuWetaCnVgmpUbK50+5s6YweD07jaG1HyvIdm3YMc94eU7D9vbch+V8jW2wxs83m0qQ9AkC3gfVzmjniXevuPP7Zc0o3HTCyWyRNsrg8JEqRlJ+Cf7g+ZZQtbkqlWTTPb67/6HgG+RE1EUF8QZJmmgUT4uxie32ZGUay9iccJsELZPoaL4xUKBI2X7xi5+rbb9eT3UhzIA41t5o8NUoNA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c5fe27-1ca0-42ae-22b3-08de9ca97b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 17:48:06.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bU5tXPEQscYe5ZkPPJJ8VpSpaL670x+FAj0VmKboNCkE7J1ha3EeXs6+vYXnO5BFQjE0v16NK/48W/iLu7+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6401
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE3OSBTYWx0ZWRfXzhFHB1w70JSt
 cFyzIlH/Vh1BnT0ozoNSu1BrVV+v/MWPB1TIFfr/g88J3X0x23b9+EWiqLzGU0VeLCFGb//ES9W
 9EG3K1KU2xWdE4Ldgg8ODkvEbszZ2fikbpS3N21CzwyVHrJj3Tzh2GBcqAf0a/+Lf/d60lvh8DP
 seGAzzw0JMRK6ZZO4ID09o7kYhfheTmRMinO8VozEakVMGcrXx2eaGEOwc2zBOF/HWzZukWZZbS
 kyfDfwDijniP64GuAMSPz2ZZ+Vu7C8IWZlLd9ETN4/SPLhD2m+H2SOUGVNimMig0vTNH0aOjJTp
 bb9POyo0cWdut9YUUiEKYig8L46A0cjX2CBGuQqNBTkUgj+vJEf7MmkV7iyZ16xX1NWQjmYVHr4
 qD5NRRTGqT2RzEoGfSoQhT8gu7pYqnvy45bFLmxDcjufgP/jaHvBe2hapuFsx94x27L9yx5JOjr
 wJlnSa/OXMqZ8SFQMHQ==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e2725d cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=P-IC7800AAAA:8 a=h8tivbg6t7_m8ZIcPzwA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: yPEv3J7mH7c4oKyiMfCOombN8VqoHzTE
X-Proofpoint-ORIG-GUID: NmBrLIrKINYQucguU6wi3EQkxEQcZP3K
Subject: Re:  [PATCH] ceph: fix potential ERR_PTR dereference in
 ceph_submit_write()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170179

T24gRnJpLCAyMDI2LTA0LTE3IGF0IDE2OjA2ICswODAwLCBIb25nbGluZyBaZW5nIHdyb3RlOg0K
PiBGaXggc21hdGNoIHdhcm5pbmc6DQo+ICBmcy9jZXBoL2FkZHIuYzoxNDg5IGNlcGhfc3VibWl0
X3dyaXRlKCkgZXJyb3I6ICdyZXEnIGRlcmVmZXJlbmNpbmcgcG9zc2libGUgRVJSX1BUUigpDQo+
IA0KPiBBZGQgYSBjaGVjayB0byBlbnN1cmUgcmVxIGlzIG5vdCBhbiBFUlJfUFRSIGJlZm9yZSBj
YWxsaW5nDQo+IGNlcGhfb3NkY19wdXRfcmVxdWVzdCgpLg0KPiANCj4gRml4ZXM6IDE1NTFlYzYx
ZGM1NSAoImNlcGg6IGltcHJvdmUgZXJyb3IgaGFuZGxpbmcgaW4gd3JpdGViYWNrIikNCj4gU2ln
bmVkLW9mZi1ieTogSG9uZ2xpbmcgWmVuZyA8emVuZ2hvbmdsaW5nQGt5bGlub3MuY24+DQo+IC0t
LQ0KPiAgZnMvY2VwaC9hZGRyLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5j
IGIvZnMvY2VwaC9hZGRyLmMNCj4gaW5kZXggZmE0ZjI1Zjk5NDA5Li42MDkxODE4Njc0YmUgMTAw
NjQ0DQo+IC0tLSBhL2ZzL2NlcGgvYWRkci5jDQo+ICsrKyBiL2ZzL2NlcGgvYWRkci5jDQo+IEBA
IC0xNDY4LDcgKzE0NjgsOCBAQCBpbnQgY2VwaF9zdWJtaXRfd3JpdGUoc3RydWN0IGFkZHJlc3Nf
c3BhY2UgKm1hcHBpbmcsDQo+ICAJCQl1bmxvY2tfcGFnZShwYWdlKTsNCj4gIAkJfQ0KPiAgDQo+
IC0JCWNlcGhfb3NkY19wdXRfcmVxdWVzdChyZXEpOw0KPiArCQlpZiAoIUlTX0VSUihyZXEpKQ0K
PiArCQkJY2VwaF9vc2RjX3B1dF9yZXF1ZXN0KHJlcSk7DQo+ICAJCXJldHVybiAtRUlPOw0KPiAg
CX0NCj4gIA0KDQpJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBmaXggbWFrZXMgc2Vuc2UuIFdlIGNy
ZWF0ZSBhbmQgY2hlY2sgdGhlIHJlcXVlc3QgaGVyZQ0KWzFdOg0KDQoJcmVxID0gY2VwaF9vc2Rj
X25ld19yZXF1ZXN0KCZmc2MtPmNsaWVudC0+b3NkYywNCgkJCQkgICAgJmNpLT5pX2xheW91dCwg
dmlubywNCgkJCQkgICAgb2Zmc2V0LCAmbGVuLCAwLCBjZXBoX3diYy0+bnVtX29wcywNCgkJCQkg
ICAgQ0VQSF9PU0RfT1BfV1JJVEUsIENFUEhfT1NEX0ZMQUdfV1JJVEUsDQoJCQkJICAgIGNlcGhf
d2JjLT5zbmFwYywgY2VwaF93YmMtPnRydW5jYXRlX3NlcSwNCgkJCQkgICAgY2VwaF93YmMtPnRy
dW5jYXRlX3NpemUsIGZhbHNlKTsNCglpZiAoSVNfRVJSKHJlcSkpIHsNCgkJcmVxID0gY2VwaF9v
c2RjX25ld19yZXF1ZXN0KCZmc2MtPmNsaWVudC0+b3NkYywNCgkJCQkJICAgICZjaS0+aV9sYXlv
dXQsIHZpbm8sDQoJCQkJCSAgICBvZmZzZXQsICZsZW4sIDAsDQoJCQkJCSAgICBtaW4oY2VwaF93
YmMtPm51bV9vcHMsDQoJCQkJCQlDRVBIX09TRF9TTEFCX09QUyksDQoJCQkJCSAgICBDRVBIX09T
RF9PUF9XUklURSwNCgkJCQkJICAgIENFUEhfT1NEX0ZMQUdfV1JJVEUsDQoJCQkJCSAgICBjZXBo
X3diYy0+c25hcGMsDQoJCQkJCSAgICBjZXBoX3diYy0+dHJ1bmNhdGVfc2VxLA0KCQkJCQkgICAg
Y2VwaF93YmMtPnRydW5jYXRlX3NpemUsDQoJCQkJCSAgICB0cnVlKTsNCgkJQlVHX09OKElTX0VS
UihyZXEpKTsNCgl9DQoNClNvLCBpdCBzaG91bGQgYmUgdGhlIHZhbGlkIHJlcXVlc3QgcG9pbnRl
ciB3aGVuIHdlIGNhbGxlZA0KY2VwaF9vc2RjX3B1dF9yZXF1ZXN0KCkuIEFtIEkgbWlzc2luZyBz
b21ldGhpbmc/DQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjcuMC9zb3VyY2UvZnMvY2VwaC9hZGRyLmMjTDE0MjENCg==
