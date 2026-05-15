Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A830C144
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871931; cv=fail; b=aoXth0k99R0pW+SrUf1SoTRgA6FkJsSJtthVSKV1uEEN6tPFR94FubNprpZW/XkVCRjHzdUQ+dsjVw4NJyiA8drsZe4ekb0gqp1nW8GtXlpmB5lQsEPEV5TnjIJW/rVDVwXt3Dw4JSvEv4zYvkFkzOq5PhpgGU9aKakQIBdxa8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871931; c=relaxed/simple;
	bh=sKMz1bqoqZfd36uh2ZZkB9vmUZk6u+ROIbeQiqfF4mc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=g1avuPcshQPCDmJeUYNvo+iRc8zGvJmeP5nACBUtLI0stwAXvJvbCfhoKjYWM5cPbSMZ+jMRQhfMdbP7Sm2FXNbCz1p7XMniJTrPYEFoBY0Cbe+FsoXm3k+vuhP0uT+ImD69EZvQEKZjVkfuCZxu8NVppTrrXjd+k7VGle0nWE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=amTfbUNp; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="amTfbUNp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBqEWH4090519;
	Fri, 15 May 2026 19:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=sKMz1bqoqZfd36uh2ZZkB9vmUZk6u+ROIbeQiqfF4mc=; b=amTfbUNp
	SEMxAmQluTqJl3rHCKq2WUuADaLnScxHLmfV3Nlm+apN3oLOYjrHZlz52/TTsWB+
	pkBMFOb/DHpvguwhS8/VgKaf7jG/UrvC6FrIfioopxDdGAhfKt8ngKWSuWIKUn9c
	NhaMk5TID86cvTojqxSQglhtXHCNivD+gcAa1RLzLDBczqvXwxQp/hEBalxM/fzI
	BOqE/A3fz2i4Hh+rnKaq5nh+Ao217mdSgtEMxTYcvMCB8DQs2ECtNqdznpYm9KJQ
	MrJHLxT+otIVCQwR1HK5FSV9qO0WEHlzsKTKRIxDhvmIPRGTDlP+JOl+1EAypSHF
	tJCiI7/zn4FDDA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m93vte0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 19:05:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfWoylbwFyxWhOwwt9RZeoP5mI0rSF8RgZ/VwT41fqVYD8rdaq09D/fJlh5g2G4JnVuCM08YW+UCyasHSEgZTxpxkq0uBk4ufpl/DhR72s+Qd83CJTEa6W0bQfVqH+d+ii1jppUQg/lj7MFZjGXZ0b/W3jAb0rTN2TWW1m0jkDK6+6ZJvJ+mwkwuFdZfucRIwGzx359m1Zhw009lZsv9VHeIZcncBr1iaRppRsn1AmW4Ub0K7RX4tseVX0q+3veL/KOnJ81JcWv74Wfuc6dUEXFTVVFSBFgh3kSaGyZpIy91BlsOtkyTuTuudSYv2KH+YrfH3adh/j++rd9ZdEJwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKMz1bqoqZfd36uh2ZZkB9vmUZk6u+ROIbeQiqfF4mc=;
 b=XiTMOOUjMR8gGVjmR0UbSSjGZ9fs/jVsaIsPJhsE3rN5cXV3/mZRFAV97WHjKFULRTOOK6NsLjxDH6zzoHPkTaoI356enGT1s/e+4i9crt/1fZp/9B0DCAGxE2ffSkjnkdiWzQ4X9YkGxzzVomRErwyMf0qo/a8ia9DG/6Rye+qEfaJlcQQZGBhhF5ddxeBS9ptKK0HRKyCDfpHGpEr41pPkibcwjxkBWnvcRk1wSsBLh09Pep44tOxgWrxut5FYCYZlnniFF2JK+sfhXFZhAnab1qdqCbQlqCmoCc9QAVvZCUXjCOFwg87EPdoK5AXyC0beBwcr7liYg5iKbfHj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH0PR15MB6041.namprd15.prod.outlook.com (2603:10b6:610:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Fri, 15 May
 2026 19:05:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 19:05:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
Thread-Index: AQHc5EL/DbBrtGispk+FbKoycfnveLYPcvwA
Date: Fri, 15 May 2026 19:05:13 +0000
Message-ID: <9011b6c7ed764ef48b4bf7a10d16957e8135e18a.camel@ibm.com>
References: <20260515081132.1570541-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260515081132.1570541-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH0PR15MB6041:EE_
x-ms-office365-filtering-correlation-id: 0f4ddd12-15eb-4fd6-e022-08deb2b4e4d7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|11063799003|18002099003|3023799003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 TOglwep3HVkTSufi0ZbwMCugLfDuWFQSxsruoeHJuXdMlMH2gDwAowBJPaBvDBPDVQQkOPyyvqJYWanxfG1TLYoz8O1IRFNb5d3kdqFziM3mErL00l2v1w3KInh+TLZ8+GMnGLwH8dwHabdSY5c3xGxwAH+TBoxj9Ewbe5UactKUfm2h0x/O2IQx1EPV2Rv2JhlKVtJmqy7qIRcQ0COe9GozJ2t08Pe4aLTn2st5n5oBrKO6SQ+8jUK0ZpXbwXJxdrn339IHHms9yMfbjLDizpfRWP6N3M0mBss9Mc9iXAnls6X4zwOgJxU6IcHyubcCMK56LsAXViVEcHyNp9pZyZoaA93r/aZE24J2WsUAMcch/bXY8FNOVLyMxEFgY42mtL8kC9cimGYZTaAhyFyslPGbdCP526CTuUWOAKdBeQv9a34YPX7qhggnbAQ2/RNgu7WgHYD88ps4U0RODDF1+Cy2D7vrhD2QPGCfQacncQfS5OtXG3N5yVDfm++IdAa06uVUJgZWP0XTwLIi4i/7kt9MJs6jCFbrRmnSNqmsl3LHMje8oAEbNXQ5Vh/NdG7axe+eozu2T9yEZyRNfBcptQwaeG97JpOpzq7c1McfEzH54f63qYhUqKqZ55D/a7LqaWTf52dBQiIueON6nUeuQj+R8+XEDKJNQbthBanUvGvJtzllSlIYskxTHogOBLhGrBHAwhrW4uSzK4t7Uzp0C9mtoMTu2S1ZxSN+r0Ah3lIDlJFcdJRTbk792/NGQVXu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(11063799003)(18002099003)(3023799003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjZnVlhOS3RCQm1RVS9OYVRWYWdOaUNUTjk5T1l5WndUN0RaTDdwODNiaitH?=
 =?utf-8?B?VXJXVGtkZDdKeGkxclRFWWR3YndmdGJkRWs1L2JlaE5rWkZLek5KZ09nYytH?=
 =?utf-8?B?aTVCV3RzdkkvbmV2Nk5PSE0zeDNpVzVTUWRKdVBFMmZkSUJkcFdsbjg4VVR1?=
 =?utf-8?B?cEJHSnVWbXhyc2lXS1EzQUV6bkZnbjhadkd4WnVNYkIvRXZOWTFTUmovVUlG?=
 =?utf-8?B?RWRoaVlybE4wbzNQbDhMbnV3ZDd2RDdVcnNYZ3lTVi9qMmVINzRBMjQ3Q3Y3?=
 =?utf-8?B?MFJVaXFpWC81eUEyRHlrWVBOdTdmdkNkRkI4M2pRaVBnWDZwbUlsL2V2eXk4?=
 =?utf-8?B?eHRoYWhGejRLcW9DbkVwTTBBM01QOE1MeWZyeFNSa1FQQkdKbVVFUlZEVnky?=
 =?utf-8?B?TVNOeVRhb3ljODBUeGNLTWVrZ0t2dFB3OUtSaVpDeE8xODZuRVJuY29VZS9Z?=
 =?utf-8?B?Y29VaXpKakVIaE5adGFRMFRaR3F1VjBpT0xDeXFGaXdUemV0cVVzKytZbS9Y?=
 =?utf-8?B?Qm52QS8zZUp5YmpiclZ5QnNkVzZSRlYwZXMyWFpmTVVBM3E2akhHOWcxRmYw?=
 =?utf-8?B?NXl4enJXcGRPL2ZaQUZzM2ErYzFseDFiT3dQeitDNXZJSEFBMm1aV1BMNVA5?=
 =?utf-8?B?bS9VNFRMYU1pYUgzdXFHMjNHcmNRdSt6YU1rZ1F3OFhCVnNSSE1pNmM3V0N6?=
 =?utf-8?B?aEIwa2tNQnRVTURGcDllcW9QMDduZkI1MTJuM3o1L1UxTXBxNk9YQ1NWWnpR?=
 =?utf-8?B?OVRJNWI5dHFDaXJuNWFIS09ybzBETHhmWE96Tlh0QVpqWEx0K3RlclVMZTlL?=
 =?utf-8?B?TjMzZEdvaXR5dDhwelFEZGk5UFQyT21CYXh2VjNnMUxUU3llaEp2TXlRSHFs?=
 =?utf-8?B?ak10dFZpNzdaMjQ2ank4M2VtVWMwNTBrcjNzOXBhd2ZFRGxLdDRQM3FzNmc0?=
 =?utf-8?B?SVMraG1INnhLbGQvNzlFODNOa1NWQ1hsTC9tdGpodjBHWWNjQksrckNucm1C?=
 =?utf-8?B?REpFdGpOcXRlVHRWeHBYTXJtY01BNVZMeEs1SXM1RDlEZjdWUy9rSjFHSGtx?=
 =?utf-8?B?Sk45Z21HalZnVFNIZlByNm44b3BsckVDbmNDdkM0NTRFNzltUm1tQ2l4N3Jz?=
 =?utf-8?B?c0pwVHNBMVhpY2hHamlLWXZtbk41OG9XMGg0UmVYUE9Oc2pKVnpJcEFWOG0r?=
 =?utf-8?B?RkI0SXVHMkZTaElhTGRtZ0d5ejQ2SGl5bHBFRlFTbm5NTUpZMnRjMWhYd2pp?=
 =?utf-8?B?MVJHa2djcHNTUUNIL015SngxNVJ2Z1ZBeWNhVUdhdDBLK1JTd3hQQno4VlRy?=
 =?utf-8?B?aU1xdHlXaFJZM0h0VllxdFFoMU83MjhmSlJRYStrN2prR2JhZU9mVm9LODRl?=
 =?utf-8?B?MW5KNVE1N2QxVkZSeHpJaWtqVVlCUkNqWFppTDRsV3JheENnS2t0OEw3OCsw?=
 =?utf-8?B?U0lDWEpNeDE4N1lFb01VY01vM2tic2g0c3QvRWFBeituYmdlRTVMVE9TQTY3?=
 =?utf-8?B?TTdmVThBcW8wKzAwaW1IWUd1ZXhPSnVRUWM5c3JueTNXVm9vdFY5V04zb2pN?=
 =?utf-8?B?dTE3UXovYUlzWUtscThlTWpLQTNYMWZQL0krUTV5bUk4Q0gxYTgxaE56ZUhv?=
 =?utf-8?B?Y2ZBYkMyQ3J0eTJHWVVwZ3ZJVU51bVljTW9Rdm56VW1UcVVLcnlXYzlDUFhL?=
 =?utf-8?B?cFVtT3I0ekRjU0ZxYUJSVXNUMElhMUlZdXhZYmZVNjdLMjhiVDdIZC9DSnM4?=
 =?utf-8?B?MnBMekFRMFE4V2NsQldjZGhIelFCV1dDaURPTXdwWUo2cktNdEdIa0hhZlJx?=
 =?utf-8?B?NHZyK3NUVVU2SWFFU29sZEwzQXl4cXRLb3czSk5kdDFPZmhPSGNDSUhOREZE?=
 =?utf-8?B?OXdHd2Fsd1JreU83ZFp6cUEvSTFpSlBLY2dVYjU3Y25TNm4xWXgvTUZNZk1w?=
 =?utf-8?B?RGVWVVJ5SDlIWmIyZlJHSTFtK0lRdHRWdnBVcktZTkt3ODBUSGF1RFV2ODVi?=
 =?utf-8?B?UWF0Qng3eU1Zbmc5SSt0WERSTGgvc0w2eGpRQ2dHSUxFMk0xTnBFcGdheXBm?=
 =?utf-8?B?S3N5ZWNTQ3pFWnpEL0dPanN5L2RRQVBwQXdQOGZ4WWZQcHJFKzlPblZMdmNQ?=
 =?utf-8?B?elFDSERyRWV5QzAvMGdwNTNRLzZhT3JRNzBtUUJ1Y1lPOXJncG9oRVRCSHVh?=
 =?utf-8?B?MzJuZUJINUtPUDNXalQ3a0p0c0xML29EZGxqSEl3VnRuVHlqdFZLV0VnTkdm?=
 =?utf-8?B?b3pXdWMwZEEzOHA0ZGd2WlJXZ29oY0l5SmpzbEdVd01tYm9BZ0hIR1NzY3Nk?=
 =?utf-8?B?ZFZPSjJjYktneGZKZ0Rvd09mQVg1UHRUa0RIWlo4T01iWGJidUgxa0l6RkdN?=
 =?utf-8?Q?nz1Vf439DndsejLRWtdPqrXeWPYLJDbvMOIQ9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5305BB52B6D89F47877BE97B0CDD27AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pFXRDHD25fjuyMMlZW01MZHt94J48kx8pz3Mi082ngtYLYdBUYvIFGeCFjrUhAbDZdp5MuCZaiku8yaYKDGPIjHLBzs6XyFU0PO+InqfNnmpLvycBDCgbyjXft9HPM3yMUGfHfRDcgvslMhNCPg4STqz1KjS+zIkdCK1AfsyjTRyCHNCGq3kbMZKgZL2QNLSnuL0ejvvPewEDSs5vjxZkafi4ZsEPAOnRIbVILAJe2uNOJO85HBWNg6RYV/8YV9/g59j+xiQLrF7hlxXZNF5Jn3hCfiZWDtHde4hJMNzr6I0OzkQWWEUhaCdXgKuHHNkuoKOlTUqjLbDHVveRMOh+g==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4ddd12-15eb-4fd6-e022-08deb2b4e4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 19:05:13.5986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmooMFesCi70818TGD85xNTbf4KOAb77uZyduBC7Q2myZ+DsUPXYmWZB0/xnuH7fx6Hpmsm6JtXFjuI4edq80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6041
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YGxk6c_LkZ849kBaNLTwdPw60I1nbdjo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE4OSBTYWx0ZWRfX8jn9tuHEn2M2
 qZzQBemirYA8O0+H8aa0KX1wraLlgrXxsSUPFcCm0HTTgwliEjozoy8XadHMBolO0HwmW0TbD+3
 LJwY1N1M5ac7q6/ybUa0lyaqbK6VVLDIdMF+sg7O9Ux5hLMDfWtrgH2JXFruqH56jXUywP+XZ4h
 pNymDR+KPqrCgZy5rpr5DHsTp9QAKP0QK21GFnz7ljDnw1zJObabMHYjLKmoylkd8W+gLxTDgZK
 AGJCP+9q/jc5zS1K1vKaVl9MKsCiptmWITFiTrtaTmtECFVwyNbxMltpSjRN5SVE5ATxvK8JQFF
 Ep5Q22t1UeE6UkHiJ1ghkoMeyle8ECZ+u+MZmWe9LYLjVoU4X1/KtjlbOLZsyBWj2/hDuiwpDli
 d3q9ECp/H6tHSugb4llRG4eCBIrsdmglPTQEiUF867KTNYpaVqmE+SuG7rFdTyDlNtmPo0gc6re
 TV9XXPU59YMGuHb6J3A==
X-Authority-Analysis: v=2.4 cv=ZZEt8MVA c=1 sm=1 tr=0 ts=6a076e6d cx=c_pps
 a=fgNoY2FrYBgJmLE9YDNrYg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VOS-Z3Iv6m_viXl2wO8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ypf5zZ2D3F8aAL8p2d0R93kzfHpd988Q
Subject: Re:  [PATCH v2] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150189

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDEwOjExICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX01BUCBob2xkcyBhbiBPU0QgbWFwLCB3
aGljaCB0eXBpY2FsbHkNCj4gY29udGFpbnMgYSBwZ191cG1hcCBwYXJ0IGF0IGl0cyBlbmQuIFdo
ZW4gZGVjb2RpbmcgdGhpcyBwYXJ0IGluDQo+IF9fZGVjb2RlX3BnX3VwbWFwX2l0ZW1zKCksIGEg
bGVuIHZhbHVlIGlzIGRlY29kZWQgZnJvbSB0aGUgbWVzc2FnZSB0bw0KPiBkZXRlcm1pbmUgdGhl
IG51bWJlciBvZiBpdGVtcyBhbmQgdGhlIHNpemUgb2YgdGhlIGFsbG9jYXRpb24gbmVlZGVkIGZv
cg0KPiB0aGVtLiBJZiB0aGUgbGVuIHZhbHVlIGlzIGdyZWF0ZXIgdGhhbiBvciBlcXVhbCB0byAy
XjMxLCBhbiBvdmVyZmxvdw0KDQpUaGlzIHBocmFzZSBzdGlsbCBzb3VuZHMgY29uZnVzaW5nLiA6
KSBCZWNhdXNlIGxlbiBpcyB1MzIuDQoNCj4gb2NjdXJzIGluIHRoZSBtdWx0aXBsaWNhdGlvbiB0
aGF0IGlzIHBlcmZvcm1lZCB0byBkZXRlcm1pbmUgdGhlIG5lZWRlZA0KPiBzaXplIG9mIHRoZSBp
bmNvbWluZyBidWZmZXIgdG8gZGVjb2RlLCBhcyB3ZWxsIGFzIGZvciB0aGUgbGVuZ3RoIG9mIHRo
ZQ0KPiBhbGxvY2F0aW9uIGZvciB0aGUgY2VwaF9wZ19tYXBwaW5nIHN0cnVjdC4gU3Vic2VxdWVu
dGx5LCB0aGlzIHJlc3VsdHMgaW4NCj4gb3V0LW9mLWJvdW5kcyB3cml0ZXMgKGFuZCByZWFkcykg
d2hlbiBkZWNvZGluZyB0aGUgaW5jb21pbmcgbWVzc2FnZQ0KPiBmaWVsZHMgaW50byB0aGUgY2Vw
aF9wZ19tYXBwaW5nIHN0cnVjdC4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIGJ5
IGFkZGluZyBhIFVMIHN1ZmZpeCB0byB0aGUgbGl0ZXJhbCBpbiB0aGUNCj4gbXVsdGlwbGljYXRp
b24gdG8gcGVyZm9ybSBpdCBhcyBhbiB1bnNpZ25lZCBsb25nIG11bHRpcGxpY2F0aW9uLg0KPiBG
dXJ0aGVybW9yZSwgdGhlIHJlc3VsdCBpcyBzdG9yZWQgaW4gYSBsb2NhbCB2YXJpYWJsZSB0byBv
bmx5IHBlcmZvcm0NCj4gdGhlIG11bHRpcGxpY2F0aW9uIG9uY2UuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4gLS0t
DQo+ICBuZXQvY2VwaC9vc2RtYXAuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBo
L29zZG1hcC5jIGIvbmV0L2NlcGgvb3NkbWFwLmMNCj4gaW5kZXggOGI1YjA1ODdhMGNmLi5kNDE2
YTExY2UwY2EgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL29zZG1hcC5jDQo+ICsrKyBiL25ldC9j
ZXBoL29zZG1hcC5jDQo+IEBAIC0xNjE1LDEzICsxNjE1LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgY2Vw
aF9wZ19tYXBwaW5nICpfX2RlY29kZV9wZ191cG1hcF9pdGVtcyh2b2lkICoqcCwgdm9pZCAqZW5k
LA0KPiAgew0KPiAgCXN0cnVjdCBjZXBoX3BnX21hcHBpbmcgKnBnOw0KPiAgCXUzMiBsZW4sIGk7
DQoNCldoYXQgYWJvdXQgc2l6ZV90IGxlbiwgaTsgZGVjbGFyYXRpb24/DQoNCkhvdyBkbyB5b3Ug
ZmVlbCBhYm91dCB0aGlzPw0KDQpjb25zdCBzaXplX3QgaXRlbV9zaXplID0gMlVMICogc2l6ZW9m
KHUzMik7DQoNCj4gKwlzaXplX3QgcGF5bG9hZF9sZW47DQo+ICANCj4gIAljZXBoX2RlY29kZV8z
Ml9zYWZlKHAsIGVuZCwgbGVuLCBlX2ludmFsKTsNCj4gIAlpZiAoKHNpemVfdClsZW4gPiAoU0la
RV9NQVggLSBzaXplb2YoKnBnKSkgLyAoMiAqIHNpemVvZih1MzIpKSkNCg0KaWYgKGxlbiA+IChT
SVpFX01BWCAtIHNpemVvZigqcGcpKSAvIGl0ZW1fc2l6ZSkNCg0KPiAgCQlyZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4gIA0KPiAtCWNlcGhfZGVjb2RlX25lZWQocCwgZW5kLCAyICogbGVuICog
c2l6ZW9mKHUzMiksIGVfaW52YWwpOw0KPiAtCXBnID0gYWxsb2NfcGdfbWFwcGluZygyICogbGVu
ICogc2l6ZW9mKHUzMikpOw0KPiArCXBheWxvYWRfbGVuID0gMlVMICogbGVuICogc2l6ZW9mKHUz
Mik7DQoNCnBheWxvYWRfbGVuID0gaXRlbV9zaXplICogbGVuOw0KDQpTbywgc2l6ZV90IGNhbiBr
ZWVwIDJeNjQgLTEgb24gNjQtYml0IHN5c3RlbSBidXQgaXQgY2FuIGtlZXAgb25seSAyXjMyIC0g
MSBvbg0KMzItYml0IHN5c3RlbXMuIFNvLCBwb3RlbnRpYWxseSwgdGhpcyBjYWxjdWxhdGlvbiAy
VUwgKiBsZW4gKiBzaXplb2YodTMyKSBjYW4gZ28NCm91dCBvZiBhdmFpbGFibGUgcmVwcmVzZW50
YXRpb24uIEhvd2V2ZXIsIGFsbG9jX3BnX21hcHBpbmcoKSBleHBlY3Qgc2l6ZV90IGFzDQphcmd1
bWVudC4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhpcyBjYWxjdWxhdGlvbiBjb3VsZCBiZSBzdGls
bCBwcm9ibGVtYXRpYyBvbg0KMzItYml0IHN5c3RlbS4gQW0gSSByaWdodCBoZXJlPw0KDQpUaGFu
a3MsDQpTbGF2YS4NCg0KPiArCWNlcGhfZGVjb2RlX25lZWQocCwgZW5kLCBwYXlsb2FkX2xlbiwg
ZV9pbnZhbCk7DQo+ICsJcGcgPSBhbGxvY19wZ19tYXBwaW5nKHBheWxvYWRfbGVuKTsNCj4gIAlp
ZiAoIXBnKQ0KPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gIA0K
