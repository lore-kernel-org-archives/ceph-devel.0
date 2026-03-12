Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA92D7804;
	Thu, 12 Mar 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303412; cv=fail; b=iQ2k6nWpJW5O/QKJt8IasEQI3my5I2VXAQvP4KdJF2Ue546DdZeqA/hadUwIHloyiWOczbCHqxkZtyJzxXPCqZMFpvWY97wstTK5N8kWDmsWModsfELello+2BrQPWq6MyOTmuFJk50EAa5aI/kiB5efejDnUJmQldd54Oboa34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303412; c=relaxed/simple;
	bh=WB3RUggO+WzfJlPdaMJwM0fnMoNZeZNmy1K3mI6Ipgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCKSwl/L5EUYIoWS1b9e/LIaQo7FIj5fo3beh0n6lSHDV3vUYlwUeKVbFnMzyqrn2Ly8/CMz97lRLtwB+HuHXGv9GOWfQaTMpTbpci6GdLN86ySRtSs6NPo+urMJ5ljRPEH+zDojweHq49159ZBlp/e712M7ZtUmGF96fx4Geyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=hSGArITp; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="hSGArITp"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C7Xgae3253345;
	Thu, 12 Mar 2026 08:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ryulqqajZF1GmuaXblC6EwQaGGb+lUFHAZvUb+vEoFg=; b=
	hSGArITpDB5Bmu9RUUGY9VIkE9ZNEW4sL+IfRsyKjaPlJK+oaYC6smcTaOkNWfrI
	bt8o+taxnxY6Uo9e3zpbKshbJo/Z5CTyAkoFUrxmLJ6D64ZWheyULe9j53G97R/H
	24ANrz80EK32Sqt3k87rtgxW0gYg/HUDB/2Qhb9X255/9RAydKIgv4R2/HaDUzbr
	6T150QODOTva1ERjRF7BnoQ0LJXUghu1/STgqoWMw2lfVAWe2xvJmIOilswXT//C
	dpmrRmrnmuZ2o0yYWRc9Z+TuHql+aLXE/b86Clx6Bp9Ag2GXr/cA3Zhmg+opx60y
	NHDYmqLBxT9YehaCngJIng==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdvv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:16:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/U3A0otsODu6O4zolsoe94lFlINfl2Dapqm0amkjmYkhYpzrZ1VAzbnBQN06ZmBVBSLHR0spuIVYdrro5Fpag2NzX70LoafdiVJS7ADN/Mp1ZylnZgZx7GPGZTAbr1uICNmFtBj1AAw5rJyXL7lP3KpQE7SVg/rGczbeIk49VkR16+iXm/ZBvqwkfyG+JyTbCQ/pbRpEhjBYXYIO7knnahmwnZQKITSb54O+mTuTD6P9wKp/edvYpKYhp9ajdYrX5iX4UhNtXHsemlR0RrYhSzcOnfsephoUFN2biRmBfKrPYkIcBO9HlxPC9nW2D+zsmrfgw08jnJMWBs7KLIe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryulqqajZF1GmuaXblC6EwQaGGb+lUFHAZvUb+vEoFg=;
 b=MSH8T09GfpV1xgEI/135skANTzFXsnQ5XNA8eRb0KVKMCgBDnJSavMUUZpQEevzIz+VLK5egWKfDsf7yZU2YKPYzwIdOYlqF7czN1qQvoIfXsitCGEfbxRB8GwWnP4d4uM/qc0uB7QqNvWzRXciUAy5xM2rvFlftlNIK5agfoJUqpKsY46eeohMDsEh5mBuP6ZM3Bu60azqLF+IPMIQcDHvXA5UfxqKUNsnuCp9Y3gnnxVx5XJpTBLBuhEflevJccUsUD9WrDTgNmSY0h5hYeyHodBuWDPMPfxW82fODxMK9TSclDx2EdgyN7AkaEY4QRxFCfXEA/cMF/vuvtKWQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:45 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:45 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 04/13] ceph: fix race condition in cleanup_session_requests()
