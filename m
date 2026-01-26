Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92146BF;
	Mon, 26 Jan 2026 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468063; cv=fail; b=MroZCsjPs8JwlzFqamhNeahbKoHuL+Sy7HuBHBhxdvS57M7tmVjapnzR4AS/M8cPHujBkO0xmV66VrINgV//z9rXm5qh3RUR7uYNMFgDercwIznxXVLDrZ2B96HGqs2UQf3ZksYsuadLEkP2XDQbmSoenN3319c6RUGnoqimFSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468063; c=relaxed/simple;
	bh=zXpIR0r59ySzSKvOR/JrJk6QPJUUYWCzH7Gw0vj5/xU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=N3VMZinta7RLj1AwjYc+isFZIilw4oeLU7x0G4vNBoNhGXVALXaVvq/wo7AnN+oIxxxnVw6Hja68vtMq27ItabO2YBs01LdaIFOFc+DWGHvADlD/UPSpcbvbsJFSIXQWKZF66AhimG3m9t0BDj/dZODsjWT0vGYO3He6QFbP3uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STyywP6P; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STyywP6P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QG6TnC031963;
	Mon, 26 Jan 2026 22:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=zXpIR0r59ySzSKvOR/JrJk6QPJUUYWCzH7Gw0vj5/xU=; b=STyywP6P
	g/PN3NElPpnjvqCcr4Ap1Bcpzi/gbXZ5s12kc8SukQmoBQ+wvb/+rZrDVPR44Xzx
	kvwIAyBSEghzYmJH/izgX1+Uo1+EImJInynHWqbszSv4j3SEVY80ixLewRWibnFE
	LC+4nZIs8JcnIhmVOyUkMb6R/YI3ax1pz7UOa23ILd/mMCVVZJS+RsF9eUJjA5lr
	LapBVKabnWedjzqj97YD8HtT9HX5FrRQlu/fOV9q2BFLXofwCZAkArRGCwqCwGIU
	s258pqm4vPlErd3PpmEbrFswbDp8LCitR9EamIXF6CtStjC6KkV88pq5lQyTyfNt
	CS99UQpxBDPNSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6tfh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:54:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QMndlf014277;
	Mon, 26 Jan 2026 22:54:17 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6tfgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:54:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srefo7/NXTyKYImO8Mayfuf/n5Ua+FdPIjalhTRGI84RcSX38hpMmfwiLRIcx+EaDfKrZlDN1p6XKtmFLyVaXvZU3L2PJZVw+kVhgBDPwWZt/owwufgruvCzD3GCirWbPLZwytMApwxtEUFUH377dtyZiDKuDbyEZ9DYX6+MJduzD5griCQDlVmbbITWHgOLZbZtK/BBK40jtJPBvA+xW5d6F6CSl/fPrHNIvDTZT5UerDkK8JcdVvWVwDfugzjP37OUDJH4wgVJN+gsWdOuxgIPOeJWaGH4Xf98pLoMN1HKsrtbjkhd5KQWHF32cqvHlBqIQjazVl+8EDwAOeL4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXpIR0r59ySzSKvOR/JrJk6QPJUUYWCzH7Gw0vj5/xU=;
 b=TVcn6RkQpGcMDHR+kKMUgha7FSwt2JqAaxznraH4NyJ8TpEJTdkVN6uC7l+OnAfP2GZOX2tDZmnnZPeA3Axzho1txzKSSjJwxjYz5UcilwlVNRfT3VDcF2bN3V46F0szZyaLSAZd8P85xkrs2844/+yJyIPql+bbdLMj2r1NBxdrYauAk9uDcvtwWHzHw/KI/gEq3d3wWJRlKURW/4yk05HvJNrmn3CHNJTCnLbUGufUnNUgxFTpgrf9rwjxHxRN6tpo8az1EGddQRhW0Ukgd+kjdbil6L0z6zzy7PtyknD2/S2kHz4MdzQ9iermF2CPl8vKYFojZYrDzmpVLIVQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5531.namprd15.prod.outlook.com (2603:10b6:930:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 22:54:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 22:54:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>,
        "cfsworks@gmail.com" <cfsworks@gmail.com>
CC: Milind Changire <mchangir@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3 4/4] ceph: assert writeback loop invariants
Thread-Index: AQHcjmvcnfu7f0RpWEugWtUtNu2iCbVlEIgA
Date: Mon, 26 Jan 2026 22:54:16 +0000
Message-ID: <345540f12f8825ebbe067564fbd94bc1966e126b.camel@ibm.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
	 <20260126023055.405401-5-CFSworks@gmail.com>
