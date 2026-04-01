Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE733F360
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070384; cv=fail; b=XJff8G4nUeaepHOTOzc9hY4GNtXl0OdE4OFQds7sVFADmwK1/QjbQxakiAWiCL5/+dDZUSJCauxIZA60mE3LMlUx6+FcULKGPjY4CNf/D6ls72+u0LYsaRJd6HaH5IdOblJJINHbdECt7BxGYzU7vRn8x6Q/28hP22JWUG1cZn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070384; c=relaxed/simple;
	bh=JpnkxWkn2VMOsCnGSL9alj06KPk3KK3D7f0T6LLAoYA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VPd3WUu3hG3mXJBz7j3qnyefkoWWnWQp0srSB82RTejTfOs7R2wLGBwO70YZVW93/+Va6l3PUjM1wSol6IKfSz89Zauw5Impp/hkKtCeMRLIGtPBltLiOQDlvmM1szJrSUp9BY1azlo8wNmGNT8FOjI5lzRVmtFpHEVb5/qhgYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EhGq5VLk; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EhGq5VLk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631IfKTo3065805;
	Wed, 1 Apr 2026 19:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=JpnkxWkn2VMOsCnGSL9alj06KPk3KK3D7f0T6LLAoYA=; b=EhGq5VLk
	du0HPAF7Th6r4UGYKlhxjSv2NbhpRnBIP5vNHyytJz1ZzQFoAGb5SSrUzeP5YFLx
	zNQK455sv6KAvYe2V0qs1uTi9BxclMBaI5WJgSOl8z8kB5fEkAU+g7U8jMcvG2B1
	Yy1tYNJhyk0BmWO/tNryyRik5y0CubgJhVeNoiP015vg9xwZGGiHgWu2TnIaT1/k
	xTkwkDk2ByXlE1Y5SCRyTsXMv5MDnyegInnJ4PyNvbZ4/6brt9orEAyBFncbNCKR
	0+RTAl5j152l97coBma+qM7kdK/ycEPo5cVYes6kAKQcB0zpyBPjPm6xSMV5ag3+
	05VVjY2pJX0ZcA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dch36b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 19:06:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDGHQJeo1zIZuaTtj9HwdFBtDh4zNKXg6naONX2axtHDbqp1cbvQVBn1G8CjwTs+Y8KqzxjkK0n85u10opF6+nxYF3l49O1ACiR2zjTq3DqzDjRF3+MYwvh/jQWjnGYC9eZ2+FxPxOTOLyzsTTYAv3Fu6ySlx4eW6k8unwGVwXWPOhJ8nJ3b1IM0omiBhXos8/YItZXJHyp5RhrW5iuKXLsj8xsAhYAwIi1X+4lUTKPPdak44d6/EZaHzdlbsmLwBlcMM6Y71a8csG/uNKfjXcc3w7kDSBZezccZ77ugc9QvePJbg/O2160n2b9NlDZOyIgWjJirT1vgKIkREhNY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpnkxWkn2VMOsCnGSL9alj06KPk3KK3D7f0T6LLAoYA=;
 b=g3BK0hsFInX3HNlZoi5h41ylrCIJNymjAGpL+wy3ktWZWvp4YLnxvPahC180IYXRufnyZbh3IYDWg2JIPet7ivQWNKfVFpze5ZZ8NCb60qrVofa4LyK890PYV7Bs4ugopNP4z6kWQF+kCpkjSXlBDBh2f8o4meHZAg3ulRpAlPIm6lVBfV1P8inis8GXVLr8no2QC4jy6oHsrBjpmBB3R28GObC3NAQbCPD8uf0GTNqAAy1rlFPEJ1v/H4Dak/DSC2BDWKFL+uvD83zzbIjxl3WvwAEOop3Ssi9MQE7FAmKA9zerjHZMglnsaZjyEonxZKtQ+v+8oM23EozOJIwvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF6404A4904.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 19:06:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 19:06:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Fix potential out-of-bounds access
 in crush_decode()