Date: Thu, 12 Mar 2026 10:16:10 +0200
Message-ID: <20260312081619.40854-5-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d0d79c6-c6b0-4918-98bb-08de800fb37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t6WRyFYXtgwl5hHkn0xIKnRinlUrUfvLCB/3VwD5bZqrjGcSh52Z128sBEBQjh9q4WGVxhVXWDZCb/+Iy9R7snU9h4DKo97QPrxVtsdSUY9Sy8y4nyBterdB/ObFCIBjBEc22QpEIR1buwx2Hd9gxsp/DXDvlLPSd/wUty2mllq6eBEoEnj89O3ZWJZxIveZ+Iqij+/MsTYeNnSZg1jwChDEGQiyG/BlXNfEStQr1f9DhrzhMEh46+be4XpHjPXU5IokgnLEmilLprxBFA9KRt9OzjKEXyv9bQYwrsAfgSUysOKnyC9sDToExqS+ugWt7Vpofg3qAkdUBZ+pY0yIr0v7UED9Cu2vumVdUq817tEw09urJR2a9SaDNiyMSkxirX36rOQ898MOQWatUUtYNjndt2vGJuEJsE26pVPRGmqrXhKJGsJ7920F746pUYOrk7JhCxvcxXiS1Jbm6g2mfM0HsACNXCMmwj9Y2Z2cfW6AVDdQ7I5ydQUEIj9xf0UEBw6VByk2LutfalVbitgfo+bZwnQpSSIej4xHfw89a6W3Xle1tujiXrGpAMsec94RFNNehj9ry53p2HIsrV1e0NeTdzau+9XrpV5onN21nHgM5lb8uMJgYEPuPMDpBK/Xpw1n+2T12tAd382nTZHhDDn5bHXjtfxDg1M1zfiYDqHvARa9eEgEYVqPHSYv3P9Gf6V0L0MPu0o+9NjPlUnRwfyDqXNwFABHfm1QGO3TmDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWTW7fk6mB9o7Mc+hBYg/Sl+sQjoqQK0YmeZcuCR1aByOsemK0J08RphjWVL?=
 =?us-ascii?Q?GM+8ojBaht9v7U3wv5XEgc9wdVmJ8RXSOIRHTp+GnhpwjfX98x+0R1eSAab4?=
 =?us-ascii?Q?/a3f3e4fnpRyz+FGxM7OnEOXnJDpe3/LO8AqHWRNrK4hgTPODZzxA6bPncpt?=
 =?us-ascii?Q?cj7ugJ2+M3uonNwTKCLOno9ra+8MkCeKqtUC3O0T0YYyZUnj9EWKY/nxvaJ/?=
 =?us-ascii?Q?90cF9hukDwiBZ12VTTftkUla2z7QLUqh4H+o8cV/VFPegsPT4Dr5/S638YrM?=
 =?us-ascii?Q?zXIaS1g+dkdxrBSYvkNaGnHdlYEeJd3wOKqTGqR6hpzT7gddhH8gGWTuqoR6?=
 =?us-ascii?Q?6fNS82t5FrC4q+s3U03lUFPjSa1g8laOpID5C912k77TNWi6AXk+oI5Fxzz0?=
 =?us-ascii?Q?pv9qh2vfBepJKV7hbZsxfbkqpj9mrSVFVv2bIBnGLdWbakZjPvMJCDskFfEJ?=
 =?us-ascii?Q?J0InkKhYwTW6JH0qZRk3pbCQA/b8ukYnYKQq3RjGVGLCye8Ms0fXIrtOLjDS?=
 =?us-ascii?Q?qQUSMnzxggbG2FWkNq0RJMdGfgHq9HkbgwWHvi1R8hQwKXION6osbxlx2ajX?=
 =?us-ascii?Q?SxwLf9GuXozjOIm1KbsY/HLTH4CmclSX5VfqujoaDKjQm6ZdmbL4pcIEQfu+?=
 =?us-ascii?Q?oz/9M+LCGkJEtmaRRHlVbFLnFugp7zePx1l6I3ot3N2/5ekQCjuxM24VQm6w?=
 =?us-ascii?Q?JD2lf5WFNiK/Nec0VhyY6pM/qY0Q5aX2eaQCEB9mS3hHtk2n2lllZuyevacK?=
 =?us-ascii?Q?YYX7kuJZ7ZAy41G4h7CcKuKQ5ZuEILOJtoIWO2/PXm8fiphKP7OcN/xboTjV?=
 =?us-ascii?Q?979ui/pP3aY77rX+7ebQCdkIYO4GDDqQYiojz2r82XLlkC+2kQoOkr6IqVmN?=
 =?us-ascii?Q?MO3WE0cXa9duWS70d1UP0yNHYiAgcwFxdC0peleygGu2BB5BeKTd4LAbkDtc?=
 =?us-ascii?Q?XKLbzwhH6qgKFeeoy4+T9mzgCJg9ilJ+6Pzt6X3ciHR21pirMuER7skYCZGS?=
 =?us-ascii?Q?cGXvFzoPun6nuO6w07wy7vfrTL/RJ3Baf1oZlN3OioXEitUbQEjJd4jc6bJR?=
 =?us-ascii?Q?wNkfLcLM/jibtqmHEVqok2u6wydhUcuVmguz2yHqYxwUwB5u3n1jPtCbp+eq?=
 =?us-ascii?Q?zk8X9+NGVeFrAV0KThLRFhN/sL/MpfyuXW0fm+Ruy40Fl2w9KvjV/ZznTmaB?=
 =?us-ascii?Q?VHxp+SKkWt6zvWwdX5ATRTgdflqkxKZpVfrI6PQGmdRKUdkIbLkk1C8gS9JI?=
 =?us-ascii?Q?rP0jWObd58XdT8VcLdBH7a2ONCloH7S1mQLkLZ5hpaSF3rnL7AdXlBfZh9OR?=
 =?us-ascii?Q?yE5MfX4RnTW4qTe2LKr4NSNHL3X1gZ1XMPdpHZtVpui6WwcgcV6/ut3VGwJg?=
 =?us-ascii?Q?rksGW1Rx6VfwP8HWIcXfF/P1lG08bY0i/RpUqHYotF2XvcTU8NjAA7JE6wRC?=
 =?us-ascii?Q?FI7R4jRviAmfkDExVhAW6s3gTMHajPsEEyw3mcuZnMxEGJ7M4uy5B5Emrgn0?=
 =?us-ascii?Q?AvIKjlw+bd/ZT6VrLHDseRV57xkKN9d1z0457ZyxGcZOeZn/7u98kioMRTg2?=
 =?us-ascii?Q?YBK8QhqKn50t2cxw5NVwCzMoOXVSs6O+egdmB9NJKG6EXejJ7QxghEjPtiKW?=
 =?us-ascii?Q?Hzgq09Zlb4vFJUpjKqqRFfe67r3n+8w7mJ5/guNR/LOaTlGYEKdr98pDxu9G?=
 =?us-ascii?Q?p4UwKv3I0xPWc9cz7XpVoCW+FpbHptphY+/SH9t0xLqYCBFST55zeHIgzGps?=
 =?us-ascii?Q?LzlLz/9E6dz1DFTVYyLgNmQq4HJE2ftoR3EgKuJIwyeWaMtgsVc4iIZjIPLP?=
