Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF1379EEC
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153666; cv=fail; b=Uq7ph85l6Me6VDZbqGXPJPVCelRiAKyAffztFUSLBGmM9/CLqaalra1q79nE2BgyQTMO316w3I7xBO/wDI9+yQ+ePOIFVoq+8MR1zmNFKErc6qDHh3guXDNHadFyw/eNSVpd1EfdP61MwFMTPHhyBRThuj1wYKqn1kFkwY0NpAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153666; c=relaxed/simple;
	bh=yUOR6a9ZCFpYpZMNTGeaZP0If82WRRjOjiPurFC1fXc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Y9zn6ACkUwTGAd5BCmhJumDbf2/IIcyb8zO1/IpFAqDkthRKJF0fFFqzaIscGc646BVuj9WobRMU/1oRQDv+3TgJ8wSU9NGNoDY+DAT1kRDeT3pVUdKW1lKFw+tqyscnm8KG8EgaqfmgPsLeNzMopwh6F8ZZg4xldajXzrimsMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jkZvzCG+; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jkZvzCG+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632F81Xg115373;
	Thu, 2 Apr 2026 18:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=yUOR6a9ZCFpYpZMNTGeaZP0If82WRRjOjiPurFC1fXc=; b=jkZvzCG+
	xygkZn/PCczgyMgsy5mfbs9xQT3cx4t4n6MET2gepop0t0e/Ee5gDdUqh83WLZTA
	GyiJZNOI+nsDCQnEztii/pDyAkPAsocl8Cj3ksMpTwRZ/mT2m98dZJkAh/mIsj1e
	XrqwyLFVhCYVsGEwf6Wp4yzmuungqGzmCK9HkbQN7pSPGzQxKInqnmL6vIV+lcjj
	n+TC/hgMvKOKAw8tHwZBzWzby/QwZLj+Bu52PzYFCU51JEgtCMizc75WdYJnhARH
	kZy4c06qxSfx46yWF/aCT3uRB/eypSnBEE8kRKu0FrK63kMXNy8+v/tTuC4vcpfq
	PgcJscD4FefzxQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3dyvw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 18:14:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzaoPBHdzUk4PuUjIi1ud7McEw7u0boZLzEz+byJEycA6bTeOEE/eUM7R26HVmgBvi4+jCGRp7ci3LZK6KNCKUyHJvQ5woP0kv3nHdtgjPGjUYdL2VvxKgcbF1T6/Hu3aZuc962Hi7Q1ytzI4Sbc4Z70IXhSbaafiHSDgTTIDO944EmnR0ALLVEK2U+vqMuxiW1B5BE6C/ChpW2ONt/707Zu6UlACyPwU5fybI3qXvHFzL/4YOz8o+xUfu99ItOX9IwSSVqLrl7fSzYqqINXq9PetGtM/dl9hoh3IAhFr/vXp8tKdIDH2LFMTgRhbLP/sz2sr2EsImagajJr9q50qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUOR6a9ZCFpYpZMNTGeaZP0If82WRRjOjiPurFC1fXc=;
 b=FOT+eH0HwFlUUFexcZFu2Mz7Qds7MWnYrxhM6G/8B2UWHQhXJpi+TlGYUeMgxZ9AkzMGv5H0Wtf/EuDvzyLOksn0miPcSHeC6FygvOqVeGfVegUrjT881rmgsMHgVG3PfI47H+9ry0LjJHieFqr+NHzY2CNWj2dZ+KY3yuUaC8/YqsoBwmOtzYw/a1SOSb0h0ya48Ug4QNP0u0tYgVSOLqbZDYiTVFPnlOG6BXn53t7haeOzZcSRx3hOVAYnjyXOFZN7MR1rErz5kZVctuFBBQ65UXH68dZ/LivdsSOgEeQ/reGv2h3c6zSmDU0tYIpG9erxcaVDGVl7gMwyhdVg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB5068.namprd15.prod.outlook.com (2603:10b6:303:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 18:14:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 18:14:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Fix potential out-of-bounds
 access in crush_decode()
Thread-Index: AQHcwnHFHO6+pv7UAUS+331xtOVpYLXMFBgA
Date: Thu, 2 Apr 2026 18:14:06 +0000
Message-ID: <db5836ada81127694ebe4baec538ec6a0b564c04.camel@ibm.com>
References: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB5068:EE_
x-ms-office365-filtering-correlation-id: d32fef21-d6b1-4000-7f28-08de90e3a14d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 CxE29miCkndT3Eq9X9YIYHg4E9RfigimMqkUF7w5hiEgvLFsA9WBuA8nY/2qd6qjyh95QYzYkXXF+bJjOTxAKnl+ovVQK3voF9pwwaWN2RlHwawr+E3QWsOOKs1XMcH8vsx2a4ED2/ttViuiPUU8tQCEaZCWO3/I0mp19BbGsnd0Z37xJMUaT2aIyUhsBt/+veEtKLmO//mPHd/yEAYT1/ZyyeGMgGT/RRJmV2ksyPXz/5iJ88VzyYHTEjRsjrylCZv16KyFrV0d0VofeBv79IKgCKEXpZakvKU04oczY21lesbj0C8p1J9hP5uAwNDeHKAtivZetK9uk+KIMm2ixCzW59sCcpPn1X4CyYxZWI7EtmoqDCzwiSMxmu8DNVlwF6ntVGlMcbP0ppcEDMwnY86NgBWk4zW7Qd+fEl88VT5oMwkXwv1p4Q5XYVvLs0p5b0qAYLQ9AGpo1lo2grY3a2+uqgx8zYBZ6Z7GgIx4L+XdLgRfVpSNM2ypQ/dVfVM1N/a1/gI+O0RFUMa+HmnKD6Cx6s83e3+ni9S+gpNzYFLuMDIlRRE4e1SJC20To5eZJamsaNflujKcpeHnxXuNn3LJuhzOim4rmnuqYA311cWUlk48D0KgpHRPrqAULh6oerg9NPi7j5zXwOUw28ulnXJ9gdVPu9XVtmceG6spGjEmDabUiAb/CQGkShajNKPShc1UXqyYe+kq3Ij98S9Pt/qzHdQkm+NusDT4BcsT+gUHplNu3gakIeP+ocCY2hnZ+t99m6BXOgB1kXSh5vuCbvJtDwqCz7ycvFBaWrKnjyE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjJ3Y1Fyb2lPY0dLQ2xOMXNjUWlhZHdPeEZybVQxL2dzeDV6K1lLdEkvdHhZ?=
 =?utf-8?B?SFoxSEdDSWdtTTNHYTVKbDQ4anN4RGZ1amJKb0s1VFlPei9lTFVLc2xDdVU3?=
 =?utf-8?B?VnliRDF4SWxmWVhEU2Z6d3dsOXFoTTlWWFZhYzdjQk1DSzBGNXBxaVdHOU01?=
 =?utf-8?B?QVlqZjBYbTl6OXhOWVpXV3UyTTkxYmJHNGxIbnVUVWJMcldDT21DYWtmbzNp?=
 =?utf-8?B?REVOc0tXRTVCZjV1TXd3dDlmc0JKeEw5MGFTUmNGUlpCNENZY0lhYmk2S21D?=
 =?utf-8?B?VllhUmdFSVR0a0FiSlZxbGt5K2lDSWlNa3ZURkpKV3VNMlhhQldhOTZEdXF1?=
 =?utf-8?B?bFk5REY2V3JxWWw5WDBzcjB3TldkbkJsMml4WHVOaUZZN0V3bWk4aFFBT0sz?=
 =?utf-8?B?L2Q0N1JGVFhpN2pNS0x2eTFmOFFON3EzR2R4eFNCbDdQbXptWDhETFd5QUJO?=
 =?utf-8?B?SWpsVU9hMkRmVEY0MTAwV1RPWlU4bzJCMzhHVVdqSms1RFdCV01yWDVQZXJl?=
 =?utf-8?B?cjNzR3h1MWhRZWV3cWZ6bHB2a3Jvbk1wOURSWXN6ZFZPakVTVmk5L05DTHJ3?=
 =?utf-8?B?UUZCM1R2Wi9OZnNyUVd1SFVtc0crRkEvMXIzOElrUDlyUUIxQTNocFFRUkZl?=
 =?utf-8?B?QkdUMGxSb2ZMUjJQdHNuSUR5elJ5LzNmckVVRjZ2SFBjc0ZzaTNvWWVDSUJU?=
 =?utf-8?B?MVpLbTlVeEYyNTVoMEc0TUF5YXNXY1RPWkIrd1A5bHdFVXZ5cnh3M3dDc003?=
 =?utf-8?B?U1lHK2hDZnRkeWVyeUZ0VWt4NU5WRG9GN1dqdGpSeWx4T1NPNmQwM3FNTDhW?=
 =?utf-8?B?Z0xJa2w3ODlURkcxNjNBVUdkdFJMRWV6blg3VExZTEE0NTZ1N1NUM2UxYWZt?=
 =?utf-8?B?cTdwWFBKU1JGYThucy9IaU1oeW94eWdHVjRoY05LYXo0dU96TGRmUFlwZ0RE?=
 =?utf-8?B?MkZIVGRXbU9VU1ZnVEl3azdpZEV2UVVGZ3NmQ1lEa0w3ZDVqRy9pV1VFTTl5?=
 =?utf-8?B?WU5UMXk3SXpzSmsyYUVJV1kxMmdvbU5rbUpTSS9DQi9kWThsb1hmakRqNmVO?=
 =?utf-8?B?cUI2THpEN0xoV0JjM1dPZXozYzdNZXhmVVZPN1NwWEVTOGhZMXBBQnpPeVRO?=
 =?utf-8?B?VXA5V0pVWmxhcUFLSHV3ZTc0ZjFJYmdhRkJ5WUhjNGZHTFp2VitJampacXBm?=
 =?utf-8?B?OGZVREpIaUs0cWFRRUMzdXJ4N1RCUWU0UnBCZ0dtcEdCNDVkTFQyQXFLb05J?=
 =?utf-8?B?SHRISGdpcjMxaVJXTWRJQmZEQm1HRW1lOEliRFhhSXoycEFVT1pZVEhyUU9v?=
 =?utf-8?B?MnVoVTNrcS91ZGZqVW91d2JKUC9oUXlTSkhkN0pqbUY2NEpoaGZ4QUZHT1hC?=
 =?utf-8?B?STRjSkZ3Yk10azRaUzFsRnI5dzhpYkIwZlhzajFzSlZwVzB6dmF5VVdhOERm?=
 =?utf-8?B?a2phTUpmZTdPNHpZcGJnWUhHOHZ5RHlOZnVHdEwxenpyWnFzNFFnVVc0UG1i?=
 =?utf-8?B?MXJzSm8wWDkyaHFOcDhVbzJTOVMranpXU2oxaWJtdllON2Q0d1hDeUpjajYr?=
 =?utf-8?B?eUlQM3dydEI1NVZPZ3g4TGttSFBDYnBnQjNWanloV0pvK1JZMGJPUFJNNUVJ?=
 =?utf-8?B?WE1FZFBBWEdWTktFR00zVHJRMmN1V2dBbm1kZUZHamQrSG1xa2QzNS9IYm1r?=
 =?utf-8?B?bFFwV1VpeFZ5b1RBY2JxVWRyZDA1dHV2UEtZdm53cHlPK3VJSzhsUmRuK0lH?=
 =?utf-8?B?MEQ4ZkJZdGxUOTBkYUVpQTZnamNJS09qdEIxUk5NbEpBQzZYc1QwS1ZLaUVl?=
 =?utf-8?B?VnhLdXI1eUNVdlRUNVRJcGwxQU96QWV6VVFNeXZoUEZ0cGc1bDhMQ2lnVisw?=
 =?utf-8?B?UXN6Z2R0Zlh5V1FmdGNkeWErZ0dyWGZBRDVYeVJvUXh2K1hTSWdiQllCMjJt?=
 =?utf-8?B?MUVXT0d6V3h0azVyMHR4dS9DMlNyMGFlR3pqOVA0ZlRTYnVSZVd0QTd4V2E3?=
 =?utf-8?B?K1dzYlVKQk1hMmxycjVLdnBLdGRTQW9HKzlIeWFOVlhob1VDWUJGclpNdmIw?=
 =?utf-8?B?eEsyaEh0blE2TDAydk5HRDdHT0xKMWJzd1pBTnpMV0JlMjF2NUQ1OHhyQi9J?=
 =?utf-8?B?OEV6VTF0UWIzYTlCTEJUNThzU2ZpTUZQalFpKzBWcFR6OEZZbzBxRE1JdTk0?=
 =?utf-8?B?NU5LS3RZMmVVWkN5Z2ExNWVDZFlTay9Ca1BJajZNbzg3clp5aVZOWHJlenlp?=
 =?utf-8?B?dlhwNnRTVFViRmRlZUdVVjNiNnRmYW9jMEVyRUlzRE9XUnA2NUdSN3IvWVdU?=
 =?utf-8?B?bDB2cHRXbGswOTZ0ajVuWVhjcThybWl6eXdiNUdVbyt0bTh2TEpCdytVU1Bp?=
 =?utf-8?Q?EmuO34mQi+Yh/j/+r+80QeXdrDKkl13H3+rZe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0F2A4C42258A74081E389BFE0F1FCD9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KSva+zNYxbX6vKfQUTG6CHyR6Ntzy8mm3Q36hpPZypBRmc8o2ZQKDBtZPRagkT7P7FstM21ryvcKqoulxRh3cMWxhFlr2tlay4sTJaKB214iqkSrK3I6RCXS0C7Sl2nZOPITcVfEof5RfBF3M5YgBHm2nWcYlqNssVoI5NFptVI8kxTEGjLK0HlgEag75s280p/jTUWhS6V7ymGCy7m4ep7BW2sk0b692xVVJy1aN/tQKuJM5p09fzlXK7JM6pHsiKaL/R2I/PJCnXkbKxY/ccE7xj7Jlk5UEx/RpxHsLHIhPVUGtr9VnNNTsfAUr2VvNtwLapGBfdwD2jSAbyR1BQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32fef21-d6b1-4000-7f28-08de90e3a14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:14:07.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+8t5w4R7HbZWseqwFcj5JoopTK8NVYN0p7ujCS3nAknDWXIlSwD0JdIq2vw4oKicevQrIPnfzE1yOD6Az9dCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5068
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2OEh17_K9CQWBRmt_qGhMpeXum5HulAj
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ceb1f3 cx=c_pps
 a=4hG4CnY/eg4LDOVkUp5rMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wEPG61vRlrZy0T5MeFIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: J-qyF41gVO_QNimTBaVxcxMValCwe4WP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1OSBTYWx0ZWRfX+vvHtdTYh2ax
 85RIdti7yagc1BeVRGrM8CVXeIpM6BFwzNll+TlLICHbiQxpMzWbsUYUnrBMzJ8VJHDCF5ZX14O
 akQ5Rdl53ZM7RdkgxjWhFaRBihEQ6OBibKcRf88B14/WsN3sVqlca73Wkc4DH+Mn4X6MrAYQUDB
 8SVt1vu9u+KG1oSF8cDoR/joq82ycPwtJmhunWd0eq2wpIatF02OKxrcFBjGjmstbS06+1rX1bc
 MMz+kEubmVlU1nBlNEdwvj5t5ZT8jt251VrXax7AW6p/FVWopwatwgQPYgj/Erm0L7rXu7DJr7P
 Gz0vdXk9L53vpxjYswU4q4GXKreaW1l+UOriXC/p5lvidBW2z/Upf15AOnsJTFaAFTJ7dHCoT6f
 0WVkDR/O6ItoAyfAxY2RGqmqG9YbPFn+B/cl7tt0l/IU2mjQTr9HSSkP3ixd+eus/Pz6Pzy+EC3
 vNq8nCxztbpuKaWl2Cg==
Subject: Re:  [PATCH v2] libceph: Fix potential out-of-bounds access in
 crush_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020159

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDA5OjE1ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX01BUCBjb250YWluaW5nIGEgY3J1c2gg
bWFwIHdpdGggYXQgbGVhc3QNCj4gb25lIGJ1Y2tldCBoYXMgdHdvIGZpZWxkcyBob2xkaW5nIHRo
ZSBidWNrZXQgYWxnb3JpdGhtLiBJZiB0aGUgdmFsdWVzDQo+IGluIHRoZXNlIHR3byBmaWVsZHMg
ZGlmZmVyLCBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyBjYW4gb2NjdXIuIFRoaXMgaXMNCj4gdGhl
IGNhc2UgYmVjYXVzZSB0aGUgZmlyc3QgYWxnb3JpdGhtIGZpZWxkIChhbGcpIGlzIHVzZWQgdG8g
YWxsb2NhdGUNCj4gdGhlIGNvcnJlY3QgYW1vdW50IG9mIG1lbW9yeSBmb3IgYSBidWNrZXQgb2Yg
dGhpcyB0eXBlLCB3aGlsZSB0aGUgc2Vjb25kDQo+IGFsZ29yaXRobSBmaWVsZCBpbnNpZGUgdGhl
IGJ1Y2tldCAoYi0+YWxnKSBpcyB1c2VkIGluIHRoZSBzdWJzZXF1ZW50DQo+IHByb2Nlc3Npbmcu
DQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBhZGRpbmcgYSBjaGVjayB0aGF0
IGNvbXBhcmVzIGFsZyBhbmQNCj4gYi0+YWxnIGFuZCBhYm9ydHMgdGhlIHByb2Nlc3NpbmcgaW4g
Y2FzZSB0aGV5IGRpZmZlci4gRnVydGhlcm1vcmUsDQo+IGItPmFsZyBpcyBzZXQgdG8gMCBpbiB0
aGlzIGNhc2UsIGJlY2F1c2UgdGhlIGRlc3RydWN0aW9uIG9mIHRoZSBjcnVzaA0KPiBtYXAgYWxz
byB1c2VzIHRoaXMgZmllbGQgdG8gZGV0ZXJtaW5lIHRoZSBidWNrZXQgdHlwZSwgd2hpY2ggY2Fu
IGFnYWluDQo+IHJlc3VsdCBpbiBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyB3aGVuIHRyeWluZyB0
byBmcmVlIHRoZSBtZW1vcnkgcG9pbnRlZA0KPiB0byBieSB0aGUgZmllbGRzIG9mIHRoZSBidWNr
ZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJA
dHUtaWxtZW5hdS5kZT4NCj4gLS0tDQo+ICBuZXQvY2VwaC9vc2RtYXAuYyB8IDQgKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9j
ZXBoL29zZG1hcC5jIGIvbmV0L2NlcGgvb3NkbWFwLmMNCj4gaW5kZXggYzg5ZTY2ZDRmY2I3Li5h
ODcyNjgwNThlNjEgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL29zZG1hcC5jDQo+ICsrKyBiL25l
dC9jZXBoL29zZG1hcC5jDQo+IEBAIC01MTYsNiArNTE2LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY3J1
c2hfbWFwICpjcnVzaF9kZWNvZGUodm9pZCAqcGJ5dmFsLCB2b2lkICplbmQpDQo+ICAJCWItPmlk
ID0gY2VwaF9kZWNvZGVfMzIocCk7DQo+ICAJCWItPnR5cGUgPSBjZXBoX2RlY29kZV8xNihwKTsN
Cj4gIAkJYi0+YWxnID0gY2VwaF9kZWNvZGVfOChwKTsNCj4gKwkJaWYgKGItPmFsZyAhPSBhbGcp
IHsNCj4gKwkJCWItPmFsZyA9IDA7DQo+ICsJCQlnb3RvIGJhZDsNCj4gKwkJfQ0KPiAgCQliLT5o
YXNoID0gY2VwaF9kZWNvZGVfOChwKTsNCj4gIAkJYi0+d2VpZ2h0ID0gY2VwaF9kZWNvZGVfMzIo
cCk7DQo+ICAJCWItPnNpemUgPSBjZXBoX2RlY29kZV8zMihwKTsNCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0K
DQpUaGFua3MsDQpTbGF2YS4NCg==
