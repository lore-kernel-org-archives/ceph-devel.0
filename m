Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE55C145;
	Tue, 10 Feb 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708036; cv=fail; b=KkDqGA1zyWluYJn/6ZQZAaId6iRQXJfKhq1wyaHx9ZEb4MLo1yzYKBsuKyDjoN8x+2HJzx1xVUcIq9ZDW1ASnuOeu0Uiu/EJHpF1ScAv03dVYmjr2OREUiUpsPiM8n9NuAsYEDypnfF+DKYL+z0qeCiTYHTw5aMACspXNpkfJig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708036; c=relaxed/simple;
	bh=rMGpsNIoZQmyIoobKH+McpJDGk7XaQK/gGXDUGuGRCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSZcA7MoXyVEtQofIggY9iQQIk8gET//0zPsjtNI1KMS9CZ84wm8N0YWhg5fP96ZpzZQI5BaQfOfSyjsb0QU2Dqk2owwKfFSjOmdijr3ONHB+oqF2byakwuzoLh24jJmXjyay9T2nx8sRmT1Vn4vA0KgfcFyBVEbXyf8Kv9TNLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Nxsm2cYj; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Nxsm2cYj"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A4LXd91344636;
	Tue, 10 Feb 2026 07:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Qt7SB0qjPI5wcMMa3I9Hlza12rpWiiT56jOFX39jVPE=; b=
	Nxsm2cYjZy+RYUKYcIR0HmZ8yuF44pN0sxx/BUYEt2l4npqkbjvgqKq+zy0pPKDw
	LL7MDku6xLm4oJ6+BtREoz6py63KUCeZQI7alqdeW1K5wKugXME0EUJ2TZsHQuhY
	oXbtDNwzHHOZxmoOXGUqTi3cIEOxCN9CHKnV7rnnotbc4TOimr2Ui/qo3TH4SLie
	9tQ5m1A9QKWo9+tzErJLmQ+4e1tpZ30+os1NcYOMg1tBPNHwutmp15OLwXTCg5Jt
	UsoMdsaSOiI+QQ66aiU7nLCMGNiVZDWTmL0sUh1tiQxIScs/bsv4Q6XcndL0nuh2
	4Dh/Uz1+IFBPw/8rqSXPKQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwk0x3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 07:19:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuitlMmv57JvAqbE9XMot5k+lW026ZtEytFNUtfbxFrDeeZyfd0e7W3UbemVakT7pO4Xup2+OrFgGonMmlIGpKNg5iK5gPJLZZ5X6WViCBjeBbORGjId73vpqhMUrkMw/AyhpRK0uIjfpZVAbCtBT+2pw3d+XaJaRAko4TW25rSDf4khhtD1XYH1NExPyx7acrYyRhuYVSER9HOQMkHCkA9y18Bg4YIFLvnI+GliBQzlYUQnj0/4FYxuBq+wrNVYVG6EtpQPBhE6f97CQgoIVEucySkBiNjrtb05e+xZgCgYFZNzf9Fp0bSw6FZxgCFPgqKrRVtWKsuuG7z4gquVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt7SB0qjPI5wcMMa3I9Hlza12rpWiiT56jOFX39jVPE=;
 b=Y/Pf1JEA8Dx2XAtkxfcEGj/DxhLah3R0JrEMaGiI5rCwZmrZHDduorGdZO2yehUM/YCPX5E6xGtZt6AAHEd3cDIvcI9wt7X1ctDlXTOGh6Uy/Z1hWxQ0l0sAxYqyCSLfcAGliJPwH0I/w0pMWpiwqp5kXxrZQgMgIuOJ1mB00oTsHEk3WnSlNGXsTzumi++m6GWA8E/UMdCL8FKffKxvIB6unT9BEKKVL9szseTuwGWRkFUvyh+Z7/hPKYFO5vq/balU7hrmpq9DjlvEQg2of0yhgquUi7bWbMZlC96dhMLy4eEZYIfpK8sDursI52s1tnUTDMNmOiZmPJnd0Y7iHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 07:19:46 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 07:19:44 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com, bigeasy@linutronix.de, ceph-devel@vger.kernel.org,
        clrkwllms@kernel.org, ionut.nechita@windriver.com,
        ionut_n2001@yahoo.com, jkosina@suse.com, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        rostedt@goodmis.org, sage@newdream.net, slava@dubeyko.com,
        superm1@kernel.org, xiubli@redhat.com
