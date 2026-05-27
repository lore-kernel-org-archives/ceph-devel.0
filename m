Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC012F585
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905069; cv=fail; b=cQ7RMM+vIassQDwUKyLVnZd4KPoJIEEHZv1RVdwAttyxp+uQgbSMmLBdQ0DXH/bXXG7+lSCx1DL9O1daZbAbgFPjb6vKQNSsCrki8ek6NxExfLEiHjtIABumBlae9yuaqRjvBFfkQY3ISUYy6s98dfd6gU59afysRVaZuAp71zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905069; c=relaxed/simple;
	bh=B8BdyxfGVC0Tsj0jebmdZjyGdfb1LuyMoy1o/2BMdH4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kbhLEoeTfBICm2yG7Y0EsNA55aP+zSFciZFxtbg6AKxcXzYkcGF7J9SuNMbkMRGUQqdb3wYCj3dxe1wxvLcMiAk7SwdBNiUJjgFsyrbGX0pc04GJueHx2zsfH7vHdmtUKNMCOrbVA2yH82V2cCmje7JeJlE1zC901pzV/wjzo38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VLwwTwE1; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VLwwTwE1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCswXJ3810729;
	Wed, 27 May 2026 18:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=B8BdyxfGVC0Tsj0jebmdZjyGdfb1LuyMoy1o/2BMdH4=; b=VLwwTwE1
	oGz9wnqlEKzuS9Bf3h0kP4pc37qvlGQb5d0Ic+/abqLb96WeDTZHHEVs/o+0uhDZ
	w0daZbmjaTIAkRmg8IUGl0f2N5Ja9Uj9jCkHSJOZL8hrHANniRNzxPlgY/QvFiZo
	VmHjeziZtIXUE7rdDToLB6VfWxLSe9iHspGMhP0AUtrCkK2geqJ+BrCzVCGry9y0
	Zww2oN6CHf+kHQMciBmIhefp6dyxq1RPXP51KIJ+l8PMFOIF4mdRYqgerkHydMgs
	c1bnpOA2eg/FChhh0Ij98lKw93LjRIG6YxWeo8+c8KibaBJaheMneLCPFGrbNV3D
	objZjxbIcccl6g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc2rpj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:04:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbR4vMnynVgfkHPbXPo0O4aa2t5o2UdNLnKkSarGRlR19F9CEsGcM+/XUuk08BCQEWjskKfNbNJ1oocceDbDD3qGcDOt1ap3b6/vvgGg7x2kavvUNtX4RTsxjnqj2Rk3jcujkEEF6URVBIpWeoD5B+Rk+0ts7P9VoOK4qOedeNC9YNnh+lamskTxFNIHagh2iPeauFZR05pv0ql4benqmKBadtPB2PLgxYlcSXJXNPWMXmTDM7AiVbvNR2GkXulpLNa4J/4h8cZgwZIsvlVTfUY940LXZd6iZPNg3HnmoRW/x0aYNPrH3hS0m9juZOun0wT16soNWc+DU7Gxhkchrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8BdyxfGVC0Tsj0jebmdZjyGdfb1LuyMoy1o/2BMdH4=;
 b=p0iB2mqlaoQ0HRmtjcHs7P47GQrJBhh8LkxIZ5DJ7eLzrzq4UJXpF5fDc+xr+M9Nuklh1zAFR+r0xmRU8DVZh4zC6DcvTs2ROyJLXWL8sIocj9uIMLAWi7jMo773dSNVtibDC8N3BQYHAlcX2rQUcGWNM82zHnyiIkSKbOHUDBCTpfWDH/vLcHTR2huitNUNDovdQkwEhaIrU2B7UEwJtnMDFwoPMoBXmxyW8uvMrYwaavg7DxqufLBGaeHmhIwj55LbmERpsRgHhhlBUN+gxAncfRWgZg9/j7LG/zRLhtZm0NB49wMVCnINdnXrJT9gSGfRZJiRJIbkg/kFjHN52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF118F27D8B.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e07) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 18:04:11 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 18:04:11 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Reject monmaps advertising zero
 monitors
Thread-Index: AQHc7bcXJhRKpgtIlUq0c/0xReXfqLYiKwEA
Date: Wed, 27 May 2026 18:04:11 +0000
Message-ID: <f50a3838477f3cf217a5d8271a0935d2f6d4be81.camel@ibm.com>
References: <20260522154420.3324836-1-raphael.zimmer@tu-ilmenau.de>
	 <502b1825d71f4ec870b64ec8257946a916bb0fee.camel@ibm.com>
	 <d2c60213-a6c1-4caf-980a-575b1c43fcb9@tu-ilmenau.de>
