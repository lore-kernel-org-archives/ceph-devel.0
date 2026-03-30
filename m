Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AA30C34E;
	Mon, 30 Mar 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891807; cv=fail; b=doBhLw2LsSBWl8Q90vQiKp9GEzglA/PmjqCkiF4HuiRLL60KdBgvPo8Kuzue9Kqh6TiWaT6HAWcmTH7Y6VWNwKEcaATh0hfrEno9Mzz5kqTHkyhrEt8eSXjYGdKc1EJlS0IFKKqV5pJCSIUozTCQhefj1WGEhl2GwB9og490eCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891807; c=relaxed/simple;
	bh=KTgPzfnL4tEAUALeowA5zZD5nZKmuJilb9wAN9g4fnA=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=d0wlv3HG4Md/gUeBzDqChcU91Ngn5n/7xDgE5C5f+abhK8XaseIowXGrgP8VT0eUnbBYWmZhMipt27ugWDxMNaozc2gFuwuFRLOPIZ9t2M+2koS7PYLct1mOK7UNFDWAJXbIfuUcrwGwVaBdBs2GWB/1i5/w/Kb7lziw6Zjj1vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNtm87TM; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNtm87TM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U79V3L2273702;
	Mon, 30 Mar 2026 17:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=KTgPzfnL4tEAUALeowA5zZD5nZKmuJilb9wAN9g4fnA=; b=rNtm87TM
	6S6e99FB6V7Lez6oaOiSs0xCx68veEuryRqGrwST+TYEcID1prtdtUp5khJDAgxF
	EKLgImeREYp8AmgtXBN+hFIBmUsB42RGvJfsI3SsBM3uiAo0AeyZeB7UcyQJ6E3k
	Ah4lT8Lsy4+yK0ZcemL1NtjaHmUnL2ePdeNUfMrbSWVY5olnNDKX0NKIj2gTCdq7
	OYR8wiYGITfAXp19D7/yq3s/Bei+uoNyyVt0qwOqBPDGJgFecODJgGDXL7IYMgwa
	tduv0ypAWahtxcezmNsydF8lxGPajp+hBtx1inPmTArF+vErSd7iGEpYp/Tg4V+K
	rIY4xhAiUDCeNw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnfx6r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:30:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cte8BMI1DyyJxmwWNrUkztUK3hkbu6kqPlQr0u/191IxovBOY5Y1DhOlgAjTd+hw/nfs6izY9d8ObEfjSqVdXE0Xdj3+rW9A/Cr8Vk7uybEw0ccndXRISrU9Ck0vYLPxbehzfKzrKS0Re0fbjuKefl9Ilt6FpGDqb9zEdVMBViOkNJ65UjCFboGFyWFgPhC4GxroEY8+cvRsumW8VLZ6ZlfumU2tPDZzJZRkrjzCRNKMGz+bjvMv0vZJNq9gr0EYGn2F8W2sAlsASucLsGiS16iJG6xEyI9Qk/MUyME0tA/q7metgPWSRwz6udmLU/jfkn0A1xVxCbN4Lwx/44qKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTgPzfnL4tEAUALeowA5zZD5nZKmuJilb9wAN9g4fnA=;
 b=vkFMqKvNiw6WbYsfY8ORG4Q2gTLM8IflrGbj1sZO3pKiY5+dPDm8i8izLW/0kwQyqSzRgeVWXp/OZ1/Onfz0Q52fYJC3kUL+YBnakIt/4j4WMjuCL3rn1rnf4kpGj03pe/kl9EAz17SyYUUD5XYpf5F9zOVYG9UjsQqxLFtohk2DUw+foVQk56rJwxTDsh7VgC+Dq/c4SqKrmzLyXyZqD0pyoXV/gmDE0L7vsp66LC1RS4umKAFpdpv24uRBlWbF3LkdGHsKiZhXY6BmqqVmmY2mov4yp4wGgmVLehhK4g3Bwu75Dkgpn8zzABi7jSFkv8cYR47rb6tlR0r4RCsx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM3PPFE7FB53C35.namprd15.prod.outlook.com (2603:10b6:f:fc00::44e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:29:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 17:29:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: clear `s_cap_reconnect` when
 ceph_pagelist_encode_32() fails
Thread-Index: AQHcwCMgvYPJmlOkfEq1PYezlavxPbXHVVqA
Date: Mon, 30 Mar 2026 17:29:52 +0000
Message-ID: <edbc43fe2e234c41e1c72275c176fc22dc773a58.camel@ibm.com>
References: <20260330084319.1357751-1-max.kellermann@ionos.com>
In-Reply-To: <20260330084319.1357751-1-max.kellermann@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM3PPFE7FB53C35:EE_
x-ms-office365-filtering-correlation-id: cd0ca87f-3190-4736-5079-08de8e81f3b1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 F3xfPs9yDm8n8E5hiMnf//s5THia0hrmXwbNkejge4sHHdV5pFXV9JwAOdpn8bVTjnKA8R8OZ8zMh3f7QGdbmOcBgHR3/bVEDzSoJxai5PEFvJIMaT6xOzCfyl8z46M9k6InGlWl1NrOVBe2f3Uvo1RVISl0N0qpqMNRoJwVW/Wb59qI+1lWdkhYse/WrMABPciYTRC4Q2cB1wq1fL6CVK02AmFIhyPVelCjkK+uOXfOzuv7eFXE54aduoRMXhPm69jD896Y5kzEnuKrjNN3uU+hM0M/3OfiCUt3yeT9CVTSbfyfcAYRJByPh4yyVp5mcVtKABomv1wnbyjoFDDTNDLKaKfBqoNFQ1iwrHtkoPMPjAHDUhPedaRRRy8ZsHhVkDbHdea/FOj33PwZS8tAStPtN21/usLtOym8Et/Ydj4O9m29ckwfR8T2/qwjv393o07XJSRu8iMoJtvmy/0KrSUzynB7Qznk382oVXAffgvH2OKLRWD0Fd9xf2EGuxh3uZ0BL3oBxTi4zh/tYtDirtNb1k85lhPDQbJQXz6h5DBQtLQpg1lG2jvBFLFiaI+q5O3mutmet06lFd4S6RPTJJmfinGmIP9B5rl9qrsbe/ZV2/tbHBzWsPTI0P/T38ONBV0bwifhMyQQHOVx1BqSZwIs2OCRUreFO/gJtnETTylpwr2nlhZUkq9DgFOufywmi6wzEzS4lSqD2O8rCiRb1admBsdtmZYA6YLVkGIb0nWXHnktF7Sj3wWl5ejDrRDJ8VKuICKQlEKbdQNYGh/M+fx6mwOQdroxktGFPTTMdRU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVV1U0dBUXJaWDhpZDRFMWh2T3FEUTlzRDNPbmpaNUpCU2tuYy9ONG56bU1Q?=
 =?utf-8?B?WkNKVGpNaHc2WEpjTGd2aWN1SFJPTGVtT0tQZjZBQVMvZVQ1VGRKeXlaTm1H?=
 =?utf-8?B?QXJyUWF6TlVGZEIwdFQ3SUpLWGtDVmdlWmVSKzQvdVNzaXQ4Q2hUbk5HMTVt?=
 =?utf-8?B?eHkxb2RlUHVweUZnVkdpeXptNmVnVW1JZHF5VzZlQ3BjQjNJMTU2R1dSWW0r?=
 =?utf-8?B?UWQzbmZlQnF2RjJ5cXYvN3dUMGI4WmNnTWpyckdJcUlCUmlqMitxcTJ5M2V4?=
 =?utf-8?B?cVpRaStXQUZOdTcrV1Uyd3graWFERVlGcjRiSXZjSWxrMkgwY2Niak9VTmFo?=
 =?utf-8?B?VDdaNzMzaWYzbjBvQ1M1TDc4MlRCdFhiOVZXYXZjRjN0dEN3N0I1RVpyWHJP?=
 =?utf-8?B?SlQyRUFUS0lpZkh0Y2dKZ3pkOGlXYTdWNXk4MEU4SGNxbmhpOG5tY2pLNk9Y?=
 =?utf-8?B?dGROaHRveVdRSWplaVoxanVNemMyRWxHY3d5U3FwTEZrdGwrUkdxdWhZZjAz?=
 =?utf-8?B?RFN1b01ZVGtCY2ZhbGJuaHArWHNkMGQreDNCY0t5Y1cvSUlxTnZXNHZyRmxZ?=
 =?utf-8?B?RkszTmRTMytXNnoyek9aZXNxamEvaElMZk1sTCt2WitmRGdpQTJLbk5CczJv?=
 =?utf-8?B?Zkd6aVdhaDhVYzErRHYxMFFkdDFQVGNZWG83b3JmdW9BMTNoNEwxeU9TZktl?=
 =?utf-8?B?aTdHUjliNmNZUHc1RVdmeFE5eHVONTIreVVUTmZsYlNvdlUzUVZ6WGsra1c4?=
 =?utf-8?B?cXcyQTlxM0ozZTgwczFNTUZuWjdlQVNJRDFYRitLUkFFNEVhTWFGb2hsY2Rz?=
 =?utf-8?B?em5xbEIxbXFsTU9uSUhoTGlZdVkrQVV2Y29uWDM2cnE1Z0ExUmpOWTQ4UXNT?=
 =?utf-8?B?VHkxMTd6QlZtMTRXOU5Lb2tzU0p5MlE5dWtXaXVpQ1Uydy9NangxNmcxWk1P?=
 =?utf-8?B?QTlaRTJONU1nRGZTdVVjRFQ0Mis0TTZJZGRWamhaeEhidDZHeEREdUVGLzQr?=
 =?utf-8?B?Ynd4Ums5eWVEYnR0RWRzMzF2YmhTWnRzaDZpdHZpem9QMnpLbUlhOVkyYlJs?=
 =?utf-8?B?ZkpyVXRJVmlmWTFvUjVCVTlUS1E0SGhXNGpaYk1MNUU3dktWY2NvelF5VWJN?=
 =?utf-8?B?TFQxOE5rTkYzWU9mSXQ5NllpK3pmV2FrUndaOStEREpOL0lLRStYSGVSb0Fu?=
 =?utf-8?B?U01leFJVTVFCRitCN3JFa1VoQ1ROQXUzbjZqU0NabXVIbTExbHdpVVJMWUti?=
 =?utf-8?B?MjhrZkxWcDkwWnQzYjhQVGZYMmVyR2JqOWo3SUJrT01OTWkyTzREcjNqRHVE?=
 =?utf-8?B?bFFDUVRiOENmQnpIT0IzcjJQMitZMG5XR2FHTFd2bVEyQUhQUW9wZXh6MVNt?=
 =?utf-8?B?Nkk2cjRYZzdwM3JhbFozK1ZHVWYzc0lTQnZFS2VsYnhkcmFYemFhTHczVU9o?=
 =?utf-8?B?anIxZVFmckt4ZUxTQmwvUG5PYjhpbEtJVHhGTG1ubGRtelVacHVZTkxIcEVL?=
 =?utf-8?B?dUVwMXhUVkl0bkNvcWRmNDRsS0JSRjVwK0FSaGowQmtyUEkzcWVscmlUa2di?=
 =?utf-8?B?VFBTYy85Q1RMRE9tUHZaRWNVcXlrcCtDcVkyYXJhenltNzRmKzMrUTM5RHpy?=
 =?utf-8?B?Q2plSHpSWjZmUmJXWXp2ejl5ZWc2SG55dVlVcVNjdVo5SjlKNUVBM05jelBa?=
 =?utf-8?B?dTFhWS9yYkdtQ0xsZ25HUjREVlFEaU4yb1k0UDdSMStiTmdrYlM4V0pGbHBC?=
 =?utf-8?B?alNOZWtCeFlUaC83ZFR4RlFCTkU0QlpMMnJDMjJrb3UxRUlYMHhZcnlrOGp5?=
 =?utf-8?B?TkxFWDRHVWpHWjVuSHB4YVBGa08zaTBZV1JjQjZUY0tLQ3FDeTV2UkhLL0pP?=
 =?utf-8?B?bkFqRG9Id1U2Nlp5bXhDK1Y1QmhVRGpYcmREV2xqVjN0VUI2SDM3a1lnbVl2?=
 =?utf-8?B?NTVOUzdKTVFreFRxNm5lWDhmMXoyZXFHREg5cFVBdlBXS3NHLytLNUpMNjcw?=
 =?utf-8?B?SFJGOTBBYVI2VWZUQVNxTUN5R0lJTmY4aUsxZDNqeFpkUzAxK0tzSzlDSENQ?=
 =?utf-8?B?a0JRd3VHbG84UW9pK09yY2pJOFRLeEduY1F4ZERUNGo3UnVOM1pTNUFBb2VB?=
 =?utf-8?B?aEJ2Z1lMZERtUjQ1V1RxWnBGSW1tNGtlcUNVUWZwbGt1aFNNOVIrektRU21y?=
 =?utf-8?B?aXkyQXRzSlRyMFdHeFVFQkZFQ3Ixdm93YmRLZWNjQW9EZ2ltanp0QnJFaWtR?=
 =?utf-8?B?bG11OXhJNGZLQkJTQi83ckRpemovQ21pMWpkeEdXaG1DL3pkM3VWcTZvd0lF?=
 =?utf-8?B?ZnkxTkdrSUp3dXNqYmFMdnJhbkQrYUlXVlI4UHRLNXI5Ym1KSGUrZkVmT2JM?=
 =?utf-8?Q?40R4RXFgBuJUvapeqNe13yjMeet2ab4XmH3Ye?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B4BEE4103608E43A287C0AC81F08F16@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dIHK9/inXOsKKQ+DpiUiX91gndeJinegYTxQmIDvR+s1RkRFwXIS1Hlm7ULztatJLtYQNHYWm9xrT1SDzRgNg8ZvlhOQe8drzYYQ6oclggcBtD/2mxThuuDv3amnSH9UuYkcMwoPaXbNAhqH+bbI8NIXJeI21d2e4SsLoS969yYni+gKzhVocBRXWN8rahlwCORynhGlW2iidw11yW84E3nCbkGWitgCgMp+BwvONa3wphtO0tS79ODV4nAH/7H8omUuPHWH6FS8kJUGMpE75E121iSucZwsAnRPFwllGflhaBcKVEZvKVfagf0ikyMcjAwuAgR5mNQLZu7KO+Ubgg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ca87f-3190-4736-5079-08de8e81f3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 17:29:52.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+JLMkaJsbF3G8MM+uEJlaD/1VxdbypCEeB1QGD4oErfb4C0ovmgRtNRxezteaVe4tNG043+zGe/vqDuEHAjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE7FB53C35
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ufh_HOF3NOGgVwV6in-qHGjbH801IzyB
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cab319 cx=c_pps
 a=xqIz4pcv3YTcvFGvps39jg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8
 a=MbieHcfxVAPqowm5FfkA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX1J/TEOhRauLS
 TOD0ACWdbx6eHwi9HjMph9jC6KDVhCIoAJIWkvNrnZUE3WWHOZ/FRe49TlIfr4qrThc7X85QHTE
 gxWIgS5c41vEJ+8paqrjaofZwsSxL/ZT6ZvTKASoWDI8pD+ISkuC0zcY87nNeSETAcwn6YEai6L
 NoGc4bfTx8Pk1JV8umkAHKOenSBmCMTRVeZUeUBAfuMPTfmUc+e0hkuh9XWMy7ob/ljmP7gZv7f
 RUaQ7l7Pctu4IeoiRrd7g0feo0FBKKpf6msF8JWbAEsLTECKnOUXtwDVzJYIXFHm4UwRBxupASW
 l9D8yT1amdJtbse5OonkHIPLHBIQWgvSHT84R2oTTrGsdm86t8sxrhPQrBmynP1dK5oLWV0sabv
 YJHwsl6dg8B+ekbe51UUg1iPR1u+GfyHq8F+3F9YMwDAnQZyFr2wFHQORywhIMKE8Q1G8OPxLH9
 a3ixuEM7lB2h/nNNI0Q==
X-Proofpoint-ORIG-GUID: RHpG3uDkiaW0PZYu6d9ycRdFnC3OIDbd
Subject: Re:  [PATCH] ceph: clear `s_cap_reconnect` when
 ceph_pagelist_encode_32() fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDEwOjQzICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gVGhpcyBNRFMgcmVjb25uZWN0IGVycm9yIHBhdGggbGVhdmVzIHNfY2FwX3JlY29ubmVjdCBz
ZXQuDQo+IHNlbmRfbWRzX3JlY29ubmVjdCgpIHNldHMgdGhlIGJpdCBhdCB0aGUgYmVnaW5uaW5n
IG9mIHRoZSByZWNvbm5lY3QsDQo+IGJ1dCB0aGUgZmlyc3QgZmFpbGluZyBvcGVyYXRpb24gYWZ0
ZXIgdGhhdCwgY2VwaF9wYWdlbGlzdF9lbmNvZGVfMzIoKSwNCj4gY2FuIGp1bXAgdG8gYGZhaWw6
YCB3aXRob3V0IGNsZWFyaW5nIGl0Lg0KPiANCj4gX19jZXBoX3JlbW92ZV9jYXAoKSBjb25zdWx0
cyB0aGF0IGZsYWcgdG8gZGVjaWRlIHdoZXRoZXIgY2FwIHJlbGVhc2VzDQo+IHNob3VsZCBiZSBx
dWV1ZWQuIEEgcmVjb25uZWN0LXByZXBhcmF0aW9uIGZhaWx1cmUgdGhlcmVmb3JlIGxlYXZlcyB0
aGUNCj4gc2Vzc2lvbiBpbiByZWNvbm5lY3QgbW9kZSBmcm9tIHRoZSBjYXAtcmVsZWFzZSBwYXRo
J3MgcG9pbnQgb2Ygdmlldw0KPiBhbmQgY2FuIHN0cmFuZCByZWxlYXNlIHdvcmsgdW50aWwgc29t
ZSBsYXRlciBzdGF0ZSB0cmFuc2l0aW9uIHJlcGFpcnMNCj4gaXQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggS2VsbGVybWFubiA8bWF4LmtlbGxlcm1hbm5AaW9ub3MuY29tPg0KPiAtLS0NCj4g
IGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgNiArKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL21k
c19jbGllbnQuYyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+IGluZGV4IGIxNzQ2MjczZjE4Ni4u
NGZhNDcxZDliM2IyIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL21kc19jbGllbnQuYw0KPiArKysg
Yi9mcy9jZXBoL21kc19jbGllbnQuYw0KPiBAQCAtNDk1Niw3ICs0OTU2LDcgQEAgc3RhdGljIHZv
aWQgc2VuZF9tZHNfcmVjb25uZWN0KHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2MsDQo+ICAJ
LyogcGxhY2Vob2xkZXIgZm9yIG5yX2NhcHMgKi8NCj4gIAllcnIgPSBjZXBoX3BhZ2VsaXN0X2Vu
Y29kZV8zMihyZWNvbl9zdGF0ZS5wYWdlbGlzdCwgMCk7DQo+ICAJaWYgKGVycikNCj4gLQkJZ290
byBmYWlsOw0KPiArCQlnb3RvIGZhaWxfY2xlYXJfY2FwX3JlY29ubmVjdDsNCj4gIA0KPiAgCWlm
ICh0ZXN0X2JpdChDRVBIRlNfRkVBVFVSRV9NVUxUSV9SRUNPTk5FQ1QsICZzZXNzaW9uLT5zX2Zl
YXR1cmVzKSkgew0KPiAgCQlyZWNvbl9zdGF0ZS5tc2dfdmVyc2lvbiA9IDM7DQo+IEBAIC01MDQ2
LDYgKzUwNDYsMTAgQEAgc3RhdGljIHZvaWQgc2VuZF9tZHNfcmVjb25uZWN0KHN0cnVjdCBjZXBo
X21kc19jbGllbnQgKm1kc2MsDQo+ICAJY2VwaF9wYWdlbGlzdF9yZWxlYXNlKHJlY29uX3N0YXRl
LnBhZ2VsaXN0KTsNCj4gIAlyZXR1cm47DQo+ICANCj4gK2ZhaWxfY2xlYXJfY2FwX3JlY29ubmVj
dDoNCj4gKwlzcGluX2xvY2soJnNlc3Npb24tPnNfY2FwX2xvY2spOw0KPiArCXNlc3Npb24tPnNf
Y2FwX3JlY29ubmVjdCA9IDA7DQo+ICsJc3Bpbl91bmxvY2soJnNlc3Npb24tPnNfY2FwX2xvY2sp
Ow0KPiAgZmFpbDoNCj4gIAljZXBoX21zZ19wdXQocmVwbHkpOw0KPiAgCXVwX3JlYWQoJm1kc2Mt
PnNuYXBfcndzZW0pOw0KDQpNYWtlcyBzZW5zZS4gTmljZSBmaXguIEJ1dCwgbWF5YmUsIHdlIG5l
ZWQgdG8gY29uc2lkZXIgcmVmYWN0b3Jpbmcgb2YgdGhpcw0KZnVuY3Rpb24gYmVjYXVzZSBvZiBz
dWNoIGlzc3VlLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJl
eWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K
