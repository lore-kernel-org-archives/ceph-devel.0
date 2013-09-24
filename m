From: =?UTF-8?Q?S=C3=A9bastien_Han?= <sebastien.han@enovance.com>
Subject: =?UTF-8?Q?=22ceph_osd_map=22_pointer_to_the_code?=
Date: Tue, 24 Sep 2013 14:36:00 +0200
Message-ID: <etPan.52418730.7a6d8d3c.f19a@leseb-mba.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:49352 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3IXMfw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 08:35:52 -0400
Received: from zimbra.enovance.com (94-143-114-250.enovance.net [94.143.114.250])
	by mxi1.enovance.com (Postfix) with ESMTP id 3DEE638118
	for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 14:35:52 +0200 (CEST)
Received: from localhost (mail-1 [127.0.0.1])
	by zimbra.enovance.com (Postfix) with ESMTP id 3BC493C81421
	for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 14:35:52 +0200 (CEST)
Received: from zimbra.enovance.com ([127.0.0.1])
	by localhost (zimbra.enovance.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pv05Fi6lXLBD for <ceph-devel@vger.kernel.org>;
	Tue, 24 Sep 2013 14:35:52 +0200 (CEST)
Received: from localhost (mail-1 [127.0.0.1])
	by zimbra.enovance.com (Postfix) with ESMTP id E6B37810D7E
	for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 14:35:51 +0200 (CEST)
Received: from zimbra.enovance.com ([127.0.0.1])
	by localhost (zimbra.enovance.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uwlEMVbsVHyU for <ceph-devel@vger.kernel.org>;
	Tue, 24 Sep 2013 14:35:51 +0200 (CEST)
Received: from leseb-mba.local (94-143-112-83.enovance.net [94.143.112.83])
	by zimbra.enovance.com (Postfix) with ESMTPSA id 95FF03C81421
	for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 14:35:51 +0200 (CEST)
In-Reply-To: 
References: 
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "=?UTF-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

Hi guys,

Does anyone can point me to the piece of code called during the =E2=80=9C=
ceph osd map =E2=80=98pool=E2=80=99 =E2=80=98object=E2=80=99=E2=80=9D c=
ommand please?
Thanks!

=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood.=E2=80=9D

Phone:=C2=A0+33 (0)1 49 70 99 72
Mail:=C2=A0sebastien.han@enovance.com
Address :=C2=A010, rue de la Victoire - 75009 Paris
Web :=C2=A0www.enovance.com=C2=A0-=C2=A0Twitter :=C2=A0@enovance
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