In-Reply-To: <d2c60213-a6c1-4caf-980a-575b1c43fcb9@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF118F27D8B:EE_
x-ms-office365-filtering-correlation-id: 7c4c51c1-f7f3-4c1c-5d3f-08debc1a5b04
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021|4143699003|11063799006|22082099003|3023799007|18002099003|6133799003|56012099006;
x-microsoft-antispam-message-info:
 7XjgwICKTqpnQgdXdG1hi5+6u5QTZkLV9it3RVml+dlDCiSGkePtZGkvYY0QB76SEs5E4Pra0nGVGrlEp6tBi8TrQXHa9sLTKDQ9ukHRICNhG2HxKZ9j8PzWUzDwZehDKYPUu56ozp3rnTgEBz3GRk2pB6Qtisp7CuraLQ1FcXsUy8NvirRW52OG3o9Bb0qV0rontTSRVFH2aSXK+tW4V6q1jrelXqm4ewmjjzgapcN39/EapOokXCoughuuCKIGPRxCbxItCW7V10usWQrVr0s9K0NxAFzUtN20a77uh+YMASJWpZ5al6shGKBc9ugHoe63vS+eV6S7F6XqB/L0yDsJHuoZ1e/GZKGdo7JcVGmPDl0AAJIVdg7IJXLNetvKVZuVl8cc9O/9I4WJQ5DSOnYvABfl9Tbg154zGIdLglsaw2c0Fy90QYu6W+d4LWmylh1WJieMxT0pVVGq4bqAjmOwNa5+TiUhkJGbUCMKzFeUrmqwQipcby/GO/Rra8FvNX57J/ppr8pdMvyOvis+OYtIbuOX2I3JQTHMuHWj9yN5ofPZMUKnrsgzJUQBvaXWHRorSKDg1MdGdxQ9Z78FqDy+nRZpnTF/jP5dwhwt1PldLY/FI7uw0CMpP/VAFrsQ3OlnJacoDorrX5Fx9d9Qd7R7Hg/PiGmOsGcBIWeFwLZh18wUrPBKb/WTIYf8IyjvhCU7vWsLRr/E9jOvXlEkeELhxZeiLIXnJVLUGvAhIJTtZdLeQe2b65eAuf+VzN0g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021)(4143699003)(11063799006)(22082099003)(3023799007)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3hVN3dGdnpYV3pDNlU2ZTJjSHR5d1ZkZzN0UmNUbzkzbDEzeVNIaFFDdEJ3?=
 =?utf-8?B?azRzcTFIMEdHTXBnY0RNNkYwWUlPQ0VscHAvRFluSmtPdUU5bG5XT1cwa2lL?=
 =?utf-8?B?L3g0QVB4RDlEbFcrcGMvU1ovUTZtRC9pQUFDalMyYit0T3BvblJ6RlJiaEQ3?=
 =?utf-8?B?cUorc3BKYkw3amk1L2RYSmsvdGZDVUFwTktnQm1tbTd0endSc2lkOUFuK0ky?=
 =?utf-8?B?VjJUZG95ZjB4ZE1sd3V4VEpvRUdRN29oMXNXQXd5cnpndnJEenh5YWR0R1dL?=
 =?utf-8?B?RGZoVWZQdW1kTWZBWjZEeEk2NkVkZHRSV2UyOXJIdlNrQkFOUVA4Njd1L1M1?=
 =?utf-8?B?MEo4VXp4d2g2YVlyelpJODlzWFl6dGVUakExWjdDZ0xqZ25GckVNTW85VkRu?=
 =?utf-8?B?T2YwTnhwRkdZZVlBdDEvbFV2MktmNEI2NzZNRU5HMWZPNGFSQzlJcFlUaVJ6?=
 =?utf-8?B?TlRJNmpGRHd0N3FnSHFvb0lJeURxOEljV3dKSlZ6OUhlYUpmSmE2SzZ5RkJE?=
 =?utf-8?B?aEFXZC9KcERTNEpZVlR6SkhxcHFjaXFNRUI2TlZjWDZyV0RnSitqVlNVTUFB?=
 =?utf-8?B?S0JzTTRGNU5BQ2ZvMTNBZTNUZVRjUVZlWmNFYjZIVTNqeTFxSmFlbEhDOFBD?=
 =?utf-8?B?T01qYWd5bElNdnFDWUFSYlJXSm5tQ1VMMXBKUG5idTN5dEM5Rm5DVTNzeDEr?=
 =?utf-8?B?NGtZVFJONEtya0xJd1JIWVBXTERKZEllSEttREtTN1AzWkg1dVExb3VEZlU5?=
 =?utf-8?B?Q2YyMmJjb2FHSDlKc3RYSjlOdFVtakdPQ2hNL3YrVGF1V3d4S284VGxwQ0la?=
 =?utf-8?B?ZnNqMW56RnhTUitWWW94SjhQOHB6UEtFcDZxMVdNMm0xSWtTUU1LaEVjV1Bm?=
 =?utf-8?B?a3UrYitWNko0aGNrYjFhTHJ6QWt2OUxEMy9rMVExVmZLNXpNdENjdHV2VTZn?=
 =?utf-8?B?MVcvMTJiL1RCUjlEbldZby9MeStjQmtpdkI1TlNFd2xHa3pYZ3Z4Z2ZMcVhu?=
 =?utf-8?B?dWdHUVoxcHY4T3Yrd0JOYWlINTlINTRXSGJ5dTU5Vnl0ZVJWVmY3M2xRVHpS?=
 =?utf-8?B?SVVFVk1UOGNTSm9XWU1RQVBYUzBDMndaSk5DcnZLeWJKbnhma2wxNWNieTMv?=
 =?utf-8?B?SWNmOFlKeG5iOE05dXNNOXBiZWhzK0hhZWtyWVlTbTZvbUdmdkdNYUxlT1VM?=
 =?utf-8?B?LzBMVEtWeEFlZnNKY2EzU2lmYTQ2ZkhpcTVBdFJCQ2Rjb1k3MGF1MXU5WG5P?=
 =?utf-8?B?M0FQSlAxM1RiVWRxQTFqNXB1T29UZ0thdUxOUC9TYXpwU0NYKzZyOVBMbmc3?=
 =?utf-8?B?OVhGQkpncTRnZVVlRzNuYk45VjVVWXVVNnNKNjZhZnlPcWtmMFNrNFBFV0hE?=
 =?utf-8?B?a3NyYkt1WCtqYk9ab3VPeEZEUk1aSUlDWEszM0ZFaWlwT0JQd3JzSjFLMnFr?=
 =?utf-8?B?MjhRcXFDVFFsUWNzSE1mbVVlUmRTekdWSUlLUG9Sa0hRQlhkOW5rUGF0NEFK?=
 =?utf-8?B?RlUzZ3dVb3dXRmZoZXpub3g0SEZHNDdnTjhwOGhES0ZIN2p6bjErNGVMZzNs?=
 =?utf-8?B?WUJWWWVJcG9GeUhFYkcyNkppbUtZZEV3eldTb1d1eG5FQWlZb1FiRFMyVVJz?=
 =?utf-8?B?Q3ZhcnZwWDVUV243d0V1bEhiRVpzOWtIdDh5aXBEKzJ6ZzlSdEZiczhFSmpm?=
 =?utf-8?B?c1hia2ZZTFl3azFyRVpodUp0U2l2ak9CeGpNMEZLTE1wSS9zU0Y5cFBmd3Ez?=
 =?utf-8?B?WnE0OEtyT0s3SFBrcWQ5ejBQZ0ZWSmZpSHdyeS81S3dxaXV3ZXlsOUlnS0VX?=
 =?utf-8?B?eFY4eXoyK01JR24yNXlUa05yNzlmYkY3eXp1S2wyU1NkNTNTM0c3MkE1bE1S?=
 =?utf-8?B?RmVtTjNsNGNIN0ZVR0Y0WkVEWVpZWXR0M0Q4ajlmM1hJOEdKMFpSOG03MUhK?=
 =?utf-8?B?REdDWUlTaFhRQmo4SU8ySUFQbGl1SENtcVFLTDBLZjZtcU5Mc1NYNWEvejdS?=
 =?utf-8?B?LzA4MTlwcGI4NmZHM1RoaWhMMzV2NHBtU1NHMVl1SnNjU3hkR2cxc1prWis3?=
 =?utf-8?B?RFp0dXJXT0puR0M3Z252YWZYYUhxOEEvUGRTd2FLRkJHNDBjSG1WbytkUWlr?=
 =?utf-8?B?YlpERGNuNEhOUUtKc3I0WFhuTEZnaGtjdGxxWHNaT0hYRFYvUmFxY1ROeTNJ?=
 =?utf-8?B?bVRnTDNpMDBsQlV6K2JuZUxVT3JnNmxRb25MYy9ISGg1Wmd6cTIrRFk4ZmVR?=
 =?utf-8?B?dGhIMGdqaWQrSitvZTRZb244T3BadTdVZjdZVFJKdWZZMkxvQ0E4ZHZYK1R6?=
 =?utf-8?B?V1JITERPT1FlSlNNK28yNmlOd0tKb2Nxb25nUUZ3NFNTbEQ0TjQ1YUd4dGZt?=
 =?utf-8?Q?+w/8R4bxBGOjwS27I+eZKkpcDTpxg1sFvwGi0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EA06096B6D5264498A117B6E8684EEA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pcmSEtKxzi2lXB4uWquFoZdyWK5cDWuhOwXHzwe9vdTOLp/ueb9GCJJ10Xntk/fH+TtRCfWImMEp5x6Itc1OfQouiTYRbZFvmIH0nIbnDoJe5SIL5sP2ZnnVoKK5o50cq15GyiVaU62xZfZ5j49ndBqx+I1jKhIU9p46/5wnDIZ6A771ePdkUoayXH0aXXNksWiGnzmhLo1PmqgvQ+/4R90+jN8Gw8G5x+2B//mDd4MVnBSfTF6zIbcwnB7rN6Kjg56MZWOGqI9ynMqvJq7NNLjWUD7BlnG8IeueickU5hn/yL9EPID85QcmIFbkpX/G9FeRJxXu61ktyazJIErzsw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4c51c1-f7f3-4c1c-5d3f-08debc1a5b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 18:04:11.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24Q0zQ6yLoMCmj1GOLVwAmMITFfqQwJih30Bt6Pyd2dtEIjnvhnOpVfopFiR0TeM9wWuKzumv9F833ph7zdx3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF118F27D8B
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3NiBTYWx0ZWRfX1JCbAL+vtP6o
 y8vlZl57fuvzjcZns4blD0u6wN5EyafcHAeT1E5JiDWUq7lYZn3nAXy9jiV0GQs/NSwNgUWj83d
 EIEPuPmu+uzO2RZA2m6HOhTCDZmnOd+rmhOUukDOz4ew5G3HRP7/jcqPkYshCockRhK5+jjal9J
 p+YJRO+Qqpqd+olBxENYWd+WbEjyqGKgXpzxpyzdJHJHMljhOaIKbYAVw/Tml9R9G3/zArWKFbm
 pQFRiJq6yNKZst/7QPz3AlH/i5cl2nfJ3nkjopRNJtrSB28Bpm72b6TNsqpWzd5+QnXchxD839G
 ptY+Bx1sTkThBNMqOzK/nEQ0LUJgOZesceCOprDsHZ5/fTM3ohso2ho2SrBYXVYwUkBUsG91dgr
 hP7k9X9e0YEQx0++eO6/MvJUWlQeiECdOMtfMcjayRMnmvBiVXK0jhI2YhTacL5mT2R+vvQSm32
 zoKLRgl86az/EsgMoug==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a17321e cx=c_pps
 a=MBvOscNZ4ImqL1nQClNoCg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=-uyCxzXkAOL0yJH5fSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jQhGWEPh4R8Ct1xkZ---kMc_GqdTEnAY
