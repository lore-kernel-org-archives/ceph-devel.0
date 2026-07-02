Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389937081A;
	Thu,  2 Jul 2026 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783034281; cv=fail; b=AuSsbnLRqgX64QJBtGcVqt+9JNQ5P73IrizOoR6BciT4+gkFBE+bVDU8jKOriP9y2ItoGK4Wd+WGlO2mUHE3xNRxX3kjuyXcyk/jg7N5EesMeiKBJIj61KFKsoRV8YwIWjQHE3wOXPT+13XaZFz7r436h881SNMgcTCqccYt+pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783034281; c=relaxed/simple;
	bh=lOjjC/n2q5l4kpR/91y/SFd2er0Q83UBlEtcPwN+3bo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DXmzjgZ1J2c6RIByj+HxWHq2y3sSOCwDLyECm6q0pySqFsRcWfDw/MgS7wQ2ZIydtmoN72bqCe68+CSURgHQHWAW0OvIHQAvHL1Fm8fpiD5ZQ5qYCu5ey7w2wvwM3uHp0kQ1pmucoSaDMpT9rFw+kB+ot/CIqb7VHw/w/ouKSuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEq52bO1; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEq52bO1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662JILjH467472;
	Thu, 2 Jul 2026 23:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lOjjC/n2q5l4kpR/91y/SFd2er0Q83UBlEtcPwN+3bo=; b=mEq52bO1
	ZBO9lC1Iajh4dKh4BrcvSbyIxgMxdJd07upjP0vBzRyRaEIyWfx6gcaDFm7KPba+
	q54T6QCP8Wp4Yjs7f20oVlfr5ffpYhIZ+fn/9h0Gy9MhdhdnWyx8SLAfwxZQoTsn
	749/lUrt6Z4y37y4pj+lZLYqzW4INH1wmzVSh0j470ugqwocaWS6zQTxrm/hLbVB
	+RLtw+zVy3ypiVL0K/KlT1w2NNwd9VTMy2o8mChsu6aQD/s7JVD40oe5qOCmx4WH
	E+tF+NEiBkZ3at0HG2nHDVB5uL2h5Ly528lcBewAbfn8+E3XLxi7e3elZgEAq+sZ
	oulTfUbPNFTOxQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfbv8w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 23:17:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzmFC3Qjjupv6fyRJ8iC4/0pPl+le0RdLbIweZst8Xeh8bPtHWfSE1grQVZ4oebM+N4ek1DVvQMd3may5sumh8Dm0uohmLMKoLbG0vp75nWDvmb85S8nQOntxn61zxsOjsHnXa2S+fTOOCQHCsJn/yEpEsIKTYh/TvRGsCOerjCQr9tX3KHsWhOo8VQvXbAZVxxgQ9Jp8Kw6w1YAxOgMrCcKpxVZxDuVvMefOw6bZ204D6LJuSddPQTaQ5FczvWwZzRmAedu4DpQzg6tIu7A+mrTpS98yDpfbJ7yGRIMlKtwLqsPWl89ZIff0J/SajE8hujlNQxiWYDNrWN1F+na5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOjjC/n2q5l4kpR/91y/SFd2er0Q83UBlEtcPwN+3bo=;
 b=KiTr0Y06V4Fxyq4fVjN9ScUfRE/b9UnXsBAlHFa7dyTQdQlkLrp+h5Xg+apGD2c6EZwLNSogoNnOAAcFQkPTMqyj11JEr8o962gXmaiB5lk1+oMJJmS8iV0v95esnaI1F9hVcVwEXX98DypK3gP0kikmrpBR8BsAXQMM01YizZbyQiquCIi4d4q+ZzscFLb1NWXynSd5IJzMMoVpMcIYEARLOpJ/d/6aPaltee/Xbbd927dbHYKceH3MQve0bKORUXM3sUWFgoNDp3DoeftpcS3olLOKynEE5n4MQf+leX2tL0Utfu8DDAb+WR/PI468SOZwkP6Itr1/tv4c4pdIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF7BF7A480A.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8af) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 23:17:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 23:17:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shuangpeng.kernel@gmail.com" <shuangpeng.kernel@gmail.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [BUG] ceph: KASAN slab-use-after-free in
 ceph_put_wrbuffer_cap_refs
