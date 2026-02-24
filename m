Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED052264A9D
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961493; cv=fail; b=sMsGQWmGVXWhTauYr9uSp8HaCT1sRVRzjfR/eftjghlfLn6hOd66so7Waml0GDd/bIEhxvld5nhk6VjlO5qlcfN4Jbwl/e4t4g7FdP6UWPcQcBW1rQpvcLWTte9jg416p+Sd+eb/KTJO21+sqpOAPjOeJNp+JnawsExTkhQtCI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961493; c=relaxed/simple;
	bh=ixn7duFbDgqG0gdI+A7Z3iA6fHjjl/Cqv+T9461V1qc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=eQjymoar9tIUzAwtma/ERDjWQudBLhqanJm1gPG+wsuyGU8g/0M3dy9362EeKBwphB2PTOvR03EstBd/pNNAw6wakU1nSLD2/rOgLbul9DohST7AwfJfX0S18tZtOK9q6VGbOXI7f/mrp1j9eUHRO07uIjsjc5Gd+mtzy+3v7RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RXV3t09j; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RXV3t09j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OJT1NF2347007;
	Tue, 24 Feb 2026 19:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ixn7duFbDgqG0gdI+A7Z3iA6fHjjl/Cqv+T9461V1qc=; b=RXV3t09j
	RYg3zi92DAwKeohVZH5Jy9dXb9B2HGOTDgYIGBam0bmK9IsEsW4DsEUkXpqiGC0y
	ejlYKEsHJQphN7GHUDedO2xBY5eQziobayWtto9VJS/Hb4CKoiwW0cehYqU/FJFe
	oSXuujFx9dP92bngmze5NOLwjGSTwvirC+0zvVNCkLN1fhCoMhdaULem/cJS9X+f
	HP/CoFPJhqiII6n+Gd/MA/PmTAj0Fbjy+zVmtT6A+80xUSwlK4bwnJO62NDHHqy2
	okr4Y9kZ+9TL1ykg2APy+FHFbXArZMJc2V0AFix90aZH/fjz7rPnWY5z45KMVb4W
	d8M4lOXF3anslA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858jnxm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 19:31:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEnxm7rXQFBWZGqJVHMQaalOU99ezqn9YyKBvX/wp874MoeKLwXBK2pVGUP9k4zdsvtMxw1UrSstxFKCBGqWH7uVfYYPGXnnpZeulOnsodu8Fqa7ikVeDBRX5/GanyCApIVn/565b+FkMCej18kMq0VKE4hxLhazOG31BVYm4i4iW6rMlzFH2DMhSqg7UClKY9K4EUBUDx+7s/ZiOH/hlAYz3zNLpteAuzEG5OVQBfmSmjQBuc0Lwewa1CLU/VNguYyr/TQq4mCHtIizbshmc5uUcEAMGdcNqQHabTjX7sAMGl4Jmv7TnNmIkx4C8Et5D+Hw70b39TAqVfgHOqMuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixn7duFbDgqG0gdI+A7Z3iA6fHjjl/Cqv+T9461V1qc=;
 b=GAUsrdavYhb1c/2SmFq//OxLdkLTTI7/rDRBuyj5n2LTbuxhcnRG4Gu0xmFJ66IYJsrs1hIBKvlpYbMUjr+OvFBodqNlyfxkPx4i8Tjsh9tnD3hjInprJA79CNR0KTxvXVWCHfTbISY+W8+5FUNGlAAI2Duie2T8+3JKHbdXDev+DN5ZqzH/AfwbQhDOCdBL7XMXsEauFBkm7JJN4vyxl9Zl5U+H1IeSe01qqvUyi4D3CBO2CYXvsO+VrG8wE1HKiGUnr1nrcjQMlPEht2VkxARG+73q7yjAjLvHY6J/XVCJHvtDNBtREA6ZyfdjNzkv62Lp7jD5P/us6COtGVa+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4739.namprd15.prod.outlook.com (2603:10b6:806:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 19:31:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:31:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