In-Reply-To: <20260126023055.405401-5-CFSworks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5531:EE_
x-ms-office365-filtering-correlation-id: c26fd64f-c00b-4159-33de-08de5d2dd50a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFNRMnZ0dTU3ZXc5b1RXdjRrdkVSSEE0Qng3eVhYSmQ3dVhIQWczd0thOUMr?=
 =?utf-8?B?S0RZWlZTU2Z1TmhSdytSOFpVMGRmK3QxaHRDTU9wSWJ2UzZPbTNYUUQzVVcz?=
 =?utf-8?B?UVJhL1ExWG8wZmtZd1ZkdUM0UWVnN2tvWjVodTJZeGlUYkxjTUJFUWphWEsy?=
 =?utf-8?B?SzJXL1BaUWtBb0VBdGxwU3hBRUg2N0RPZjVPaEliZEt2ZCtHeDVVT3o1M3Jw?=
 =?utf-8?B?a1c1Nzk2ZHVZN1IrUFhHazRjczRpVFN0Y2pzazJpNTFwNXB5eFN4VldFdG9T?=
 =?utf-8?B?SjViZHEyU2x0YTN4R29kZ1FuMXFaWjJuN1VMNzdnOStuRGNpdjBPNVVPZEpn?=
 =?utf-8?B?cWZLeWxYNmtyOVNlN3lFUUkvN0NjSEc1TlVCWkJsSUdwTEcrekZjOGhzRitT?=
 =?utf-8?B?c3UwMVBuVnNYUkV1ZWVZQlp3Q0dyRi8yMWR1R01RL3orR1p2dXQyNThaQTZk?=
 =?utf-8?B?RklZU0Z4dklxRG1ZSk01dU5FTDc1ZFp6YTJPOVNobVgyWlJHM1pMRFBJUElO?=
 =?utf-8?B?NTR1ZXVKZ3JJVTVHRTRPZU85L2ZZQlpGQ2FINWZsdnN2TzNEOStVNkxkcU9p?=
 =?utf-8?B?bkhnK1BuWStKWUJXdTdjK3VabXYxUmRhb3lONEdmNWh5ZTdxZytQN2Jlalha?=
 =?utf-8?B?UTZKTjZ2cDg3QmcrL0FhWlQvSXVISW5zZkZlRkdiT0poTUhDU0w2N0VpT0Vq?=
 =?utf-8?B?WmdoOEhrdThIcW81aG1zRkVDb21IN2JLbGNsSkMzd1grb251YURrRlozb3pk?=
 =?utf-8?B?K1JCVm5kb0RQS2lIWXRqRTdZa2tQSC9SSDF0WnBITlpmcGpxKzF0VjZYSFEw?=
 =?utf-8?B?eUNwV25iM0RtZ1R3aEhkbXBtbklRUHprQWM0a3JCWWdkM25jczh0RUpaaDdH?=
 =?utf-8?B?dmtxNXlpRkhacEhzWGpaK1BQRTFzMEpWaFR5S3JBYXdlQnpGRit3bU5RWE54?=
 =?utf-8?B?UmM1a0ZjR1ZheEZ4TXV3TGMzVVBwMGlaRjl1TlFXTHd6b2JTa3h2S3c3aHdm?=
 =?utf-8?B?Zm1rWW8vTWRYRDdoWjlnUEV2SU1NWkV5RU1ZWFJDRnBDcEFDVWdLb01DWVZP?=
 =?utf-8?B?cGFjQ24ydFNWOFZFSTIySDVqSCtZUGJjdTNxT1oya3lFZjdRczV5d1VNb2w3?=
 =?utf-8?B?c3ZrOGh0QmVVdHRHQjFNc1FSSThsb0l2MDYxaUZQTTFtQXVDZ0Q5blJ2Rjlk?=
 =?utf-8?B?Tm1aTUZTS1VUalZ0dFBRVUtGYzFlY2wvaGRqZFE0S2RDdERxNnZIa2t2RVRH?=
 =?utf-8?B?K3R6Ri9sQXJVSDFHR01JSzBoL20xVFFGNjVNd1BMNXJ4RTVFaGdubkFPRXpn?=
 =?utf-8?B?TVU3Q01hMnlnS2JTcjVONHFNeVpqM3FCT0oyNDFhTnlRQ3c4YWdTYjZDdFB4?=
 =?utf-8?B?MTYzTjhxVWFjdDJ1Z3p4dDdtOVBPcWw3ZzljbC9GcTJybFBubTd5YlZVWENy?=
 =?utf-8?B?NEUvczN1dUU4OUpieEJOT2hZL3lvb20xNFlzczNER1ptVU9RZG1FZ2txajIx?=
 =?utf-8?B?N1VTZVlXVWRlb0Jjd3BhUmpud3ZQMXNsRXhmMFVRT2RqeDlwR0hQVTJ5RjhQ?=
 =?utf-8?B?RmloeG9uVnh1d0U5ZVBBNklJd3g3c3hXa25lbzF0SjhmMFNmbEsrNmpsWURI?=
 =?utf-8?B?R2xybEpSRW9NbVhrS0JrZ1YydGxqd0hRd0ZsdFRETWhseU1WdEhaZm9UcWVE?=
 =?utf-8?B?dEtxaHFSR2lERitIL1lHd1JsK3RQU05hcXFxWHNZTi9hUlNud3h0ZDhZc2pq?=
 =?utf-8?B?cUJFQ3lUazdZeTRyV244RHBUdDlRRVRNc2VLditydEF1Q0pGSURmdTJDdkw1?=
 =?utf-8?B?UGtEMTBKeFd2VW5FRTVaTytGN0c4eENUMHp1a3c4N212RzE1ZGlvbUMzcFNF?=
 =?utf-8?B?cmU0OXJ0dHF3MWFHS0VzZGFJaC82bDFHdGNmWlNrNG04ZjhKMkFQSHliTXJZ?=
 =?utf-8?B?dkZ4UnE1Z1dJcUhrVVlsZ0xpQUFYRjhoaXRXekVMSU5wQmZRT1YyV21BQVk4?=
 =?utf-8?B?MTZISW9yT3FCbytBcmVGSFdNWFY5Mk9TcTlCVHVaRmJpMFBENi9yREtIUkNs?=
 =?utf-8?B?NEhuWm16WVBkVk1nME9RMXk4clMyM3N4UDhNM1hLSit3U0Ivc3VMTENKSU1N?=
 =?utf-8?B?bEp4cHdPQS8ybWovV1ZxcWttNEszVjM1d1Awa0Y5dlZtVkVxa3VmRDVnWmM0?=
 =?utf-8?Q?xI0i/eDWcfkPBHqLlG/ta9k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjJMcStWS1QwTUtRdzBUYzExQkhPeDRNRnRwaDdsT3lQTy9BT1dvZ2ZPRXov?=
 =?utf-8?B?emtWUWMwZXp1ZzhydmliSlJZRmZGUmg1VmUyNkduQ09JeE1oUU1BMDQyV0gr?=
 =?utf-8?B?MEtaOVQ2dHdLcy85OTVpcDVKcjNoeWhCaHBiTXF0d0R1a2M0T2p4aVRSa0NL?=
 =?utf-8?B?SUJCQjdkV3daNGR1QWx2Rk9ia3prQWROV0RsSEtNdDVPa2h6UDZ5QzU5Vjd1?=
 =?utf-8?B?QlpEZmVEQVA4WG5RdWk4YVdrOUx1WVVxVWVNZnZMSnZTTTFBd3BJVm9VUmdz?=
 =?utf-8?B?Y2lTVnBlbzl1OU0rNHhYQnlBYzBnS1huSWV5Q1lBV21hWDVLN1RBOGw4V2Ry?=
 =?utf-8?B?ZzNWcEJyWWJxMithdzlNUXpBNExBMWpVZThTNFFZcHhENkMySmQybUxDTVpX?=
 =?utf-8?B?MEdtV2NFUFgyVVFLeE5UZDdoNGRiZzl3MUdjWXdaWlBjTkVwVVpXTTVERTZu?=
 =?utf-8?B?QXI4NStuWVpEQkFkSzdLbnIyQ0tRdkZLRmhEVkV1c3l1dUUrS00wWitUZGZs?=
 =?utf-8?B?YWtLU0RLaVFaT0V1WnB6cEpESnRXaG5qZ1VkbTl0ZnJuUFMwbnNvKzJRcEFy?=
 =?utf-8?B?OElLQkZ1VTFoKzJMdTJ1L1cxMHlzR0Qzb1FORzdndDQyS2NKeTlTdDI0MnQz?=
 =?utf-8?B?MkRYTlA3STRmWGdvbUFQa0JwZHNOOXFhRGZoUUQ4bys5MTRDM0NZMlY5SnNB?=
 =?utf-8?B?cXdvRWVOdDhTbm1jT1VGS0pEVGljS3Y3dzlLWWpkeWxCaEhHZWtWWXM0a3RJ?=
 =?utf-8?B?cDhTV21seXlhY291YWExNmVDRms5NVhNYkNwV21kVmt4eW9GUXVTYVhOdUNU?=
 =?utf-8?B?MXZ2MVYwMkUxaHA0eTIrNHNRcjBJand5dGdYVlgzNkc4UHZHZTk4R2hvNSs4?=
 =?utf-8?B?ZEdSUU5TUSsrY1AxU0NYbElRa1VINHFGeUk2MmhubjZZUktydGtyUXhsS0JZ?=
 =?utf-8?B?RmswcklKN25GOFkveDVXREhiK3pBM25zK0dNL0ZDQzVwUHlsSUl3ZUZsWjkv?=
 =?utf-8?B?Q2NtMlp3NnlPaDhoaitXZ2NxL0hmVmtVLytVVzh4dnZxZThHTFNWSnRQRWdC?=
 =?utf-8?B?bldmOG9pMnFncnNVSzc5QWQrVDRvZFJBOGFWWm5NUml2VGdPSVdMbUhVZ25T?=
 =?utf-8?B?M21FTEFZZVplSW4yclFrc3lZYjBVRDJoY09hbEtrSzZYRWExdFFVbktXbHpU?=
 =?utf-8?B?dFMzMExabW81OVF0SlVtZ2dKZUNTVElYSjVFMEc1L21wQ29xWHc0QmVBU1dT?=
 =?utf-8?B?ZUxnN1k4NHJlbWozLzVLNUtIa1V0dlN1eEQ3U1diamdSdUtUWnZ0cEczRDZZ?=
 =?utf-8?B?TERmZVA1OVJBNzJZM2R6eHZmNE1CV0c0Rlh0d3VFU245QnJrVmVWTUZwYVdw?=
 =?utf-8?B?Um1CUndLRjhYUjFEOCsyZW1oN0J5b2VGaDNBME9STGdscFJYQ0E1dG5CR25s?=
 =?utf-8?B?ZlhKdU12Q0lxbVJXYTNvUVBSeS9ibzN2TENTQjA4YlZndlkrNmpCVTBFakRW?=
 =?utf-8?B?THA1MExmQmNTZ0tzTVE5NWQvaFYzMGtzOW1PWi9McEpKb1ptcUwyemZxU0l2?=
 =?utf-8?B?QS9iWDV6Q2dibjZOVFZJQTlReDBZamNsaURhVUQxQ3BtTU9QTHhrWlVoNDVD?=
 =?utf-8?B?UHFUNWpsOVBJblhiTFpTVlRMdlRiVVNXeXFPQm9RVEtUMm1KZVgxNExOdWVI?=
 =?utf-8?B?TEpWQ1E1QU9HL2RDL2dWdUdjMENlQWNrM1FXdmpYYUlBbmRqdEN1Q21JZisx?=
 =?utf-8?B?MEMwbEtBUXVzSGJNSlZBUE54NE5aeVJROE9JVUM1UUgvOEg2elZEdVZWdFJ4?=
 =?utf-8?B?WXZDcjBxQ2hRckRoaVJxd2VKU1o1QjBXa2pUUzFNWXNiS3h6eGtURWQ1Tmly?=
 =?utf-8?B?NjJrM0E4TS9lQ3o0enJmRS9RZFlnamNqdmhrelVleUEzQ21RdzFzOVgzcjdC?=
 =?utf-8?B?MEVac1VUZVFiUm45empDTnR6TENmVFBzR0RGc2MzSFVPckdzWEJwcGpnMzFy?=
 =?utf-8?B?L0RqZW16MUxid0Fvb0lTUHNjc200bUZ5TjRJU2ZEV2lVUlV0S2lmTUJOWGVi?=
 =?utf-8?B?MlBWeFU4eDlzMllpeFdOWDZaYldhdGljTDM0RHhPR3JFQnR6L0hZejY1MGRo?=
 =?utf-8?B?cHkxZGlCN1kvRHVjZ1Y0c0M4eUt0L2tiV0ZweXZIeUVseVVPNC9kcDNyOWNG?=
 =?utf-8?B?a2ZzamR0VW9uaG85NE43YXVzU3FrRkRUNHJSVm5DNjNtbWJxUTZjSFZLeGhz?=
 =?utf-8?B?WDJzZzhiMkZjK292WjNlM2ViU09RWUIwd3JDcDROanM2S1lJTzdOVjlxeGgz?=
 =?utf-8?B?ekN6TzltMVkvOEJTamwwUXE2a2xUQkhSeExRS1FBUlRzS1JHcjVNVDVwV2k1?=
 =?utf-8?Q?QfSYdtojiQ1yra4TEb8j407g4XKvidxnNOO03?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <003619498099F04F9D57B2EB548B6677@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c26fd64f-c00b-4159-33de-08de5d2dd50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 22:54:16.2041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yokhQRddzchyQpG3R/0Ja2nwfy3fZrfJRE4pXVc88D1GMbkUTILKdzHcvgL5DZ4ySycoKNsqQsCgAiq4sEkGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5531
