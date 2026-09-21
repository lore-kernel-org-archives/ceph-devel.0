Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020089.outbound.protection.outlook.com [52.101.69.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A34C77B4
	for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007461; cv=fail; b=FZpvReAF8rS1uRDUcur2prcWIE7QRfFQ+ltaVs/YduLIdXZfPoKndJczFsUQVJ5ESt1XjFFID7K0sokcMqdSeg3u78NKiyMIB2rhSLguSOKeeXJjYdjXAmcJKKL2ZqFmnUr042Hf5Nv9fGebxKQTT7CcTpDLxTZfrms9TLe1x0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007461; c=relaxed/simple;
	bh=hQODe56bGrr0dgjj4jQ3XJLT0255GaFXZ/B/LPniOH8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HzBkKPcs4UzIRrN3uFFaQsT9OgLXq8fAiJnbZlcBef6o5XodstQN263i12bA9DNeW4B68LUF6jU3zu85Ad0juiLAKfG12vvy6qKPTpPr0YnTBgX/EzLRICTJ7Dn0mT5TyZkzHAXnwVYEBaSOrXdBCnUiXiYEpUc+r34Zh29Pyps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com; spf=pass smtp.mailfrom=kx.com; dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b=R4A6/Gmd; arc=fail smtp.client-ip=52.101.69.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b="R4A6/Gmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibul1rg1kO1lVIzRYSN0THLpAt/Bfm1o3SJIX+PamWKyBSEewzFgiHEd4v3kIy/+9u8QyRDn9mvkEPaUMtP/NFYuyQZoK713zkZQzt0V84ynRRzwVs6B0bAvyJWVUM7dPUkntHw8KnpfhCG6yWOqOCbj/FaVU3VZv8zi9N9RWkj5Qsgu3gBA0XyTIn2Qie5nwmojdiLMuiGvlyy+csQk8JJkjzVmATLuTzzlrCQYGEfBDouRxUfhKSphjsKLGAw/z2mCWWmwBchWuMXqQwGDYHs0DUZl8Be4GbZR2npD5tVoyowLw4+aXuskw65L2597co4Spz0zB/389LrlUrj/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQODe56bGrr0dgjj4jQ3XJLT0255GaFXZ/B/LPniOH8=;
 b=StLX0P1MDoztxMGxAOpoZxT7fIL0AvBzF0IOJvBoV748Tww1ioNr/JrKRLD+FY3dtFOl1sy2sOBYBWp3CgyPCGrdZ6mOv7cuGW5k181tHqVKq/A+kF2JfANtwAVnQuK5o3NUC3vCNgBh+bo2SdDRNzOxehqH+fQPs3ypl5Nkoi2x/M/3dJv2T9Btuy83Ef723KZNyLBiVaHfpC6aU2gDmvmuMeDKkebAVKzwxNmrXq1bjHuFn+8LHMQbr8yVZRAWvN4XmDll+0kIf6fNnesfOB0oGyV03lTbji78kS1NMDANxHAsPKd7Td334rNfdC1KeppYmXiyVud1WIZ+dfKr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kx.com; dmarc=pass action=none header.from=kx.com; dkim=pass
 header.d=kx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kx.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQODe56bGrr0dgjj4jQ3XJLT0255GaFXZ/B/LPniOH8=;
 b=R4A6/GmdllxTdKA606lXTusmo0ut1VkIeOlMACk9hEsNr5hjkThog+cjGOLhjWXDMaEHsNZ+iMRH5ixeKw3Z9q9Zm5j0rXUJLtmZlsYi2hhH8bG/wAOcYVzzk1soqsbUf9gaFcaT7JINofW1J3PeZDa4YcM+34Jjrv/RXrGnpgJbQcGkEf4Pl/LASLiljfMun6ygtrX95RLMrEDsYkbm3JiU4HBl6ZSgUB/fIC5Ol6utGOIBYrabuAPeDY/fZ/7ANH0tZO4uFbv5jCawyAuS8mkZCXYGAB4TWiGgYAMFSRkx6ZV5CCydV0hFppwc5KNzI/R2gm1ZfBmawc1EBMb2Vg==
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7)
 by VI0PR10MB8648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:17:34 +0000
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542]) by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:17:33 +0000
From: Domhnall McGuigan <dmcguigan@kx.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
CC: Liz Norris <enorris@kx.com>, Brendan McAllister <bmcallister@kx.com>,
	Pavlo Piatkovskyi <ppiatkovskyi@kx.com>, Pierre Kovalev <pierre@kx.com>, Oleg
 Finkelshteyn <oleg@kx.com>