Thread-Index: AQHcweCaWsPcTgYzVkufQOaOFrbgUbXKkWYA
Date: Wed, 1 Apr 2026 19:06:01 +0000
Message-ID: <513d275666da93b1430124955e515704361a43ec.camel@ibm.com>
References: <20260401135132.3642689-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260401135132.3642689-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF6404A4904:EE_
x-ms-office365-filtering-correlation-id: 73b67bea-0448-461e-ffee-08de9021b75f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 PnAypgmIQLhjPo+7nSGcv4A0hpo2BNQGyI63AOL52K456KOMcQZJWjx3wetqVBl4hwbWmFu+U88vpDEC1Dt/OLx2S0CyXlkhL2oTNIXOObTlKRkVKtx8z6YsxtlEiWcFkV8OPEwwPS+jpzk5jKapenM5tHqB8zSDih+wSeexnWoxYDn7HRWL1mBL+XmKsTFoHQlhpYEQGNS0oDB+ZiCD7lEdZXVXhNeo5TJTKppFMtu4YXc+8bFsFLloJtl/C0esfKb0MRQJ++cucZkT7WJrSs2WZUWwea42YXckdACnTMY6jmBUrLZKRvBMvu4gcrYXxQW69AE7ZUFhxwFensf48Row3E0pJm3hcLMlk8z6ABCJS/jTFN275IoooV689ZoRAUVLvj3yZ3zBDF0UKTK6KnBbhUcvYcxs2Y7LGJXU0zPNQC12G5iQbMJ02dRfAgtGrrKVAg7ocM4/GjLC/N8jqF4xKn+Cf83FcP1ooBJCgOMjhBxk66NLV430sIWRb/7L8dhN1yJGdzysjBd4kGiSYvhXiYMm9UsoyhnnzCN2uXaZy9iiLDOD6LCxNADuNQHiTbp9JUhS2vIqFwTA2mxe6kuFHlWrdAUWOcEcmNSAUaPAk/7Y2Rt3WMsXn1kS8QjyHEyEM9sdJSZvCfv2EG0/gq6Need18P/ILusWUFuXFjg1y0uR8T/WE05Azz3YJBJTpR5fGi+aON1JpJwav/N1iVB5fvbCUJTef5Jp0+fgdFcazPnZeO+SRluu4GdPvyL0NyllVv0p6CZjhirzcXLJYuNVi/qJmnLH2D+tFy3gn8E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amFjd3U5dXgwZ0J5SFdBNkE3ekhXSHZ4Q2NlWnlHbjhJUXAvc2ZkWm8zR2s0?=
 =?utf-8?B?bGdBOTIyYis4NERjRHFpK040UFhremZCQlpSUTRBK3FLSSs1ZWQ0OWNGNWxr?=
 =?utf-8?B?K3Q1Q05vbXRKSTh3bU5TeGFPSDZhV2phSW15dGdRT29ZQlpuOWx3UW9aOXNE?=
 =?utf-8?B?TkNncTFCY25KTlVzT1EwMGZLYkdyM1B4OTZkaHlyWThwaklCV3BmdHYxZUor?=
 =?utf-8?B?aWgvaFc5S3VZNE14VHAxM0hWQm1GUVRkM2RuK1pqbXRROWpnSWNwak82VXhW?=
 =?utf-8?B?YTN5ZHExMmtSQkpkN24vWkRiUHdmYUd2M0lEUnh3aXhHdmI2dTBrdTkvZzZy?=
 =?utf-8?B?MEtFYXMvb3VYcjMxRzhWRzZadjM4YmhmTXhNYU91a0tMMXRqWXFrcXAyUEo5?=
 =?utf-8?B?amtEaGxlbFdZTVE3U2RGMit4Vlp1Qk9BcUVsTHpzd0ZtK3hpZE1QOC96a21S?=
 =?utf-8?B?eWZVUXBVczNvRFNuYlowR0pqL1oveXd2WUNHUER2ODZNQTYvcHB5S3oya2Fo?=
 =?utf-8?B?UzY4SG9BV3dVdWQvOG1HRU80L2hVeHo3Zm45V2tTNURmM3NBa1NiMm96bUgx?=
 =?utf-8?B?a1AzcE9ZNnlHMm40ZnkrZ05YMXFqQ2ZKYUIwSWZtdnRQTkw2TmFwZjlKZ2lG?=
 =?utf-8?B?emlCaElKVFJVakVCMmlMSTFkdkp1SkJIWk1OZUpRV2tjTjRoSDNmVS9tR3ht?=
 =?utf-8?B?WU51eWlSamptYmgxNmJ6SUFmY2lJdEpuNUt5bUlBcU5iMDNsazdBT2g1R3FE?=
 =?utf-8?B?SnNhdDRNV0VxOTBNZzRTK2grbTUrTVhzMVBEQXdrWUcvRU9rKysvOVNGMXZv?=
 =?utf-8?B?azM0MmtpZHVMUlljS0wwMCt1YTgzYUNCSmRxdi9CcENYdnU1NVIvWjcrSHpY?=
 =?utf-8?B?SzhmM0JjbzhSRFcvSVltNlVLd2N5VlQ0ZllhZnNQWWJpclhrWDhCTXIyN1cx?=
 =?utf-8?B?bWVBVzBzZVc2V1JISmlrWFhWeGdveTRTVnJjd2REUDJZQjNhQ0hXT0JCbCt5?=
 =?utf-8?B?SUhjaE8xWGdqVXBsdWZYa0xWSCtZS1lNT3FFNUE3T2FJcnlzQ2M3ZGc3RHBY?=
 =?utf-8?B?UUQrNTNjUlZVS2VmVks4RXJhQVRUL0F0dWpPYXpTZ3B0aU9vc3BaMnd2U2Zy?=
 =?utf-8?B?L0xoQ3R1NUFRWGpHQVFnQ2FwbWpCZmNlSGVhM2dQcmp4NDdTVXAyTG00R0c4?=
 =?utf-8?B?QmdlQVFzUDZaTndRVE5uWFg1a0hiYUdvSmg3YjNWQVJsUE5vWjlJNmpGTTZF?=
 =?utf-8?B?RzRYTmZPZ1FVRDFCTG5iSmVqcnRQR2NyT2xFcEtpaUR2bk5RSmpWM24ycEs4?=
 =?utf-8?B?TnhNcHloVlNSTVhHVVpVeWtOeE9UdFRYcFpxTCtJTHM3M2JKK3FMTlJQMFNW?=
 =?utf-8?B?bWI5RkdxeGI1VzJCbTJ2TU1LcEFJdkNyUGFTT1VBUU5sQ0RYNDBCeFFURjhh?=
 =?utf-8?B?TXMrSWt2RG5IbHVmZlBtUXNQU1dtd3ZQOHhpeURpUlJRRldhUGgzVEdFNDcw?=
 =?utf-8?B?Zzk3UWdmeHdxQ24wMzZFSGJQZ3VjVWplOFh6aHhESnl0QkZxallCUDVWcml4?=
 =?utf-8?B?YzVNNmlPTWpVeHM2T213TklxVDJEc01IY1dZbmxTUlJaU0dvVktSREVBdkVp?=
 =?utf-8?B?NFpScVorZEVzbFkyOEZGYTI5UDJIdGE3YjhuK2FTQjcyT2tWS0NUcUtKYWZa?=
 =?utf-8?B?Q3FIOUxGVVJSbDE0Q3Z5WEtJUUZVUmx5Rnp1UVhUcEtTMzB4dWppTnJ6Q0VI?=
 =?utf-8?B?aTY0TUlONHphZTBiYUF0NzRTZUJlbU4rZnZGczRGOUszVnFUZmJBNVZseUF4?=
 =?utf-8?B?THE2K01FNjRRWnZXWXpVUXNwZUxJeFg4SWJmQ1MwMVdVUTRoc1FENGJLNHls?=
 =?utf-8?B?aVYyLzNzR0dvK2ZtbDhjVE9hRnU0L0szVkpJbTZmandZeW1wdDQ4M0NuYjZM?=
 =?utf-8?B?Z1dHbnZqNFVBZ1B6ZDg0Y1dKVHdnV1EyNXBmSmhiaDN4S3FqdHhkU1Zva0hC?=
 =?utf-8?B?T09zYWd1d2tKQmtOTURrd2xmZ0Z4RzVJajNaRXl2d1VNczk3UFlRZVRlejZ0?=
 =?utf-8?B?L2V3eHhZOUd0d3JBQnlnZG1RTEZyWDJSa3MrS2RkTFJlcElUTzRSNS9iQStj?=
 =?utf-8?B?SHBqbjlJRUFjMktXN2ZCTDNQNlY2czF1QUlXRlNQMlQzZkZBcTJ2NEI3ZkRj?=
 =?utf-8?B?MW5DdnZyU0JFK21HZ0RQeHJMTnc3bjdSV3Axc1dKNEwzYlJvb1BzOGpQR1hZ?=
 =?utf-8?B?cGZJYzhwT2JPUWVjM3dZSTREWjBEYWRKMTRscUlWcjdkMlc1TUM4RWdRdXI4?=
 =?utf-8?B?TmxEeXhRWGFwWVVxcnZkOWFGaG91bU9pZC9rbDNXamtPT0JITGJObVZwSHBv?=
 =?utf-8?Q?LZoFqg1z/VfQGLChof66/fYjUZV02lTjZwYNV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A42DEA219E8843A543398B060B37DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	te4/WOUpZvRGNOaMbqRPsw4IXeq0pI+shMwPM23KyW8QiklIpafpbimceQx4ts+KRtsGz8jacUUtHmYEl/33BAXngH/pU5h5AXxLBm6lACxbcFgnCh+vptJdluHgv8QVzTyktejK/V1fDDniTHrnvuQFW9Z98MB6ZgYPV8hfj4Tb4b6Llq+jDL4d49R+AsJG5/PyJBmfoaUI1c80ag1NbgiXYQ0Zwdqbpv1A/GAJdcCmrvlbopKhyAO0/uxy3pt7yv4EaphF2jM4Nos+sAjEyMyXNPbRmRrzTZzCqIKOV3xEl1BnhL9IaCTrn8fT9yr74tUc5KxF6VMsYdZ/hZ0a0Q==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b67bea-0448-461e-ffee-08de9021b75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 19:06:01.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfR3mBCLGqKWVuqD1xTnJnHZFGwFY3kdq04h9DXR7A8kF1OP4GR58yUXO9JO+Hpy4QEHG3HjZ+BZC2HOTW8Wsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF6404A4904
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd6ca1 cx=c_pps
 a=7Di9vct5tcmjM1itADynpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=P-IC7800AAAA:8 a=MWDzL99E-foOncG9cWkA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: vxZL4KnckXkEXxIeSshENVYss2n9cf3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE3NiBTYWx0ZWRfX7LuiGE/nEhH5
 X71kgl89qS5yPp/UrnNJcemseKiSMOHs3FXr55LKlnc7XSncwN+ddOD0mI1yTo/+qVHRcKjjUeV
 tLJegFfTj/DassDz6+Kg1Jx2hCWJiM4dDEJCDYgPUNdRN5NSfBnmTFIr3A4Fuy0BIQ8JM+d4nq0
 GvGpKQHGgk23iTP+mkqusH/Qg69mkI/NlJANymZ9Idsth/GOA4FIzDMn3jVbFIegHLDsc3LY9pm
 nWXiGpVbtXErS8Qx2oNUmqBcsb3ghk2D9eusEgTkGQoH8rwnnFFoYsp2NL/QmqppkJaiaQwGfLN
 +fqyhIjhoTyADIe6BbHE8e720lvuYCgLnriv/GjPIU+YL8W7WAA32g9it0u61nej//GTS2nX2bE
 z8TDQH8goU8983ufV/8RsrQG72j8OiEpGwN3+62cmLNFacOWYCwqUuUptulPka0lUS9sMi7Ilc1
 fP5UFzX+vCraXr3JdiA==
