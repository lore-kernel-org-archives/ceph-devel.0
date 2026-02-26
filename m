Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAB453491
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136734; cv=fail; b=VbyC7ogMwphLo3jWqx8PnXmQt/cOmQ8w9Ul59sI8sxHsaiuN/XlBp++A5SXa2XJ9dgBKLFVtVlg0JL/zr5davTI+/NYD/J1/22+lmMbPHps9+kal4jkKk4COexBwldKQfXNGbO1FlkKPPb/A9B31uCCiIi+yhFJOoK9NouIKyzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136734; c=relaxed/simple;
	bh=0cggIWnQvv08sv4jRiCnNNFaMgcWJmjDbodk8D+BRg8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=irkWp+opDCOjM7L2J3JZV170i0kOyrU1L+wZ1Do/fFw0rYvierG77/Ene6Rrh5r4DamQ0U4EhLm/f5ld7cc6iHeOT3eehckufarrBE340sBmYyut9v8+loewy/rdveaXv5LMHF9kKC5Js78CIwsUeXFi6VPiVso2MlPf6/iH20M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U7csJavd; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U7csJavd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QH7KL13239518;
	Thu, 26 Feb 2026 20:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0cggIWnQvv08sv4jRiCnNNFaMgcWJmjDbodk8D+BRg8=; b=U7csJavd
	kFYU9NBKDW+ozyxslcBRDsP9Ul6O75pezGsrR4MQPGUHc24GDTBYlQFV163praIX
	jLjpNEFXSeKLC6n52LoofCu22HYSdLFYeacNWTcsDgUg8PzNxiivjijEOesCihNE
	dkDMR8UcrYSPzDcMWyyGl1no6s6VKkB+aML3+5bObJ6B3eGXwjHzFbg3ULJIy9WF
	/GCg+jB89W1UIwBbSZp6XDKYPk81IT7NWSry9i4NGo4K/eAOXxwLLxZDAWhZ+xS5
	XxGsPq3eTShd7SqUDdcZPJpHtAzVKlmtMSaEHKo5L4zPOia53CtrHbhHoHTRPGNi
	6se8a8cJqppt2A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gr4cb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:11:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obi6vvsm1ZI/QxSSkLAcXK2cdnBa7KK4m7nLi9LgpSzWGZb/yfoT+XdrnjPdGDORs7ZsNMlmE2E8Oaw/bkiDrOgPKCEoxdI5EFerLntk9xo7W7WvM6RPkpilv7DhLD0+S7+a50ygNdMPEE9dn1hlfGDBL70b4o6MoWNZuL2W69CDBTtW01MUKTumJqG1GH4rFYHDxbuoxROXKfLs4mA3y+zp5nl3GhX6aQmnG3svNjmSU25E2S09u60EYNLGuyiP8x7tWnXWmO2JOgHQkID/vcSLUBnKHcmz16ICgpmZmYz+X+pjbgy2Tuwqy8lW1NBZU4TK6adVDmaKPM9aBsapYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cggIWnQvv08sv4jRiCnNNFaMgcWJmjDbodk8D+BRg8=;
 b=QrAB7Jhinh+uahmbq/gGglgsAZ6Mugy8DK1KtbBKqJhnT+zX0+Nhzq6+abErAFAYcSkrmIl7V91hF0EaXtM4p8hL3oDBsM6WJKSnF5QKJw5/cWiWvRXm1w/Y8w65peK+uRw+uhSnD0gtoYs8AZhLFiCx4OIgyhqcQmvcNbZV6KqONgrXvIK5kuh4XY+79YrKjIdNTacOPy+7YE/dUCkVcp0vDUyZEjR6ybfDZuHeydUfHhhUBsw/sOo0f+pBhO6QkoLEngwwaWp7y1/3b4MCH8xYFzaxQWaj8McJsVDBg1cimpbZsBmb2itr7iSs43dspMinNslLTzbc7Tug8uLTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5628.namprd15.prod.outlook.com (2603:10b6:8:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 20:11:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 20:11:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH v3] libceph: Use u32 for non-negative
 values in ceph_monmap_decode()
Thread-Index: AQHcp1wnj2bGaZtD/U6OgBG1ZeNq8Q==
Date: Thu, 26 Feb 2026 20:11:56 +0000
Message-ID: <90d1dd9b5ab6dea55de777715fe8d0db9385ca54.camel@ibm.com>
References: <20260226150731.1257332-1-raphael.zimmer@tu-ilmenau.de>
	 <9fc9e9ebeef1049a0de420a2dd25fe91db5f3504.camel@ibm.com>
