Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BA3B7B93;
	Thu, 12 Mar 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303429; cv=fail; b=ASeHuroKr4QtpEfepQoEm0R8mdC0DNC/tJOLEum0fAhWPclawPWaO0a87sD/lXBJJYisLILu4IWCrQKf6HnIZ9MUUjbBjgshHMPuupsTyR4//PT5M1PmQoXC+ubAbsN8NPAiRkjskxCW3Ou8nneXv2SYcU1B6JPb5c9OotpmIko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303429; c=relaxed/simple;
	bh=QTMTsJqFPnhhbtzWDQwjjtAeLJRZV2x4J9JBjKtq5A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjZjP4BQUy5OP/E7sXAsUr7LQ2+uN3zmoY0b167VwgIIvHfG1HPlDkXxANnF5xdGNYX52zhnEPN+juSIG+C1oOenrpmHF0k/Dsi7Ad3pWktjR4ZJCoRcfRIu8oG2bCeqVPftj3fuO7+2oxWt4ywCxBCMTQXazxNDuaE39rgDITo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=kFycJ79l; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kFycJ79l"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C58umV1757210;
	Thu, 12 Mar 2026 01:17:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MULjjVSasZ4jlYHjr3zkmwYyqj1Hxm/izbSmYUhtfNA=; b=
	kFycJ79lslzKYL1nVOelJx5bh3qiLramoGAJhord7zkb0naUHNs7l8XIoYqLFLmo
	5F6v2GPLbmuj5npffvdyq+sFiwMIZSC7/eX8EC5YXLhF7gbfJsD+/f+IgluxwRIr
	4TyTTknaxRe5TB9KkmHAMxVBA3NQ8CPC0g1nR1bg3rqZswz9aEusjwVn366UXY1S
	yiW5UP5AWhQD/gh6MaDeW7fxf1WsJjcjLqYCTMLe8aEQbGz2Gg0RAi/nlxAoCrUv
	OHYbRuhjZnF3fU/XO1j1UXSoDDs7r1XE6CT1f4vjr+kWMkBxW+OyzHd0b3cFoGZe
	5rJMcCFoB4H12WjALzpWoQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6t8enf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkNQflsS7b5Mr27OriSmP9Ts0CmrIijqzPECbAVmFAn7YMnZiIblxRwA5m5+Nj2WrlCcN7hbipdXQr7oLyS47d/4tgXh5oC2fYnUOpYCi63GO5Jc/uoyLxK6vEOvGEJSXWid7PZBwZt5Lc/QUaseOWp6VXlr4xhQLZklP+cyCmPhSAfdRrjcQRPfLnCOmL98eL20S/LUPavlqZhlua+rsZDBGYJLrxYPz7xk/hQDOhBsqWrLc8YaxT2e+t1lNYtNJcrdgAjl3bupZVG4aJqyqQ6BVpPppk9TZM0cy10+N5ilgMUNzMi/keo8n0jMmlvjb5927zYYKtTfRXI0VjrLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MULjjVSasZ4jlYHjr3zkmwYyqj1Hxm/izbSmYUhtfNA=;
 b=cwRUYLSs/QYGPMm7FhPGGAhUNlTep11ffyyfwZxOPlyKEwAaaqWVr4rYqyd1Fil+mibc6j9tHLXhHR463HZFgNb30bNLNhD45Tyaa56/n0DepNzurBgetyra7teCI/3r+LmvDBpYCCUDdYDHXRFmFdU79FMUVY1o3yXY1WQQjjP6a1kfY7Jn/hxsrW2C4yh2zgtA9iYW5iq/gwsZg5c5jmWqrkpnURnL9Ka2ar1zVR3E+mmBu8yrVPLxSFvQZ4uoehaEosPFzg9SIcM5LKK89gMy74EdeIqWW1JIOjtMyzUGxsINtFMjQI9sHWmdI5X+6x+fuErQwRhYbR0WWeUkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 08:17:00 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:17:00 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 11/13] libceph: reset source address on persistent EADDRNOTAVAIL