Subject: Re: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
Date: Tue, 10 Feb 2026 09:19:29 +0200
Message-ID: <20260210071929.15602-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
References: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0190.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::47) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: efa44d7a-7338-4886-8f90-08de6874c3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dneIdUOvsBKyah/QMKUCzB9BG17qLT2gTk9tmyGrEL2Q2UK/AfmkmxFZh1pw?=
 =?us-ascii?Q?LdByFy7jt/T4jXNg5tB4LRsnLBLsdXE3xpTc6n16+nVmB4dmugrEMZH+gTRJ?=
 =?us-ascii?Q?d+gg+WJhVqdIbtg3QyiM53nlCEgIT41Mxqsj3bluGZwVvLI554oPM1yDoi18?=
 =?us-ascii?Q?4ZXGwWijlr53nWEPiGZm707f06xnJyn1QZ7Fqu7YWGsy1/THrp9/hyaCbwrz?=
 =?us-ascii?Q?hgyWoTqH4C6O4rjDl94qTlCaOgW8XVWo6Ah6HOLMqaxTrr8iKSwW2sNUOZyF?=
 =?us-ascii?Q?4POVtwmlNmwqdAr3mIS3WEdb6QR3SsTzaRnA4roQYkjlFtyA3yUlnpu1n42H?=
 =?us-ascii?Q?apSbiVOyuv7vza035g0okOqUmrsXHPZgbJ28JYcPEW8LWSdsfx/qLGhX6VvL?=
 =?us-ascii?Q?YJCstOm0cEL6WQu/jiyo2Jcy3Jo1SWhFJhYfw1svi/M2/9ihWM2CJcS4RsyH?=
 =?us-ascii?Q?Q8Lpq6JAOMSLpWZzJnvoXCw0dqL73qBcQOozF58c5s4efFXDrFfz6uosgheY?=
 =?us-ascii?Q?vANLkn7iJPTYY6MP91IoTMPoswLatveiGACrk0FdR33YsiDhL28C9dw2ue/B?=
 =?us-ascii?Q?ock1ZzBibRs8Hrw8KAWDgbGNwr71SwZSKEXv8vZfuBoDUP7gTJp/rj1C8Smo?=
 =?us-ascii?Q?IeNpu+VIos1zKyotqobD7z37uS2Xcm5fmu8kGDXZfgqMAiJDqgzUi11VVF+T?=
 =?us-ascii?Q?bhvJj0wDhU4yr1St136dlOX8Z+yRtRocASjkw676+ACJKGfg7H3vl5gtvgGp?=
 =?us-ascii?Q?FvfOPBrC9FRq5THFz+Oq1xJLS47qzhd0q56rGIU45+/EVZlBFJTYqNCWcggf?=
 =?us-ascii?Q?4GsV13yzXegK0qEvlVd5BTof8N+dDBjEoGOklZwG/e8zS8Z/g9O1hLzxEFkb?=
 =?us-ascii?Q?aTF4D5WNDJyx7pLIEM5ch6woj7ioyM1RPTEyy5vNKH0/eOeVNGnt/ZJGNhm6?=
 =?us-ascii?Q?sKozB1P7mmHqeQ0gxCI76pL8DyUEkcJM2GIdCtzQcEKgi1dcprCP7xVqNwc9?=
 =?us-ascii?Q?U+auLd7FQpM33+DMsscXIhElj8KuIrnc4eqP317mv4/DPfPjQ7ooPtevttWr?=
 =?us-ascii?Q?wpPHamn8tW9HGis7d+BYGIyFmh108ZKEillydi5WPBmhwhz80orHWxZrbY39?=
 =?us-ascii?Q?qv4s+DaujAkWHnx3HHWtoOoKDO1iKELXNhJL5jG+ijEitdUEJEUFXeBFIbpQ?=
 =?us-ascii?Q?Fa9xaBNmMQ2G1zjTUu1K9UGFiGKvEpB33JFhllhnXP564UkUygTrAwq5jWbd?=
 =?us-ascii?Q?aSBJ9sdbr/RmodG/PRK9wA21z7ghPTgJSpBuKXZ9xJUKBmeZ3N/GiOB/69Re?=
 =?us-ascii?Q?UX8hY9fKhKxW1wXRMco5Sin8d3zLbW/jzDcZmfi9P2B6oeHXLcn9qgfOMqsu?=
 =?us-ascii?Q?NT55UpA3MwtCnsurWB8Vxo35g7WNkxe9k7jQULudyBY6kS1FStKJHT9xbEs1?=
 =?us-ascii?Q?oDAp4MJ+g6Y+Ve0Y44IWZQ6ymNFMltFWG8knFyWqJFmgWcwCajhtaKkZenLK?=
 =?us-ascii?Q?nGO9eiEmrIBXdjzDvH1P0NiD9ROf5d/U2g0SX4G/9QZCSn6ydlsmgLpgCWtV?=
 =?us-ascii?Q?xrnsyggaOHgqxw6Y+EI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JJQIMvExVdycqAkVEsPBFrz9gbmWBEqVNrjxs6Y0I3cevFPlRyIEk3T4Ce/Z?=
 =?us-ascii?Q?DIItl1u5PbJxNBLtFAIOav4yWsMpMhQDGREey5lm5GRfRPS7rU+7qwUaW42y?=
 =?us-ascii?Q?n/89Rg9dF6nL2vnPH53OdRn+tyy7ytge+rYEMaHPOHO6BT64o9L1J6mZsUym?=
 =?us-ascii?Q?9GhEmvvs1qMv9+xXaX0z+2rYmShWLWAX2+Otvw47lGim2P6GWBWLVsHI63WB?=
 =?us-ascii?Q?0nzaU8ZsHNZViQNxWnKxTsEJR4dLNL+Pe+Ml4lJ28vq5OiGAWkUCT6GeAUO8?=
 =?us-ascii?Q?Olu5VrDXUicaichoaTRjR2v/n+I67aLUDsO6hT0IWwSsR6FJtRMmbXE3iVy7?=
 =?us-ascii?Q?fSgp/dxr7wRAU7T2IaymCPIhmlYwdCBETY08wM4pinOpvHDLk46LTb3+aTyr?=
 =?us-ascii?Q?gYd3WheQJ2JZuhIZTEUV6uSXusWCarUZX+CnsNCzu8YFrbx8EAmDV47h77A+?=
 =?us-ascii?Q?+nUaRSCWISMT/x3hMPnmX/8DBLqjjKTg4DaliXSCFlMCFxpt9owoGbwDzoKH?=
 =?us-ascii?Q?i2jjbnZXxzEYLJB9YiU7MzyZWJMjy52SvliSTSmCiPlre8IlbH/XCjupJlVT?=
 =?us-ascii?Q?v7H7dxPaO9BOddMmDSmcFJeiJ7dLynbKJKrfuu9injZn3MP0oOcQ0tWKO7bE?=
 =?us-ascii?Q?Ismz4b93hxatdjzaWxpUwDMkbEhqooIzipKopDPp2fxXh6mZF23jnlqcqRyj?=
 =?us-ascii?Q?r3cQDOfRPXZSFLtgvUfAO0OhhKRZUwJryqwbCSIPBmUKl+gj88pEK9m6DQ0b?=
 =?us-ascii?Q?4ZhB14BvFsevjkRT7bwyyC3Oqxjim7Xooa2YyoJL/0qqnY8caWc2Gqoci2C2?=
 =?us-ascii?Q?UCtIdJHME/zu0A7Uiup09R+4gLwrbNRGghj0k4o8y9Jn2B7r673lb7SATrh5?=
 =?us-ascii?Q?ppkZaXdXBHXhBkB/rd6dLr03BAhfIfmtevYJCSaUU7H5ENvEzETSm7kze2OZ?=
 =?us-ascii?Q?OQi7+ycuC18lUO/y19a5jiDlI1PBm8VLHUxRcLyBu+K977wBQEgIKU6Quupj?=
 =?us-ascii?Q?ErwCVlGKJ6MIv7ZFjGV+fziXWcPCVr5upsjMMxQglv2KLimdxgTBSmhaiZce?=
 =?us-ascii?Q?KOJ8FJcgGRP2eTefbj3g6ohWyGKR7i8SGSO23dG/za28gHiPb5tr0iYFba74?=
 =?us-ascii?Q?M+wkeNehJAJ/qZxtrhBkmXiGrpUr83Vwm8mW88usWAkx/GiKCDJfK2Q3DBUi?=
 =?us-ascii?Q?fQhhLY3fZI2F7KoSn3eazL2A+F3/gua+BJav1gDS628Z4gNwp80x5R4Vmgdk?=
 =?us-ascii?Q?ul0jJkAXyLxrA5aUcPwhgILHy+ugm3MqmhGYyOtjAvsnGnPNiGcYWn8VXkD2?=
 =?us-ascii?Q?H9HqX4B0+AyLMQHWzZpWsHVfA6d4yoLcEJuONV+Aad5UpRQs3F7YhzgHzUD8?=
 =?us-ascii?Q?55HO+fz1FlRD9vfnkctUNO2hlu/ewaOATIBpFTd4UB/Y8AJexYxrjT92QrGj?=
 =?us-ascii?Q?0Ys+AnN8PrcyVFvndUaFFEBtgSljL48anLzTSWhdZIgHJgUNNWZ49GpCwjiP?=
 =?us-ascii?Q?X0R+cyMDW9GjZ1QIAlZLsFJkGPyW0+S1YvXlqGVOcVK/RAEQ3R9TASC4W6Jb?=
 =?us-ascii?Q?s7xablC290AQXthvqXU+pyrrT/ho4Y4JfWHS13CGbqBgoknPKNgcDIEkajX+?=
 =?us-ascii?Q?ykyO4wZSShcsufhJsbNJCeA+F+SVWmZbvLOdsJ9PbwVWUzacOQWylx+6H181?=
 =?us-ascii?Q?0MFSrAp9jdiyFOq40QG0nqS8rAOllq5fedbkbGBuVlexNsYwL/5vPNL8rNBc?=
 =?us-ascii?Q?EAG3gYV6Rvuyt7lyFXycJK69okeKV84sPyavQGnuEI6T7CpAnx+xd5OZol5b?=