Thread-Index: AQHcpaO6lW4MdY2yj0iVR9o3PORNqbWSPPwA
Date: Tue, 24 Feb 2026 19:31:13 +0000
Message-ID: <03568ee4e42923e939a77b7d04244070122d89bd.camel@ibm.com>
References: <95b6e21f-0bfd-4d39-93c1-757f3706590f@tu-ilmenau.de>
In-Reply-To: <95b6e21f-0bfd-4d39-93c1-757f3706590f@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4739:EE_
x-ms-office365-filtering-correlation-id: 5ccc1657-0102-4b26-2c08-08de73db456b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmdTTlQ1WDIyckdXSkg2a3Y0cWt1bHNKdWJZUHZnU0hkb0RsOGs0WlNFNWZu?=
 =?utf-8?B?ZlBGMFVQUDJOc014NStTM2NIZEVNREVySDBWQm9PeHlkakE4UnJBeWE0MzRy?=
 =?utf-8?B?aVBkbmg1T1hYS1NONFNEOEtlWTRZeDdzUG5nZ1pwTCtyeTY3T1JOWDlTV0dI?=
 =?utf-8?B?YXBicXdFUkt1bEdjOWhiVTJPRTlXajdJR3E4Vm91dXhQTjZyOW1ERDdHWXdB?=
 =?utf-8?B?RnE3djdMU3AwRENOdzdSbDU1ZTV1QVBYMGV2SUVwamV1TlRYa2pKM2JNTGxF?=
 =?utf-8?B?S29pQkxjVm1qbHg0U21naVJMSnlnSU81ejdld2JscTlVU2pPUXJpYWNDWkth?=
 =?utf-8?B?VkZEeTZlOXZOclY4MnhUSHRteko1QmVudjk0c2s2NW84SnYzUEkzTzdiSzBG?=
 =?utf-8?B?VjFoTFdiUVZxM05PRFI1WkJnUUM2VkRreWZiNjR5VE9RNERvZ1lMTzZCSXNT?=
 =?utf-8?B?amQvNk9ULzZlN1hLUEZyVWVOSCs2SzE3Njg2eDhoUC91VmM1clZ4N3VqRG95?=
 =?utf-8?B?b2dMcGUwZUF6VUlHOVY2SWo0WG9WYUs0WmFVMmFTZGhIL1dMWkRVaU1RUHhx?=
 =?utf-8?B?MFRlUHFoSDA1SWFxTGNlL1grYi9nbm4zc0xPMnJvS3hHblhJd3Azc2RTN3NI?=
 =?utf-8?B?ZlB5alhjbFU2MXRGMWJ5NWU3TUttQnAyclkzK3p6UGNVNE5pYmdkSklZOTh3?=
 =?utf-8?B?RUp3V2R4WGIrblZqSGdYVFo1dHdkVEwwcm9VdkxWQ3k4TEVFM1ZKV01YaWJQ?=
 =?utf-8?B?RXB0UGhrWXkxeTY4dFNpV2hScTRMbjFxL2tQbWZWb0drNDBpaDZXaFpGY09m?=
 =?utf-8?B?QkIxV3pqV2lqTWViVjkvbDgyTEwyaTRNMkUvQy9Ocjdtb0NRRVYrc1RGRkpm?=
 =?utf-8?B?eU1FQ0RqU21oNFJvSEtLVTl6SmFuZTNBUjMvZFBnWFRZeUEwSTlXYlpURVBy?=
 =?utf-8?B?cGRZY2phNWpJemg4VFN3MWhCQ2hiZ1QzM2FGYnNBcGxsc0E5WU5UQ3VFRU5n?=
 =?utf-8?B?SXZieHZZTitOK212czgxalRMaTc4ZStBcWlIdHpBUGRLMzQ0YXBHbjRTUTBj?=
 =?utf-8?B?R3JaSlcxM2Vqb3FnQldHUS9taG4yTWp0eWN3RkpBNDQ2N1RabU5lRnpQUzdn?=
 =?utf-8?B?RlltNnJWSDgzdmFhbG5xVkh0TjliM01FanljOTZCUGRYME1BL3o3eHE4NkYr?=
 =?utf-8?B?eFFtaDF3MnZwQUJSZ0E1Y1cyakRjeGFsZU5EdEVjaFUxZnRGMUpTVXp4NnUy?=
 =?utf-8?B?aHBZYXUyL1F2VmlUNFNiaURnNzBXY1NJUEVUempKN3BvaWY4K2lGOTBkc09B?=
 =?utf-8?B?VGU4OXpaN0JRQk05Tm9QeklzNVk4cXVzSHdBbVZoWUhRdWNoN2dmWXNIU3h5?=
 =?utf-8?B?WE9FVGR2bG5VTVFZOWF1Z2xGWUxMZ29uUHI3QmJOdm1xRW5EMHBiZU9md3pU?=
 =?utf-8?B?ZTFGazkyQ01ST0ZpZWlaUDhxVHlGNHllYWZWdGo4RlY5eVpoRlZUNmV5R3dw?=
 =?utf-8?B?QTBFTVprbUR6aGpOS2JBTmtIa1FkZ25XNno5ZUZtSi9RQ01uYWtqOE45N25p?=
 =?utf-8?B?SXFlN1ZHVWN1cXVFbndFOHlVdjB1em9JdmVFMXJESGNuSW9TUVlrZXBaZjk4?=
 =?utf-8?B?bVJCL2pNSWhXeFB4ZGpBTHoxeXMxME9ZOElyYUh6NW1hR2RmNGt3UnJ0SGpi?=
 =?utf-8?B?WksvVzBXTHJGbVNEV0h5ODBEQkRMc0RtOEN2bGsxa3JVVTU4Ky9PdmJUaG1l?=
 =?utf-8?B?ZU9vUjNqVy96NGZ1NnBsY3d0YlRnZU16SGo1NlVZWWFVNkplVjc3Z2gwbXJi?=
 =?utf-8?B?NEw3cmF3dlpON2VheDU2RlFSQ3QvN0xUdnBabjJGdm5yNVN5dldyYkJjOStS?=
 =?utf-8?B?MVdma3hMNnRUZ0VoOFdQejVzMmcvYTRFU0dDV1F6N01OdkUxWTFncEgzM1c0?=
 =?utf-8?B?dloyRmRzTGdZV3h4MFRkRVA4WjhmdU5BOFYvL3lUdFc3ZkJtZ2ppcVlCSEFZ?=
 =?utf-8?B?aHd6ekRJT2k4UHFtMGNWNmlhUzZ5MGRibDlGRkZFaDZMNlpRaDBoNGVTRTlr?=
 =?utf-8?B?YkxlTDMyMUtZQUtCSUgvU0MxNUNKUm02TE1UK3FYTzZsdG9WREdyaWkrNWM0?=
 =?utf-8?Q?byCVv2tFtHchICzxDIzT4vBtU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXpubTFxRkJHN0FJL2FoZjBDa2VXc0NORmxBU3RrQUZITm5XTHVpL0VWSkR3?=
 =?utf-8?B?SWduai9uY29BVks3TnFHaWl6bkFUQkNxVnpVZldkRmQ5L1Nwbm1FTE1Ob1ZB?=
 =?utf-8?B?YVRUbzBSenhLUXZVN0FSY08wWmptalhhRnFPOWZnck1pM0VwcFhDRWkvOWor?=
 =?utf-8?B?dG1Mc1AwWE1xS2IyQ0IrcGltTG92YlBMdVZYMXJJenFadDh5eUFjUkN1ci9n?=
 =?utf-8?B?a3BDMThuZTFhaUNjS0g0WERCaW55dXZmZXg3M0JlaVBOU0JtNjAyZGRobG9v?=
 =?utf-8?B?OTMxaE5PM0pmRDdxbUJ2aExobUoxNzg5SjgyMy9lSjB2SjlCcVArRlVBMUJs?=
 =?utf-8?B?SXlKajR4S1BTOHlUbjNTYS9Kb1pVZ2xSbG1xbHJWTWx0S25GZ2FoR1hCN3ln?=
 =?utf-8?B?Lzd4bHN4cVMwSHBzNEI2S2Z3a2hkdUFGbzVtYjNtb1FHLytpOHJteVYySjl4?=
 =?utf-8?B?b1hDZFFoMFpLTFVnVmMyUjM1aFdVazR4QmdEZ1dNbE5uYTJ2cUFpd0dOTlB0?=
 =?utf-8?B?MUwydWppNEFJd2kyUWd4REFBdHgrTjZ2WWowcGplR3p6c25odGZISjhSU05N?=
 =?utf-8?B?R0JqY1dtNXVPbDBNYlpKTXMvNnVpODRoaS9memc4aVI4cG9GaHF0d1BPeW9t?=
 =?utf-8?B?bUZCTjd2UVQwRGJ0NlZhVmplanBraVNvVjBIS2x0WHA3Wm1oR1A2VW5ieDhD?=
 =?utf-8?B?QTV1NFpET1o2Q2ZKVGowK1R2czdNUVJhbUtyMklrL1ZTSFk5b0ZnN21tSmw2?=
 =?utf-8?B?WFR0Kzd0Rm15Um90dXRwRXdiNUxLbVpkY1hBcjJ6T1pMY2JJYjB0N3k3RVQr?=
 =?utf-8?B?YXIwOFZHdkg2a2hOMjB3bzNsaWY3aDRRblhCR3lRekt1REJjbHRwY3JHUENW?=
 =?utf-8?B?bWptM2h5emNEN3RMY25aUC9tdk1LVHcrUlhYbWRPZjFycllDdkdzWjhPWC9n?=
 =?utf-8?B?MGFBQk13SEN1VXhtRlNGU1plK3NiaXBjN3JpZDFjM25OaElXbnU5bWYyZzVG?=
 =?utf-8?B?b0VXNndmV2ZvVXE1ckZEUjdpZy9pZElZUm54MGxqckdQRDZiSDdldXNRUFpo?=
 =?utf-8?B?blhwK1B1Syt5OWFqQVZBY0xuMnpUUzgrSWtqRXNTUWl1aTJQL3BKN3FxQ2Z6?=
 =?utf-8?B?dUd0WHpvYXpzTUhhZ2NPRUpYMUVQa2MzT3RpTkEvRVZ6ZTBPNGV5bEJ3cE1q?=
 =?utf-8?B?NGVwazk3amhicHUrSkpIMFFjUVhWL296ZlhqNkloTXpJWEQ2QnN2Y2gxVmJ3?=
 =?utf-8?B?aGpBUVR5NG03a3hFZUh1dURDbVRkc0I4NGlVdVBpcXhrUktTRG8vSnQ2aE9G?=
 =?utf-8?B?WExDNUc1R1c1Qm5FR0RwZ3ZkenpRZk95dnc1YkhxTW5HVjRSY0VCVDdMc2pp?=
 =?utf-8?B?NXdSUzI5UWkxRUYwS01YQUNPcDhidFcyRkx1WklaTEEwdnhaaVBZaVRsandS?=
 =?utf-8?B?OWpJYnlsMmhrdXdxV05qcjZhVHptLzhEajRUWVRtSlV6QytuYnEwZjd5NjBn?=
 =?utf-8?B?WjJVSVJmaDJNSEpJYytid3RoWFR4WmNoWk5BUWwwMUtEREw1dTR5WVJBOFZt?=
 =?utf-8?B?ODNTMC9wd05PNUtNS2l5a1E5U0VjdzRUM2tpRUJMWEFBdDArdkhtd0RrVGYv?=
 =?utf-8?B?czAvNkxTSG16a2k4Q21PZHJ1cGI2QWUwSmNubytDbHhudEpPb1dvRXZJbDRK?=
 =?utf-8?B?Si9mdHMwUHNOU1d5OTlmdzJFSUN5RHFQdjJTd01nM2hZVG8walVaV2xtMVlp?=
 =?utf-8?B?OUthV2JlRUxLd1pQRks4RHFWZEp0NjcxUjhSUGRwRkc3Ny9WM3kzWnZFK0xq?=
 =?utf-8?B?R25nb1RjSDNpR2hLUlpHQkZ1bzY2NUFjUnZPeHZTMDhDSzcra0Rwa05zdkVw?=
 =?utf-8?B?aVlDeDNyeUlEY1VUSWpXMkM3VG8xTmZFTzNSaUlnOGg3WnNYS2ZVMG1XWWw0?=
 =?utf-8?B?TG5YKzF6VXpnYXJjQmdHTjUwUFJENkd1eGgrVzZTdXpmUnFPdXBqRS9jRXAr?=
 =?utf-8?B?TkNFUHpma1c0a3RlcFEvSzZsVVJsclFZc2t4M3dPaDZ4dXNSZlhJUVQyQzY4?=
 =?utf-8?B?a1RoWnNBMUtCOHBCc01aNGdBLzVicjZLTHFSWkhQQmYwRjE4bGlDcjVQVUxj?=
 =?utf-8?B?azUzUDZoTVVzNUsza0VwMkRTaUwyZEFQNkVaeVFvZWhmWW16ZDVFTmVkZkc2?=
 =?utf-8?B?UGx6Q0laL2RtbHEyL2pjRlo4YWgyWnBpYWF4OGNxd0JNVlVKeEhPTUVMQk1Q?=
 =?utf-8?B?MU41V0JEbHdqZUIvNi91YnQxdC9TVDlkRWV6UnB1bGlSN2pFR2lCdC84aFYx?=
 =?utf-8?B?eE15WjlsajE3SVBBenR1cmRadzZxS2xmd0RYYjVpQUt1Q3pCRzY1NmNjckdX?=
 =?utf-8?Q?QhZu1mb/R/I2EQYQ3g/h/HQ4r7eTIPZuzby7y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588B6669E99F194782D9EED5526A943B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc1657-0102-4b26-2c08-08de73db456b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 19:31:13.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8aPamAaBTQFSgxpgeG3FHFAxIB1zrsuZyYSBUzb+iCTiXk4VudEvBwpgiASfhdAmhNhbuR5Ti7YPhQoIEgyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4739
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE2NCBTYWx0ZWRfX/E6GXNPVhBHT
 s6LszodQgywugNn66/m8eyCKzP7/Q7flY3ovJO5B0r8ijOB1YVh87yGMqCRylpw6EMGNFQyxERo
 7iF+8yZCmmWtYfwXKlSkIcd0bA5pyI4bkifuolnPRlAm6JrEQDQGXjWnnRaJ9UJJT08NZ6n91dk
 cXp90lga+OPkPfq2CeFo7zW5FzWgr+orB1510OfzNoiqdsnim0o1QK5seU/n1Qd/zruafaQrfav
 gXM9FBxIbH8dqxbmXDECpw7BWAfcfVplQ8fiFWsuwFVYBZwTtUv/utvwxUuDDrpPBf/IkGNvgiM
 Ryxy37InYIV1RRQwpxg5beHIIQb6OCz7NYc+YTBIexOUtO3pvKBVv5RNlVugqnx9KUmXIufsyPt
 ydf0KZzzA4liANrelSNWjpYMXBnFk7+qwK91WlkcfQ8DVG1ASVYFt+NbkAwmwxLP6R/ICx0FR2N
 aYdtcANLW7L7+uSpJWg==