Subject: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
Thread-Topic: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
Thread-Index: Ad1J453OFY2uoDx/ROiPZd0eA4o9DQ==
Date: Mon, 21 Sep 2026 16:17:33 +0000
Message-ID:
 <GV2PR10MB61387727F5B89B621AD8307BDF842@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kx.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6138:EE_|VI0PR10MB8648:EE_
x-ms-office365-filtering-correlation-id: 9dc6366b-c756-4536-b8c5-08df17fbd808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|10067099003|6133799003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 IEVdgV14NI+xcMkfBxZa45b1B51cT4PNgJB3723WJCKpOzGRnLycL2JOK58ByCDMqBsNXBxSyGYoQJOlq4oVuPi/nSRb7139Ecj2MgbFzeiW/4zvdhjDTwdHRFhh0jjGi7wFyDJOPeu7b1hESijMafsdpvJjNPDHhzntkc0zvE3JVs9ff/4QrOs37VvKbA7WRVltHKWWl6FPpiXY6s8E7xaLxow/GQ97hhgutgdLGIVmiLFExV/6hRWbkAVJdw+XXew4pW7Wy9CTzRzri6SWdtPzpuOUk5qH3Ykwd88DHmsPltT3Av9X5tU0Ero88MZcqEoS+cNlcgXhzEu/PkpPVlFlQKlZGox5ZdgMLv2+pShC7XbxaWa3M3WrMsH9O2eMi/V/k0cdT6e1QYNhSncoz833L67JtbtfLUTEHzqMhTCtZ3Qer+K3gvVpdlW3GUlsG4oYq8X3HN4LEAMoM+L7/DSf/0TvJVOhEt+Wrly87HhoxbRaz/7qPJ+o4kATplcPtQbdpJBy0gjpllYAx+aXGf0AAgHcsbOPsE0koSS1NsFUe3+CgXXURnFX1uX3w9paEx8FTQZ3MVJBXNVJ1AbRjHHvMC/XU8O1VnzF66yVMR9y5P3x2zeHIa3fzhd2HMWIZrq7DkzrJr/pcyg+I0+683wFWh1dLl4wy2TDRKs8zONXps4/XZ4SjF94Qs5R1r1v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pqT1FL85PGsyZQl1vb9VEJsRO4IZKHQx2DKUykM/sq9vrqjEv6BdirzziXxn?=
 =?us-ascii?Q?2XROCPpceOa9BD/kbQrGjtT670WVm3thZTiRCr5yGsmgMNmuT4LOmXEiCRvc?=
 =?us-ascii?Q?jOPv5OxA6c4n7TizyzswHPqWufrg19dCDDCe+FcUop7lXOU1gWXChIJNwBdq?=
 =?us-ascii?Q?jEFNBwiO3qXa1w1RG3aNyfcIOqfagxeTU863WrDQ35Buk8x/1xCwr/5w0VEj?=
 =?us-ascii?Q?rkoGNv2TyAAAEa7rV443IIcQZ4XioCy8TQNKQh827jJ20dtLjz0yJDhANTug?=
 =?us-ascii?Q?p38lRuTHRtKliKIlh6D+zYNHb7WQY/lvtHrrDJt/p5E1qxhrzciIzGwpiFyP?=
 =?us-ascii?Q?fGlrqerglgP3BeAaZqUt6UqA6n/RdDQUPby6sMA9Hub2Y3//NjSoUdVnCxiP?=
 =?us-ascii?Q?P8Rye5OhONNX4WqOpgUZ050Vjr+JgHSPY+iW7v79UCxzTSUMt1XddZ8pimc9?=
 =?us-ascii?Q?esOulUFOMfR2Jc6yTC+2v4x1wgHLU2+dG672rh1hHCidTbM9jGkHFuFPzuN2?=
 =?us-ascii?Q?vO3TMAh2tOFsX2WEUA9Y6jtjXpoRWrOS3a7Y3KC0QkPgC1hmP3Wfe8EmxZCU?=
 =?us-ascii?Q?jc8rdkaZ4flVMoysBE4yW7TR3rhQ1LjQLh4DC9ijVHRnJf3z6ye/F8iI5q6d?=
 =?us-ascii?Q?W5huYHt+0a3WRwfR/t9BL3gytc/wMTNDGBmx4uP8dOVBKw10qIdHIVXLGO9o?=
 =?us-ascii?Q?AAqbj5YD0QACPw+Qw2gZlqVvXy79HEEVwlxDSJfhCZ7HssQgG7AjG4mKjMLH?=
 =?us-ascii?Q?okXMMRJ+cSqWzPvFAC8wMwym5njUp1dZl/2S54qy7vB+4RAVujKy8e9CEXKH?=
 =?us-ascii?Q?0Q52JLhXZ++gTU9HSc6aeH6mFsDeH2lJ7O38wGEqdabSq5+GtijXSkRNPoNT?=
 =?us-ascii?Q?8sXuH2PlG2tuteBRsusUw2ixKpsVVQ5mtNm7xP4RaqY+vDR3k9E0aCfBLzWy?=
 =?us-ascii?Q?SGrSv9dzBAE3gMELf/685u0onQPgb/P7koC5LIP74OLqhlqarlMA2iwA6IKy?=
 =?us-ascii?Q?OcAe8FHDkvMa+HMLOsuGBCe3JfrZqDeIA26NyAwKOYewEE1+k8hiJPGl2/hv?=
 =?us-ascii?Q?p8FxWyEDw894h/wCEal8rp5jnYKLpAwQpvwYnJHhc7JelEUydvYWXbJsoF1l?=
 =?us-ascii?Q?It8UwKGFNsFRWHB3wh6cperdndKxkFrx1+F1QVyj6YbAt9gKDO6C0nzgTk6h?=
 =?us-ascii?Q?Z8XxKhR0XlNCEC97VYlNRZO7clBy5VgDUqdI1/7DSITLGieG0sap3eprC+6j?=
 =?us-ascii?Q?bCPEshWEWIbTHqRvoPfRpKgOwqW6t7ZaPMz48NtP51h4554I0zTh6Y9PNpHp?=
 =?us-ascii?Q?Y2UzhOL8uYGSYchGdcSeZGBF/aah8K4Qhq8fbNZnsq14qZUVal9y/vPaV4jj?=
 =?us-ascii?Q?eyV/MksE+Nq12M/L2LJNaXs5ArtQQVGic7q7mIpnsxXz50U2Wpq/bjJsulWP?=
 =?us-ascii?Q?xWChCpNJjpzE5ox61xgqahVIDVo9Kj0MhXc8MwEsukryz1J8Qn4BDN6ec/j8?=
 =?us-ascii?Q?aOi+QXtkzQIkEbPbFLgNd67DBjfrISDi3E3MpaFeR5XnXtUQMp7UOsMqDJBV?=
 =?us-ascii?Q?lM1YCSis2PpZA1DYgMImtHABlUMq1NI9orvNZdjSOC15l/VZ6zKp1uvxZQA3?=
 =?us-ascii?Q?3mojUCQOxEJC83Fw4RbP2PgM8Duc1QdIIBQmLp7or+LNKS7O5R+VUi01B5uF?=
 =?us-ascii?Q?kcC2Na9bBBPph9+5wRiBNRuw+J5YsJ3T1O+haUqWKvhQ26k6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc6366b-c756-4536-b8c5-08df17fbd808
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 16:17:33.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b006032-f7cd-404e-8f6f-4719f041417b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgzDvgGyfNCKAJamh0D71MR7t3p03RHmqb2DtXMa0bKJxQhIELOBJ2UW8phdvyn9lK1zsDgeb07dpnAR0wibCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8648