X-MS-Exchange-AntiSpam-MessageData-1: QaalT7uSIQ+k+MzroFWjbCC2U55+oualHKs=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa44d7a-7338-4886-8f90-08de6874c3eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:19:44.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81K3RUem8X1MULvKz5kXIpNIs6b98cf+woRkzRFFyanLy7ebdNBF4ZC9Fs1SJZHIFCjFOdCuhga+zcwRWfrj8wivOcy+yUQa66n/pFwnqi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=698adc15 cx=c_pps
 a=Eox/QAxx2gIfswQ7UCXYtg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=-nfw4szRPzZ7EVJmS7QA:9
X-Proofpoint-GUID: 9o60jtERYEsZ8xeK_zCrq68yeZHt7_Am
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA2MCBTYWx0ZWRfX+Hki5+95unhV
 teavM8+orDehuHpmei5rJzeupuOXf63gOmT2plLC+0X2CfqUiCVW1/obyz9UB5qQjl5hRbpd9u7
 geyoeGecBMu1JXo9/G30VTbyPR3wrqS5A9/Snn50A+jjNPMwVWG9wX9JVA1U2iOschUThL7Tcc6
 uZ1cSyOwzp3/v/NBD9CJVh/nLjQi8FwswmtdUeYiM28Biepq/SRFX/xSA7v32tLyrDhvu6xUBdJ
 b8GjQp71pqt2P5XCIkZDPnoQbY9OwxvAFDnHZOIPFt8brL5jGz+D9eWlUncOzRL1HB3/E58ECEA
 4MmaNiuDbZfN1kX3+ie7neoDxc4ejQ/WJLyoGAbVhSBrzySO5V/OL9tqpDIW6aPQjyrL760dZYK
 ybOfq6KjklND5SA0jFjTSgDBVWnBxmD/oL+7mc0Eghs4IRI4pRoFxhwoxDlEV48UZKS0h2MK8zG
 1Qw1c/FF4OAqNuHirng==