Thread-Index: AQHdCndK+t8I5OnJNkiXsfeCHCvfKbZa3Q8A
Date: Thu, 2 Jul 2026 23:17:51 +0000
Message-ID: <8371ae54da48303972868a674203a25517b91dbb.camel@ibm.com>
References: <A8282F50-9D26-4DF3-8B86-D09252A5767A@gmail.com>
In-Reply-To: <A8282F50-9D26-4DF3-8B86-D09252A5767A@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF7BF7A480A:EE_
x-ms-office365-filtering-correlation-id: 0952083b-078c-4e4e-ac2d-08ded89023a4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|56012099006|11063799006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 +lutq+T2fVaubuTzSIiOOxMNQwcf8Jfv2S3wdd1Du3Qp2MJnI684LaAmix+91ahUrG3AwsRTciTeU9oiEp7az6562VJXOynQoB8xqGZsPk4ZUNIMSAVNOmACxf4Lxfpb6/1fyhpFvkjlKKgJWP/b4x+mHyR5RH1WKPSw02rYYou4xCAvDq3CWLNwvJWILEFHo/KL+rawnMmJbWtEWN1rk/ojhi9PBWXKbvWJff+yx/JhpIKXaK8GN8fiKP/gR3wEwO0zh3YABl5IITDp/44EUepEmLDuKgba4hlxPj+c7wuDMGodxVH1EkqHPnc8l3lVawpD+cpWgrx/Rhc0meVIXEvqNQBHIZLN/xqCKXbcpnPq5YKQC66aN4s6ZLQeqHwW0utVPf4xn7F/W6exbnMi+6V35EDI5vz7U3sS24QzZg9wJQfGV7wTwGdpjpsAj6MJfTsoIhdDB4LOjyALoQiThixMukIBDJCfbS9HBpQtuEvnWRQoReTUYxE5nrsC5indOdSFaxMeBb3y6vR5r4wdTFoiitkM4xfZkSKaGtpoC0U8DUnZlivOnS8WvoGve+sLEaifkL4RDlkBF7mFHr7SDaILER/HBVDLrJ5DzLARLHu6ZCu0iCC8tqW+EHtQd8cTKiWF2tcE6g2LYpxVlWy6iBXsyPbW9jrM950EOj0JQvc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dituK1JPQ3RpRmNTaWQ4ek0rVjE4NjlNbWRwWG9JQ1NFTU9LWCsyNXhMRisz?=
 =?utf-8?B?R1R4MzJzQmwyRkdERFBsY01GdFFxN0czVTA3OUhEb3VveWp2TTY2SUtkTU5F?=
 =?utf-8?B?NEFjbzA1dDgzYmFUZmZ0ZURwUnZ0SUZTTEpDajdUUXdENDBFNm8zNWE5RlBm?=
 =?utf-8?B?T3pFNzd6UHFJWUdNcnpqWmx2NFBXeFhlaHBKVGk0NHFOZFNFVjRDbmJ3OXFO?=
 =?utf-8?B?UGcvVnpyZ1U0aDljYnh6d0xDdHBwUkxCak0ycFAxNWdPMUk2Y01yQ1Y5eEYy?=
 =?utf-8?B?QXNtc3MrbVRxOEZWYnlVY0hIa1hhWm9sREo1bHhjNGRwV1dFbURGbXFaRkpv?=
 =?utf-8?B?UFF6TFArUnRNWDQraGpTeVVxc0RRemc0dS9jOFBsdEF1dVB5aVUyNklFbkJK?=
 =?utf-8?B?TzUrVDVKS241L2NNdlJPL3JIcmhHanN3aHVKK251azF2eFdZbk1FM2NWRTRC?=
 =?utf-8?B?dm1oV0I0eWVZRW5aaU1ibHhVM1RkVmN4MjNFK2pPME5hTHZzZW1hd0lsMUFP?=
 =?utf-8?B?S1pqaHBoL2RmM0pLOWk3Zm83VGtFd205ZUNnN3Y3d1dxRU5oOS8vL010Qytx?=
 =?utf-8?B?dDhkQXhWTzF1ZEljblhxOUhXT2dZVDU3b2dLQzdsUVZpNExaSFlsMVdxcjZL?=
 =?utf-8?B?OUYxM0t4ZWhBUTBocDRabGhlRjRIWXFHcWljdFlaUHZYMUxONVpPUW83aTVM?=
 =?utf-8?B?dWxFWitVd1hmWXNBeU5xb1ZkYlg1OTVvaU85UFpWa2Q0WkRHZFJrYmxJSlhB?=
 =?utf-8?B?THhTemxJVVlsbHZjOXBDOTBvaWVrZ3c4Zm5FRVdBQTZaSzJrUFVreTRLWGZX?=
 =?utf-8?B?SGQzVm5yMmplYitpM1VnY21rSGNIMDAyVEZWdjRtNFBqbUk2Z1RzamliYVJo?=
 =?utf-8?B?Y2dhNGw5ZTE0NjBibEhyYkIrK01pQXZwSHlneTJGTVNWSHRJS3NNUlErM0Vh?=
 =?utf-8?B?Q0FvdXRPUjVSTk9FT293TWFwOWVqSjVEZ29YaVc4Z2xTWW9WVk5qWmNWS0dB?=
 =?utf-8?B?b0d3emJYYWk5UmdKMVhya2daMEZ5Y2JzM0ZpVTNIZEIyT1R2dWQ4dHNySDE2?=
 =?utf-8?B?dkd0MXZiNGZXZVNUelVDNjQxY3BCWjZNTFZ4VHpWMzQ5M2N5azh2ZVVHUUw4?=
 =?utf-8?B?M2xqenNlZ0lNQXFMUTVST1JtRGtseENBZThOVnJHTk0ycUNaRTBPVjVpQXpZ?=
 =?utf-8?B?SmFxM2xVWTZFWERGZ2FtSEc4ekpBL1YxVkpReVYvOUdLREFucHR4SjE2enJP?=
 =?utf-8?B?eXhyMVF2bEljYzRUVDBjSVg3SEQ1V2xrSU1hOFpLY2JWYllFd2FvTXAyVU9n?=
 =?utf-8?B?K3VOYU1sZVFiNSs2OGJiS3I1RVRrUUtDTzM4ZVNobnNQTUtrNUFERWtRdGpR?=
 =?utf-8?B?eUYzaFR4dTF0Q0dMN2RuSXJDWkhhWVZPRFJ5dnptTnN5N3J5SEZ2cWdDbENL?=
 =?utf-8?B?Y283eU9EcWxmR3VnTmsvYVBsZmJpOFRNRXU4a1I4OW5GSGdRU1I0bFRUVGIv?=
 =?utf-8?B?VXpYRExuYzlQSUliKzNHU3VKV1hyM3hVZ2cvVkc3ZnZYdnRqWXpTVDZqUmhX?=
 =?utf-8?B?Nkgvenpha01JS29FNkFHc0xjUEVhamYwQkhnYUl0K25TSVlDRzg4R3pOVmpJ?=
 =?utf-8?B?dVA3aU1KSVpEWHFBRE5zTWtUK3dHV2VEa0ZycHJweUIxQmRrWjBkZ2ZRRjVh?=
 =?utf-8?B?cDhDNGYxOGpacTAwZmdiOTB1WFZFRWdnR0piaHpKd3A2ZllyTlVHRXVCUFow?=
 =?utf-8?B?VWQ1cWovSUU2ZEhsWU9nRnJjUEozd2dyc2JjcUd5ckk2Rm5ubS9iaXRNYnN6?=
 =?utf-8?B?UGFRZTNwdDhKbXZGL0xvcUp0NVRYMDNtWnJaUE1iS0xpUkpENkFTcmNoZWlO?=
 =?utf-8?B?TUc0aDViL3RMZ29icURrbW82eUg1QUJDQkg0UWIrcjRpMTlBeVlnem15aGhV?=
 =?utf-8?B?WStWSHcvRFUzY0c5alVBUXBKVnJPTXVkZHE0L09ydGV1WVFpbi9wTUNMNy9G?=
 =?utf-8?B?RVIrbnB0R01QZkZRUFpvWWxiZm9YRU9mRW1MMUF5MlA4aG10WlRZRjNvQ1RI?=
 =?utf-8?B?TERFOTBlSllIUENiSHdJREpmQUtVM0l6c0gzSzIreDd2a3RwQmhGL0ErOTZU?=
 =?utf-8?B?WTZOTHM4VXB0ZWRvN0dGZkZkSjNZQzBMOVFTNFpzYUhRMm5udFVkdTNEclJJ?=
 =?utf-8?B?MmVSclBLTzE1SEtPT3lmTzUxSFRDT29qNlJvQzBZcVAwN29pN1k3ZzAweEhl?=
 =?utf-8?B?YksvcmpmV3BhY21OVXBid3loOStKTjVRbE5iUDRFdkNsOVNaZEUwQzJyQTYr?=
 =?utf-8?B?WGJ6dEFsZGxWL09EeXM2Z2o0WlNRaGt6eTM0Zzc4NFB1WjhkdnZQanduVTkz?=
 =?utf-8?Q?C7pHF2fKIvZa8I01B3oxZiHv3LepPyBswAuhK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E555FDA8292689498F16F4D64AAFFFD2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BylKZa4nTIFEbDCttvQOlWLEo5W5f78jfL7z5qD4ljxiLE9erCeGP6bb1IzlSd/R1wpy3I4Cmg0w448n8H1lNqONKx+pebCS2a6eQdGDOEqMd09+8pPFcZ3YK5gxjH6rTfAPY7aZctgAwVK1onO/0PyDR+yZoENRzx2kQvyX4iiLBvWGZWnC9OqT8IAF0peu75hPFC5bKDKM160ZaKA+fR5sxr6baNG8+xtdAPljIJEVftwePVuwi/STkF+s7ffVlzQiRR6LMMMop/cxz5jrdjvotjsbd7URQaxJd0g/4LSIYF6zNZnSGRtYs3jTZyJV/pRuvHo+78PSQY2YTvhzWw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0952083b-078c-4e4e-ac2d-08ded89023a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 23:17:51.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnEtnst8G/A8aWELtziikdc1pqaCTGUzLxd7Nab3GmRGQEC6tr3vl2AQg6vD3CJGuoH6XiLZp0pFzsimEh6EUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF7BF7A480A
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46f1a4 cx=c_pps
 a=S2IqtmjrQAXuShkhhqPLog==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=4u6H09k7AAAA:8 a=pGLkceISAAAA:8
 a=9HWaFTZYV_k2SgXGJxUA:9 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-ORIG-GUID: rDoq8zx80091T9xgQSHV3jp_e9mAbXp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIzOCBTYWx0ZWRfXxoUBP4DGELwf
 dbEgesCMWvA0UNXRrxUH6o+fDxZ6n2j5j/Aq8dxoN9qCvZd1LeSiZuAFgB+k7LvDDk3m5qfOL48
 RzBJ76zQb+Sv2WcH7JW7KAQ5Bwuw6YHDDU5mXw0s4GjSdmE9OEn5MoHmwPczCgFK+/nWip/atIX
 f2bB219LWFVaeLLgyZG3BSRKHCD8yDAdz2Xkmp5yC2DxtHbnCuNMBolxlLp+1MPQqN4r9HE9ljA
 5kShqhhH09PQW2e5/9vhoKbp1g5/RXzwtwAUDnpwEvfZtlcDkxvusqo8g7TWLpvLZrbJvMWsyRG
 QIJ67ow/4fRyK8+jOvyVMSYndF1U/rg8u0C84nLVX91iJrd8c/vzbXZ7A/4+ksXpYRYli8YhhpS
 GmUOh1DWBhZzu7qHJzJPOxwOsfi5WoZ2owHimON8GRd6AsTnYT8fjoPl+stgKqGIlu1BXANirDG
 zoqnLMwcyR/19h3yn1w==
