Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE830E835;
	Thu, 12 Mar 2026 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303428; cv=fail; b=qJtsoUT6sCKCO8wfnmxvMCCzE5nHz0howuxdIwh5NeHHyBO8XiJVeAv9I3/vO0+aCcOJ2FxXcqGxe1y64xWGb0nkUqwuiGwFGKtzDiXV5xIQg8oa4YY4CimlqmIX49V8ApR1blpgQaK5dVJmnGh9kd0+A+i+/FYJWiMyS7ViPK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303428; c=relaxed/simple;
	bh=UUEvl0jKOIix0RTUgq+jGBhF9XV4FAB4zSFl/7FVSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BmVd1Vm+WXbWik8RUedsTODhzgUGAIuTVWQo6soZYkak1TU15UQMknQoTuwhRPeDrRjIorJ1R58Jn4XyxkpMS6M4V68uIPu+CBLydBJf0+EnhERtmPtmNeNRrV4IOtz05YdMpHCxLrFChy4l35K1embNzxkItbY8DmEspfEt1mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=C+K971LR; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="C+K971LR"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C6koDW1844649;
	Thu, 12 Mar 2026 01:16:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=mXZhuy0BYt8HK3eY32NhJLwcs9CcSYnGuAZm7jxEZy8=; b=
	C+K971LRgP+6BkRrKv3ZC126Le78WMsapmX5yoZ0gSEmjgIJT1XxsObHJXJRv2Uo
	+skkstZPfoMGV6756c6fBA8fozpTppXBhKHFgsrF2vQQx/zG5Xre0K7pZr5tDd9q
	2pYnGFE8RZIQUcPMi/kmZHVhPz1wufVpVg5sbxaqaLIB/mapQsxJj61XKIHCKaHR
	j37KptQ+fzvvlypUEq1x2j+xeHT6n4rCg5jCXroNzn7brYs8EPd4DXpCP/BWOCMq
	agiukX+/Hf5a7MNrdNPUloiT9WzgTVNj7uMzfoB8mzCJOPFCMoLrhdR+ttqMKYGp
	h/oVNHewL+7PJLUFbLvxpw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6pren5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYeC+bumUaX734uqjzn0uRQHupnAFAlDaQpW8toWbqk6ca//prOTZpzDMzmt/XEUJXKffovbj3B/zPqXncya+YxcezImD03TydESuk1rBwQC5LRJekhyyW6YAs4Z6v+MbHvX0UrB0OPk8Gu+se14md1XSedWG0booaODAQDAK+1DbwnZl51w6bln0Km5xczbvSByezwup26FGhMpJ8nWOBjUWp2Wz9urDConYYvpQzDfQgcmltAC6JZUII9Wy5PP/mQxuhT1KEdI1JyCt9nktBRiAoPYv9Jz9yZMg6qhVttzaPwLtm3bWYDs3YjmKM1ravs2MxLQGZhattixZjW0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXZhuy0BYt8HK3eY32NhJLwcs9CcSYnGuAZm7jxEZy8=;
 b=OvLVggo5otpb6UfEU7Hd7a3fzHHEJMBr6cpPhiDQXbOPEIc6hzf7QHRpglMz8RZkKF3V/+N2TK5a9r/A/0Nl0Xv84bfzmyF+DDA/4N7trqMp1h9DYqLatruksGhie2OwhbXWTgsrZfdyZ3QEfA3Jb4INf5vayUJmDV2RaihJ6zYjBzzHspk8IzMcNak3Tm8LpgFJ0sfL4ag2EqdxdzjujfGqtrB6GDVbWmIraUvkT0Sh8U4u1Zz7WKoK006PK9wQ4IxvrkLYR/kyogPZZl80JSHGqbpIpj47lVBSrWJHPBqa7qR+Tzlo42/RpjUYHhTClgte2fEXak/1dlfZbj+WtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:56 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:56 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 09/13] ceph: make remaining I/O lock functions killable