X-Proofpoint-GUID: b5lY31gj7DuYCrN1APTj2ZKpblJYctm6
X-Proofpoint-ORIG-GUID: JrT7HkGBRC5PjUnyThDIU4mfwWwTyQM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5NSBTYWx0ZWRfX/rzrWLTT8F/j
 J95RQXIiilP8uV70Qd3PIInNDM+XfrxedbSaYQc51uKNgdB5wxB7ipcA4jG/q1qVg9vl/iF3CIN
 FQZYKNYAaH6eBxfQQmUFvwIdFHDhI53tdeGPrLfStOXfOxesvB7Id/PJ586LSxAof8z5Bs9LAEe
 YMQJkGlIP+XoFG17q66il2DfZhVIZC35T57SJscMUjhqUJGSXzdAX1vkCVVzsaBI+HEDZJyRgzQ
 9J1w1u3Yn1N+YZIx+uHctUihvfD9JmcU+Cbh7dxjynHBOR/74a7a7fxFAE4bqRPPF0Z4lt5Vi1V
 7fpiG5miPjw45M8xFFTbg1G8QVbVxMqOId7U4YLd50Zo1RZq4wD18wYQ0W0EB7Za3QPbhVX3Ei4
 eHiQSbIHndLMlilegAoLW8Hj9COnTFfG9ZSVqf1F0e/mkN2QQ4rsn6qneip79Xyko7ccP1bLy1Q
 dFNw3c687kKv/Ln4rsg==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6977f09a cx=c_pps
 a=rwqFklNBBe0PgClOpsUSJg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=NWpptHyORv4PuU_99ZoA:9 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH v3 4/4] ceph: assert writeback loop invariants
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260195

