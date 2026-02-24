Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A91F03D7;
	Tue, 24 Feb 2026 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894019; cv=fail; b=i7sOh3Yo/+OOqFyRwdfL7E1xQ4w5EZO1eaTdUy0loeGA7WBXJlPAn/4wWBot26+JI37FrCv0IhVGbOeCtkpzTeNaRgCgjRUk/s8X5ALOf2PvPWqn//GEcX8VsqXuPigtj44dcd5jypyAN4zCKVOM2tXe0VKcz8aEzxdIQTKZz0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894019; c=relaxed/simple;
	bh=bRw3oxDNM3vu/ppoHsVjYVQw7a6Qv74Ifpy9fMd05CM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LiJ2S7BY366JekyhxzwBtOT+lrP+PN6m4A89GxAdoqHAXt9SEZXjzBq4L2M9S3UtCJ27MuqzRlUzSoMBmdWp3PzUR2n89mvkRYGH8KEGHntmEdteKHQkSpDlaE4Hxrv6cK/qwNbYPw9lgd+Ph/7SSDewQC+ubLyIdaoGYfhNJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SEkXiQGF; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SEkXiQGF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCeDUg2221454;
	Tue, 24 Feb 2026 00:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bRw3oxDNM3vu/ppoHsVjYVQw7a6Qv74Ifpy9fMd05CM=; b=SEkXiQGF
	hvUBJy92DBztjETxeflYAHs53J3OLYzbc9gb6wukrw+j/TeYeZsLqYDVVzSL60Dc
	8P8GaAml469pt4Gkyy42xxBc4kfb9yKDP5lzPtcVdzu7Q+VA8iLnH/oTT0GUUNPg
	ALSl2cgiuo5vBxircWtG0VDWWV30ECZp74e3HEzd0NF35DySakuDtPm94iu/UWLQ
	XH3G0k488RTPJV9WZkasXhqP4GWEhHMuJ3MkOPhpkWDkXIsvWt+wjYLLHnM2N2rS
	NqpXJ29z0svjyKkOhKJr819IvJLLN/sVlHvOujhpK5ffUG2d8OjfKXZv/AcA+FWS
	9kBEpBt8iHcaNA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c0x27-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:46:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6t2gbg4kUAv7KKhRRhkFyB63hv9NYGevkmtOW1mE8OIPjMEa1fHzbTQAIFX6EFifoGmAjhxKmIh+WIICZzvuRn2LKvIfWu84GcYw6pl5ZPPDBQW/bQ5cum0Se6AgQOjM4z84uEtYR6lA0YTNe4O4qsiqxSD+XI3dSWrcVyFE7J9p5fbzcAKLzpPQb14ey/WfLXpWqUPvew+d+Gqg2fdKqDYKK4UVK8JDG8BBJ5iSxUkK8nnC2PHfI0DGR+8GZpIu8Yl15/WUIduKXiN2sYu5nTWwzTcj+6ffaSVq2BpQiNxxsMeF1Gn8gthRGeQ5ZmoN/DY0pSwyqgR8Rl4ZZ1V2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRw3oxDNM3vu/ppoHsVjYVQw7a6Qv74Ifpy9fMd05CM=;
 b=dCcVPk10vstG4gCqZ6DWuCrZj1YhTEyx44BLvdc6Lke8OZ1xR7sRkeR3E2BKvuVQE3ABs9q55VJr82izIijppfA/YaBEU+ALFvgh7Nu5hVoq8D53kVRvILKI5CaKXZwPsHJgeK8uU1bEjoWfKLVY2cYi116YE3LCa+qvA+ggRG0z6KdOAX8/NX4fBECof+Gnejf/WUk6xNzkWIxJSueu+/cRnVVNPzy9ZzopXPuN5Ae11kU2SWl3C7k5L5oHlz+QnBInC7/2m8tfHp82thr+jZK9HfsPD5UHYNIAR4bllFgiSax6G2NiT7L6iBB2kUkz3R104ulGz6M64Bg2w2p1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB4051.namprd15.prod.outlook.com (2603:10b6:208:274::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 00:46:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 00:46:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "kexinsun@smail.nju.edu.cn"
	<kexinsun@smail.nju.edu.cn>
CC: "ratnadiraw@smu.edu.sg" <ratnadiraw@smu.edu.sg>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "xutong.ma@inria.fr" <xutong.ma@inria.fr>,
        "yunbolyu@smu.edu.sg"
	<yunbolyu@smu.edu.sg>
Thread-Topic: [EXTERNAL] [PATCH] net/ceph: update outdated comment
Thread-Index: AQHcpMbUKb/j0Pcb/USDZRTuHrgmkbWRBIEA
Date: Tue, 24 Feb 2026 00:46:37 +0000
Message-ID: <813085a960ca0fdff633236cbc0e5a6f3026b111.camel@ibm.com>
References: <20260223131507.901-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260223131507.901-1-kexinsun@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB4051:EE_
x-ms-office365-filtering-correlation-id: 92ab40ba-554f-4533-6c7b-08de733e2ac2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlhFUGRkM3lyNUc2TmF3OVcvUG9UTzFwa1RLNXcwRS9UZUhaVWVnN24zQ1Nk?=
 =?utf-8?B?M0pleGpHZW4vOXBaa2RkREhhOHQxL2luLzRwMnphaWtIc0RqU1FkUGI3VmN5?=
 =?utf-8?B?ZDZNMDA5VUlwSU55WVRHc24rS29na2FwdTZ4cFhPanNnUU43eHlaRDNEQ3lx?=
 =?utf-8?B?VVcrWmpjSUtrWXpsMXd0UkNLQ1JVKytzYTAxMnZyVkl1N2xhV0M3QktwbnN4?=
 =?utf-8?B?NjN4UFhGZU9KMGFSYWlDR1dpbVdoQ3lGekRRVEFTK2ZneEZsTFN4bkQ1dnRL?=
 =?utf-8?B?Q0h6RktwNW1qalFOem5qZCtRVWpaMUJ2V1BIbHFNTnYvN1ZpWG82K3RjS3M4?=
 =?utf-8?B?WUg4S0ZObEpyOVBFb0FYZTdsRkNMLzdySlFWUVA1Y29NbWxvcVh3cmRadFdh?=
 =?utf-8?B?TjgyOFBVM3JIY3pEek5RK1FnWXVlZldVeWpOQ2ROSGdhVmVBN2o0cUtyOSsr?=
 =?utf-8?B?MlZSMzVrQW93bXhmSG03U3M0cGJORmhINzdiRjN5V0Z4M29taDRmaDkzUk1D?=
 =?utf-8?B?WHZzSlJzWG9iSUhUVkVoQmE3alZ1K29VSGdkWXJWcDN5MG5rNEJhRldHVUc3?=
 =?utf-8?B?MmlUdzhGcERGYWJGKzZkZGJUVDRGbEl1V20vWGVzYVBKajdUUXFnUnZ6M1N5?=
 =?utf-8?B?MVJ4RHZXQXJaa05VcVhCVHlmSlJ5UFV2TFJlT3owQ3U5WlNFOWZGZ0xWbWY3?=
 =?utf-8?B?L2hqUVMvbkxnd0wxRlNQWHZpUG9LMlpKNHlWTkhHVG1zQ2EyQlJWWSszc1d1?=
 =?utf-8?B?dzMwNTBhTjlwNm1wR29ZL0Y2RzhCaGhFNmhsdnF3a29zaHQ3SE40Qk83bTIz?=
 =?utf-8?B?cWl5Z0R1ZllzazA2bDV3bDViMFBYVXJHcVpBdmJIdFVvUE4zWDhJKzRKU3VN?=
 =?utf-8?B?ZHJKUlRxOExYdnIyN3Z0RlpvU2N2Mm1aanp0bmRTRDRmWll6UXdjVUJMenpw?=
 =?utf-8?B?anFlRzdiTU9CTkVZUlRScHI0Qk9nS3ByUk8vQUZPcTlWRlFlUVFlMnlLU1ZH?=
 =?utf-8?B?cTJJUTU2bGFadUNZcmJlOVR6d1RJWlAxSTkwY2dpVE5uSEhtclpVcm1XK2hP?=
 =?utf-8?B?bGFyL1ZoaHlvck4xRnR1SlJNYUxBenlObENEcEhaY1NpWGk4aGRtclFHTW5w?=
 =?utf-8?B?NFNBUVJLOGJ1ZTRzVFk1cUh6bG9qN1RyenNvZURmckRkSVAxeXRRTG9xYkdU?=
 =?utf-8?B?ZDBtUzlERVZZb0NqVzFRcGpBZGtZZU0rZzFnNk1ZcXhwakgrTGRkaXVuQVFS?=
 =?utf-8?B?L0lTenBMT3htMEVocTIwbU9WS0x4N1VERHdCRGhIQjlmSmdBY2M2bENqUmVF?=
 =?utf-8?B?blZBVkMvdzFOc0IyR2MvU3J3VFNta2t0Q1F1MHU0K1RzS0pCemtsT2M5ZmJP?=
 =?utf-8?B?TlBSNGlMbVdTUTlXaXVCOGZVZnpiWW56TUtqOWMyREs5Z2dxbXRMMmR5YzZw?=
 =?utf-8?B?eEY4OFdxSC96RWZJTFFDTmpUNzFtMUhaZkV1L0xZdkNpR2RqZUdCYXpwelM2?=
 =?utf-8?B?QW5hdUFGVE5xS052TjFMSk84cERTNVg0d1JHcVJVaE5NQUhlTjVhSWxwTzMv?=
 =?utf-8?B?MTEwYkpwNzFpVUJjYW5jU1dVZStPMS96L0VwazdKWEdVVXJ0TXhtRkxneVhz?=
 =?utf-8?B?NE13MEtPRmZEcks1ZURmN2liK2lDd201TjBlVm5LY3JnSlFZRFlYR1Z0V2hN?=
 =?utf-8?B?TVZJTVQ5SW1ZbldDMTFHUVZFMUJqV2ZETUQ5UGhVSFlCS2VPclVRZWV5bnM0?=
 =?utf-8?B?VmVwSlVnM05waXVvSEJtV3VJRDBITnF3ZWx4ZXphMVdNRGlBZU12Nk5EV2Jh?=
 =?utf-8?B?ZWVqU0hOdVNmLytvQ2wxa3I4L2VzVTU0eW9jWE5QUXIwQkVLNmVEMHQ1TExi?=
 =?utf-8?B?QXV3K004bjY3NkVqQWxFRGU1NThpcmUzam41dVR0cG50RHF6WTlaRlBrd0Rk?=
 =?utf-8?B?WUJiNnZqVUk2bmUyTDRkT3l0NE9yWWprK3FPY21pZHYxcHJhRmFITlFaYVNr?=
 =?utf-8?B?QmI1amdLaGZlbzkrdkpEYWZuWUllY0poSGFFb1V6dXFrbUN6MThYcU56WWNn?=
 =?utf-8?B?ajhGZnZkNytOdUk5bEV1bzdoa2xZSHF2REdkWWNHQlNsVjBudUo3bnZ0KzRn?=
 =?utf-8?B?TElBNHpHaEpPTGpIRVF6YWhlTWZyMlU5bytxZ3FMelhnUTNIdi9sQldiWnpl?=
 =?utf-8?Q?5vszxHYGP8u4mZkUWsT61xg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0lBaVBNT0t6ZHV2aURZYzYwVzQwZGZadFZ4L25BU2F2dXphUCtIUEpSeDhY?=
 =?utf-8?B?dkJaRVJ2SGhUUmJjQ1hDL1doay9TNlBTS2d6NG9CWkJ5eFZFUFdlWHl3Yyt5?=
 =?utf-8?B?U1JzaVBRZHNjMTIzS2pyNlpQT09GZ1ZuUXorbXcvRGk1TGU1a0pTa3dQQVc2?=
 =?utf-8?B?Zk9XK2NTcmJURDRldDAyVkFSVDJua1NuSkhyS09uUzgwZlhmWGgzOFBLcC9y?=
 =?utf-8?B?VzY1WDEwN3hpY2lNZGt1azQ4a3Vvc1NHalJ1dndDRlgvTFA3YVZzMStSSjZ4?=
 =?utf-8?B?eWF0UDZ2TFNJb2YvamR5TGphVzFzODhwSFY3WW56Wk1lbTh0c3pjbjdBK3VD?=
 =?utf-8?B?U1MzZUVjUEp1MktUVjJCbXphT1FyQkpuc0t5Q0ZVSDZJciszekhuOXBqMTJr?=
 =?utf-8?B?bUdnOWFGUnFSb0cveFlXL2ZOaGtQcTU1VTFwUmF0azdZbDBEdlVZUmhJdVhP?=
 =?utf-8?B?UHBYaGxPcmY4WGQwQVo3MzViZ1VPRnVxakU2WlM0Q0lhakpoZXVsYU8zOGVs?=
 =?utf-8?B?dlE4eVpsT1hyVE1MYXQ2KzltbjVmdlo1TGt5K0orZmNFbEU0K1VHb0hjVFVQ?=
 =?utf-8?B?WkJ5WjJLNDRicFMyQTc3N3lnT1BwUkFOd2JsWnBMUWJJckE0bHZUMG50TkZy?=
 =?utf-8?B?anEvMGtNalp0V044UW1wcnByd0N5b1FGNGhFL1RzVk5KUzNqM1RFTllra1Vt?=
 =?utf-8?B?cS96cDBuc0Uxcm1UTXBxdVdEc2didlI2K0lsNGF0d25WVDZrNE1QVWpkQ1FK?=
 =?utf-8?B?am5SeFVUVHFPTFI3WEt1SnFKdTNLeUp1dXQ3YWRGVmtDSmlQUCtZamZITy9H?=
 =?utf-8?B?ZnNqUGRxU0w2cC9qR1YrejBybnZFSTFYQ1lJbzVicVRVNXRPK2RlVmhjWHdZ?=
 =?utf-8?B?Y05PczNXaFQ1ZGEybjl5bjdRM3RENjd5MDFXT0p4ZG1KV0J6c2hmOVZxakJZ?=
 =?utf-8?B?a0xkWndUalc1U1h0V0ppaS91SFpXdEJtMEIxbTRzTXJoWnRIeXR0VmhxT2tp?=
 =?utf-8?B?NWNOT2RUQlY3Q2lhaklTWjlzcmdIZjNxTVhqeXVsQzlCNXNFQURKc0hBL3N2?=
 =?utf-8?B?Z0VjVzNseExrSU5TRkVsUEVqdE90OEY1b25uTU5kRENIRmwyVTBBYko1ckEw?=
 =?utf-8?B?dVY1Q25hbW04OHhnRGdQcEdGMjBqemhhUlkzUjJTQXhOUi9HdlM1U3lkTnVh?=
 =?utf-8?B?NkJuWkM0bDAzdE9lb0t1bmxsbHI1S0l1MUFwbWVGcHFYd2EvWktqaHFxOEdM?=
 =?utf-8?B?WExrRGxPTlU0b3pOUEsxQ3NoOEt3K2VJOVhSbEdSeGQvb1c0cFFBa3l0b0Vs?=
 =?utf-8?B?dWlWUVJZTDcxMXhsM2NtdWZCc2Ftd0d2YW9XSlRxU04zc0ZmbmhKcndNL2pu?=
 =?utf-8?B?SllHQmNRT1N0SkJBQlNZT09WUlRJc3MreFNHYnpZSURZdERrVDJKSm5NSkw4?=
 =?utf-8?B?LzFadDJ3T09lLzI1dXQ3U2YweWtmclZJM2wyNXowQUdhTFYyMjNqL1R2UE1W?=
 =?utf-8?B?SzROd0tKb2hJaXZmd0dhd2hvcVZUUkdjS2M0KzUrWVd3K3kydjRhWlJocHlM?=
 =?utf-8?B?cGJLTW5lZ3RjVXRBcjFnTFE3TVhBV3Rwa3ZDTlR6SmxlWS9MMTNxTDhtYnBL?=
 =?utf-8?B?TENuRWtEUHB5ZkZ0V3ZpRzVhUlk4MjVYTVFDVDF6VDQrV1lFakljRk04M0VI?=
 =?utf-8?B?MXRFcG5CdjVOL1dHcWlKZjBlZXlaeHhGTmhvdWo3SGwyTWdQb3dCcFZiay85?=
 =?utf-8?B?b2taemhrRDJjUis0T3d5MEJHU2trMnJsNTRob1pJZEFwYzhwemkvR3lJQXE2?=
 =?utf-8?B?eUFYbFBsU2JBWnNTbjFaSGpaSFhKNkdiT0NIMEdqY1hCWkNrUEU5ZnVmNUt3?=
 =?utf-8?B?dGNwK29hblFHZngrVEVtaVVCNVlMcFMvSE5Ma2lNTDVVa01JV1Z3R0U3a3NW?=
 =?utf-8?B?RVVRT1BKVXdCVXN5WGJ5MEU2T3RiUGVzczI3TnBHaUQxVXZyanR2dHZ3UjI4?=
 =?utf-8?B?R0M4MW1kTGxlTEY2Yy9rcGM5Q2YyNFEySGptZGVGZEpHRm1TWEVTY2NxbXNu?=
 =?utf-8?B?ZCt3dUJ3S1AzVzVCMjNTZUUrbUMxOC9Gbmc0VkhuV0ozUTdEQVpmMkhmWFJ1?=
 =?utf-8?B?OExSSEZlbDkwN0lhSkdQd0tiNU5sNUFza3MxT3pyTmhTU3BvWHYxS0dCM1l3?=
 =?utf-8?B?dHlrMkw3SldtWnNtaFlhRWtFYjRyYXEra2xqaDJVRjJrVmx2c09ZWmpkN3J0?=
 =?utf-8?B?UVdWY053dkZkb211RWlpVFpjcXRjNU56S3VmbXJoTmMyaWo4TEdKdDFPV01t?=
 =?utf-8?B?aHNwUTZvUk9raFZMME1md1FBZTB5c1Z3VGc0V3lOd2loYjBHZGFIWFZsNUx3?=
 =?utf-8?Q?eTIOhqCv/FNRk6df+0IwTCUlfvguEMKTaHjTP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAD7FF886A8B5049990CEFABD6264916@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ab40ba-554f-4533-6c7b-08de733e2ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 00:46:37.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IGZItkOjiDm11w3hXq0li0+kmrI+yZILc65zKrhxUil7eWEKUU3bsXOq9+E3GVlS9gGN25xfJ7PLitp4vvSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4051
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMyBTYWx0ZWRfX6MTPp/XW/W6T
 WPw4mNf8EMG+ZTVE3HiQu9I9xW3ScME5GM4q6zEBQKW8jOlVuHylKHgVQQ/3Z4+na13E+iGRsh/
 OwSkP4oN2V1dtNlC1M6JUj9XmAnHqGDLLDtxN/ouMK8xskOyOthpM+QdrpH8HmTK6EpmAhYva0o
 cJ1SzHBChAK9Cjo4CcTm7ryaFMLEmuKuSZySu5yHgDLtCnc7suMADCjRo6MTgQxEHaw80MqSLg8
 2HWHr9s/OuIMRxl5rezKcMgx2PS2yQyqztsfMghPqESxMg+XtWdzPO0catlmunZsCN8BlmrH90I
 +XXWav/3/9LctJhcqHkH4LgD1QgaPu/y49QJ7tCKv0Im7N9cgLfBY94z8j91IM8mswTfizTLgQT
 dcNPUllFNAMBRbc4guq+Z/bsyuZvBy2VJMN8tb3+fl6JkWZlHULC/yeHcK1Zx/lqs/9xhwxF0u7
 FPtXC/uY3eDqzgN4PYA==
X-Proofpoint-ORIG-GUID: ztpF3Oc-694KaBw8sI-tgM7pgo2Dvlq3
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699cf4f0 cx=c_pps
 a=cEhcA1GRg4KA0mca7hj4fQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=aPzpeVmvhMQvvlGobDAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dTX11XUBpf4Gs_V-xmJEzpBIo8q3luMA
Subject: Re:  [PATCH] net/ceph: update outdated comment
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240003

T24gTW9uLCAyMDI2LTAyLTIzIGF0IDIxOjE1ICswODAwLCBrZXhpbnN1bkBzbWFpbC5uanUuZWR1
LmNuIHdyb3RlOg0KPiBGcm9tOiBrZXhpbnN1biA8a2V4aW5zdW5Ac21haWwubmp1LmVkdS5jbj4N
Cj4gDQo+IFRoZSBmdW5jdGlvbiB0cnlfd3JpdGUoKSB3YXMgcmVuYW1lZCB0byBjZXBoX2Nvbl92
MV90cnlfd3JpdGUoKQ0KPiBpbiBjb21taXQgNTY2MDUwZTE3ZTUzICgibGliY2VwaDogc2VwYXJh
dGUgbXNncjEgcHJvdG9jb2wNCj4gaW1wbGVtZW50YXRpb24iKSBhbmQgc3Vic2VxdWVudGx5IG1v
dmVkIHRvIG5ldC9jZXBoL21lc3Nlbmdlcl92MS5jDQo+IGluIGNvbW1pdCAyZjcxMzYxNWRkZDkg
KCJsaWJjZXBoOiBtb3ZlIG1zZ3IxIHByb3RvY29sIGltcGxlbWVudGF0aW9uDQo+IHRvIGl0cyBv
d24gZmlsZSIpLiAgVXBkYXRlIHRoZSBjb21tZW50IGluIGNlcGhfc29ja193cml0ZV9zcGFjZSgp
DQo+IGFjY29yZGluZ2x5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieToga2V4aW5zdW4gPGtleGluc3Vu
QHNtYWlsLm5qdS5lZHUuY24+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvbWVzc2VuZ2VyLmMgfCA0ICsr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvbWVzc2VuZ2VyLmMgYi9uZXQvY2VwaC9tZXNzZW5n
ZXIuYw0KPiBpbmRleCAxMDhhZGI1ODM3NDQuLmEwNDE3MjVkZGVkZiAxMDA2NDQNCj4gLS0tIGEv
bmV0L2NlcGgvbWVzc2VuZ2VyLmMNCj4gKysrIGIvbmV0L2NlcGgvbWVzc2VuZ2VyLmMNCj4gQEAg
LTM2OCw4ICszNjgsOCBAQCBzdGF0aWMgdm9pZCBjZXBoX3NvY2tfd3JpdGVfc3BhY2Uoc3RydWN0
IHNvY2sgKnNrKQ0KPiAgCS8qIG9ubHkgcXVldWUgdG8gd29ya3F1ZXVlIGlmIHRoZXJlIGlzIGRh
dGEgd2Ugd2FudCB0byB3cml0ZSwNCj4gIAkgKiBhbmQgdGhlcmUgaXMgc3VmZmljaWVudCBzcGFj
ZSBpbiB0aGUgc29ja2V0IGJ1ZmZlciB0byBhY2NlcHQNCj4gIAkgKiBtb3JlIGRhdGEuICBjbGVh
ciBTT0NLX05PU1BBQ0Ugc28gdGhhdCBjZXBoX3NvY2tfd3JpdGVfc3BhY2UoKQ0KPiAtCSAqIGRv
ZXNuJ3QgZ2V0IGNhbGxlZCBhZ2FpbiB1bnRpbCB0cnlfd3JpdGUoKSBmaWxscyB0aGUgc29ja2V0
DQo+IC0JICogYnVmZmVyLiBTZWUgbmV0L2lwdjQvdGNwX2lucHV0LmM6dGNwX2NoZWNrX3NwYWNl
KCkNCj4gKwkgKiBkb2Vzbid0IGdldCBjYWxsZWQgYWdhaW4gdW50aWwgY2VwaF9jb25fdjFfdHJ5
X3dyaXRlKCkgZmlsbHMgDQo+ICsJICogdGhlIHNvY2tldCBidWZmZXIuIFNlZSBuZXQvaXB2NC90
Y3BfaW5wdXQuYzp0Y3BfY2hlY2tfc3BhY2UoKQ0KPiAgCSAqIGFuZCBuZXQvY29yZS9zdHJlYW0u
Yzpza19zdHJlYW1fd3JpdGVfc3BhY2UoKS4NCj4gIAkgKi8NCj4gIAlpZiAoY2VwaF9jb25fZmxh
Z190ZXN0KGNvbiwgQ0VQSF9DT05fRl9XUklURV9QRU5ESU5HKSkgew0KDQpNYWtlcyBzZW5zZSB0
byBtZS4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0Bp
Ym0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