Date: Thu, 12 Mar 2026 10:16:17 +0200
Message-ID: <20260312081619.40854-12-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081619.40854-1-ionut.nechita@windriver.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: ab623bf7-95a1-4dd8-64ce-08de800fbc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|10070799003|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J00273C3a9FSsCliUFjfjXx2kb8++eDi+ZQZqe4x//U+3XP1J88CMKpCWfcGxPIOCH3cLaXc4gH3I7B/b2v2mYNWb6GNylb+Y3w6y5CdRUjV76iajxPJvBtfFp1Bwft91a/+lGTDmhEJIrJsj7zjfkGwSVmPXBEf6CgLZrOQEZiNqDPiGY8tj9mlOiWEcJgtdbCJgf45aqA6LhJaFJQyVnOCfLFlVlIOI0VgK7rXKurU4j5HJC0mlobQDSvgzTNMrmW5TU+Y1XLNKo7KeKgJOf6WqOkDDWyxovZuR7ScwZJ+laqCCBN/TFYjCjpD6D2jgSqqEN5esRCVUwNC0QYVM7H+YOkMateX4bq4QVoGNnTCffgUxxyZt4Z7azgXhSfmjOEj13cIfMVAou4gzbX6CqkD8HZAqe2L+ctp5NxcweyhP/0UpA6fqIk+vFZwcj1eD3QCTWDxfjn2xceDTLuE5g34AlAPybGNPW6Vcs02PocFjc5N3K5phLXdZVcMRrUFB680EPIetdaK0j4ImCdatrO1pMggdwE92GnyPwudR1oYizz8W/VclDKvtJwLszBr5lYz0/NV2B+DbetR7nyI2dRm1dqhFHWLnmUaw1//cysNXKH0OsrfGCpI3yT9GBkh3oN5KgEHmtOuyiSCO2yCFUZAPCu3Z7YJcucStyy3IOtW3kKRZNWEBA1hKDVssFv+pS1ffU9/e/HOxvapOj2lkWMlijC4XxZrSxTE8EVjJm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(10070799003)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ACg+gj+DG4KyMjhjABhD8o6aws5/6dl17KVQGPxJ5BXnLuv1GuVzeVQP/3Sw?=
 =?us-ascii?Q?pjQdKJnRra3SMTuG6TpWKtZmUQ+pWmV8HCJMV43av+LrA5732VwNZO79uDPb?=
 =?us-ascii?Q?QElmt7iglplV6cmtX/Sp8nYhW00tEMDSERC+8uZeNE73HBqCJaruNicbcAb5?=
 =?us-ascii?Q?nSA5FVVmRa1DD0eU6GhbCI0LaC02vCxNJUIYwBswkQJ5C9Zgk74gTLHcoPnL?=
 =?us-ascii?Q?Vr5llM/Lp/a2NCScgqAUVnAL8bN071YVIqAFDGVRCU0KoQkQZIatLrAtIAen?=
 =?us-ascii?Q?Qn4xaIIoqpg76WDkmnCie2KsnP8MLxTHgxiSrLASjX4sOOBhGlKrg4pT3+Xk?=
 =?us-ascii?Q?OiFYYWZxCDL4zsDRhAUqasZha7O4Qxl1GeD95IBDrSL83oOohFBERcSrqCQm?=
 =?us-ascii?Q?XxaxsconvBI5Q8nF4LdnWyIzV6eekGJpPH62jFPhEWfovUIeIgyMrkm4FIkc?=
 =?us-ascii?Q?iAOLj7t5mGKxO9kVc67BMhKx0ya8C9V2lRcTx3knzwizvpuMgevUFLFlk64I?=
 =?us-ascii?Q?mGD2/eP66+53kZgF+6QfTiFlnmq145cKhl82yHUByjT3ggrEHZF8dcQqEprq?=
 =?us-ascii?Q?iObgEpPDmGZ354l6MSIZ5HU2C62VZWcFbFXQeKmAznE4p0eJ4+DdHOkQkCMv?=
 =?us-ascii?Q?/DqfD0mpuU471vkKVuQoNmn4oSL0/MHgbXPk907kN8DePq8Kx0Yo8WPDjSs7?=
 =?us-ascii?Q?SrHrZCtpAxxT6P/MMLDTpGnuxSD93RDaiDQpaJNZEyxQtFmUZq/ulTurKj5s?=
 =?us-ascii?Q?AwkaHYOiDsy8g6gzTUHJgZG21+vmoJxTWmJtOmDXz+fTt7iyk4sXWoFqZlkV?=
 =?us-ascii?Q?kTH/MImgTuiotcZATjQIeKKrC07w4W1hFoUBQVObhFHsWQcmD33J3s7LH8ay?=
 =?us-ascii?Q?i2W0SmIHugCUpDfr5Yb7Cx/AraWRTcKWKDKkXLtNT5CQbfNE8SGn61CKm2NA?=
 =?us-ascii?Q?DL8xpMpQpVeDGDWt06qhszlWYKNLhIfcJlidesqG/yn4GlSMePsysxxJ+A32?=
 =?us-ascii?Q?9cqxezImCpXsaTYzibTUK2jHLv4goBPH5cmxhtghDzLUUYLnYWoAMhFgSUHg?=
 =?us-ascii?Q?Grgv2nQl2ZhBOryzVwuexppItX6fo/6HIJgHKRNza3VpQjrvD3xcGeXqDxdn?=
 =?us-ascii?Q?HLxkCfr4GZnj69OrS+J9mRTIAW5ymZvgyRsnI7OnL0NXUxBR452HOvWc1fkX?=
 =?us-ascii?Q?Dga1QQsM0jJVd7VrY7jB9qKRjKxHy2n8HYVYKHUf5UlAvI+9/h9nN2eXyaTU?=
 =?us-ascii?Q?87VYKUxK5g/mRz6GBKMFMBI9rsFE8ilJRVUGPoMklGJl4vS8bEUl8d5ZEXhP?=
 =?us-ascii?Q?PW+3sDhOTl12Xy9KW3OED/lfSNcWtIkg522LptOftou2hd1cbjgWB886CS1v?=
 =?us-ascii?Q?2fiWjo4wsJGqg2LxzhjAFY0x2jP9E0HIsplrtFXGsD/t4+n0saCdPAy2VXaO?=
 =?us-ascii?Q?31nwzOPkZ1p2pgn+0qCinr+hJ/yGawl/HChlG4TUH4ES/F4zXVgmsI7D+ofI?=
 =?us-ascii?Q?qhQlJSl9F9d1tbBknrdm+i3gL0pxpZ5VbtRupz4zIa1buC+tKWPBUA7Wj7MS?=
 =?us-ascii?Q?elSzK0dTlHQmvfPjdUbvsiwotZHOp9YLY0cS+qkTJ6bE1amWNpPLm96gUKI7?=
 =?us-ascii?Q?qjRmXoImnsDvtISl3YqegrJeQa+mItuyjyXNTNlQiy915FDF4W6W+BidU0ql?=
 =?us-ascii?Q?de7XBOLLKnuyPb+keTkBFRzGJvnAcHUtbetiFCBuKrNDyVHmIs+BzpE3GIq5?=
 =?us-ascii?Q?syred2H5D+gOmTgIHoMpLAHOS3UEdyoNSjs5sBXv9mUrtWJOgnU69lFPOIKJ?=