Date: Thu, 12 Mar 2026 10:16:15 +0200
Message-ID: <20260312081619.40854-10-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 2023103a-cc60-41f8-be41-08de800fb991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vGY3OlV73vGWq6w4yZiQxlwMOlrpykUUXVABWJCSZ0Tx3B1Ck4ecYI3Ojrq3I6MCGfDLT4xs+m9wwxEJzvpZ91M+xUiWOHwdcQwGu3n48KgopjDgS0vHMNg0p4EsYS4/FhoqWRQuYLlM1PgA6VX8swKj7yU7zZ8lWAS/vQhim5qczqRXr8xDhdXsU696wonZXdvHnU0Wn2JQBmmACom6LJD8vaTeGyLA+gVbxQmnlukNnwM8KqdYbfTMU0SSuwbqAz7Yq9kJpysm9gVUo/8Njsrbt5haN45EnytMi6DHxomP9xPv5r8DA8fp7XX23xob+pdSrdZ7nolRHj1qDR0XzgpicIJr3MjlDvtLKqvLbFw2i4Gqydw+UvR1sW6pHv6Ft0ls17pitohoJkkhLWzWX173VDkhMYwP6T+BkPptQYnLU9ajujhaZpnAjLcApm7OSYJjaBRYlc3W0cgOhY1TwtLnpak7deeyaH9+20ciMFm1Sq8PnicVMuvbC6bT2bpqALWXZ4v0b0eebvyveZyV9XYPzgUvAuk/uZnLNv5mQHtIX7z8a2QhG9XcuQYFtQUdI0A+2CvJJOkSvdCU9f24EXEw15OwVYr92NgzT6btvZcyp5dCje1ON1YhwmA7OQFiWmktwEjUQq3A12yk4e+wn5vuDnGM1RoQzbNK2MGJ2C06CYfFo4TnSiQV1mieuBosZKESL61e2K/uYUXPK2qMTQ0D2w21Q6bXODPp4syJ/NQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Id5k8cyvHIzaX221q3vUs7MXUnjVOzRtyyqgfrq2OVXzfPWDi1e17FH+BKwj?=
 =?us-ascii?Q?XYS3K4oCRgGeXnflPfa5Cpya4Kzptem2EJtOjuPIjNa3e73/19ur3a38cHhK?=
 =?us-ascii?Q?BCp3ltqr4Y7bCgKE4bUvklHNrBBgR+GWEM7xM9Z/BFqKSM+E3HPwkZtxFirQ?=
 =?us-ascii?Q?9r3uKe5LLVTZAqyedAdsPKiu5lSGvwGXSA4u07BwcxD8iiKG0XlKrXU6iAQo?=
 =?us-ascii?Q?uv2Tpi4NokaTQwXhJt3HvDCJeraKaOqAJjhPuNkKDz/YjQ9Pc+LC79ZP2zhh?=
 =?us-ascii?Q?S0gsONmwwih88qfz8JFFMbIKN2pDDoGFFMBWR3GT+WbVxxT9tDkjFIKIYGW7?=
 =?us-ascii?Q?5svRyD6GQCXsRo7ffMMN3z/Me7X9xf+QkG+MAvlhvxpVRcCZv6Y/Y+VYNE8g?=
 =?us-ascii?Q?OVDHxkm7KyV8osX1NJk8j3cgHUagzF3x3DORqLMUpEjBnu3phUlHHEysw029?=
 =?us-ascii?Q?fSibu7kLcAmcGhSI3A2CyUnN2sZscW4M8bfi0yxi+tMN+B3gphDtTcYfjVS0?=
 =?us-ascii?Q?Cq2/lvGXtCQmChHBDrQNL8DV9BnCis9Ql9QqZBm6Q9P0ng7DdsP3X1kXilXo?=
 =?us-ascii?Q?5bej9AhfGXzNJ1zscxUMnk4szBquPnCbtuM2vlAE9meeQ1dj73it8nOUTQoG?=
 =?us-ascii?Q?ZxsgeWJy5aFSIy6RldHMsLcvfqUvNwmPoy2L8V8TFZDaqTtbgUGQt909VnUH?=
 =?us-ascii?Q?G6pUEKbWLALQtBQSt8tzguOxoV9ascLV8baCD46PiiNMWA1PsDurp/NBvb5p?=
 =?us-ascii?Q?6umMSc7qP2LmCeisDZz62Bqbjb8AJqtSs9gZIJaOLBd34KZgouu2wPDLHduB?=
 =?us-ascii?Q?2WslQLyLUVVok1Utlcn3ZDqnae2fFRA2MfQt6bbnSAT2lovKt6ro5j2i/aQL?=
 =?us-ascii?Q?3I0fLlWhOJFql7Lc1Ug8FLmBURGSWVlZZhtLLc+FurrEWNTyvi8cRfa+dsWg?=
 =?us-ascii?Q?Bsf3lZt3J69CsNeNqaPFprISqRT5ELsmHHscZVyF0AwGMjaIrFYuCHRW81n5?=
 =?us-ascii?Q?iJYPvJ0ySDjOTwwo86LecBDHusTEUzos93glBnyCoQCZMoa5v8tI3H5HPB0g?=
 =?us-ascii?Q?4QR9fkMz5cDvnT3bor6oxZpbjCu1E67XjJR1zumSiK9VQDzZG4iXzKAbOQM6?=
 =?us-ascii?Q?A/Uoo1brjgUVdncB4tHEbLxK9hwsn2XDYtRNmUHvaOmMI9Uddc3BPfGvHzzZ?=
 =?us-ascii?Q?cyfj1zw9ftuOq9pJytPSyQHwPFtRoseiZWCCRtoLRlduUM3b+x9eabgolqdw?=
 =?us-ascii?Q?LQ8D8ZuoMOITZkdBkaCMQm24xe/WLMJMvc3nSUL7f9a9NncZJ1RFOSyPC5zG?=
 =?us-ascii?Q?IyJ8O8TA15aqMg+Ll8t/JjMGh+s6YRfGZij+sfAeMKjeYW/UCs1nojFAP1kg?=
 =?us-ascii?Q?q5bO8PO+wiSNSIW2xo2n1698D2N6ukFnMelPZa2n0amdPRI0/vtEzJqObkeU?=
 =?us-ascii?Q?3A/Av533TIlYNp/HrXoH8tYoiA8cPPFhv4e/AwgAR2ShGo2QhDalkG061KfS?=
 =?us-ascii?Q?hYuNT8y6Me84AszoSmEUkGIICEfNtHJ+8ZViw/pjp+QoPh15UIgzTOHNToxp?=
 =?us-ascii?Q?5ggOGT3jYaOMozDQiMdBSR9YOXWDID2rKA3tkGO7VBb8Xcx17AwSc3+ArJbc?=
 =?us-ascii?Q?9yogJuTcaHzxVNc5xijzyOmGW7Lc2VaQKV9HV/rzSKgHnrxQHdTXsCxhkCw4?=
 =?us-ascii?Q?7TfLme7y2+PIcnATfGaXAiZrKGHje13wGv3xi3JUX3ClVNhM4efZ7L3Iqvn/?=
 =?us-ascii?Q?DUpcrYQmMGS1hnTCaVq5gB0r5wZY9VWaDVMaGkpH+2F2M3Lg+PXfyUXrpSxp?=