X-Proofpoint-GUID: IZ0NjxkSwa3yNGEnSCdoZCbUxYkPSIaA
Subject: RE: [PATCH] libceph: Reject monmaps advertising zero monitors
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270176

T24gV2VkLCAyMDI2LTA1LTI3IGF0IDEwOjU5ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMjYuMDUuMjYgODozMCBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9u
IEZyaSwgMjAyNi0wNS0yMiBhdCAxNzo0NCArMDIwMCwgUmFwaGFlbCBaaW1tZXIgd3JvdGU6DQo+
ID4gPiBBIG1lc3NhZ2Ugb2YgdHlwZSBDRVBIX01TR19NT05fTUFQIGNvbnRhaW5zIGEgbW9ubWFw
IHRoYXQgaXMgc2VudCBmcm9tIGENCj4gPiA+IG1vbml0b3IgdG8gdGhlIGNsaWVudC4gVGhpcyBt
b25tYXAgY29udGFpbnMgaW5mb3JtYXRpb24gYWJvdXQgdGhlDQo+ID4gPiBleGlzdGluZyBtb25p
dG9ycyBpbiB0aGUgY2x1c3Rlci4gQ3VycmVudGx5LCBhIG1vbm1hcCBpbmRpY2F0aW5nIHRoYXQN
Cj4gPiA+IHRoZXJlIGFyZSB6ZXJvIG1vbml0b3JzIGluIHRoZSBjbHVzdGVyIGlzIHRyZWF0ZWQg
YXMgdmFsaWQuIEhvd2V2ZXIsIGl0DQo+ID4gPiBpcyBpbXBvc3NpYmxlIHRvIGhhdmUgemVybyBt
b25pdG9ycyBpbiB0aGUgY2x1c3RlciBhbmQgc3RpbGwgcmVjZWl2ZSBhDQo+ID4gPiB2YWxpZCBt
b25tYXAgZnJvbSBhIG1vbml0b3IuIFRoZXJlZm9yZSwgc3VjaCBhIG1vbm1hcCBtdXN0IGJlIGNv
cnJ1cHRlZA0KPiA+ID4gYW5kIHNob3VsZCBiZSB0cmVhdGVkIGFzIGludmFsaWQuIEZ1cnRoZXJt
b3JlLCBhIG1vbm1hcCB3aXRoIGEgbW9uaXRvcg0KPiA+ID4gY291bnQgb2YgemVybyBjYW4gc3Vi
c2VxdWVudGx5IGNyYXNoIHRoZSBjbGllbnQgd2hlbiBhdHRlbXB0aW5nIHRvIG9wZW4NCj4gPiA+
IGEgc2Vzc2lvbiB3aXRoIGEgbW9uaXRvciBpbiBfX29wZW5fc2Vzc2lvbigpLiBUaGlzIGhhcHBl
bnMgYmVjYXVzZSB0aGUNCj4gPiA+ICJCVUdfT04obW9uYy0+bW9ubWFwLT5udW1fbW9uIDwgMSki
IGFzc2VydGlvbiBpbiBwaWNrX25ld19tb24oKSBpcw0KPiA+ID4gdHJpZ2dlcmVkLg0KPiA+ID4g
DQo+ID4gPiBUaGlzIHBhdGNoIGV4dGVuZHMgYSBjaGVjayBpbiBjZXBoX21vbm1hcF9kZWNvZGUo
KSB0byBhbHNvIHJlamVjdA0KPiA+ID4gYXJyaXZpbmcgbW9uX21hcHMgd2l0aCBudW1fbW9uID09
IDAgcmF0aGVyIHRoYW4gb25seSB3aXRoDQo+ID4gPiBudW1fbW9uID4gQ0VQSF9NQVhfTU9OLg0K
PiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1t
ZXJAdHUtaWxtZW5hdS5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gIG5ldC9jZXBoL21vbl9jbGllbnQu
YyB8IDIgKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBi
L25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiA+ID4gaW5kZXggZDJjZGM4ZWUzMTU1Li42YzVmODMz
NzkwNTUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gPiA+ICsr
KyBiL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiA+ID4gQEAgLTExNCw3ICsxMTQsNyBAQCBzdGF0
aWMgc3RydWN0IGNlcGhfbW9ubWFwICpjZXBoX21vbm1hcF9kZWNvZGUodm9pZCAqKnAsIHZvaWQg
KmVuZCwgYm9vbCBtc2dyMikNCj4gPiA+ICANCj4gPiA+ICAJZG91dCgiJXMgZnNpZCAlcFUgZXBv
Y2ggJXUgbnVtX21vbiAldVxuIiwgX19mdW5jX18sICZmc2lkLCBlcG9jaCwNCj4gPiA+ICAJICAg
ICBudW1fbW9uKTsNCj4gPiA+IC0JaWYgKG51bV9tb24gPiBDRVBIX01BWF9NT04pDQo+ID4gPiAr
CWlmIChudW1fbW9uID4gQ0VQSF9NQVhfTU9OIHx8IG51bV9tb24gPT0gMCkNCj4gPiANCj4gPiBU
aGUgcGF0Y2ggbWFrZXMgc2Vuc2UuIEJ1dCwgSSB0aGluayB3ZSBuZWVkIHRvIHJldmVyc2UgdGhl
IG9yZGVyOg0KPiA+IA0KPiA+IGlmIChudW1fbW9uID09IDAgfHwgbnVtX21vbiA+IENFUEhfTUFY
X01PTikNCj4gPiANCj4gPiBJdCB3aWxsIGxvb2sgbGlrZSBtb3JlIHJlYXNvbmFibGUsIGZyb20g
bXkgcG9pbnQgb2Ygdmlldy4gV2hhdCBkbyB5b3UgdGhpbms/DQo+ID4gDQo+IA0KPiBJIHRoaW5r
IGl0IG1heSBsb29rIHNvbWV3aGF0IGNsZWFuZXIgdGhpcyB3YXkuIFNpbmNlIHRoZXJlIGlzbid0
IHJlYWxseQ0KPiBhbnkgZnVuY3Rpb25hbCBkaWZmZXJlbmNlLCBJIGNhbiByZXZlcnNlIHRoZSBv
cmRlciBhcyBzdWdnZXN0ZWQuDQo+IA0KPiA+IEFzIGZhciBhcyBJIGNhbiBzZWUsIHVzdWFsbHks
IENlcGggY2x1c3RlciBoYXMgb2RkIG51bWJlciBvZiBtb25pdG9ycyAoMywgNSwNCj4gPiBldGMp
IGFuZCBub3Qgb25seSBvbmUuIEkgYW0gdGhpbmtpbmcgc2hvdWxkIHdlIHNoYXJlIHNvbWUgbWVz
c2FnZSBpbiBzeXN0ZW0gbG9nDQo+ID4gaWYgaXQgaXMgbm90IHNvPyBXaGF0IGRvIHlvdSB0aGlu
az8NCj4gPiANCj4gDQo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGlzLiBXaGF0IHdvdWxkIGJlIHRo
ZSByZWFzb24gZm9yIGl0PyBJZiB0aGVyZSBpcw0KPiBvbmx5IG9uZSBvciBhbiBldmVuIG51bWJl
ciBvZiBtb25pdG9ycyBpbiB0aGUgY2x1c3RlciwgdGhhdCdzIHNvbWV0aGluZw0KPiB0aGF0IHNo
b3VsZCBiZSBzZWVuIGZyb20gdGhlIGNsdXN0ZXIgYW5kIG1hbmFnZWQgdGhlcmUgaWYgbmVjZXNz
YXJ5LiBTbw0KPiB3ZSBhcmUgdGFsa2luZyBhYm91dCBhIGNvcnJ1cHRlZCBtb25tYXAgYXMgY29u
c2lkZXJlZCBpbiB0aGlzIHBhdGNoLg0KPiBDbGFpbWluZyB0aGVyZSBhcmUgemVybyBtb25pdG9y
cyBoYXMgYW4gYWN0dWFsIGltcGFjdCwgYXMgaXQgbWF5IGNyYXNoDQo+IHRoZSBjbGllbnQuIEEg
bm9uLXplcm8gdmFsdWUgaXMgdmFsaWQgYW5kIGNhbiBiZSBoYW5kbGVkLiBJZiBhIG1vbml0b3IN
Cj4gbGllcyBhbmQgYW5ub3VuY2VzIGEgZGlmZmVyZW50IG51bWJlciBvZiBtb25pdG9ycyB0aGFu
IGFyZSBhY3R1YWxseQ0KPiBwcmVzZW50LCB0aGlzIGNhbiBoYXZlIHNvbWUgY29uc2VxdWVuY2Vz
LiBBIGxvZyBtZXNzYWdlIGNvdWxkIGJlIGhlbHBmdWwNCj4gaW4gZGV0ZWN0aW5nIGl0LiBCdXQg
YSBtb25pdG9yIGNhbiBhbHNvIGFubm91bmNlIGEgd3JvbmcgbnVtYmVyIHRoYXQgaXMNCj4gc3Rp
bGwgb2RkLiBBbmQgaWYgdGhlcmUgaXMgYWN0dWFsbHkgYW4gZXZlbiBudW1iZXIgb2YgbW9uaXRv
cnMsIHdlDQo+IGNyZWF0ZSBhZGRpdGlvbmFsIHVzZWxlc3MgbG9nIG91dHB1dC4NCj4gV2hpY2gg
bG9nIGxldmVsIGRpZCB5b3UgaGF2ZSBpbiBtaW5kPw0KPiANCg0KSSB0aGluayBwcl9ub3RpY2Uo
KSBzaG91bGQgYmUgdGhlIHByb3BlciBsb2cgbGV2ZWwgZm9yIHN1Y2ggaW5mby4NCg0KVGhhbmtz
LA0KU2xhdmEuDQoNCg==