X-Proofpoint-GUID: FwByhQNFXq5DRSr5Q-dq6FCzoTFUd1m_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIzOCBTYWx0ZWRfX9r4XOf2wMiMz
 bdMfXK1YFfEvZhvTuriY6Jar1FvMUsidIl5HBQ0R6Qt+drAxLxq9DMs/z25UZqKNkjThfOZL1po
 Nrbz+7KGBzz9fnEcU73oRZsR5bRTjUc=
Subject: Re:  [BUG] ceph: KASAN slab-use-after-free in
 ceph_put_wrbuffer_cap_refs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020238

T24gVGh1LCAyMDI2LTA3LTAyIGF0IDE5OjA0IC0wNDAwLCBTaHVhbmdwZW5nIHdyb3RlOg0KPiBI
aSBLZXJuZWwgTWFpbnRhaW5lcnMsDQo+IA0KPiBJIGhpdCB0aGUgZm9sbG93aW5nIEtBU0FOIHJl
cG9ydCB3aGlsZSB0ZXN0aW5nIGN1cnJlbnQgdXBzdHJlYW0ga2VybmVsOg0KPiANCj4gS0FTQU46
IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gY2VwaF9wdXRfd3JidWZmZXJfY2FwX3JlZnMNCj4gDQo+
IG9uIGNvbW1pdDogZThjMmY5ZmRhZGVlN2NiYzc1MTM0ZGM0NjNjMWUwZDg1NmQ2ZTVjNyAoTWF5
IDI1IDIwMjYpDQo+IA0KPiBUaGUgcmVwcm9kdWNlciBhbmQgLmNvbmZpZyBmaWxlcyBhcmUgaGVy
ZS4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNB
X19naXN0LmdpdGh1Yi5jb21fc2h1YW5ncGVuZ2JhaV9jODJjYzI0NTJmMmZkM2YzMTgxNWVmYjgz
YWQ4MGIxZCZkPUR3SUZBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhO
SnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09YlBmazN1NTAtbXJuRHNvUU5kakNZRHd2
Qk54SzRKR1JMVlIyX052S3VpYkxkd3BJanUwSmdzTHU1d2ZueXRrdSZzPTlfSXZwSGxTU01KWDFI
anNkTDkzcDA0VHRYOHo1LXV1UjNPQnY2U2dHbWcmZT0gDQo+IA0KPiBJJ20gaGFwcHkgdG8gdGVz
dCBkZWJ1ZyBwYXRjaGVzIG9yIHByb3ZpZGUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+
IFJlcG9ydGVkLWJ5OiBTaHVhbmdwZW5nIEJhaSA8c2h1YW5ncGVuZy5rZXJuZWxAZ21haWwuY29t
Pg0KPiANCj4gWyAgMTk3Ljg2MzI1Ml1bICBUNzk1XSA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gWyAgMTk3Ljg2NDMy
OF1bICBUNzk1XSBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGNlcGhfcHV0X3dy
YnVmZmVyX2NhcF9yZWZzIChmcy9jZXBoL2NhcHMuYzozNDA0KQ0KPiBbICAxOTcuODY2MzQ3XVsg
IFQ3OTVdIFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZjg4ODExN2E5M2MzOCBieSB0YXNrIGt3
b3JrZXIvMToyLzc5NQ0KPiBbICAxOTcuODY3MTM1XVsgIFQ3OTVdDQo+IFsgIDE5Ny44NjczOTZd
WyAgVDc5NV0gSGFyZHdhcmUgbmFtZTogUUVNVSBVYnVudHUgMjQuMDQgUEMgdjIgKGk0NDBGWCAr
IFBJSVgsIGFyY2hfY2FwcyBmaXgsIDE5OTYpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIg
MDQvMDEvMjAxNA0KPiBbICAxOTcuODY3Mzk5XVsgIFQ3OTVdIFdvcmtxdWV1ZTogY2VwaC1tc2dy
IGNlcGhfY29uX3dvcmtmbg0KPiBbICAxOTcuODY4NTEzXVsgIFQ3OTVdIENhbGwgVHJhY2U6DQo+
IFsgIDE5Ny44Njg1MThdWyAgVDc5NV0gIDxUQVNLPg0KPiBbICAxOTcuODY4NTIxXVsgIFQ3OTVd
ICBkdW1wX3N0YWNrX2x2bCAobGliL2R1bXBfc3RhY2suYzo5NCBsaWIvZHVtcF9zdGFjay5jOjEy
MCkNCj4gWyAgMTk3Ljg2ODUyOV1bICBUNzk1XSAgcHJpbnRfcmVwb3J0IChtbS9rYXNhbi9yZXBv
cnQuYzozNzggbW0va2FzYW4vcmVwb3J0LmM6NDgyKQ0KPiBbICAxOTcuODY4NTQ4XVsgIFQ3OTVd
ICBrYXNhbl9yZXBvcnQgKG1tL2thc2FuL3JlcG9ydC5jOjU5NSkNCj4gWyAgMTk3Ljg2ODU1NV1b
ICBUNzk1XSAgY2VwaF9wdXRfd3JidWZmZXJfY2FwX3JlZnMgKGZzL2NlcGgvY2Fwcy5jOjM0MDQp
DQo+IFsgIDE5Ny44Njg1NjBdWyAgVDc5NV0gIHdyaXRlcGFnZXNfZmluaXNoIChmcy9jZXBoL2Fk
ZHIuYzo5ODApDQo+IFsgIDE5Ny44Njg1NjhdWyAgVDc5NV0gIG9zZF9kaXNwYXRjaCAobmV0L2Nl
cGgvb3NkX2NsaWVudC5jOjI1MjQgbmV0L2NlcGgvb3NkX2NsaWVudC5jOjM4NzAgbmV0L2NlcGgv
b3NkX2NsaWVudC5jOjUzNzApDQo+IFsgIDE5Ny44Njk2OTldWyAgVDc5NV0gIGNlcGhfY29uX3By
b2Nlc3NfbWVzc2FnZSAobmV0L2NlcGgvbWVzc2VuZ2VyLmM6MTQyNSkNCj4gWyAgMTk3Ljg2OTcx
OF1bICBUNzk1XSAgY2VwaF9jb25fdjFfdHJ5X3JlYWQgKG5ldC9jZXBoL21lc3Nlbmdlcl92MS5j
OjE0MzApDQo+IFsgIDE5Ny44Njk3MjddWyAgVDc5NV0gIGNlcGhfY29uX3dvcmtmbiAobmV0L2Nl
cGgvbWVzc2VuZ2VyLmM6MTU3NykNCj4gWyAgMTk3Ljg2OTczMV1bICBUNzk1XSAgcHJvY2Vzc19z
Y2hlZHVsZWRfd29ya3MgKGtlcm5lbC93b3JrcXVldWUuYzozMzE0IGtlcm5lbC93b3JrcXVldWUu
YzozMzk3KQ0KPiBbICAxOTcuODY5NzM5XVsgIFQ3OTVdICB3b3JrZXJfdGhyZWFkIChrZXJuZWwv
d29ya3F1ZXVlLmM6MzQ3OCkNCj4gWyAgMTk3Ljg2OTc1NF1bICBUNzk1XSAga3RocmVhZCAoa2Vy
bmVsL2t0aHJlYWQuYzo0MzYpDQo+IFsgIDE5Ny44Njk3NjVdWyAgVDc5NV0gIHJldF9mcm9tX2Zv
cmsgKGtlcm5lbC9wcm9jZXNzLmM6MTU4KQ0KPiBbICAxOTcuODY5NzczXVsgIFQ3OTVdICByZXRf
ZnJvbV9mb3JrX2FzbSAoYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoyNDUpDQo+IFsgIDE5Ny44
Njk3ODBdWyAgVDc5NV0gIDwvVEFTSz4NCj4gWyAgMTk3Ljg2OTc4Ml1bICBUNzk1XQ0KPiBbICAx
OTcuODg3NTkxXVsgIFQ3OTVdIEZyZWVkIGJ5IHRhc2sgNzk1IG9uIGNwdSAxIGF0IDE5Ny44NjMy
NDlzOg0KPiBbICAxOTcuODg4MjIxXVsgIFQ3OTVdICBrYXNhbl9zYXZlX3RyYWNrIChtbS9rYXNh
bi9jb21tb24uYzo1NyBtbS9rYXNhbi9jb21tb24uYzo3OCkNCj4gWyAgMTk3Ljg4ODcyOF1bICBU
Nzk1XSAga2FzYW5fc2F2ZV9mcmVlX2luZm8gKG1tL2thc2FuL2dlbmVyaWMuYzo1ODQpDQo+IFsg
IDE5Ny44ODkyNTNdWyAgVDc5NV0gIF9fa2FzYW5fc2xhYl9mcmVlIChtbS9rYXNhbi9jb21tb24u
YzoyNTMgbW0va2FzYW4vY29tbW9uLmM6Mjg1KQ0KPiBbICAxOTcuODg5NzU4XVsgIFQ3OTVdICBr
bWVtX2NhY2hlX2ZyZWUgKGluY2x1ZGUvbGludXgva2FzYW4uaDoyMzUgbW0vc2x1Yi5jOjI2ODkg
bW0vc2x1Yi5jOjYyNTEgbW0vc2x1Yi5jOjYzNzgpDQo+IFsgIDE5Ny44OTAyNTZdWyAgVDc5NV0g
IGNlcGhfdHJ5X2Ryb3BfY2FwX3NuYXAgKGZzL2NlcGgvc3VwZXIuaDoyODMgZnMvY2VwaC9jYXBz
LmM6MzIxMykNCj4gWyAgMTk3Ljg5MDgyMF1bICBUNzk1XSAgY2VwaF9wdXRfd3JidWZmZXJfY2Fw
X3JlZnMgKGZzL2NlcGgvY2Fwcy5jOjMzOTYpDQo+IFsgIDE5Ny44OTE0MTFdWyAgVDc5NV0gIHdy
aXRlcGFnZXNfZmluaXNoIChmcy9jZXBoL2FkZHIuYzo5ODApDQo+IFsgIDE5Ny44OTE5MzBdWyAg
VDc5NV0gIG9zZF9kaXNwYXRjaCAobmV0L2NlcGgvb3NkX2NsaWVudC5jOjI1MjQgbmV0L2NlcGgv
b3NkX2NsaWVudC5jOjM4NzAgbmV0L2NlcGgvb3NkX2NsaWVudC5jOjUzNzApDQo+IFsgIDE5Ny44
OTI0MjJdWyAgVDc5NV0gIGNlcGhfY29uX3Byb2Nlc3NfbWVzc2FnZSAobmV0L2NlcGgvbWVzc2Vu
Z2VyLmM6MTQyNSkNCj4gWyAgMTk3Ljg5Mjk5OV1bICBUNzk1XSAgY2VwaF9jb25fdjFfdHJ5X3Jl
YWQgKG5ldC9jZXBoL21lc3Nlbmdlcl92MS5jOjE0MzApDQo+IFsgIDE5Ny44OTM1NTJdWyAgVDc5
NV0gIGNlcGhfY29uX3dvcmtmbiAobmV0L2NlcGgvbWVzc2VuZ2VyLmM6MTU3NykNCj4gWyAgMTk3
Ljg5NDA1M11bICBUNzk1XSAgcHJvY2Vzc19zY2hlZHVsZWRfd29ya3MgKGtlcm5lbC93b3JrcXVl
dWUuYzozMzE0IGtlcm5lbC93b3JrcXVldWUuYzozMzk3KQ0KPiBbICAxOTcuODk0NjE0XVsgIFQ3
OTVdICB3b3JrZXJfdGhyZWFkIChrZXJuZWwvd29ya3F1ZXVlLmM6MzQ3OCkNCj4gWyAgMTk3Ljg5
NTA5Nl1bICBUNzk1XSAga3RocmVhZCAoa2VybmVsL2t0aHJlYWQuYzo0MzYpDQo+IFsgIDE5Ny44
OTU1MTldWyAgVDc5NV0gIHJldF9mcm9tX2ZvcmsgKGtlcm5lbC9wcm9jZXNzLmM6MTU4KQ0KPiBb
ICAxOTcuODk2MDA1XVsgIFQ3OTVdICByZXRfZnJvbV9mb3JrX2FzbSAoYXJjaC94ODYvZW50cnkv
ZW50cnlfNjQuUzoyNDUpDQo+IFsgIDE5Ny44OTY0OThdWyAgVDc5NV0NCj4gWyAgMTk3Ljg5Njc1
NF1bICBUNzk1XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQgZmZm
Zjg4ODExN2E5M2JlMA0KPiBbICAxOTcuODk2NzU0XVsgIFQ3OTVdICB3aGljaCBiZWxvbmdzIHRv
IHRoZSBjYWNoZSBjZXBoX2NhcF9zbmFwIG9mIHNpemUgMjQwDQo+IFsgIDE5Ny44OTgxOTZdWyAg
VDc5NV0gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCA4OCBieXRlcyBpbnNpZGUgb2YNCj4g
WyAgMTk3Ljg5ODE5Nl1bICBUNzk1XSAgZnJlZWQgMjQwLWJ5dGUgcmVnaW9uIFtmZmZmODg4MTE3
YTkzYmUwLCBmZmZmODg4MTE3YTkzY2QwKQ0KPiANCg0KSXQgd2lsbCBiZSBncmVhdCBpZiB5b3Ug
Y2FuIGNyZWF0ZSB0aGUgdGlja2V0IGluIENlcGggdHJhY2tlciBbMV0uDQoNClRoYW5rcywNClNs
YXZhLg0KDQpbMV0gaHR0cHM6Ly90cmFja2VyLmNlcGguY29tLw0K