X-MS-Exchange-AntiSpam-MessageData-1: OKh42+x12j7m9aurblne/UEK71JnMbklwdA=
X-Exchange-RoutingPolicyChecked:
	uix5AwDvWiP1IKKOH5d7EmuAEetgms4e8QKaPHuoR0xWvIYNZstd0niMDvc5cdaDCBLYRQPFkh2hS6SJhrokTUMEDGgipy5qhL4APLjoFug3UC+FWigXAIRTbUjvVIh7wGsmbs6yJwFqaKV53FWPHbQTlZtlhQqk+6Jbo40lTrmZtb3mMxig7t1kTjm+Z49Z4E/WZX6DlU20jogI9gWqKlr7SCAlTEjUzVPhQsrG0uQfvE+XSQxRovbgW7bSisr/oeXtogCYunMQr9HqWBnGMfzBshg9iJ6mLPkU956/uS7ro3rZjQlJFdjbbaRJmmHYdNfbX6ABehP1FIaN4MfuoA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab623bf7-95a1-4dd8-64ce-08de800fbc16
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:17:00.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taGq56niwXRVctXExtsWM5xS9NvdRXCSQnaj7XbJdy7LAhaVVZy9dVdsYvC36ulZuAxKVF/2IH9q5XHJa6xgVieKKQ8mH5YvZ2gfaOeAw/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-Proofpoint-GUID: 7M-VP9_ijJTetRnKUQ9uP-IDkYVW0kl_
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69b27680 cx=c_pps
 a=KNS8ES/6Vao0xGfhhZwSfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=EdDtN2VJIkaq4EvSNGIA:9 a=LONr8ofnQXjLKK9x:21 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7M-VP9_ijJTetRnKUQ9uP-IDkYVW0kl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfXyIliYIrfP5ct
 Zrrt4cuyQcQVxCq0V5djkHOj+aqJyuIizRccp5bKFeNX36V8Lxn8Q2XMlgSppVNvUg20wQN9YLk
 8i9u5F29taT+f+YoYdCQnPI6h0/GJA8KJn302otyUkfBqsXxIGOJE21/zD1aHi3J0uJ1OIJVapv
 R6jfxu4jKvo7VpQyfBEDOGYRjfFEKozXKlUx9is/a1Z5SOyahMuMP5iSdUdl86MqtT/ogM2YR1l
 kAKNS2BlzBcDhDlOP78v1HZOBRVZ0/1SUv6wK9ZA5OeGvcov9NsnxIFoAmu1pVc6E+U6Zh8A1WD
 WR4jgAbI1ymfUOXLzUXRKLhYHEu8fSzjS5fWj7ft244pamASEIYahehXkqx7Q4BOeMp1EY9NicH
 AjwXCNm1gP6Cj8MGP//BXZ/nlTedkA0gYVAEDnsEZgzOTeosm6GS0sMzzMVyu1CTFynZhe1PZ6U
 0jolErnidQFLakPKbsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