X-Proofpoint-ORIG-GUID: 9o60jtERYEsZ8xeK_zCrq68yeZHt7_Am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100060

Hi Ilya,

Thank you for the thorough review and the good questions. You're right
to challenge the "1-2 seconds" claim -- looking at the dmesg data more
carefully, that was misleading in the commit message.

> I'm missing how an error that is typically transient and goes away in
> 1-2s can cause a delay of 15+ seconds against a 250ms, 500ms, 1s, 2s,
> 4s, 8s, 15s backoff loop.

You're absolutely right that if the address became valid in 1-2s, the
third or fourth attempt would succeed. The problem is that in our
environment, EADDRNOTAVAIL does NOT resolve in 1-2 seconds. That was
an incorrect generalization from simple DAD scenarios.

From the production dmesg (6.12.0-1-rt-amd64, StarlingX on Dell
PowerEdge R720, IPv6-only Ceph cluster), the EADDRNOTAVAIL condition
persists for much longer:

  13:20:52 - mon0 session lost, hunting begins, first error -99
  13:57:03 - mon0 session finally re-established

That's approximately 36 minutes of continuous EADDRNOTAVAIL on all
source addresses. This happens during a StarlingX rolling upgrade,
where the platform reconfigures the network stack extensively (interface
teardown/rebuild, address reassignment, routing changes).