X-Proofpoint-GUID: 4Y3VCRffFszYFc1AgIqbIXh_D_HfcOqc
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699dfc83 cx=c_pps
 a=lT9N4OFqmOca6tf2P0aJdw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=P-IC7800AAAA:8 a=wxCYqUQis3xRqluiwgsA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 6hVqCPZdzRxC8yUy8nQN_5fLfsGrHaQq
Subject: Re:  [PATCH] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240164

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDE2OjM4ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gVGhpcyBwYXRjaCBmaXhlcyB1bm5lY2Vzc2FyeSBpbXBsaWNpdCBjb252ZXJzaW9ucyB0aGF0
IGNoYW5nZSBzaWduZWRuZXNzIA0KPiBvZiBibG9iX2xlbiBhbmQgbnVtX21vbiBpbiBjZXBoX21v
bm1hcF9kZWNvZGUoKS4NCj4gQ3VycmVudGx5IGJsb2JfbGVuIGFuZCBudW1fbW9uIGFyZSAoc2ln
bmVkKSBpbnQgdmFyaWFibGVzLiBUaGV5IGFyZSB1c2VkIA0KPiB0byBob2xkIHZhbHVlcyB0aGF0
IGFyZSBhbHdheXMgbm9uLW5lZ2F0aXZlIGFuZCBnZXQgYXNzaWduZWQgaW4gDQo+IGNlcGhfZGVj
b2RlXzMyX3NhZmUoKSwgd2hpY2ggaXMgbWVhbnQgdG8gYXNzaWduIHUzMiB2YWx1ZXMuIEJvdGgg
DQo+IHZhcmlhYmxlcyBhcmUgc3Vic2VxdWVudGx5IHVzZWQgYXMgdW5zaWduZWQgdmFsdWVzLCBh
bmQgdGhlIHZhbHVlIG9mIA0KPiBudW1fbW9uIGlzIGZ1cnRoZXIgYXNzaWduZWQgdG8gbW9ubWFw
LT5udW1fbW9uLCB3aGljaCBpcyBvZiB0eXBlIHUzMi4gDQo+IFRoZXJlZm9yZSwgYm90aCB2YXJp
YWJsZXMgc2hvdWxkIGJlIG9mIHR5cGUgdTMyLiBUaGlzIGlzIGVzcGVjaWFsbHkgDQo+IHJlbGV2
YW50IGZvciBudW1fbW9uLiBJZiB0aGUgdmFsdWUgcmVhZCBmcm9tIHRoZSBpbmNvbWluZyBtZXNz
YWdlIGlzIA0KPiB2ZXJ5IGxhcmdlLCBpdCBpcyBpbnRlcnByZXRlZCBhcyBhIG5lZ2F0aXZlIHZh
bHVlLCBhbmQgdGhlIGNoZWNrIGZvciANCj4gbnVtX21vbiA+IENFUEhfTUFYX01PTiBpbiBsaW5l
IDExNyBkb2VzIG5vdCBjYXRjaCBpdC4gVGhpcyBsZWFkcyB0byB0aGUgDQo+IGF0dGVtcHQgdG8g
YWxsb2NhdGUgYSB2ZXJ5IGxhcmdlIGNodW5rIG9mIG1lbW9yeSBpbiBsaW5lIDEyMCwgd2hpY2gg
d2lsbCANCj4gbW9zdCBsaWtlbHkgZmFpbC4gSW4gdGhpcyBjYXNlLCBhbiB1bm5lY2Vzc2FyeSBh
dHRlbXB0IHRvIGFsbG9jYXRlIA0KPiBtZW1vcnkgaXMgcGVyZm9ybWVkLCBhbmQgLUVOT01FTSBp
cyByZXR1cm5lZCBpbnN0ZWFkIG9mIC1FSU5WQUwuIEZvciANCj4gY29uc2lzdGVuY3ksIHRoZSB0
eXBlIG9mIHZhcmlhYmxlIGkgaXMgYWxzbyBjaGFuZ2VkIHRvIHUzMiwgYXMgaXQgaXMgDQo+IGFs
c28gb25seSB1c2VkIGZvciBub24tbmVnYXRpdmUgdmFsdWVzLg0KDQpJIGFncmVlIHRoYXQgYmxv
Yl9sZW4gYW5kIG51bV9tb24gc2hvdWxkIGJlIHUzMiBiZWNhdXNlIGl0IG1ha2VzIHRoZSBjb2Rl
IG1vcmUNCmNvbnNpc3RlbnQuIEJ1dCBkbyB3ZSByZWFsbHkgbmVlZCB0byBjaGFuZ2UgdGhlIGkg
Y291bnRlciBmcm9tIGludCB0byB1MzI/IFdlDQphcmUgdXNpbmcgdGhpcyBjb3VudGVyIGhlcmUg
WzFdLiBBbmQgd2UgY2hlY2sgdGhlIG51bV9tb24gaGVyZSBbMl0uIFNvLCBpdA0KY2Fubm90IGJl
IGJpZ2dlciB0aGFuIDMxIFszXS4gU28sIGl0J3MgY29tcGxldGVseSBzYWZlIHRvIHVzZSB0aGUg
aW50ZWdlciBkYXRhDQp0eXBlIGZvciBjb3VudGVyLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVu
YXUuZGU+DQo+IC0tLQ0KPiAgIG5ldC9jZXBoL21vbl9jbGllbnQuYyB8IDEwICsrKysrLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBiL25ldC9jZXBoL21vbl9jbGll
bnQuYw0KPiBpbmRleCBmYThkZDJhMjBmN2QuLjhjZWQzYTkyOTdiMyAxMDA2NDQNCj4gLS0tIGEv
bmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+ICsrKyBiL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiBA
QCAtNzIsMTIgKzcyLDEyIEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tb25tYXAgKmNlcGhfbW9ubWFw
X2RlY29kZSh2b2lkIA0KPiAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4gICAgICAgICAg
c3RydWN0IGNlcGhfbW9ubWFwICptb25tYXAgPSBOVUxMOw0KPiAgICAgICAgICBzdHJ1Y3QgY2Vw
aF9mc2lkIGZzaWQ7DQo+ICAgICAgICAgIHUzMiBzdHJ1Y3RfbGVuOw0KPiAtICAgICAgIGludCBi
bG9iX2xlbjsNCj4gLSAgICAgICBpbnQgbnVtX21vbjsNCj4gKyAgICAgICB1MzIgYmxvYl9sZW47
DQo+ICsgICAgICAgdTMyIG51bV9tb247DQo+ICAgICAgICAgIHU4IHN0cnVjdF92Ow0KPiAgICAg
ICAgICB1MzIgZXBvY2g7DQo+ICAgICAgICAgIGludCByZXQ7DQo+IC0gICAgICAgaW50IGk7DQo+
ICsgICAgICAgdTMyIGk7DQo+IA0KPiAgICAgICAgICBjZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVu
ZCwgYmxvYl9sZW4sIGVfaW52YWwpOw0KPiAgICAgICAgICBjZXBoX2RlY29kZV9uZWVkKHAsIGVu
ZCwgYmxvYl9sZW4sIGVfaW52YWwpOw0KPiBAQCAtMTEyLDcgKzExMiw3IEBAIHN0YXRpYyBzdHJ1
Y3QgY2VwaF9tb25tYXAgKmNlcGhfbW9ubWFwX2RlY29kZSh2b2lkIA0KPiAqKnAsIHZvaWQgKmVu
ZCwgYm9vbCBtc2dyMikNCj4gICAgICAgICAgfQ0KPiAgICAgICAgICBjZXBoX2RlY29kZV8zMl9z
YWZlKHAsIGVuZCwgbnVtX21vbiwgZV9pbnZhbCk7DQo+IA0KPiAtICAgICAgIGRvdXQoIiVzIGZz
aWQgJXBVIGVwb2NoICV1IG51bV9tb24gJWRcbiIsIF9fZnVuY19fLCAmZnNpZCwgZXBvY2gsDQo+
ICsgICAgICAgZG91dCgiJXMgZnNpZCAlcFUgZXBvY2ggJXUgbnVtX21vbiAldVxuIiwgX19mdW5j
X18sICZmc2lkLCBlcG9jaCwNCj4gICAgICAgICAgICAgICBudW1fbW9uKTsNCj4gICAgICAgICAg
aWYgKG51bV9tb24gPiBDRVBIX01BWF9NT04pDQo+ICAgICAgICAgICAgICAgICAgZ290byBlX2lu
dmFsOw0KPiBAQCAtMTQxLDcgKzE0MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tb25tYXAgKmNl
cGhfbW9ubWFwX2RlY29kZSh2b2lkIA0KPiAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4g
ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBmYWlsOw0KPiANCj4gLSAgICAgICAgICAgICAgIGRvdXQoIiVzIG1vbiVkIGFkZHIgJXNcbiIs
IF9fZnVuY19fLCBpLA0KPiArICAgICAgICAgICAgICAgZG91dCgiJXMgbW9uJXUgYWRkciAlc1xu
IiwgX19mdW5jX18sIGksDQo+ICAgICAgICAgICAgICAgICAgICAgICBjZXBoX3ByX2FkZHIoJmlu
c3QtPmFkZHIpKTsNCj4gICAgICAgICAgfQ0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuMTktcmM1L3NvdXJjZS9uZXQvY2VwaC9tb25fY2xpZW50LmMjTDEzMA0KWzJd
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5LXJjNS9zb3VyY2UvbmV0L2Nl
cGgvbW9uX2NsaWVudC5jI0wxMTcNClszXQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjYuMTktcmM1L3NvdXJjZS9pbmNsdWRlL2xpbnV4L2NlcGgvY2VwaF9mcy5oI0wzNQ0K