X-Proofpoint-ORIG-GUID: f2_gnHDdfCNrteUtZHhqxaPQiwjR6Wl_
Subject: Re:  [PATCH] libceph: Fix potential out-of-bounds access in
 crush_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010176

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDE1OjUxICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
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
ZXBoL29zZG1hcC5jIGIvbmV0L2NlcGgvb3NkbWFwLmMNCj4gaW5kZXggYzg5ZTY2ZDRmY2I3Li5k
YWFlNDIzMGJmMzggMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL29zZG1hcC5jDQo+ICsrKyBiL25l
dC9jZXBoL29zZG1hcC5jDQo+IEBAIC01MTYsNiArNTE2LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY3J1
c2hfbWFwICpjcnVzaF9kZWNvZGUodm9pZCAqcGJ5dmFsLCB2b2lkICplbmQpDQo+ICAJCWItPmlk
ID0gY2VwaF9kZWNvZGVfMzIocCk7DQo+ICAJCWItPnR5cGUgPSBjZXBoX2RlY29kZV8xNihwKTsN
Cj4gIAkJYi0+YWxnID0gY2VwaF9kZWNvZGVfOChwKTsNCj4gKwkJaWYoYi0+YWxnICE9IGFsZykg
ew0KDQpUaGUgTGludXgga2VybmVsIGNvZGluZyBzdHlsZSByZXF1aXJlcyB0byBoYXZlIGEgc3Bh
Y2U6DQoNCmlmIChiLT5hbGcgIT0gYWxnKQ0KDQpIYXZlIHlvdSByYW4gY2hlY2twYXRjaC5wbCBb
MV0gYmVmb3JlIHNlbmRpbmcgdGhlIHBhdGNoPyBVc3VhbGx5LCBpdCBjYW4gY2F0Y2gNCnN1Y2gg
aXNzdWVzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiArCQkJYi0+YWxnID0gMDsNCj4gKwkJCWdv
dG8gYmFkOw0KPiArCQl9DQo+ICAJCWItPmhhc2ggPSBjZXBoX2RlY29kZV84KHApOw0KPiAgCQli
LT53ZWlnaHQgPSBjZXBoX2RlY29kZV8zMihwKTsNCj4gIAkJYi0+c2l6ZSA9IGNlcGhfZGVjb2Rl
XzMyKHApOw0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMC1yYzYv
c291cmNlL3NjcmlwdHMvY2hlY2twYXRjaC5wbA0K