In-Reply-To: <9fc9e9ebeef1049a0de420a2dd25fe91db5f3504.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5628:EE_
x-ms-office365-filtering-correlation-id: 762ae164-894a-4376-82d5-08de75734a48
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 R9c6CiSf8baqdvnMrRJPWJeytqSucluQsNUNZrFyKeTTtqTf8YOPJyZcLFGvwhC3AojW8mTGxgMJeE9VCvkzciABeyEQ7/3UOyK5rpRSj46edOr3d9P81Y2uDj2YdbRWk8YRN6S3D5QkLULfcNYqy9x/O+Z+wdEO8WFqPMuHwHQKgr+2ewtHbeG/RWp/EC0vGUvGvgMfg4NGpGY9eDe0zAehVyWDOVnla7w5ROpBNcFGDuh88EkpVFTwbS1k3qAaGxCmrJBJiLEc5/+BaEJz3lUt9Cn+Pu77zJaIjL6dt/scv0KnKBst2FtpNR3cueEba8711W6Q12ODHfJ+2283U5jo74/0F1BT6D+tJXDregaSUxRHRMiikj9tl0eLLwzOeANEKFMrq2pZ2zBl3Y3GzEW895FnnXTNpW69ctahANEudJrhGo+ehx/DEOn+x5kLEc5oGkx0zEIfUYmeHVqKQc1m2Xkzx14+9kGEZSd+LcT8PUpI5RjSpUo+zm6OaA8n0pyLs9DCgYEWENQA76xO4Ph/Zp6q2jw/NTjjMQW+VgBn/22cpkIqLeEbcMrrqG6Uy1IH20hdlthsc8gGWUJCmMWz1xRg6FqEY9kxGpNiOrlP3z2j+C9RwtZVNZ31kVyl4e/yrrZg0r/GrKLu0gko/1d+P3DuEq5Zp2cPvvH37Nzu2HEexEmkq5wdurLgDzZ6xQfbOdoOSGRLjnC7W+jw7qMUFfTeePZcw1ZLzmKVd9tg7imk/a08ZWDNlc+4Tklw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGtyZzU0Rm1pTUFnSFF3YnZsQ0Z5eW9OOTFzaGdrMmJMSlFhWTdMZk1LQ0pk?=
 =?utf-8?B?a2VTZE5MZmlYMWhjRk1tcHZiSk1Ed2dmNllEY2R3aG80MENnck5Rc0NDTGdM?=
 =?utf-8?B?WHl1Q3BWZlNTeDZ4TlVNTUhBKzI4VStPMGlvRVRDSE92RTJ4K1ZWVC9kMVg2?=
 =?utf-8?B?Zy93Rm1BNVJYdHdXUS9vZWJiZ3NOWm40M2F1ekJrUFA5Wmdza1B2U0w3cTdG?=
 =?utf-8?B?eW5mRHh6eWx0NEZYWkl6YXpva04yOFlaaEE0L0pHbUZaOGQvKzBOUWFmTm5S?=
 =?utf-8?B?UVgzNUh0QlRpTGlTSDU2Tk4wOUlwTGNLNHFyc05nbXRMVWsxenk5ZEo2OWFG?=
 =?utf-8?B?WmFVR01vUHpjQW10NlVYRHQ2eXJKbFBlT1krSko3TVVnbHVtM1lBWDVmUjV4?=
 =?utf-8?B?UlpZTUtMcTVhcm9CZ2k0eEhRekJzUDJzbUpLakpVRnRuazJsWnU2SytIeEcv?=
 =?utf-8?B?cmRDcHYyZ044b0QxbE9sVzh4MHpPUW5oVStPWFNSWERrY0tTcFpmZXlvOU80?=
 =?utf-8?B?WGJtdVdzYnVoRjJ1YzBncXhaZ3NzTXM1T3BEK1FhZ3cxOHJ4WlRONUUxS0ZW?=
 =?utf-8?B?YzhLdzlaWFFYbUs4N2FweTRjZnplTkpoTk1GSGszeUhSR2tGRVF6UW9YcFNm?=
 =?utf-8?B?VnNpYnZpSVhxVXpnK3l2WVI3NmFtellqcDRJTTdUTzRBN2NPYURsNlYzYzUy?=
 =?utf-8?B?OVAvNDdqdUZiUndPTkRSZ2dCbjQvNE5kTzFEYWIwTjg1NE5Xd0hpSkxKcVJq?=
 =?utf-8?B?ZjYweG43MEJCMnRaaDhxNFJGdGQza2tvUjBlcVV4N2RMeDBYYXY3TlZsd2JX?=
 =?utf-8?B?R1NLZUVaNzdyKzBEYUpCKytETUprNXlRSXo1Q3FEaTUvNDNKNlR3OG8wVWdx?=
 =?utf-8?B?Z1c1WVBPV0xST2xOdGYwaktrR2JhcEVKUjBPeHE3aW9NRlUvaVNkRWhFcTBV?=
 =?utf-8?B?aFFQTWtkRlZJWFMxb3hVNjFJL3JQQ2k2ZTlxenB2NXI2d2hBdWNUUHNsRmRx?=
 =?utf-8?B?SDMyd0tWMWdsMWJhcUVoYS9JK2tRNlNpcVp2ZTR4dVFpdVBOTlNTSnZRWVph?=
 =?utf-8?B?b1VuYnBTNUltck1KbUh1dVh2bjQweXNpeGVJQkliWkFKVko3SlpONDNtdEw1?=
 =?utf-8?B?V2xQUUZkRFNmR1RJY1ZIVU95UzVFSnBFazNHeFlRSnpNY0FJeTJwdGdsZjMz?=
 =?utf-8?B?U0R6VzFCVlg4cmRmUHRLTUJwZ3AyTUFFYVhiQjlJM2IyalBVQ1VpNnRLdW1q?=
 =?utf-8?B?TEpqaUpxdkw5c3RiaDk3TmlhelRLcW1UL1N0RmFSVlhtRVRSdXdOVk5xaWs4?=
 =?utf-8?B?cm8zUTdFdGEzMDBNSTI0THB6T2tnTE5sY3hjRGd0VkUvRzZKdWdYU09USkVy?=
 =?utf-8?B?bkNRSzc1ZzAycVVITW8wSmx1Unl3ZEJoZVk5djA5NmJJN2J5cy9wWEw5R25h?=
 =?utf-8?B?WU1VNXcreGpJSDU2eGVsSXNQZnNPNXlZN0Z5RnIvRGdKN1RSeFBTbXJrRWJz?=
 =?utf-8?B?UkxmeDY0TG0zMFM0ZGM0bXZVQWFDd3NFOTFUR1lUTnpnZXBtbG9RbWU4TktW?=
 =?utf-8?B?Y3RqNFkvdnE5K29LNDhLYjFoNXRteHliL0dxRXozdlBQVmVsWDg2THgzbTF6?=
 =?utf-8?B?c1VQYm9TT3M4Nmd3ZUxJUU96U0RPSVJnbzNITkl2VEliOXRIYWJKMEgvYVRO?=
 =?utf-8?B?VENkVUhyY0ZVOFlTaFc0WjBLL3ZEbUJJdTVoZ3dnQnVYRFJ6T25WQlhNZUJR?=
 =?utf-8?B?eDM2U0V1L0dCbUNUcGYwYVM3YzRkU21GOXlWTlh5MVpsY1cvRkFwb3BlbmdO?=
 =?utf-8?B?UUgzWjkvZU54c0o4ZWtwc1lwZ0RoeDdnVnRVcDRWKzRwcmlWYTJBUWIrZUNC?=
 =?utf-8?B?QUxlU3lQMFg1c3VYMlBjV2VSY0dDTmM3SkxVVk5kbG1YTzdmcjFJN2lTNDVZ?=
 =?utf-8?B?WnRTSG82YkM0U2FOenRiT25GYXRnTm1NR3huNEdGWHVkT2ZuenNKRDZRK3Bj?=
 =?utf-8?B?QlJhd3krM1NHYnA2b2ZPbFYzMTc4cWVlYkN3c3k1QmFPVDBubFhQeDRSK2NJ?=
 =?utf-8?B?YmIybEh0d3M1NmNlTVMxRTYrUTQ0UzB5MXZ1NU9jRDF2Nk96ZENwczVPay9U?=
 =?utf-8?B?eS8zbktrMXNuS0Nac3NRL1NyOVFNUmIyNTN6WSt1T2IrcWtWeFRLbUs4eElO?=
 =?utf-8?B?NVJjZmk3RHF0Y2VnN1VUcjMvVERTeGdvcnQ4eXdJUlNRM1RaaTNya29JVGtQ?=
 =?utf-8?B?TVdqWTRldU1ESE9XbHpzd29YL0piMUhtbnJmemIyV2Rlb0N4U1JHVVlVL2NS?=
 =?utf-8?B?a1E4YlVZUjR1MzVQcnc5KzBLSTAwaWZnYkg4ZjYvd1gxd012bm9iVzVHYmJK?=
 =?utf-8?Q?H1RZxsrlKTzZ9RGk2Zbz4nb5HV2nhx5BM52v/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBC441C680E7094A9C769526B0CEACA8@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 762ae164-894a-4376-82d5-08de75734a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 20:11:56.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVmrKzxNv1nuiwXlqqoQlBVKfarQgvqhQL3ekP2/LCXNGKF4otu3Wqajl4VhPYQ5KuMKmdxWqdnxO7EOmnGaAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5628
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a0a90f cx=c_pps
 a=dnat/ZFdcaejr8kp+uhwWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=oRlLzrVBqHTsRpar2KUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HqyE-xOEljovKV9QDkpfy-dlARmrUuL4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4NCBTYWx0ZWRfXwtTeQYGkiwk2
 L0qn0S5mw9CitvI4J1FIVP63X7O5wzsOcpaUW3vK8OekmLk2iAGSYsh8kILBwm50NKbDTiAXJVH
 SE/MOQ0m7dfybWBhEQs81aiE79T/jxqB41fxnYtSKiap+lwaINF5OBBtDuSswa8h/2xP1f9sPfw
 3xOBkqRimwZw910HA05qPqn/qbJZVW0oF9cqqCcsw5FfNL5kwMxPtXXd+IPLgnt8goJjlcjVxJz
 BZiPvyRuSA9xLnQHWutIcDrdqsM71Hlczzf90YshyaafZVoLc/pKVwwbRUs1x3t3yBtRO54DJcc
 PIa1m3SuDbf817mgUFy/+r+HTma4JR1W6hXNhChgReVEH+B1mSHpb1Qyqg588R4vfKsQ1016bFV
 bcI1N0mjqSHE04E7w1NmWANX1u6nBdORXQk6s8Gloh2cOdeRUxtC0e0EYIeNyYCCoTeHfEpHH11
 u/vuSFVSlGm1qlbFrFQ==