X-MS-Exchange-AntiSpam-MessageData-1: WYue3qcPAV6LeWPr0UNSS5DJthv/tSs2q6w=
X-Exchange-RoutingPolicyChecked:
	EZF1OY7FiO/wyL7SsqJAJt8peU9d2ZN/atpdPa2SoYq266WfvgmKv8Z5/o651ifyCN8mb9aAqkcgYsuEcUfgA/Q+TSWDXZ8JfbHtFvxvb71jdz4a6YhannhUAO+ZVt+2OZ5GT9CM2jNC8Rda15j18RRBGo6WBxl0kUUNwDfM7NO/07eaxpVN7jUtCOBTEPDeYRmjoy8Ezdp7z4nF0HxsBy8I1oznxcpunGs4Hhe/LkQd3Y2njbaNRdt0sT+u3w1IhtI+vRCVizjFRYDlsLXz9bd+5p57g6l19snD9Z4EejjR4BswPax8w0lL2nW5X9BGnAJAy1FbLI9fcvALXaBYsg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0d79c6-c6b0-4918-98bb-08de800fb37d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:45.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nrb5sDpR1d8hMJB/Vg8Fjd+t7UJPeXxqDFk1gcFJqmzNP5XPMODwIMdMCGgkaWTUi9EpZMRKNLaXQKt5rM5yVt23JhZjHjWTkDvR3Z85qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2766f cx=c_pps
 a=8AG4s+rqopmfoFde1j+oJg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=LiVfuos2sF1OzTiVPoMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX7wbCaIIw+LY/
 L+maqZ0XLFAc2fTWDNGyLF/DeJF3qX74+o25FwQ/hvWZUSag2bokHXyocuISR6Qpa57RZnXVPH0
 rQRkA0NAHQ3f5QyR5btxpdUD9u7jrRW0hQF7DAjk83EW9idMf1XYVc4sNI2CvSD9vgqCFn3GEBK
 REuQmQvFFt64fdGjKIrS9lQzTQO47D8zfSUBsHM1QN9PSO25JYkw2irdiT7iLPPN0woyJPR6EIK
 4lhQf0mq/C81PNv/DyzxlgEa422fPC7XD7cOOfLnjFZb87CvkJ1FKoRM8IL75DZzjaIJCMpinSe
 pzilq+LwidX7ntfkCc2RD+UCBjeYBvA99sRT6psjAr25xyujbRyASaa8RfRt6qNyb30ehRKDbpZ
 uWR1zmuqi2+pfCeI9tO6wXrvpw4ni3bC+eqWrb4Qz+rYMYlC2L3J4+Why0QTvTWTOwaTt+m9iMG
 yHYok1eSaHCRsWJlK3w==
