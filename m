Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA703A9623;
	Thu, 23 Apr 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967177; cv=fail; b=RC93yBLxeDbAfpKHEkZgMQefscm7I1gwshfnC7L0nvhBENCB6+hISBZ9CLgiQsxHYuK172pwLgciQbX3zEalQnlWw7udlVYka/S06drYYbODfaJIDrNPUzkWHtVlGcICEuKMce8g54MpW1XH9SLb637ZcMPqbrBKQWvhxuiC3xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967177; c=relaxed/simple;
	bh=4NcvzyoeKDSvzXy9gDBPBmWYMNzxY0q2oqE5VQmo9BE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8Vl78+XuOLoPcWTIbENz/GS4gtbrloyStmzN5vOWtTMqVOGXECpXZIU+zeF4ZQEmP25tNi7qtGn2wsrPXCcGau8iT1gOIqdFPjQ5gmVbWOass3b486fmlpoGO3gNa1C4dmFyj7WkP3zjLGKlMExwXwywHEuK/WAL8uD410QKfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kmJ/se5M; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kmJ/se5M"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8ptJw3229334;
	Thu, 23 Apr 2026 17:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4NcvzyoeKDSvzXy9gDBPBmWYMNzxY0q2oqE5VQmo9BE=; b=kmJ/se5M
	GissE3ICRpzXE7MkrHPnqBmDjsgEdHtvkiDvBpIIdZq5uRiJfnW59EOB1c4+gs1y
	5dd0M52KSW50JrJsZNoB8Wt660AKlsNeunPk9Ad0AUSs1v/xPpDo6f1CQVTRS3QI
	GUoIjTOsO8WILOXjee4hihvN6uj8rQXWA8eJWeOgu5jU8mYo+psscEfajTqNgYo4
	qMZEfNjgQgJ+IsTg9uuZg+I4elsjKiOo7AIRvrRtTvprfqFahNSSC1hTm2l/7zHT
	MOBrP/dQtdeCKElzuAFOdtSacg3wxUwjeYaVD0P1RkFJTjMC08x4F2Tn0fJSzTBT
	cSmGKMlDpjjr/w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2a268-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 17:59:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9bNnAf7X3A2Mj5i0IQtGkk+RqTAj6XT9OMMQ94u8fke74N1ODcKFcmaY74zDmtXqSGvbjEFs/fTy5hErMJeGC78rgxCmQlSwQ7Os95cXy/NEZexzpwzFj2LBLV4fAJOXYVXGsjTU8bV8vz5j1sTEamBvpAUxGWxzxkgqiUI6nUUoWWBmIs68e46QHjXnaUeWDjM6Bg1f2pfXEfz6YdLp1Tcois4YIkW/TOIASRqaHcSleomwkM5SyN1vevDl9nn226CLLhaHfda3yhvHAtGckRk5FO8ue+SeG3HISdx1s+08nlKVAJEQObEnF4zbsCmD18f5/7lXtr+QlYIrNqDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NcvzyoeKDSvzXy9gDBPBmWYMNzxY0q2oqE5VQmo9BE=;
 b=Mjup/nKF8RLSy2D8dKoGbN6CRGhxvRlM2MnclKl7H4rVxP3NZFgihjnWu6Ge0bA3yfGvR6eLK3rnG+l0+BwyTkiu6z3/wmUkraVY68uQ4jghCgCRV6TCEY6Oy6XrcKIX3bEAtOK8RBdo65rRjVY98zbsrfttSN8ApvgzyfsoOeazypOWTz1zKy20N1labfwtSlvhCWJO3IHXxsTCeCLas9a9Shu3gj/2ZvrjD5D63Rvnx+ud8lqO8tqgaF1iMOVVaS81tQe4HnCrGzFOX+//rRZZ0vPHN0x5Zv3ZqIqFJQjiw4UlRfsAh0gz/HbVOCawyhhy26sxfNZ+kEs57PxXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF44BDF4180.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Thu, 23 Apr
 2026 17:59:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 17:59:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>