The reason the delays compound beyond the simple backoff sequence is
that there are two independent backoff mechanisms stacking:

1) Connection-level backoff (con_fault in messenger.c):
   250ms -> 500ms -> 1s -> 2s -> 4s -> 8s -> 15s (MAX_DELAY_INTERVAL)

2) Monitor hunt-level backoff (mon_client.c delayed_work):
   3s * hunt_mult, where hunt_mult doubles each cycle up to 10x max,
   so the hunt interval grows: 3s -> 6s -> 12s -> 24s -> 30s (capped)

At steady state, each monitor gets ~30 seconds of attempts before
the hunt timer switches to the next one. Within those 30 seconds,
the connection goes through the full exponential backoff (several
attempts up to the 15s max delay). The round-trip through both
monitors takes ~60 seconds at max backoff.

> How many attempts do you see per session and in total for the event
> before and after this patch?

Before the patch (from the dmesg):
- Total error-99 messages: ~470 connect attempts over 36 minutes
- Per monitor session (one hunt cycle at steady state): ~8 attempts
  (immediate x3, +1s, +2s, +3s, +5s, +8s before hunt switches)
- The sync task was blocked for 983+ seconds (over 16 minutes),
  triggering repeated hung task warnings:
    12:52:11 - "task sync blocked for more than 122 seconds"
    13:31:05 - "task sync blocked for more than 122 seconds" (new sync)
    13:33:08 - 245 seconds
    13:35:11 - 368 seconds
    ...continued up to 983+ seconds at 13:45:26

After the patch:
- The ADDRNOTAVAIL_DELAY (HZ/10 = 100ms) replaces the exponential
  backoff for EADDRNOTAVAIL failures specifically, so retries happen
  at a fixed 100ms interval instead of growing to 15s
- In testing with the same rolling upgrade scenario, the total
  reconnection time dropped from 36 minutes to under 3 seconds once
  the address became available, because the client was retrying every
  100ms rather than waiting 15s between attempts at the connection
  level
- Total attempts per event: similar count, but compressed into a
  much shorter window with faster recovery once the address is valid

I should correct the commit message -- the "1-2 seconds" claim was
wrong. The accurate description is that the duration of EADDRNOTAVAIL
varies widely depending on the environment: it can be brief (simple
DAD) or very long (complex network reconfiguration during rolling
upgrades). The patch helps in both cases by keeping the retry interval
short so that recovery happens as soon as the address becomes
available, rather than potentially waiting up to 15 seconds for the
next connection attempt.

I will also note that the connection-level backoff delay does NOT
reset when the monitor client switches monitors via reopen_session(),
because ceph_con_open() sets con->delay = 0 but the new connection
immediately hits EADDRNOTAVAIL and con_fault() sets it right back
into exponential backoff. So even though the monitor switch gives a
few immediate retries (the first 3 attempts at the start of each
cycle show 0-delay), the backoff quickly ramps up again.

I've prepared a v2 with a corrected commit message that reflects
the actual production data and explains the two compounding backoff
mechanisms. The code is unchanged -- only the commit message and
the Fixes: tag are updated.

The patch is currently scheduled for testing through a full cycle of
multiple rolling upgrades to validate the improvement under sustained
production conditions. I will share the results once that completes.

Thanks,
Ionut