Hello, we've been observing a rare but persistent issue where a truncate-th=
en-write sequence to a file on cephfs (mounted with the kernel client) is l=
eading to half a megabyte of writes being lost, leaving an unallocated hole=
 in the file.

Our application uses ftruncate() to shrink a file to a non-aligned offset, =
then writes several hundred KB from that offset (without fsync). Occasional=
ly (around once a fortnight) that data gets lost: a BlueStore onode dump sh=
ows an unallocated hole starting at the truncation point and ending on a pa=
ge boundary. Later writes are stored normally. The client received no error=
s, and no other clients had the file open.

We've seen this on client kernels 6.12.79 and 6.12.83 (Amazon Linux 2023), =
and 6.12.0-233 (el10). Ceph version was 19.2.3, deployed via rook-ceph, mou=
nted via the kernel client with default ceph-csi options, with a single act=
ive MDS. We've seen this happen on multiple independent deployments but hav=
en't got a controlled reproduction yet.

For full details, including the onode dump, see the issue I've opened on th=
e tracker: https://tracker.ceph.com/issues/80704

Does this match any known issues, and are there any steps we should take at=
 the affected site to catch the next occurrence?

Regards, Domhnall McGuigan
***************************************************************************=
***************************************************************************=
*****************
This email, its contents and any files attached are a confidential communic=
ation and are intended only for the named addressees indicated in the messa=
ge. If you are not the named addressee or if you have received this email i=
n error, you may not, without the consent of KX, copy, use or rely on any i=
nformation or attachments in any way. Please notify the sender by return em=
ail and delete it from your email system.
Unless separately agreed, KX does not accept any responsibility for the acc=
uracy or completeness of the contents of this email or its attachments. Ple=
ase note that any views, opinion or advice contained in this communication =
are those of the sending individual and not those of KX and KX shall have n=
o liability whatsoever in relation to this communication (or its content) u=
nless separately agreed.
***************************************************************************=
***************************************************************************=
*****************
