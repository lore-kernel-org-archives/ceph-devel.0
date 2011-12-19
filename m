From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Could rados pool support tree view feature ?
Date: Mon, 19 Dec 2011 14:51:45 +0800
Message-ID: <1324277505.4089.26.camel@cephclient0>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:4031 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751169Ab1LSG5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 01:57:19 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi ,

Could rados pool support tree view feature ?for instance :

$rados lspools -m 172.16.10.10
data
metadata
rbd
Product:00000001
=E2=94=9C=E2=94=80=E2=94=80 00011
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 00012
|        =E2=94=94=E2=94=80=E2=94=80 00013
Product:00000002
=E2=94=9C=E2=94=80=E2=94=80 00021
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 00022
|        =E2=94=94=E2=94=80=E2=94=80 00023
Product:00000003
=E2=94=9C=E2=94=80=E2=94=80 00031
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 00032
|        =E2=94=94=E2=94=80=E2=94=80 00033


This feature is very useful for us,if not,how to implement it ?

Thanks,
Jeff Wu

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