X-Proofpoint-ORIG-GUID: 1dkxApkTUtzwIYB_lRc2oQZ8sKznIxX3
X-Proofpoint-GUID: 1dkxApkTUtzwIYB_lRc2oQZ8sKznIxX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

When an MDS session is closed or reset, cleanup_session_requests()
only unregisters requests that are on the session's s_unsafe list.
However, requests are only added to s_unsafe after receiving an
"unsafe" reply from the MDS.
This creates a race condition: if a write request has been sent
but the MDS becomes unavailable before sending the unsafe reply,
the request will:
  - Have r_session set (points to the failed session)
  - Be in the request_tree
  - NOT be on s_unsafe list
  - Never have r_safe_completion signaled
Meanwhile, flush_mdlog_and_wait_mdsc_unsafe_requests() iterates
the request_tree looking for write requests with r_session set,
and waits on r_safe_completion for each one. Since the request
is not on s_unsafe, cleanup_session_requests() won't unregister
it, and the completion is never signaled - causing an indefinite
hang.
This was observed in production when running xfstests generic/013
in a loop, with stack traces showing:
  INFO: task fsstress:14466 blocked for more than 122 seconds.
  Call Trace:
    wait_for_completion+0x14a/0x340
    ceph_mdsc_sync+0x4b4/0xe80
    ceph_sync_fs+0xa0/0x4c0
    sync_filesystem+0x182/0x240
Fix this by extending cleanup_session_requests() to also unregister
requests that:
  - Belong to the closing session (r_session->s_mds matches)
  - Have NOT received an unsafe reply (CEPH_MDS_R_GOT_UNSAFE not set)
  - Have NOT received a safe reply (CEPH_MDS_R_GOT_SAFE not set)
These are requests that were in-flight when the session failed and
will never complete. Unregistering them signals r_safe_completion,
unblocking any waiters.
Requests that received an unsafe reply but not yet a safe reply
are already on s_unsafe and handled by the existing code. For
these, we preserve the original behavior of resetting r_attempts
to allow re-sending when the session reconnects.
Fixes: e3ec8d689cf4 ("ceph: clean up unsafe requests when reconnecting is denied")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 37899464101f7..45abddd7f317e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1792,6 +1792,8 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 
 	doutc(cl, "mds%d\n", session->s_mds);
 	mutex_lock(&mdsc->mutex);
+
+	/* First, handle requests on the unsafe list */
 	while (!list_empty(&session->s_unsafe)) {
 		req = list_first_entry(&session->s_unsafe,
 				       struct ceph_mds_request, r_unsafe_item);
@@ -1803,14 +1805,30 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 			mapping_set_error(req->r_unsafe_dir->i_mapping, -EIO);
 		__unregister_request(mdsc, req);
 	}
-	/* zero r_attempts, so kick_requests() will re-send requests */
+
+	/*
+	 * Iterate through all pending requests for this session.
+	 * Requests that haven't received an unsafe reply yet will never
+	 * complete on this session - unregister them to signal waiters.
+	 * Requests that got unsafe but not safe are handled above via
+	 * s_unsafe list; for any remaining, reset r_attempts to allow
+	 * re-sending when session reconnects.
+	 */
 	p = rb_first(&mdsc->request_tree);
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
 		if (req->r_session &&
-		    req->r_session->s_mds == session->s_mds)
-			req->r_attempts = 0;
+		    req->r_session->s_mds == session->s_mds) {
+			if (!test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags) &&
+			    !test_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags)) {
+				doutc(cl, " dropping pending request %llu\n",
+				      req->r_tid);
+				__unregister_request(mdsc, req);
+			} else {
+				req->r_attempts = 0;
+			}
+		}
 	}
 	mutex_unlock(&mdsc->mutex);
 }
-- 
2.53.0