In containerized environments (e.g., Rook-Ceph with
Calico CNI), the kernel CephFS client's source address
(msgr->inst.addr) is learned from the first successful monitor
connection via process_hello(). If the initial connection was made
through a transient CNI pod address (e.g., a Calico-assigned
dead:beef::... address from a CSI plugin pod), that address is
stored permanently in inst.addr.

When the pod is later rescheduled or the CNI reconfigures networking,
the original pod address is removed and Calico installs a blackhole
route for the old address range. All subsequent kernel socket
connections fail with EADDRNOTAVAIL at ip6_dst_lookup_flow() before
even sending a TCP SYN, because the IPv6 source address selection
finds the blackhole route for the old address range.

This creates a permanent deadlock:
- All connections (mon, mds, osd) fail with EADDRNOTAVAIL
- The client cannot reach any monitor to re-learn its address
- inst.addr is never blank again (set once, never cleared)
- The only recovery is force-unmounting and remounting

Fix this by tracking consecutive EADDRNOTAVAIL failures across all
connections using an atomic counter in struct ceph_messenger. After
ADDRNOTAVAIL_RESET_THRESHOLD (30) consecutive failures (~3 seconds
at 100ms retry interval), reset inst.addr.in_addr to zero (blank)
while preserving the nonce and type. This allows process_hello()
(msgr2) or process_banner() (msgr1) to re-learn the source address
from the next successful monitor connection, which will use the
current stable host address instead of the defunct pod address.

The counter is reset to zero when:
- A TCP connection succeeds (in ceph_tcp_connect)
- The address is successfully re-learned (in process_hello/
  process_banner)

Observed in production (kernel 6.12.0-1-rt-amd64, Ceph Reef
18.2.2->18.2.5 upgrade, IPv6-only cluster):
  - Client instance: client.55136 [dead:beef::a2bf:c94c:345d:bc66]:0
  - Address dead:beef::a2bf:c94c:345d:bc66 was a Calico pod address
  - After pod reschedule: blackhole dead:beef::a2bf:c94c:345d:bc40/122
  - All connections stuck in EADDRNOTAVAIL loop for 16+ hours
  - After force-unmount + remount: new client got stable host address
    [aefd::2b93:d245:fd09:127e]:0 and worked immediately

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/linux/ceph/messenger.h | 20 +++++++++++++
 net/ceph/messenger.c           | 51 ++++++++++++++++++++++++++++++++++
 net/ceph/messenger_v1.c        |  7 +++++
 net/ceph/messenger_v2.c        | 12 ++++++++
 4 files changed, 90 insertions(+)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 730a754353aed..d8f7946d85a68 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -113,6 +113,17 @@ struct ceph_messenger {
 	 */
 	u32 global_seq;
 	spinlock_t global_seq_lock;
+
+	/*
+	 * Track consecutive EADDRNOTAVAIL failures across all
+	 * connections. When this exceeds a threshold, the client's
+	 * inst.addr is reset to blank so that process_hello() will
+	 * re-learn the source address from the next successful
+	 * monitor connection. This handles the case where the
+	 * original source address was a transient CNI pod address
+	 * that no longer exists.
+	 */
+	atomic_t addr_notavail_count;
 };
 
 enum ceph_msg_data_type {
@@ -328,6 +339,15 @@ struct ceph_msg {
  */
 #define ADDRNOTAVAIL_DELAY	(HZ / 10)
 
+/*
+ * Number of consecutive EADDRNOTAVAIL failures (across all connections)
+ * before resetting the messenger's source address. At ~100ms per retry,
+ * 30 failures means ~3 seconds of persistent EADDRNOTAVAIL before we
+ * conclude the source address is permanently gone (e.g., a CNI pod
+ * address that was removed) and needs to be re-learned.
+ */
+#define ADDRNOTAVAIL_RESET_THRESHOLD	30
+
 struct ceph_connection_v1_info {
 	struct kvec out_kvec[8],         /* sending header/footer data */
 		*out_kvec_cur;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c40c7c332e7f4..8165e6a8fe092 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -497,6 +497,10 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	else
 		con->v1.addr_notavail = false;
 
+	/* Reset the persistent EADDRNOTAVAIL counter on success */
+	if (atomic_read(&con->msgr->addr_notavail_count) > 0)
+		atomic_set(&con->msgr->addr_notavail_count, 0);
+
 	return 0;
 }
 
@@ -1663,6 +1667,52 @@ static void con_fault(struct ceph_connection *con)
 		}
 	}
 