X-Proofpoint-ORIG-GUID: KBVYOsVG8kwK6GY_mnF7j92j0akmNJF_
Subject: RE:  [PATCH v3] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260184

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDIwOjAwICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFRodSwgMjAyNi0wMi0yNiBhdCAxNjowNyArMDEwMCwgUmFwaGFlbCBaaW1tZXIg
d3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB1bm5lY2Vzc2FyeSBpbXBsaWNpdCBjb252ZXJz
aW9ucyB0aGF0IGNoYW5nZSBzaWduZWRuZXNzDQo+ID4gb2YgYmxvYl9sZW4gYW5kIG51bV9tb24g
aW4gY2VwaF9tb25tYXBfZGVjb2RlKCkuDQo+ID4gQ3VycmVudGx5IGJsb2JfbGVuIGFuZCBudW1f
bW9uIGFyZSAoc2lnbmVkKSBpbnQgdmFyaWFibGVzLiBUaGV5IGFyZSB1c2VkDQo+ID4gdG8gaG9s
ZCB2YWx1ZXMgdGhhdCBhcmUgYWx3YXlzIG5vbi1uZWdhdGl2ZSBhbmQgZ2V0IGFzc2lnbmVkIGlu
DQo+ID4gY2VwaF9kZWNvZGVfMzJfc2FmZSgpLCB3aGljaCBpcyBtZWFudCB0byBhc3NpZ24gdTMy
IHZhbHVlcy4gQm90aA0KPiA+IHZhcmlhYmxlcyBhcmUgc3Vic2VxdWVudGx5IHVzZWQgYXMgdW5z
aWduZWQgdmFsdWVzLCBhbmQgdGhlIHZhbHVlIG9mDQo+ID4gbnVtX21vbiBpcyBmdXJ0aGVyIGFz
c2lnbmVkIHRvIG1vbm1hcC0+bnVtX21vbiwgd2hpY2ggaXMgb2YgdHlwZSB1MzIuDQo+ID4gVGhl
cmVmb3JlLCBib3RoIHZhcmlhYmxlcyBzaG91bGQgYmUgb2YgdHlwZSB1MzIuIFRoaXMgaXMgZXNw
ZWNpYWxseQ0KPiA+IHJlbGV2YW50IGZvciBudW1fbW9uLiBJZiB0aGUgdmFsdWUgcmVhZCBmcm9t
IHRoZSBpbmNvbWluZyBtZXNzYWdlIGlzDQo+ID4gdmVyeSBsYXJnZSwgaXQgaXMgaW50ZXJwcmV0
ZWQgYXMgYSBuZWdhdGl2ZSB2YWx1ZSwgYW5kIHRoZSBjaGVjayBmb3INCj4gPiBudW1fbW9uID4g
Q0VQSF9NQVhfTU9OIGRvZXMgbm90IGNhdGNoIGl0LiBUaGlzIGxlYWRzIHRvIHRoZSBhdHRlbXB0
IHRvDQo+ID4gYWxsb2NhdGUgYSB2ZXJ5IGxhcmdlIGNodW5rIG9mIG1lbW9yeSBmb3IgbW9ubWFw
LCB3aGljaCB3aWxsIG1vc3QgbGlrZWx5DQo+ID4gZmFpbC4gSW4gdGhpcyBjYXNlLCBhbiB1bm5l
Y2Vzc2FyeSBhdHRlbXB0IHRvIGFsbG9jYXRlIG1lbW9yeSBpcw0KPiA+IHBlcmZvcm1lZCwgYW5k
IC1FTk9NRU0gaXMgcmV0dXJuZWQgaW5zdGVhZCBvZiAtRUlOVkFMLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJhcGhhZWwgWmltbWVyIDxyYXBoYWVsLnppbW1lckB0dS1pbG1lbmF1LmRlPg0K
PiA+IC0tLQ0KPiA+ICBuZXQvY2VwaC9tb25fY2xpZW50LmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9uZXQvY2VwaC9tb25fY2xpZW50LmMgYi9uZXQvY2VwaC9tb25fY2xpZW50LmMN
Cj4gPiBpbmRleCBmYThkZDJhMjBmN2QuLjk0YTdhODJjYTQ3NSAxMDA2NDQNCj4gPiAtLS0gYS9u
ZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gPiArKysgYi9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4g
PiBAQCAtNzIsOCArNzIsOCBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbW9ubWFwICpjZXBoX21vbm1h
cF9kZWNvZGUodm9pZCAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4gPiAgCXN0cnVjdCBj
ZXBoX21vbm1hcCAqbW9ubWFwID0gTlVMTDsNCj4gPiAgCXN0cnVjdCBjZXBoX2ZzaWQgZnNpZDsN
Cj4gPiAgCXUzMiBzdHJ1Y3RfbGVuOw0KPiA+IC0JaW50IGJsb2JfbGVuOw0KPiA+IC0JaW50IG51
bV9tb247DQo+ID4gKwl1MzIgYmxvYl9sZW47DQo+ID4gKwl1MzIgbnVtX21vbjsNCj4gPiAgCXU4
IHN0cnVjdF92Ow0KPiA+ICAJdTMyIGVwb2NoOw0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtMTEy
LDcgKzExMiw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tb25tYXAgKmNlcGhfbW9ubWFwX2RlY29k
ZSh2b2lkICoqcCwgdm9pZCAqZW5kLCBib29sIG1zZ3IyKQ0KPiA+ICAJfQ0KPiA+ICAJY2VwaF9k
ZWNvZGVfMzJfc2FmZShwLCBlbmQsIG51bV9tb24sIGVfaW52YWwpOw0KPiA+ICANCj4gPiAtCWRv
dXQoIiVzIGZzaWQgJXBVIGVwb2NoICV1IG51bV9tb24gJWRcbiIsIF9fZnVuY19fLCAmZnNpZCwg
ZXBvY2gsDQo+ID4gKwlkb3V0KCIlcyBmc2lkICVwVSBlcG9jaCAldSBudW1fbW9uICV1XG4iLCBf
X2Z1bmNfXywgJmZzaWQsIGVwb2NoLA0KPiA+ICAJICAgICBudW1fbW9uKTsNCj4gPiAgCWlmIChu
dW1fbW9uID4gQ0VQSF9NQVhfTU9OKQ0KPiA+ICAJCWdvdG8gZV9pbnZhbDsNCj4gDQo+IFJldmll
d2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gDQo+
IA0KDQpBcHBsaWVkIHRvIHRlc3RpbmcgYnJhbmNoIFsxXS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoN
ClsxXSBodHRwczovL2dpdGh1Yi5jb20vY2VwaC9jZXBoLWNsaWVudC90cmVlL3Rlc3RpbmcNCg==