X-MS-Exchange-AntiSpam-MessageData-1: 7kPc3Gz++7CcT8huR1gjxdlISTdk96u1h7Q=
X-Exchange-RoutingPolicyChecked:
	QFng6/sNlp8HsLIm2cmBnxN1t/sQCBYRTqwHdvnwX2CuYKp0Zggb+/BY1rRqt2DrYrcA4QGGvgv/5xfz8MiRWOrGa+nQ6DcK9YN2nSp4+XRVUSFo7knaaSB61tG51EbITd598A8//yMj1QJ/MD55rfOqHZeH/mKEZ0SyXsJUSyNaufUjJrWpKof2VaOQSZe0mW9I0qTbyDpFDHwZBKOhh4HRa/hxFNAAw7J/9buVh5I61qaMOyVvPMW1PH7qgoWEEmlNuc+Jvrv4JIRSqSYYJVIo5eNlXXxsXN6+5cmL3L8r1CcE8WDm32+4P6KXtMfvXie4QDkCl3A4hgQpfUTJSg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2023103a-cc60-41f8-be41-08de800fb991
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:56.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL9/axBafLvIwEX3DYbSRSt1migfuVqhOxmo1JR2jv9ljG406gJB6gK2GAFdtPrsGpAzjJN0J0rGvhGcvCGRKDrmX836Yi8IUVn7m3tR5Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ePAeTXp1 c=1 sm=1 tr=0 ts=69b2767a cx=c_pps
 a=w9jTARCbdo3hRO6w7Rsibg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=lyTWyWsNyHauK_dbpokA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: H_VhTBafzkqZvb9n2g1-eL3mGZ2lZRaB
X-Proofpoint-GUID: H_VhTBafzkqZvb9n2g1-eL3mGZ2lZRaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX3gO+ifuUjDNl
 osQxjrr+UsLzHdqSoJvsks10R281I06fv3YXLAM0YBmJu1tfjkajM5ShOGVrJhDykFSOFhoGrT1
 gsuc9ZoyOFEXf1OxvcTNohAU2Vq/Zqp1CnsHnBJuZOVOGB0nqVd2WxgmiOVrn0IBo0+SiZzhmMZ
 RyUawSuzFppei9QXvcCXbQG6e6hBVh+lrojadp9KNvVzrexUISDWm9fqAy39X5d3AwDToJXx0Y/
 EFaSsDJ0SPHP6xIHsdd7N5nAObhJWcue6Qzyu6FgmErNROZqe3ekAZ2H97t5qknhEetF+R3jl2s
 FQXr79rTtj3a/bTibfzThQCZnt+ZFFDAg1GEJzqOaMDO3qRnLRs5LypwGcEhK7gEmmyNaYmJW9K
 D0B0bNxrGZIK8Iuhq5N4BKKghu1ULEckfmZ09C0E4OKdl6FQNKpsLRAOp47nm47GKSwl4I2ZR8S
 njp2LnmB3Ha8AJNBlZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