+	/*
+	 * Track persistent EADDRNOTAVAIL across all connections.
+	 * If the source address stored in msgr->inst.addr is no longer
+	 * valid (e.g., it was a transient CNI pod address that has been
+	 * removed), all connections will fail with EADDRNOTAVAIL at
+	 * ip6_dst_lookup_flow() before even sending a SYN.
+	 *
+	 * After ADDRNOTAVAIL_RESET_THRESHOLD consecutive failures,
+	 * reset inst.addr to blank so that process_hello() will
+	 * re-learn the source address from the next successful
+	 * monitor connection. The nonce is preserved.
+	 */
+	if (addr_issue) {
+		int count = atomic_inc_return(&con->msgr->addr_notavail_count);
+
+		if (count == ADDRNOTAVAIL_RESET_THRESHOLD) {
+			struct ceph_entity_addr *my_addr =
+				&con->msgr->inst.addr;
+
+			pr_warn("libceph: %d consecutive EADDRNOTAVAIL errors, resetting source address %s (will re-learn from monitor)\n",
+				count, ceph_pr_addr(my_addr));
+
+			/*
+			 * Zero out the address portion of in_addr but
+			 * preserve ss_family, nonce, and type so the
+			 * client identity is maintained and debug output
+			 * remains readable. process_hello() checks
+			 * ceph_addr_is_blank() and will fill in the new
+			 * address from the monitor's addr_for_me response.
+			 *
+			 * We preserve ss_family so that ceph_pr_addr()
+			 * shows e.g. "[::]:0" instead of
+			 * "(unknown sockaddr family 0)".
+			 */
+			{
+				sa_family_t family =
+					get_unaligned(&my_addr->in_addr.ss_family);
+				memset(&my_addr->in_addr, 0,
+				       sizeof(my_addr->in_addr));
+				put_unaligned(family,
+					      &my_addr->in_addr.ss_family);
+			}
+			ceph_encode_my_addr(con->msgr);
+		}
+	}
+
 	WARN_ON(con->state == CEPH_CON_S_STANDBY ||
 		con->state == CEPH_CON_S_CLOSED);
 
@@ -1740,6 +1790,7 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 	ceph_encode_my_addr(msgr);
 
 	atomic_set(&msgr->stopping, 0);
+	atomic_set(&msgr->addr_notavail_count, 0);
 	write_pnet(&msgr->net, get_net(current->nsproxy->net_ns));
 
 	dout("%s %p\n", __func__, msgr);
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 0cb61c76b9b87..4f3868f296c06 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -736,6 +736,13 @@ static int process_banner(struct ceph_connection *con)
 		ceph_encode_my_addr(con->msgr);
 		dout("process_banner learned my addr is %s\n",
 		     ceph_pr_addr(my_addr));
+
+		if (atomic_read(&con->msgr->addr_notavail_count) > 0) {
+			pr_info("libceph: re-learned source address %s from peer %s\n",
+				ceph_pr_addr(my_addr),
+				ceph_pr_addr(&con->peer_addr));
+			atomic_set(&con->msgr->addr_notavail_count, 0);
+		}
 	}
 
 	return 0;
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index bd608ffa06279..12ad9f571dcca 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2260,6 +2260,18 @@ static int process_hello(struct ceph_connection *con, void *p, void *end)
 		dout("%s con %p set my addr %s, as seen by peer %s\n",
 		     __func__, con, ceph_pr_addr(my_addr),
 		     ceph_pr_addr(&con->peer_addr));
+
+		/*
+		 * If we re-learned the address after a reset due to
+		 * persistent EADDRNOTAVAIL, log it and clear the
+		 * failure counter.
+		 */
+		if (atomic_read(&con->msgr->addr_notavail_count) > 0) {
+			pr_info("libceph: re-learned source address %s from monitor %s\n",
+				ceph_pr_addr(my_addr),
+				ceph_pr_addr(&con->peer_addr));
+			atomic_set(&con->msgr->addr_notavail_count, 0);
+		}
 	} else {
 		dout("%s con %p my addr already set %s\n",
 		     __func__, con, ceph_pr_addr(my_addr));
-- 
2.53.0

