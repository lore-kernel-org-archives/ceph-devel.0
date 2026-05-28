Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D662F8E88
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993383; cv=fail; b=h/ImiT3hd6GXpcBmhxczh5pzZC8mGnPVDzd2f1nDcXD4fafuMoSR2jRFMvE8KdbwScaI131f2ajIDk5L2RlU/xbK5kLRy5tqkT2xTr9b1SnWk7kDlV1eALGhrItvFlpMpKCwuYPjWhorl4eBy2hAUeVjsXBVON06jov6klGtDiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993383; c=relaxed/simple;
	bh=EKtuqGu4cye5dCF1B7hzAZKXRcxNdF4nb4hdVeCcPcs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=OMCtcp1UxwXJm7ZsdkQ5a3bYndYFnxj4WnY3ukciP4DGfRirYnILSyZZjd77jOeQ8dAMBwhCv/oiRUQ/LW+shUaKPAfthhiWY5funaKh0FV3c5SVnyMA72Ae+1m1GsucsdFRSNTywPuWs5GoASog1hPpx5ErtrQdKd7TS0BciSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B9P0ery0; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B9P0ery0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SBHRUq3784371;
	Thu, 28 May 2026 18:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=EKtuqGu4cye5dCF1B7hzAZKXRcxNdF4nb4hdVeCcPcs=; b=B9P0ery0
	MCR0lNjMoJke0NCl9qGULshgZs5+Oz/6WvMt+ticlzXACWuZPuklGobPQqxu5yBE
	CLGPxhbronzVC0vwa4MKD63M0dP2+5SeE0hajFHKDLWOTr+udd7Oq/YXMLW8v2Ob
	CT26zi+sxzmRAJx9FbPav0HKeF8it5CdxlQLzFiKLgC1ua9OBHUU7y5tceN8hvBx
	9WtbJOCTScWExsX3mK2XsT+D3w6D/xDA+jrWjthhOAyE9/RDzstV8I6ymGEbdmce
	1458MkMEpHrLnwhSdCUw1hftMz9v7OA+ZrvLWtD83dIMszqj4fLYX9CINl77KbSN
	qiXbXoMpCuLdlg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889ccms-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 18:36:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sViDdS+dRYGgY5nduQgGzAV8jBnQ9gHokJCDUjFlcfd3M2L7bFJxGJjdkjM1ik2MHNSmMDw6eSX7+0ko4YWfs8jCNoXQV8jiOgRsR/Ysn1uVINiy3jAbIF9ATsRZoMtx26oQvgcJXHgw8mbGd9X6xCxwkySaL0o/ZtrBXB7vFwApW4nqbwcEKxXZdtMLAlkWydvbgxorNBbzi90zDwbwr3mVkHWGjGjr603VtiSE6mzHr8/BEFkhqLN0Q7PUwigrklg7Q3V0zUN54/ivb5IoV5HI4fPxmf4gau7bravq6Nl9dtNU7t5idrc/tfxGs/ihXrKREz/hmuHf1jmBk24GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKtuqGu4cye5dCF1B7hzAZKXRcxNdF4nb4hdVeCcPcs=;
 b=hGyQ/+iQtmZ7Fut+SdmnHkhaR9gMjyEcGmlA06HsWzd/l+wWz8XbBn48R118bv8+hk/dV3QabbHSvAJXI3JVivcTjWMqNtH9w6sPg/B65d3QAKnZxdwqz6sukBIlaWSFaQ9ubqXLZ0abTz4T/dc/cTDY2euDknjW6CyMiz1nYQQnHEn4IueUOXDMs7wLp5sxfLaWVPlrWqwp/0TLePiM8cChtBfd5xlPV3fnLG7VD+xkakHJvY8ldLBCTjAWVH3PvbY7sSiKPTfQKVpuMobhczNmORyEpdpXYIx5cz48mG35oGBk4V9oaar42aZCtg5nntwiTRW/rGDE6KcT/TP/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4601.namprd15.prod.outlook.com (2603:10b6:303:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 18:36:04 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:04 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Reject monmaps advertising zero
 monitors
Thread-Index: AQHc7nkfE9CRjQvCREaLWZvENtvoMbYjxLkA
Date: Thu, 28 May 2026 18:36:03 +0000
Message-ID: <3954b88a1354b96d65a88a379daed3cc53e3d88f.camel@ibm.com>
References: <20260528080023.3634455-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260528080023.3634455-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4601:EE_
x-ms-office365-filtering-correlation-id: 783de785-3368-47b6-07bc-08debce7f957
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|6133799003|3023799007|11063799006|22082099003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 apfz7+lNuxStjZ6V7D4UTUPY1pwOOg8yONnasRs+LiQSXhxGiyTP+YyYSMtB2RwXiMoz81ZVveQ/ozhQtcMJGXxE8gXdJzQUo2EYTR80kN8I7pzfeNd22w+tClXM9RieH//U8/LvlDPweJ5yt47LTeBrhlKgHKASzqXaWDRquzo9N81VdYzgxTCVdqKNlNy/kYawdp5Q9JX+KZ0divBNiIiXblqZLIySFn+VboZPkv7MmnS0Ij9N8+ia/TQQ/XbyMm8o3pbjriEyAgsoVQoCMxDvrmWaPjRscXyCJ0k/ya120GJqkIQfngQNpatz4K/FKDTclpydL1liVg8jcsSIulNR/yY9DSafevYhS9Zkc3ggLwcDqF5eR4bKTx8Wa7Iq6SnmDBavKUXKKrm/K0QzHm5Fs/imhO/ypzKzZHVb9XuZ9B78S3iHc9CVBPjrkbYvlCDxpr2eM/nvYHKh36xpSniIolLNYfz0JRanhhRsyeB7RiOWxTGZkFD8zBtUZRJUIA1lU/fAb9WQBNb+EhDZEvMYLRoCH6/0x8MYDnb79kmJIdv/jm8Sj+r0h5QsrFzCRNpc9VeHVORWGl3TDcs2kWd8Y8PkZsRjVfZHLRWZVQe47io+vNUyW/j7ZLKJ9h/nwwWSL+Z8+VoGKiI//8chOj4UDIx7lw/8K47Z6g4lsM4i0eA+/ArzKF91dWWCmFOrL2/hgsiqwfYBq3opaLu/hSylXBMhk2MOPMbkzxbACmg7CPjFZnriC1AHheFu7t86
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(6133799003)(3023799007)(11063799006)(22082099003)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDdHYlRxejEzWUhwejFxUXlBd0J6M0VUbGxmcG5yS1NIVUFlUm1iMlM5NTA3?=
 =?utf-8?B?MjlSdWRtWjMyWmRvR0xBWjNmek9rUHJULzBIUVE3WXRxNnVpMlNJSUpQWi83?=
 =?utf-8?B?R0loWkp4eHlQZll0TWJrZXNHbVJLb1pWRnZFZC9hRXA5UnZJcVZ6ekpJUmJC?=
 =?utf-8?B?YU9GdXNSZEdCWGpTbk5TUlltVE9ScEE5K2Z0QlpzdCtYWnV2THVzYzZLMWE1?=
 =?utf-8?B?RGMwMXRNL2pqdDlBdjZFaXc0RlhuZld3bjFVcjhKelE2M3BtcHpzYnRPcnZk?=
 =?utf-8?B?akdraG90SjBncnBaa29maDBPdkhsZGcwWnU5cTJiTWZTWnl3WWUzUEJHNTUw?=
 =?utf-8?B?RWpaa0dJcEZhMzI1dHJjdWlZQ1RmeTVpRGw4R1RHelhmR2E3cVhpcnpZY1lV?=
 =?utf-8?B?eSsrcFdiUVhaSG1wZVFaeGVPTXFDSWx2TlorQ1RzS2VoZzVyYmcycjA2YTFr?=
 =?utf-8?B?VkpBaHhZRHVRazBEOG9leTZpaTNvQVIrRXdDcGtBS1pkcWdyTGlYbldOc2s0?=
 =?utf-8?B?ak5QZGJtYnhQcGpUdnNWMjNaOFVrUVQzZjlqaUJneTBKN29oMHE0RkRENnVr?=
 =?utf-8?B?bUtIUFE2dXZtcTJBNHlwNlUvUUNZMXd0Q0p5dUV1bTFZOU1iNVFOS2tEQ2I0?=
 =?utf-8?B?ZHZSY1Q1T3crU0hDVWdueDFTd25kaDR3bG92YklvMHhsc3JDOEdjUm9PekVZ?=
 =?utf-8?B?cjNVRUZrUFhNNHVCbDJtcFpheXJmRW41K2l4Wit6ZjMyUytwY2JtSndtbmw1?=
 =?utf-8?B?ci83WmM5TVBzenNhUVJBWWtROWpUK1VGMVQyRm1FbGdqN3dkSjVTbHB3VlJS?=
 =?utf-8?B?WXpCRVJMMERQRDVYZy8yMTVjWGRFdkJqN0gwOTl0MXlnZFQvNnJEeTFvTHM0?=
 =?utf-8?B?ek1KVC9ZZTFyZU55Yzl2SExLcWNWZ0UwNUJOMG44dEttb0JrZUd2RVA5YWlH?=
 =?utf-8?B?RmNVL05RUzRJVGt0cDRLNHlWZU5EYXAwMXVpQ1BQN2Mwakd4dGxpbXZVbFpW?=
 =?utf-8?B?c0J2bWZ0V1N0bGVZMHB5TitidWtBYUJRQW1lREVqMU85M3VOVlJ3VHNkL2Va?=
 =?utf-8?B?a3NuclluOXdPcStqQUlPR3dpM3BvMHByQ3Q2a3FUNXI4R1IwRVhzMlJsZ1pG?=
 =?utf-8?B?ZUdUdTU1Y1pGZElsWGRjbzRQV2pPNnVEYmp0WFVwUSsraytwUWhoMEx6Y3pp?=
 =?utf-8?B?T2NZTjBLRGRkN2tjRWtuNVp5MWx2UEx5UUU3SHNFeGY3V0RPWnNJZEgrYUtp?=
 =?utf-8?B?dDFuV28wWXNld0xpdDZNcGhwVGZVRy9HZkJwTkdrVFZIMVlKWFY3ZVQ1UUVC?=
 =?utf-8?B?UEpxbG9ZTkhoNVAvK2Q5aXRQU2xkNElBNmR4SERGU0wxaDhQVll5N0orQURB?=
 =?utf-8?B?VG00QTBqb3JEeXljaVZUejd1Y2p0dDV3eXR6eEZMUHJEdVl0dE5kb0NGOEdU?=
 =?utf-8?B?dzlHdmd4MGJkK25FS01UK0l3WnlGQUttRG9ZdURLblF2VEVrcmNvRG4yN3Ja?=
 =?utf-8?B?T2RrQ3ZiVUFLVitjaWx2U2FnWmFIb1JEN1dhSUt1cjJianJjemFMTzMvTXlU?=
 =?utf-8?B?eWFxYnVHNTlsTmlFdEFVeUdRRUkxRVRFbG45VC9GVlZ6RUVJZmk4TFlEUksr?=
 =?utf-8?B?dEZQZ1drQkZ2aFo4SEVlNmJJQUJOMUFzYTY2THpIOUVmYktVRUMweVdnUmk4?=
 =?utf-8?B?Q2tyNTVUMitSbFZXamN6d3UrUUgxNTE4b1JvWEJLc2xqYjV5bUtGM1htYzhI?=
 =?utf-8?B?cTdIQXYvbU9CZElHbWJkcHZ6eGQxVlpzSUFPUDN3MUJVU29xaDV3RzVZWnIw?=
 =?utf-8?B?cGZiNkxEVDBTK2ptVVJBZjczeGZIZTZoVHNzOEErcno5N29QYnI2UVFIVXpz?=
 =?utf-8?B?UUdyOXUyVUY4RVhyMFBtSHh6T3lCUGEzSDB3aUEweG9Gb1hTWjRZcDNxMHJy?=
 =?utf-8?B?ZElyUVZrMjRVK2xjOXB5WTg5eElFdnRRQ2srZ01DOEVNUDZZdEVvWDRSYXZG?=
 =?utf-8?B?aHZQLzMvWGRUOFc1MHpmNnQ1N0dNVUZza1N0QzJ0ajBvaDJMd1BlUnpvaU55?=
 =?utf-8?B?My9vQTlpR3pndWtwSTF2cXJSZDNwYjlZMWRJK0prdm9SazFSUFpTVFpWbU5i?=
 =?utf-8?B?cFpjWVNBQjN3QzdYdlFiU1dteTVEZFM3a1V3eDNZaUNveWNySmpSYlVoQ0NG?=
 =?utf-8?B?RVVBYzdabTRKVUM5UEJ1dWxCMFVkMWdxVHR2ZGo2NVNLUVhLM3lnbjFNd2pz?=
 =?utf-8?B?RUdwWVQ4K0VLVnJNMTRta0ltbjVBNmFOVWJncE1xUDk2dTJOckFJQ0QzZDFJ?=
 =?utf-8?B?alhrRUI2eTY0bHVYamhGM2V0UVM5V2IwMXdBbUhDa2lhRm54L3ZqdVg4R0ps?=
 =?utf-8?Q?k+sVAhlbJIY4Q85gCV+XKCZI4pATCSccytKf8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A056254A2F9CC74D85ECCB6E77456702@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IgfuIm/RrYDyUi+c5avXN7zmParFLXNzU6mK2XB2rolY7ef0tVKSqTk9yGNxThXHCjS3prTHJAJ40B21KxhJ9iH8wN8/JzDkNcQTqtVCkgiDa4riGZjUhSUo9Ao35AVBSYE+gToCpIbBdS4OvFe15Yturr4HfCKs1r4LUOXfLzYlx6BK5ZChjaJPpr3/8ghtz25++D6XiwMDtan+SAxJHUIGYZP46XYV6Que0fAzM+SzezQ008SeKaq+nv77S2DwC5ggsQ8UB/lE8D7iz+l1w9h5pMqFq4qvV4aduRl0i+t47WFYC9kuF83lNn/jqGIogUGBVQnVx/j0wgT0O1b6+A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783de785-3368-47b6-07bc-08debce7f957
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 18:36:03.9100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKz93GbwQ0pDKqSqDTOoSV2N0UBazXP6AZSxrgslm1AtR0m5//yLla5jTXAR3eDSwGdymsTaj9h9hrgUlNMs1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4601
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YoYsb0JxDiHWoUDbkg1s791MtAWDkcFw
X-Proofpoint-GUID: HyXmz05pZCZjydylWBrxbPKIfDJbQ-Ku
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a188b1a cx=c_pps
 a=56WOIFdoL1k8+DRIoLPNvg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_SAZctRkYT2yxTfkzGcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4OCBTYWx0ZWRfX1a/5kB0LGLoO
 Q3IiL/QSegBhEOqnshz61kvOY1wAixlEZFWKfUoR0XO7H00chFgFf+fCUCX/QDecRSeJNiRRb6I
 hDrz2SX0wUHHOFphL1VXf3jp4okKqryW3o63E9kQaeZ5Dne05DrS0a2yd13VjMe5513C1Q0v8WT
 tuzMqoOgzq5zr5ib7dq781PRoBoNDdJoaWXK7ZpC+V+c+C8slB834MUC7BWq0bQATtoA7bVzXk3
 Mpd5GbvlMfuR7OY6dTq9s6w4Zwg/8g7FuEmQYIP5MGO13HxmY/C0whQuyUjLcG6RgxULXhzJUmp
 dIB9VgIHgvnIF21tNSwUwNpy+vKO5nIPmfBuSfmM1ic92sycrbZhySQZ6FyE2ExBlgv2qjk5lAM
 I2iec6V5DUU+vVGRXCNEfI1AZiab3KfM6pMprOjXkBi2CDzjukABmoiUOOlg8MuKaiRaQwSU+Eu
 +7uo+e9fl77j/SxsBQA==
Subject: Re:  [PATCH v2] libceph: Reject monmaps advertising zero monitors
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280188

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDEwOjAwICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfTU9OX01BUCBjb250YWlucyBhIG1vbm1hcCB0
aGF0IGlzIHNlbnQgZnJvbSBhDQo+IG1vbml0b3IgdG8gdGhlIGNsaWVudC4gVGhpcyBtb25tYXAg
Y29udGFpbnMgaW5mb3JtYXRpb24gYWJvdXQgdGhlDQo+IGV4aXN0aW5nIG1vbml0b3JzIGluIHRo
ZSBjbHVzdGVyLiBDdXJyZW50bHksIGEgbW9ubWFwIGluZGljYXRpbmcgdGhhdA0KPiB0aGVyZSBh
cmUgemVybyBtb25pdG9ycyBpbiB0aGUgY2x1c3RlciBpcyB0cmVhdGVkIGFzIHZhbGlkLiBIb3dl
dmVyLCBpdA0KPiBpcyBpbXBvc3NpYmxlIHRvIGhhdmUgemVybyBtb25pdG9ycyBpbiB0aGUgY2x1
c3RlciBhbmQgc3RpbGwgcmVjZWl2ZSBhDQo+IHZhbGlkIG1vbm1hcCBmcm9tIGEgbW9uaXRvci4g
VGhlcmVmb3JlLCBzdWNoIGEgbW9ubWFwIG11c3QgYmUgY29ycnVwdGVkDQo+IGFuZCBzaG91bGQg
YmUgdHJlYXRlZCBhcyBpbnZhbGlkLiBGdXJ0aGVybW9yZSwgYSBtb25tYXAgd2l0aCBhIG1vbml0
b3INCj4gY291bnQgb2YgemVybyBjYW4gc3Vic2VxdWVudGx5IGNyYXNoIHRoZSBjbGllbnQgd2hl
biBhdHRlbXB0aW5nIHRvIG9wZW4NCj4gYSBzZXNzaW9uIHdpdGggYSBtb25pdG9yIGluIF9fb3Bl
bl9zZXNzaW9uKCkuIFRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZQ0KPiAiQlVHX09OKG1vbmMtPm1v
bm1hcC0+bnVtX21vbiA8IDEpIiBhc3NlcnRpb24gaW4gcGlja19uZXdfbW9uKCkgaXMNCj4gdHJp
Z2dlcmVkLg0KPiANCj4gVGhpcyBwYXRjaCBleHRlbmRzIGEgY2hlY2sgaW4gY2VwaF9tb25tYXBf
ZGVjb2RlKCkgdG8gYWxzbyByZWplY3QNCj4gYXJyaXZpbmcgbW9uX21hcHMgd2l0aCBudW1fbW9u
ID09IDAgcmF0aGVyIHRoYW4gb25seSB3aXRoDQo+IG51bV9tb24gPiBDRVBIX01BWF9NT04uIEFk
ZGl0aW9uYWxseSwgYSBsb2cgb3V0cHV0IGlzIGFkZGVkIGZvciB1bnVzdWFsDQo+IHZhbHVlcyBv
ZiBudW1fbW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwu
emltbWVyQHR1LWlsbWVuYXUuZGU+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvbW9uX2NsaWVudC5jIHwg
NiArKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9tb25fY2xpZW50LmMgYi9uZXQvY2VwaC9t
b25fY2xpZW50LmMNCj4gaW5kZXggZDJjZGM4ZWUzMTU1Li40NjFhOWNhYTc2MDkgMTAwNjQ0DQo+
IC0tLSBhL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9tb25fY2xpZW50
LmMNCj4gQEAgLTExNCw5ICsxMTQsMTMgQEAgc3RhdGljIHN0cnVjdCBjZXBoX21vbm1hcCAqY2Vw
aF9tb25tYXBfZGVjb2RlKHZvaWQgKipwLCB2b2lkICplbmQsIGJvb2wgbXNncjIpDQo+ICANCj4g
IAlkb3V0KCIlcyBmc2lkICVwVSBlcG9jaCAldSBudW1fbW9uICV1XG4iLCBfX2Z1bmNfXywgJmZz
aWQsIGVwb2NoLA0KPiAgCSAgICAgbnVtX21vbik7DQo+IC0JaWYgKG51bV9tb24gPiBDRVBIX01B
WF9NT04pDQo+ICsJaWYgKG51bV9tb24gPT0gMCB8fCBudW1fbW9uID4gQ0VQSF9NQVhfTU9OKQ0K
PiAgCQlnb3RvIGVfaW52YWw7DQo+ICANCj4gKwlpZiAobnVtX21vbiA9PSAxIHx8IChudW1fbW9u
ICYgMSkgPT0gMCkNCj4gKwkJcHJfbm90aWNlKCJyZWNlaXZlZCBtb25tYXAgd2l0aCB1bnVzdWFs
IG51bV9tb24gJXVcbiIsDQo+ICsJCQkgIG51bV9tb24pOw0KDQpNYXliZSwgd2UgbmVlZCB0byBj
b25zaWRlciBwcl9ub3RpY2VfcmF0ZWxpbWl0ZWQoKS4gVGhlIHBhdGNoIGxvb2tzIGdvb2QuDQoN
Cj4gKw0KPiAgCW1vbm1hcCA9IGttYWxsb2NfZmxleCgqbW9ubWFwLCBtb25faW5zdCwgbnVtX21v
biwgR0ZQX05PSU8pOw0KPiAgCWlmICghbW9ubWFwKSB7DQo+ICAJCXJldCA9IC1FTk9NRU07DQoN
ClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4N
Cg0KVGhhbmtzLA0KU2xhdmEuDQo=
