Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64181175A9F
	for <ceph-devel@vger.kernel.org>; Fri, 20 Mar 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031342; cv=fail; b=b7Hyy8iWxlvPBB8ob7JPOgAPKmOFc9iW1GGtGDyrmA7wyYKvHvWXQVhNb9pkJ4OWSD3MhaDPjjgvNCnOhgF6oqLk//XjQ8Jfztda7mP8yJYgVMQZ7oQiVTzVzIdgOekYlFaC+PD2Vw+EcB5G51wnvJz7dzzJ9zQP9HqvTAkLmW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031342; c=relaxed/simple;
	bh=DNnrewij/Sh5Hxtl8nKBBQMwlcTkEUjcIu2xwbe34bs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GvgurtmKBLvrd9EbCeRbydjCiYXGKO2pp2Abvxkrxg9Af5j3yoMQUJJPAIYwzR1eaDHG9iBFtgpUkA66khkpLK52Ay48xuxWLZGqVHAp2YbpiveRd65w6Nb+hhqbZxeaaCx3QNyXhVbQwRNonIV7notYxgkD8+rowB7TcG30NsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IVUOI5h7; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IVUOI5h7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KI75oU693890;
	Fri, 20 Mar 2026 18:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=DNnrewij/Sh5Hxtl8nKBBQMwlcTkEUjcIu2xwbe34bs=; b=IVUOI5h7
	LsBO/9PuKl9biQEUbqFHbsQOKnwfn5LCHvVqKeBkC0vX61iNj9s++eCd/oZwE52r
	J06FW1tDRU4HCoMDILxFP/lMxDep3ypc1GC9rDMjuROjOcok3lOaeA24rc1WsoME
	+DGaH5MHZMgO/iENVnhF/JJddxvdFKW06LP2Uasgbc1Vtj2E/xbxg8ruqb0npBHL
	kyLPw4fSH+P8tN6/2JWtRR/bdByo9lH8Ug9GWPQAg7+MnIqdFX/mV2+ACuoXuglK
	b19mp9/p0YjXuRZqi+eTSKihrI/azNcZJmHPz13xqDsVdgSu9UIAXHhlBWT1cs4X
	YhspGOvDcrFGvA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauv05m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 18:28:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXjjbChQey47OUA/n8sQF9+Z0qUSe2OXMy23fUkOvWxzOZWNvWdSOersGERHCBb5a+kGEGVy9UeLhBnuM39zpMHDSBsM6HIrWzcwjt8jNzFl+AIS00/EdoPeUuOBuSDTa6SxJ0OLKU7H7txBcNtrPiNPIuUmn5vntbZfqkUjWZl5ppaVAg3vZA9Js0rXimfXuTX4G2novQ04qaXAJm/gluoOaftxu6/g3RM7wVVV59nddpRrz1Xqqz74H3GddHyeIQa7jeRyLoajpXpY9HsNj29KUD4gWlsGMtAIPQkuXE5JrKvwxAxD3VmXtfu6xRCga4B0tc3rE8fN55k0YG1HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNnrewij/Sh5Hxtl8nKBBQMwlcTkEUjcIu2xwbe34bs=;
 b=DPXAuwoWenM42IvVxqUxpUENAfYiVbSYdFrx74mK19msW1SEfY4E6QoI4GuwwspxM6vLA6BaqUCCWDx4lHZm92aBflavvstdfQ63IuG5botm9oj/8vsx+0f3Cy0qF0pJ4HdIpW1uP0SrVsqliUGQHavV9bnnt+xsqpgmBrQG8mACSHNg8bEKAzyM654TeQWniN7mGoQkgg1wbUI9S17dDqS5/iZkQhbNLS4NjrnkIOTMpUzYZq8xFPe/FdduIU9Ii/r2uY6WKwB3lEVC0n0pnVZby43DMWa6gdtfLmXyevplvv9Rbcg2izK+aPDYArdF6DBGf1e8Pu53usYH1ppe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5564.namprd15.prod.outlook.com (2603:10b6:610:141::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 18:28:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 18:28:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Fix slab-out-of-bounds access in
 auth message processing
Thread-Index: AQHcuE3f8jI8bm3MA0+qbYru8XvtfrW3viCA
Date: Fri, 20 Mar 2026 18:28:38 +0000
Message-ID: <0959410fbce95fb8f5ac25de6c751421834ae923.camel@ibm.com>
References: <4f9fdcde-f5a8-43a8-9580-6ec3402c4185@tu-ilmenau.de>
	 <20260320094154.1158656-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260320094154.1158656-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5564:EE_
x-ms-office365-filtering-correlation-id: fa3247af-6fa7-4a19-e453-08de86ae813a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 U9HPEM6iCRyIekm6zEQlGgey4ewa63KalSjpWqWs/aMiAsYxH+IyrGGfj5hPthAIY8fDGDfDFJ9PLIku6D15arJCujJsENoHoWrzZSdlJQtmEf4HtRHNDDeXBr06DbuAnVsZLzjhoKn7S5vVrOpc7LNwL+WBdWV5f9FURquF20fmrMwFEx8RspBoMxb/SPSIRtx6Q3IQM+B5L8T0OlHDbJLFSuCXubbtxNI/usTjfx54xX7oJcYaVNaTxkKBYob/yszmp5zLOTkG2p+SDFQg1BWtz7GzAu1ftiY4K94AqAyQNx2YviV2SxtyJWwNEEkUy4j2VC/qCk9iCPdjQb9Httd/5cOhldaly3xUqpAVvgvuTCwECe5BHcIMi0Gs165u7FRPuHV75NVdsijxcSri+d1bik7Eigv0JbWEQfeId0sQ4p1m3okAfLR9UdkiOB56s/quEkg00t91hJ4gPLbmLD35d9L322oAp4G1GXmyDOQ+yHOHcUyT8rwYYTs9MNZk5R79UjQI0tvoHTkyE5Ig1wXdYVzxy1QM0f1+Jc2AlnJ8+8foGOd1abYai2Q3iFX0nNuHnB6SgZZE4VNIb0ZpfOv170nJ9cVvYR3YIs+m4ek6Bpw5R8OeMW+vij04gbcc2t21VKkmhcTb+l+/YH0jpiWE6uaKHj2he9o5VZz0ZVj1lQIo5VvBjHe+G59tR77AwI+s+TElJoap9cfKWdwMaUGQLXO3D6tfTXOOCrCfIRnl5xRaHxriRHhwK/c9RtMJjoNgSg0ruVZiaAYNl04TaAidNpgGCBXwIDL006uDWg8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0hXQVU3Y2MvZlU1TmdhQkNUWStqY3VaTHJkbHFTbXByT1NlUmx4bUxiMENk?=
 =?utf-8?B?ckFiNG0xNnJ5cVpPdGNzMmd5Y1l6RlpwTnh6QWJ4bnZoaVJNWGVOcFYyYnEy?=
 =?utf-8?B?Q294Wk4rcG9xSUxBaU14R3pGb2Z5eFE3NzloclhLdGU1NXFmN0hkZkp2b0pT?=
 =?utf-8?B?dnlGL0tYY0x4TXhGbFVDbmU0SHgyTkdoVTAwM2JUSHdzbGVwbEJUQTZLU0J2?=
 =?utf-8?B?dU9kRVluckx3VVBKQW1GbWpqbTdYZ3NQaVp1eEhZT1JBSHdxajhENTN5ak1r?=
 =?utf-8?B?MjZid1YwSEE0L0wwTTVjdkJuREZJOUQwNHVEd1ZISVZXNGp1Z2pnYmpCU2xw?=
 =?utf-8?B?TWtEZ0lrTXJWQTMrcVBNNjZRMkROdDlPRHJnaEpvRnNLc3RrKzh5ajh0ZDA3?=
 =?utf-8?B?MkkrQnNFbFdiNUVOMVI5U2hMbUw4VW0veU5odlpQNjVuY20yQysrNTdUN3Jj?=
 =?utf-8?B?bG5IOHRJL2dPNitzMGFpeUZjakNLSVBZNXFzUWlMY3I2emVneWNNVWRHdVhJ?=
 =?utf-8?B?Z1JlbW9nS1B0UW5JWjFuL05udzhmUUpOVUJmY3AzRDR6VlhuRXFYbHJydG1y?=
 =?utf-8?B?VE56NUI1UzBJeVV4Vitzd2NNV09XVnFic2xJd0lmVGg2cjNWOS9BVVppQzIv?=
 =?utf-8?B?UWNwUzkxb285RHJoK2hJQmRzWVBscVNQa1hxVUg0bTdYYy9QYjdHelRPZEs0?=
 =?utf-8?B?U0tvL2o3aER3OG1iejBsQTBZUzhFYTl5aGRxRmhieXdRNGhZUW5jejZOdWJl?=
 =?utf-8?B?Sm1kRUxLdU1IMlZwREhUUjk2SDZTZmVmaVd2WjBnaUxJcHg2MmRNbDg4QXJx?=
 =?utf-8?B?azZSQ1lKZEN4bFp2K0M1ckFoYTNlaGptK2RNeFVEaE5kVkhHaWh3elVueVF5?=
 =?utf-8?B?bElCU29KSVNWS0l6aFkzTUlvc2VVd25sekJsYUVoL2x6SmE5eXcrbndCd3Fx?=
 =?utf-8?B?dzUyT2RoVUp5dGFiMDl5clEwdm9RS2lVQ3JENFc0U0p3dkRPemZrYVA0Yml2?=
 =?utf-8?B?alUrcE5wSkwybVBEdGJqTDk0TXcxbmxBVDR5SE1UNFJhdHdaTEg3VW1FTGEz?=
 =?utf-8?B?YzM4a3FHaFhHZnRtNzVRT2pxK2JhcTJBNjNBN2VwWUNWdjIrSzRPYW1kYldU?=
 =?utf-8?B?Y3VRMDhZV08raU9jRXhFZmhiVk1PS00rV0g0TnZlY3NNNUZaOFVMeFhNQlFv?=
 =?utf-8?B?WGlxdTlSWHMreWwvNDd5ejd1NXYxZnd2QnFqNkFlVUZtSFgwTVk5Q1RxdE1C?=
 =?utf-8?B?QU1Cblg3SloxZHRrMUJ3dkpWZHpsdGpIellwUDJPR2lONDZCd0ZSTVNkSHRT?=
 =?utf-8?B?VStxNmFNM3BOeXNjN0pwWExuajVuMTB2TFZPVlVJUjNGSE1KbzliWHB4K2M2?=
 =?utf-8?B?a3VJYS8xZHlISENmQ282ek9jUytFWFFhQ1hoUWpOOVlzbmlJcWRhdENKY1Zp?=
 =?utf-8?B?Y0ZtZlFqUUpFNktHbnI1UlF0Zk9lcXdOaXRxS0pHei9vNzNxQnlFMXRNalUw?=
 =?utf-8?B?VUZwaXAxRzZseVVZTDdXODZhaWs5eHowV01GYVlRUmFNN3JFSFgxSmJSWUhZ?=
 =?utf-8?B?T3NZSVBpUW1zdllURGU2TmRUZHhmWXdqQkZLMXpkWHRldXIvUDArRUtGbnpV?=
 =?utf-8?B?Yk5iUjhNeVI0VWQ0S1FRZW84OHJta3pLV20zNU9ReldoUVpMSG9QQlJrVVp5?=
 =?utf-8?B?eEVDUisvOHFHc3RPelBFL3EvaFNNMXB5WTZvSFgyZWM4b1FtZUFUbVVPaWpl?=
 =?utf-8?B?aVorOUNHcHQ2dUVnNzFrN3pXVDNwKytLRmsxNjc3Ny84c0h0K3hwaUZmZDVK?=
 =?utf-8?B?OWRobk5acnhHOTlpTjluTXUzb1FoOHJ1VHpLYm1tRkNQc1ZxTDdtTHhsMUhl?=
 =?utf-8?B?VGhhVStkeWltTG16QkorbS9zZlZCcVo4a2s4TGhjVmRTSUpwK3l1YWNyUnpY?=
 =?utf-8?B?c2NuTzZub0hLWG1LS3VVRml3NWsyWTc0VXBiNjgzUmxUaG10dTJ0SU9abWxn?=
 =?utf-8?B?T2dZWjg0Q1JSNDRoVVU4bndITDQ2UWJHOHZrRnYreEdqUVZvU2ViVXlya2p0?=
 =?utf-8?B?N3RVTGM0RHA2UTJacXdBV1d1bzNYdHNPTjdMR2duRmp6QkRiaU4rTHVNWms5?=
 =?utf-8?B?VkpZOU5odFNmejdOOHh6ZDMvVXdLelB2aVpkcm1hVUpLV05PMC9zeDRISDR3?=
 =?utf-8?B?VnpEZEU5S3NZbDl6bDJqMHVNY1k0RUpMWThTOTRETFRhazUya2Q0cHlkU1dt?=
 =?utf-8?B?Njk3SlhmYVlEUjJLaGZCalJKTFhFeDJvMVV1Q3krNmJ0dGVwbjRkTDhuN3RW?=
 =?utf-8?B?Ui8wSkdKaU5WRHJXNS9wS0dCOXVtdWZmb0JLQlVRak1ka1UvKzdWSGFVbDBY?=
 =?utf-8?Q?jfOwl9V1Ma9oXOUlDRdn93HH9dYWUVYq0RDz7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB01D912A3B2D94E806AB0E7C82A1E3B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UNae/KDCmeM2tDq7y7BDIU+xwsi0zQ4RHBFyLAtBfnpAwQKpsXjuWzT9xmkIKZ9KK/Dn/4GsvXaDStai0gfw2pgw27bgY7BxDk6j36EezMiujNz4DRAUW5n1F/CfUIDp7bXnk4utZK18TVjK/aV4p2QUPeLBltzFQ889EzOTpYN7hiuRQd0jvgLJnXvOHrgNh7f1aqPsbzBwYTgQExJ1FSd7seiFoSRJor0x4nF9HP/7gIiZfBy3g8LdbuEp7CrUJPQ0mxnS2YQry6ijLlZx7AvNeAXLrMAhyMcOO04JKW0ilFd26B7jNVz77F158TP1IjLoGjZFtKIZLdWo/RhtaA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3247af-6fa7-4a19-e453-08de86ae813a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 18:28:38.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZqOfXxqV+ilJnMKAGjEXtm1AKl0rZTWFEPPX+hLFnO/oUEWq5f3TkHTFNQQeWOy5EovDpzU55/HPZP34I99/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5564
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0OCBTYWx0ZWRfX0RtNTBHmCZP1
 aVDBWU1tSbosvPNCwHRQLtbQc03zHUlUSk83nomj1ixU35kIjKubkJuGvwOvqOJ+pv5OOBrQTE/
 iAp4NUfXUSyxOYcHw6+D4ODTIF5ZKyyx7Tcxwmc3Cq8vymOvJxXapeOiZWObQLmO1cFWwvEQIEA
 Sd3yQoswpBeefhb35yX//KBTsoPHLihfHondGklOFes99oWneh6ZpnAUiM9Yy8uFCj0UjycxVIy
 tD4mzTLdt3RAOHOIzrSC9ZWyU35IA0Q17IvszaKg1s4+aYBPHZDmq0il2Jolje0qPwn4ok0/1qC
 1LC0Rm+TCrlF3Aytdm0pFMlXLoOwVYxVgK30NfeNcvrmVaEVKfbcNwnjsYmk7PXYxs0lwH3pWM4
 Grz35EAz2DY9u86By1P/fT7qRQa38YoJW/VzKFjhgn6TBtTPfhvSY9coWFyPzSxJB/rJdNDKyAv
 KFf6ixyjyGQ0PGAOWCw==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bd91de cx=c_pps
 a=AE2032bzocsdReLOztW59A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=FKdW87WAEeayFCxRYRMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Uq-NeGaeOoPnZXqBRxqHU2XIizWeXdPm
X-Proofpoint-GUID: rjdJ4HzveM6lPI0Ehgs_ixwNzk80Lzau
Subject: Re:  [PATCH] libceph: Fix slab-out-of-bounds access in auth message
 processing
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200148

Y2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQoNCk9uIEZyaSwgMjAyNi0wMy0yMCBhdCAx
MDo0MSArMDEwMCwgUmFwaGFlbCBaaW1tZXIgd3JvdGU6DQo+IElmIGEgKHBvdGVudGlhbGx5IGNv
cnJ1cHRlZCkgbWVzc2FnZSBvZiB0eXBlIENFUEhfTVNHX0FVVEhfUkVQTFkNCj4gY29udGFpbnMg
YSBwb3NpdGl2ZSB2YWx1ZSBpbiBpdHMgcmVzdWx0IGZpZWxkLCBpdCBpcyB0cmVhdGVkIGFzIGFu
DQo+IGVycm9yIGNvZGUgYnkgY2VwaF9oYW5kbGVfYXV0aF9yZXBseSgpIGFuZCByZXR1cm5lZCB0
bw0KPiBoYW5kbGVfYXV0aF9yZXBseSgpLiBUaGVyZWFmdGVyLCBhbiBhdHRlbXB0IGlzIG1hZGUg
dG8gc2VuZCB0aGUNCj4gcHJlYWxsb2NhdGVkIG1lc3NhZ2Ugb2YgdHlwZSBDRVBIX01TR19BVVRI
LCB3aGVyZSB0aGUgcmV0dXJuZWQgdmFsdWUgaXMNCj4gaW50ZXJwcmV0ZWQgYXMgdGhlIHNpemUg
b2YgdGhlIGZyb250IHNlZ21lbnQgdG8gc2VuZC4gSWYgdGhlIHJlc3VsdA0KPiB2YWx1ZSBpbiB0
aGUgbWVzc2FnZSBpcyBncmVhdGVyIHRoYW4gdGhlIHNpemUgb2YgdGhlIG1lbW9yeSBidWZmZXIN
Cj4gYWxsb2NhdGVkIGZvciB0aGUgZnJvbnQgc2VnbWVudCwgYW4gb3V0LW9mLWJvdW5kcyBhY2Nl
c3Mgb2NjdXJzLCBhbmQNCj4gdGhlIGNvbnRlbnQgb2YgdGhlIG1lbW9yeSByZWdpb24gYmV5b25k
IHRoaXMgYnVmZmVyIGlzIHNlbnQgb3V0Lg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNz
dWUgYnkgZmlyc3QgYWRkaW5nIGEgY2hlY2sgdGhhdCBjYXRjaGVzIGENCj4gcG9zaXRpdmUgdmFs
dWUgaW4gdGhlIHJlc3VsdCBmaWVsZCBvZiB0aGUgbWVzc2FnZSBhbmQgdHJlYXRzIGl0IGFzDQo+
IGludmFsaWQsIGFuZCBzZWNvbmQgY29tcGFyaW5nIHRoZSBsZW4gcGFyYW1ldGVyIG9mDQo+IF9f
c2VuZF9wcmVwYXJlZF9hdXRoX3JlcXVlc3QgdG8gZnJvbnRfYWxsb2NfbGVuIHRvIHByZXZlbnQg
c2VuZGluZyB0aGUNCj4gbWVzc2FnZSBpZiBpdCBleGNlZWRzIHRoZSBib3VuZHMgb2YgdGhlIGFs
bG9jYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56
aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4gLS0tDQo+ICBuZXQvY2VwaC9hdXRoLmMgICAgICAgfCA1
ICsrKysrDQo+ICBuZXQvY2VwaC9tb25fY2xpZW50LmMgfCA1ICsrKysrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9hdXRo
LmMgYi9uZXQvY2VwaC9hdXRoLmMNCj4gaW5kZXggMzMxNDcwNWU1OTE0Li41NTViMWZhYjQ2MjMg
MTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL2F1dGguYw0KPiArKysgYi9uZXQvY2VwaC9hdXRoLmMN
Cj4gQEAgLTIxNSw2ICsyMTUsMTEgQEAgaW50IGNlcGhfaGFuZGxlX2F1dGhfcmVwbHkoc3RydWN0
IGNlcGhfYXV0aF9jbGllbnQgKmFjLA0KPiAgCWNlcGhfZGVjb2RlX25lZWQoJnAsIGVuZCwgc2l6
ZW9mKHUzMikgKiAzICsgc2l6ZW9mKHU2NCksIGJhZCk7DQo+ICAJcHJvdG9jb2wgPSBjZXBoX2Rl
Y29kZV8zMigmcCk7DQo+ICAJcmVzdWx0ID0gY2VwaF9kZWNvZGVfMzIoJnApOw0KPiArCWlmIChy
ZXN1bHQgPiAwKSB7DQoNCkZyYW5rbHkgc3BlYWtpbmcsIGl0J3MgaGFyZCB0byBmb2xsb3cgaG93
IHRoaXMgaXMgY29ycmVjdCB3aXRob3V0IHByb3RvY29sDQprbm93bGVkZ2UuIERvIHdlIGhhdmUg
YW55IGRlY2xhcmF0aW9ucyBvZiByZXN1bHQgcG9zc2libGUgdmFsdWVzPyBQcm9iYWJseSwgd2UN
Cm5lZWQgdG8gaGF2ZSBzb21lIGNvbW1lbnQgdGhhdCBleHBsYWluIHRoZSBzaXR1YXRpb24gaW4g
bW9yZSBkZXRhaWxzIGhlcmU/DQoNCj4gKwkJcHJfZXJyKCJ1bmV4cGVjdGVkIHJlc3VsdCBjb2Rl
IGluIGF1dGggbXNnXG4iKTsNCj4gKwkJcmV0ID0gLUVJTlZBTDsNCj4gKwkJZ290byBvdXQ7DQoN
Ck1heWJlLCBkbyB5b3UgbmVlZCBqdW1wIHRvIGJhZD8NCg0KPiArCX0NCj4gIAlnbG9iYWxfaWQg
PSBjZXBoX2RlY29kZV82NCgmcCk7DQo+ICAJcGF5bG9hZF9sZW4gPSBjZXBoX2RlY29kZV8zMigm
cCk7DQo+ICAJY2VwaF9kZWNvZGVfbmVlZCgmcCwgZW5kLCBwYXlsb2FkX2xlbiwgYmFkKTsNCj4g
ZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBiL25ldC9jZXBoL21vbl9jbGllbnQu
Yw0KPiBpbmRleCBkNTA4MDUzMGNlMGMuLjcyMDZkYjVmNzY5NSAxMDA2NDQNCj4gLS0tIGEvbmV0
L2NlcGgvbW9uX2NsaWVudC5jDQo+ICsrKyBiL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiBAQCAt
MTc0LDYgKzE3NCwxMSBAQCBpbnQgY2VwaF9tb25tYXBfY29udGFpbnMoc3RydWN0IGNlcGhfbW9u
bWFwICptLCBzdHJ1Y3QgY2VwaF9lbnRpdHlfYWRkciAqYWRkcikNCj4gICAqLw0KPiAgc3RhdGlj
IHZvaWQgX19zZW5kX3ByZXBhcmVkX2F1dGhfcmVxdWVzdChzdHJ1Y3QgY2VwaF9tb25fY2xpZW50
ICptb25jLCBpbnQgbGVuKQ0KPiAgew0KPiArCWlmIChsZW4gPiBtb25jLT5tX2F1dGgtPmZyb250
X2FsbG9jX2xlbikgew0KPiArCQlwcl9lcnIoInNlbmRpbmcgYXV0aCByZXF1ZXN0IGZhaWxlZCwg
YmVjYXVzZSBsZW46ICVkIGV4Y2VlZHMgYWxsb2NhdGlvbiBzaXplOiAlZFxuIiwNCj4gKwkJCWxl
biwgbW9uYy0+bV9hdXRoLT5mcm9udF9hbGxvY19sZW4pOw0KDQpJcyBpdCBwcm9wZXIgcGxhY2Ug
Zm9yIHRoaXMgY2hlY2s/IEl0IGxvb2tzIGxpa2Ugd2UgZmFpbCB0byBzZW5kIHNvbWV0aGluZyBh
bmQNCmV4ZWN1dGlvbiBmbG93IGhhcyBubyBpZGVhIHRoYXQgd2UgZmFpbGVkLiBZZXMsIHN5c3Rl
bSBsb2cgd2lsbCByZWNlaXZlIHRoZQ0KZXJyb3IgbWVzc2FnZSBidXQgdGhlIHJlc3Qgb2YgdGhl
IGxvZ2ljIHdpbGwgY29udGludWUgYnVzaW5lc3MgYXMgdXN1YWwuIE1heWJlLA0KeW91IGFyZSBy
aWdodCBidXQgaXMgaXQgbm90IHRvIGxhdGUgdG8gc2ltcGx5IGNvbXBsYWluIGhlcmU/DQoNCkFu
ZCBpZiB3ZSBkb24ndCBzZW5kIHRoZSByZXF1ZXN0LCB0aGVuIGNvdWxkIGl0IGFmZmVjdCB0aGUg
d2hvbGUgZnVuY3Rpb25hbGl0eT8NCkNvdWxkIHdlIGludHJvZHVjZSBhIHJhY2UgY29uZGl0aW9u
IG9yIGRlYWRsb2NrIGhlcmU/DQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICsJCXJldHVybjsNCj4g
Kwl9DQo+ICAJbW9uYy0+cGVuZGluZ19hdXRoID0gMTsNCj4gIAltb25jLT5tX2F1dGgtPmZyb250
Lmlvdl9sZW4gPSBsZW47DQo+ICAJbW9uYy0+bV9hdXRoLT5oZHIuZnJvbnRfbGVuID0gY3B1X3Rv
X2xlMzIobGVuKTsNCg0KDQoNCg==