T24gU3VuLCAyMDI2LTAxLTI1IGF0IDE4OjMwIC0wODAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
SWYgYGxvY2tlZF9wYWdlc2AgaXMgemVybywgdGhlIHBhZ2UgYXJyYXkgbXVzdCBub3QgYmUgYWxs
b2NhdGVkOg0KPiBjZXBoX3Byb2Nlc3NfZm9saW9fYmF0Y2goKSB1c2VzIGBsb2NrZWRfcGFnZXNg
IHRvIGRlY2lkZSB3aGVuIHRvDQo+IGFsbG9jYXRlIGBwYWdlc2AsIGFuZCByZWR1bmRhbnQgYWxs
b2NhdGlvbnMgdHJpZ2dlcg0KPiBjZXBoX2FsbG9jYXRlX3BhZ2VfYXJyYXkoKSdzIEJVR19PTigp
LCByZXN1bHRpbmcgaW4gYSB3b3JrZXIgb29wcyAoYW5kDQo+IHdyaXRlYmFjayBzdGFsbCkgb3Ig
ZXZlbiBhIGtlcm5lbCBwYW5pYy4gQ29uc2VxdWVudGx5LCB0aGUgbWFpbiBsb29wIGluDQo+IGNl
cGhfd3JpdGVwYWdlc19zdGFydCgpIGFzc3VtZXMgdGhhdCB0aGUgbGlmZXRpbWUgb2YgYHBhZ2Vz
YCBpcyBjb25maW5lZA0KPiB0byBhIHNpbmdsZSBpdGVyYXRpb24uDQo+IA0KPiBUaGlzIGV4cGVj
dGF0aW9uIGlzIGN1cnJlbnRseSBub3QgY2xlYXIgZW5vdWdoLCBhcyBldmlkZW5jZWQgYnkgdHdv
DQo+IHJlY2VudCBwYXRjaGVzIHdoaWNoIGZpeCBvb3BzZXMgY2F1c2VkIGJ5IGBwYWdlc2AgcGVy
c2lzdGluZyBpbnRvDQo+IHRoZSBuZXh0IGxvb3AgaXRlcmF0aW9uOg0KPiAtICJjZXBoOiBkbyBu
b3QgcHJvcGFnYXRlIHBhZ2UgYXJyYXkgZW1wbGFjZW1lbnQgZXJyb3JzIGFzIGJhdGNoIGVycm9y
cyINCj4gLSAiY2VwaDogZnJlZSBwYWdlIGFycmF5IHdoZW4gY2VwaF9zdWJtaXRfd3JpdGUoKSBm
YWlscyINCj4gDQo+IFVzZSBhbiBleHBsaWNpdCBCVUdfT04oKSBhdCB0aGUgdG9wIG9mIHRoZSBs
b29wIHRvIGFzc2VydCB0aGUgbG9vcCdzDQo+IHByZWV4aXN0aW5nIGV4cGVjdGF0aW9uIHRoYXQg
YHBhZ2VzYCBpcyBjbGVhbmVkIHVwIGJ5IHRoZSBwcmV2aW91cw0KPiBpdGVyYXRpb24uIEJlY2F1
c2UgdGhpcyBpcyBjbG9zZWx5IHRpZWQgdG8gYGxvY2tlZF9wYWdlc2AsIGFsc28gbWFrZSBpdA0K
PiB0aGUgcHJldmlvdXMgaXRlcmF0aW9uJ3MgcmVzcG9uc2liaWxpdHkgdG8gZ3VhcmFudGVlIGl0
cyByZXNldCwgYW5kDQo+IHZlcmlmeSB3aXRoIGEgc2Vjb25kIG5ldyBCVUdfT04oKSBpbnN0ZWFk
IG9mIGhhbmRsaW5nIChhbmQgbWFza2luZykNCj4gZmFpbHVyZXMgdG8gZG8gc28uDQo+IA0KPiBU
aGlzIHBhdGNoIGRvZXMgbm90IGNoYW5nZSBpbnZhcmlhbnRzLCBiZWhhdmlvciwgb3IgZmFpbHVy
ZSBtb2Rlcy4NCj4gVGhlIGFkZGVkIEJVR19PTigpIGxpbmVzIGNhdGNoIGNvbmRpdGlvbnMgdGhh
dCB3b3VsZCBhbHJlYWR5IHRyaWdnZXIgb29wcywNCj4gYnV0IGRvIHNvIGVhcmxpZXIgZm9yIGVh
c2llciBkZWJ1Z2dpbmcgYW5kIHByb2dyYW1tZXIgY2xhcml0eS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFNhbSBFZHdhcmRzIDxDRlN3b3Jrc0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZnMvY2VwaC9h
ZGRyLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2FkZHIuYyBiL2ZzL2NlcGgvYWRk
ci5jDQo+IGluZGV4IGNkZjExMjg4ZDZiNy4uNGUzOTJmYzcwZDMzIDEwMDY0NA0KPiAtLS0gYS9m
cy9jZXBoL2FkZHIuYw0KPiArKysgYi9mcy9jZXBoL2FkZHIuYw0KPiBAQCAtMTY2Myw3ICsxNjYz
LDkgQEAgc3RhdGljIGludCBjZXBoX3dyaXRlcGFnZXNfc3RhcnQoc3RydWN0IGFkZHJlc3Nfc3Bh
Y2UgKm1hcHBpbmcsDQo+ICAJCXRhZ19wYWdlc19mb3Jfd3JpdGViYWNrKG1hcHBpbmcsIGNlcGhf
d2JjLmluZGV4LCBjZXBoX3diYy5lbmQpOw0KPiAgDQo+ICAJd2hpbGUgKCFoYXNfd3JpdGViYWNr
X2RvbmUoJmNlcGhfd2JjKSkgew0KPiAtCQljZXBoX3diYy5sb2NrZWRfcGFnZXMgPSAwOw0KPiAr
CQlCVUdfT04oY2VwaF93YmMubG9ja2VkX3BhZ2VzKTsNCj4gKwkJQlVHX09OKGNlcGhfd2JjLnBh
Z2VzKTsNCg0KTXkgY29tcGxhaW5zIGFyZSBzdGlsbCB0aGUgc2FtZS4gSSB3b3VsZCBsaWtlIG5v
dCBoYXZlIEJVR19PTigpIGhlcmUuDQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICsNCj4gIAkJY2Vw
aF93YmMubWF4X3BhZ2VzID0gY2VwaF93YmMud3NpemUgPj4gUEFHRV9TSElGVDsNCj4gIA0KPiAg
Z2V0X21vcmVfcGFnZXM6DQo=