Subject: Re: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to
 WQ_UNBOUND
Thread-Topic: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to
 WQ_UNBOUND
Thread-Index: AQHc00rtYbMyfCQAAUuEesxpLB6L0Q==
Date: Thu, 23 Apr 2026 17:59:28 +0000
Message-ID: <1a5b5d23dc54c9099643795bfad9f14705505fed.camel@ibm.com>
References: <20260409191517.318015-2-slava@dubeyko.com>
	 <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
In-Reply-To:
 <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF44BDF4180:EE_
x-ms-office365-filtering-correlation-id: 1b7f6db5-ee2c-4ec5-90d5-08dea162105f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 aDYOlRghphUFwg8yCMGK2VafQAQUQFVvYj2+l+6Kqcuilm9I7JPmKG5lVCrk5Mv0y3ZF+Z6pqZg+P6VLkusQ5uF+24PU36uF1RuVUd2YJCKGpl/vlEnw/O6b9wSbfXee84PeuTaJCUxLXO5sEupeZ3YMLp/VdMVyUwAvSocOgmCrcqShtIvW4qVo3pjPnwXjaDfpmMlsbjlIBp6RkRf9qJpdUtX1eoI/5Tgr7l36EOs5ko+UCVXH+ExG1ZfEnnwVo4pRoR/smf1KuvXzWMBj8E+e626iz/8jRTcLxRyjwv4M6mQkcfwqsc9LJ5gtDGXPjOpulVi0yCyN0r/yqw93aXejB/uS9QZVxu65dZB6wAgjQk/jb5RegRs4ZV62+XJ5SzYAwhryGzjJjlnTWyB6rYiYo675QPK59WJmOP2cjjY2W3fMOOQM5xp7fNCiy4Ok4Y5+sx2LasWcgD59vjKsBKP0B/FQ6IMWdQ8NC3R76SzO9Tq4SqfBfvWw3qD/aE0WNEOpwK5Hdby//ZPNR2s94acz9eBr04FeRtwIJM5++HAwurD63Qm8Jl65VpQdAPvwpZgQ+1V7TWLzM739EnAfo71XKfVcfK5B1g49MW7sBZeEma0W6E8pIsLw04B7pZul/HCsWcyEkdrKPiwwpDYcmotOQL3n4UKO1fu/wn6Qm4x0iri0BsmroZ6gIWRCEY4y7iFsJ3UufpTV8dtLej62R0Ct0QJ8SgSXpmJIk2sOaAJl1IvaNyHlqnWL/hhTNfDlXIP5bJDhAF4YNb2dmMUs85JcULlZIpi5EKYLWZ2/WMw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzRvTlR3MEgzTEtLYytkRVFVN21PWEZZUUZzK0wvTUVZNVl4elFwOE5XaSt0?=
 =?utf-8?B?bTViS1FCajR0Nk53cE02azFZd2MvQkNrL0NRRTNJUFo0aVRVbThMWkZweUhI?=
 =?utf-8?B?NE03RU5uYjdPUEJZNVQ1N2JDQVA1N1Y5VjZTL1Znd2k4Q1AwZnpLOVpqOWox?=
 =?utf-8?B?YU80bExla0I5NkdkSksvZnY1am1nN3JpaVRaa2Z2NHVjejNQdU5DUHZBL1Aw?=
 =?utf-8?B?NUo4QlhwQ1NRZWFFektZaHNkTEU5bk94clRhQzhiaGRRWmM0eXZ2TnhQTDlI?=
 =?utf-8?B?ajR6S3dqeG45eVpLSWdDUlFxUEJTenE3d09xN2xhMHBBTDVkZHY0YWdSby9i?=
 =?utf-8?B?alJ6UDVveUVHanlJVEpjcDAzQm4wbXFBRkRhQk9mZnlwTEdNS3FuZTEzc2RL?=
 =?utf-8?B?TnZBQ3EyRjBzNHZiRVZHRmxBVjJnR0NmZy9BQnBGM05BSHdVaDk5MGNZSTV2?=
 =?utf-8?B?MlR1bW9qM3BkWm4vQWlZVlZLWjVmK0JMR0tERUh6NVA0NU1rMVl2anFJa3d4?=
 =?utf-8?B?ZkVEcTI4cUNLNkdSMlZWdldjVnRybkNGWE5HQVJiL1EvdlkrdHRDS1ROb0dL?=
 =?utf-8?B?K2k1ZkhtL2E4ZWpCWnE1dUtFLzJCbWV3ZmpPZkRBOHVyU3NvR1FoSGVoN3ZD?=
 =?utf-8?B?Z29vK3hxcmRiRjhvaGY4MXBHK0lFbDJTYXRSS3NqRURwYzBQZFVpVDBOYW9X?=
 =?utf-8?B?c0o0eVEzTXN3UTc5MXZHSXp5YkxXcW9zaTJrNC9wMy8yQ3l0NmdNNzRmbVAw?=
 =?utf-8?B?ZjZxK09TZFpObzN0TUJNQ2VJK2tFLzdjVEdIc0RQYVh4VDRCVlBSU3BDUktv?=
 =?utf-8?B?NDlSNlpBRFBBbURMT0h6VlhBdXYvWTBJRE5JWC9aN0hvUGlJemRQL0ZaSU5q?=
 =?utf-8?B?OUh1YmVrODV4b3JVR1F6Yjk5TGdybXBmbDJiemNTaGRURmJ2N3Z4bzhaeW5O?=
 =?utf-8?B?ZzdJVStmKyswMmNZSGMyTCs4VFh5QjVMWnRqWDBqdHlwcDl6ZExSTldjN1Zn?=
 =?utf-8?B?L0svMWhXTG9ZVjh6M1M0UzhsaHltdjFhdWFCYS9uZlB3SkkydUhmTU9SWTE1?=
 =?utf-8?B?eTRrSytWVFh4NTB2ZWs3aFVkQ2l6VlhaWkN1cERWWUNFQXBERlpEQ210bW5p?=
 =?utf-8?B?clRzS2lwTGU3a09DaU9MTUI2NVBvbExCQTE1b3d6cjFUTkFPOTQzY09ZRXFO?=
 =?utf-8?B?RUQ2aE8rcXBUK1RxZE0wc0I0N1l4WGZoYmhFZGk4RjZneWl2c0NadGE4WXZT?=
 =?utf-8?B?emVEV3JDaDR0bFNaWXV1eUFNSTZTYnk0MVJPMWJneDV2MEpNZDhtY05ESFVZ?=
 =?utf-8?B?bzdMd29vOHFmc3pZQ2FvNEQxZC9lSHRjYnpnQUt2d1hpRTJlL2dNZjRIYXdL?=
 =?utf-8?B?NDVidlB2QmdvWWR3M1hVQm1uUktGYnorMW8yZkZRWUlSSklnSmRpeXU2ZE5V?=
 =?utf-8?B?emNqd25iUG8yVkYyYUUrQXZqeElnRW56SG14ZUNaMGtTUjhmR3FCZC8zQWFv?=
 =?utf-8?B?djNmL2hIVFJEa0hMblBDN21YeEkxVjRrdTlZamF2V1pDL0F5TEYzTG9zYXNi?=
 =?utf-8?B?aFNRTUh5YWNXR2poU21FQ0dsV3Eybk4rL0lES2cyWUl3NENRQzBVY1UvMFpq?=
 =?utf-8?B?cTJxZHgwbUNzeWZLTW03UDRRVjc4NlBBeDlpRG5ZRGRMNXFGSTRTSDFFRkxm?=
 =?utf-8?B?WkFOR1BQY3J5dERCOENnRXJ0STByMDQwQlZhbWxzb3gwUGNEaFBtRjI5elI1?=
 =?utf-8?B?Y3p5bWI4UTQ3TkxZbW40RmdEaXlacmw1bXRZUFJ3VDY4NVNaRitHUlQ0STc2?=
 =?utf-8?B?Y1RiMVcxMWkwRzZRNHl0OUtsdm52aGpISWhmKzlEcXpOM3NYMGo1MHhMY1hY?=
 =?utf-8?B?dm1DZm96cjNtNUROM0VYcGF1Qmo1bXhJVGw2cWNtYk5GQ2w4VXg1WXdGOSt0?=
 =?utf-8?B?Yk10U09TQmw3WVhXMjR3NnVXNXJxUE5oOXE5UVZibWZYMUhoczZwWit0R09W?=
 =?utf-8?B?VEpaMkNZdnB0TzRJeWtuVzFLN3kxVWhzSk5PZkl6SU9OakpvaUlBUWs3Sjl6?=
 =?utf-8?B?Vk93b1ZZa0VkMWNwWFIrRnEvSGdmaytDYSs5TVFSZ1F2Mk4vQ3JhQW1qTldp?=
 =?utf-8?B?cnZRQVNOcElMRmlwckF1eFlVeHYyc1VxTStWV3RuQ3RJeWJodjB5K3JselNS?=
 =?utf-8?B?di82bm1Bc1llanM5ZkVPSXdNc0laNCtVRVptWkRPeFZWQ3hrcm5nQ1R3bzNw?=
 =?utf-8?B?V1psVmRVOHBqdm9PQlBpRWtGaUxYdS8zR09VeHFnMUZwVHltMnFNRk9TOVRx?=
 =?utf-8?B?Q1pwQlR4TXIvRU52QWlwWjQ0TnplaUVVcHNVcjZHcGY4ZkJoZE5qZjdmQmd1?=
 =?utf-8?Q?W4QooNzkL9H78wPoP9KHBxQwPUB9AlmWyGD6L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED70D4BD2FA69145B245C3D673A31B53@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TgvWkz3hVlyLUkkLAx4UqKZ6exymaDQQezFerxOZu9NX9NMjH/zEbNO3L7iV5n3x4sL2sSzJP+sotD90+sGEeuSiWd3kkCQMhuEGM4pCHOkGW/SxfNWUBh2N/pqOtKDBbXUJewELCLYk//FalnyTfWgjImSsSX38S2ZwNDBY4WKeTc5V3vhHAq6jBmnSYyHMhl8OMOnx6ky7qiQNWJ0n9mynhccrFcSytQHMulOs9PiItLUeMqMzwGrf/W3rcfytLZj8u70GO0EAE4wrZvMZmuoKURDcPfT1TOOB8XWUXz+cYwK8uwQMfqiMrvztDpNAHmTClsVqrwm3B1AXVzvfIA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7f6db5-ee2c-4ec5-90d5-08dea162105f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 17:59:28.6462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqCamduQavnWPN7aSv3xblkczBEMgqgL/yGHD2pdNHB7uFj0Z0yGYjoP7nceEskTdQ8OFGsid45qrgaJw9JMjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF44BDF4180
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OuE1AiG4qvvhe9pkWB5EAG3NPdHxPsRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MyBTYWx0ZWRfXxJNO6CAnuJwR
 WnRFPTDr7fkShwx9yZZU/TCUSiv0Rml1m5y764S3J5oh+pKceguudvXoCj3q/fm+xTdP74W7bx6
 XN0+pG/beRKdndxCv3sZx1O6Wt7U/i0LnSJnH/gW5rxTw1G+n6DwUNzFTOxqPr1QD4XsS583VIK
 IfWuJyFv+d1mt7hhnM6hJAYPlVw5BlIt1MYTTzrVAzCYMPUQm1imKEFZEKtIX71bxh6Tc26e3tO
 RKL/BcPFyF/yYyF4Y5QabO26ROeQPAOY6/lxXw6ZiMIBz/aPNdeEiUq7dEITb0SgbMXC/pcoXrq
 OlAtmFCwgXYrCHF8nquUD8qKSjvcTLMpYwXZ39J1XSiQdGavxPEPjxm+WpaUXDWr6Zys2X/Fseo
 tjUb+WoBathUY/MbfNi4TVvyBPQEaqTWpmS8WsyHAF02knMZc8ZJNpJCcFaB752P03rCKj3S3PO
 8naMd4h/YtSaSG1Nx+A==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea5e04 cx=c_pps
 a=iHXbSHwDNs+yH6wS+48/mw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=wCmvBT1CAAAA:8 a=VnNF1IyMAAAA:8
 a=vu-05LN_1I4bKrZKIQMA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: tlVxxta_OgVmzc0GyiP4r7xPpVXAnHh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230173

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDE3OjM0ICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIFRodSwgQXByIDksIDIwMjYgYXQgOToxNeKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbyA8c2xh
dmFAZHViZXlrby5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFZpYWNoZXNsYXYgRHViZXlr
byA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiA+IA0KPiA+IFRoZSBjZXBoLW1zZ3Igd29ya3F1
ZXVlIHdhcyBjaGFuZ2VkIHRvIHVzZSBXUV9QRVJDUFUgaW4gY29tbWl0DQo+ID4gMjdjZTcxZTFj
ZTgxICgibmV0OiBXUV9QRVJDUFUgYWRkZWQgdG8gYWxsb2Nfd29ya3F1ZXVlIHVzZXJzIikgYXMg
cGFydA0KPiA+IG9mIGEgdHJlZS13aWRlIHRyYW5zaXRpb24gdG8gbWFrZSBwZXItQ1BVIHdvcmtx
dWV1ZSBiaW5kaW5nIGV4cGxpY2l0Lg0KPiA+IA0KPiA+IEhvd2V2ZXIsIGNlcGhfY29uX3dvcmtm
biBjb250YWlucyBhIHdoaWxlKHRydWUpIGxvb3AgdGhhdCByZXRyaWVzIG9uDQo+ID4gLUVBR0FJ
TiBmcm9tIHNvY2tldCByZWFkcyBhbmQgd3JpdGVzLCBtYWtpbmcgaXQgY2FwYWJsZSBvZiBob2dn
aW5nIGENCj4gPiBib3VuZCBDUFUgZm9yIGV4dGVuZGVkIHBlcmlvZHMuIFRoaXMgbWFuaWZlc3Rz
IGF0IHJ1bnRpbWUgYXM6DQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IGNlcGhfY29uX3dvcmtmbigp
IGRvZXMgaGF2ZSBhIGxvb3AsIGJ1dCBpdCBkb2Vzbid0IHJldHJ5IEVBR0FJTiBmcm9tDQo+IHRo
ZSBzb2NrZXQuICBCb3RoIG1zZ3IxIGFuZCBtc2dyMiBtdW5nZSBFQUdBSU4gZnJvbSB0aGUgc29j
a2V0IHRvIDAgdG8NCj4gaW5kaWNhdGUgdGhlICJzb2NrZXQgaXMgZW1wdHkvZnVsbCwgbmVlZCB0
byB3YWl0IiBjb25kaXRpb24uICBTZWUNCj4gZG9fcmVjdm1zZygpIGFuZCBkb19zZW5kbXNnKCkg
Zm9yIG1zZ3IyIGFuZCBjZXBoX3RjcF8qKCkgZm9yIG1zZ3IxLg0KPiBGb3IgZXhhbXBsZToNCj4g
DQo+ICAgICByZXQgPSBzb2NrX3JlY3Ztc2coc29jaywgJm1zZywgbXNnLm1zZ19mbGFncyk7DQo+
ICAgICBpZiAocmV0IDw9IDApIHsNCj4gICAgICAgICAgICAgaWYgKHJldCA9PSAtRUFHQUlOKQ0K
PiAgICAgICAgICAgICAgICAgICAgIHJldCA9IDA7DQo+ICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ICAgICB9DQo+IA0KPiBJZ25vcmluZyBvcGVuaW5nLCBjbG9zaW5nIGFuZCBhIGNvdXBsZSBv
ZiBvdGhlciBzcGVjaWFsIGNhc2VzLA0KPiBjZXBoX2Nvbl93b3JrZm4oKSBzdGFydHMgYnkgdHJ5
aW5nIHRvIHJlYWQuICBXaGVuIHRoZSByZWFkIHNpZGUgb2YgdGhlDQo+IHNvY2tldCBiZWNvbWVz
IGVtcHR5LCBpdCBwcm9jZWVkcyB0byB0cnlpbmcgdG8gd3JpdGUuICBXaGVuIHRoZSB3cml0ZQ0K
PiBzaWRlIG9mIHRoZSBzb2NrZXQgYmVjb21lcyBmdWxsLCBjZXBoX2Nvbl93b3JrZm4oKSB0ZXJt
aW5hdGVzLiAgSXQNCj4gZG9lc24ndCBldmVuIGdvIGJhY2sgdG8gdHJ5aW5nIHRvIHJlYWQsIHNv
IEkgZmFpbCB0byBzZWUgdGhlIHBvdGVudGlhbA0KPiBmb3Igd2hhdCB5b3UgaGF2ZSBkZXNjcmli
ZWQuDQo+IA0KPiA+IA0KPiA+ICAgd29ya3F1ZXVlOiBjZXBoX2Nvbl93b3JrZm4gaG9nZ2VkIENQ
VSBmb3IgPjEwMDAwdXMgTiB0aW1lcywNCj4gPiAgIGNvbnNpZGVyIHN3aXRjaGluZyB0byBXUV9V
TkJPVU5EDQo+ID4gDQo+ID4gU3dpdGNoIHRoZSB3b3JrcXVldWUgdG8gV1FfVU5CT1VORCBzbyB0
aGUgc2NoZWR1bGVyIGNhbiBmcmVlbHkgcGxhY2UNCj4gPiB3b3JrZXJzIGFjcm9zcyBDUFVzLCBw
cmV2ZW50aW5nIHN0YXJ2YXRpb24gb2Ygb3RoZXIgd29yayBpdGVtcyBvbiB0aGUNCj4gPiBib3Vu
ZCBDUFUuIFRoZSBsb3NzIG9mIGNhY2hlIGxvY2FsaXR5IGlzIGFjY2VwdGFibGUgZm9yIG5ldHdv
cmsgSS9PDQo+ID4gd29yay4NCj4gDQo+IFRoaXMgbWlnaHQgYmUgdHJ1ZSwgYnV0IEknbSBub3Qg
c3VyZSB0aGlzIGNvbmNsdXNpb24gY2FuIGJlIG1hZGUNCj4gd2l0aG91dCBhdCBsZWFzdCBzb21l
IGJlbmNobWFya2luZy4NCg0KTXkgc3lzdGVtIGxvZyBpcyBmdWxsIG9mIGxpa2V3aXNlIG1lc3Nh
Z2VzICJ3b3JrcXVldWU6IGNlcGhfY29uX3dvcmtmbiBob2dnZWQNCkNQVSBmb3IgPjEwMDAwdXMg
TiB0aW1lcywgY29uc2lkZXIgc3dpdGNoaW5nIHRvIFdRX1VOQk9VTkQiIHdoZW4gSSBhbSB0ZXN0
aW5nDQp0aGUgQ2VwaEZTIGtlcm5lbCBjbGllbnQgYnkgbWVhbnMgb2YgeGZzdGVzdHMuIFdoaWNo
IHBhcnRpY3VsYXIgYmVuY2htYXJraW5nDQp3b3VsZCB5b3UgbGlrZSB0byBzZWU/DQoNClRoYW5r
cywNClNsYXZhLg0KDQo=