Following the same pattern as ceph_start_io_write(), make
ceph_start_io_read() and ceph_start_io_direct() killable to
prevent indefinite hangs when waiting for i_rwsem during
MDS/OSD unavailability.

This completes the killable lock conversion for all ceph I/O
start functions, allowing blocked processes to be terminated
with SIGKILL instead of hanging indefinitely.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/file.c | 27 +++++++++++++++++++--------
 fs/ceph/io.c   | 28 ++++++++++++++++++++--------
 fs/ceph/io.h   |  4 ++--
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 01e4f31b1f2f3..c828552d51920 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2122,10 +2122,15 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	if (direct_lock)
-		ceph_start_io_direct(inode);
-	else
-		ceph_start_io_read(inode);
+	if (direct_lock) {
+		ret = ceph_start_io_direct(inode);
+		if (ret)
+			return ret;
+	} else {
+		ret = ceph_start_io_read(inode);
+		if (ret)
+			return ret;
+	}
 
 	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
 		want |= CEPH_CAP_FILE_CACHE;
@@ -2278,7 +2283,9 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 	    (fi->flags & CEPH_F_SYNC))
 		return copy_splice_read(in, ppos, pipe, len, flags);
 
-	ceph_start_io_read(inode);
+	ret = ceph_start_io_read(inode);
+	if (ret)
+		return ret;
 
 	want = CEPH_CAP_FILE_CACHE;
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
@@ -2357,9 +2364,13 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		direct_lock = true;
 
 retry_snap:
-	if (direct_lock)
-		ceph_start_io_direct(inode);
-	else {
+	if (direct_lock) {
+		err = ceph_start_io_direct(inode);
+		if (err) {
+			ceph_free_cap_flush(prealloc_cf);
+			return err;
+		}
+	} else {
 		err = ceph_start_io_write(inode);
 		if (err) {
 			ceph_free_cap_flush(prealloc_cf);
diff --git a/fs/ceph/io.c b/fs/ceph/io.c
index f9ac89ec1d6a1..7bd57de2d9681 100644
--- a/fs/ceph/io.c
+++ b/fs/ceph/io.c
@@ -47,20 +47,26 @@ static void ceph_block_o_direct(struct ceph_inode_info *ci, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
  */
-void
+int
 ceph_start_io_read(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret;
 
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	ret = down_read_killable(&inode->i_rwsem);
+	if (ret)
+		return ret;
 	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT))
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	ret = down_write_killable(&inode->i_rwsem);
+	if (ret)
+		return ret;
 	ceph_block_o_direct(ci, inode);
 	downgrade_write(&inode->i_rwsem);
+	return 0;
 }
 
 /**
@@ -138,20 +144,26 @@ static void ceph_block_buffered(struct ceph_inode_info *ci, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
  */
-void
+int
 ceph_start_io_direct(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret;
 
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	ret = down_read_killable(&inode->i_rwsem);
+	if (ret)
+		return ret;
 	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	ret = down_write_killable(&inode->i_rwsem);
+	if (ret)
+		return ret;
 	ceph_block_buffered(ci, inode);
 	downgrade_write(&inode->i_rwsem);
+	return 0;
 }
 
 /**
diff --git a/fs/ceph/io.h b/fs/ceph/io.h
index 94ce176df9997..9432b8b607650 100644
--- a/fs/ceph/io.h
+++ b/fs/ceph/io.h
@@ -2,11 +2,11 @@
 #ifndef _FS_CEPH_IO_H
 #define _FS_CEPH_IO_H
 
-void ceph_start_io_read(struct inode *inode);
+int ceph_start_io_read(struct inode *inode);
 void ceph_end_io_read(struct inode *inode);
 int ceph_start_io_write(struct inode *inode);
 void ceph_end_io_write(struct inode *inode);
-void ceph_start_io_direct(struct inode *inode);
+int ceph_start_io_direct(struct inode *inode);
 void ceph_end_io_direct(struct inode *inode);
 
 #endif /* FS_CEPH_IO_H */
-- 
2.53.0

