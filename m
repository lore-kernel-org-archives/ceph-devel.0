From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: infernalis build package on debian jessie : dh_install: ceph
 missing files (usr/lib/libos_tp.so.*), aborting
Date: Tue, 10 Nov 2015 15:06:19 +0100 (CET)
Message-ID: <1308176045.19397617.1447164379282.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46337 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbKJOGV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 09:06:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id DB0FA4051FDE6
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 15:06:19 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Id87AxGEUaAF for <ceph-devel@vger.kernel.org>;
	Tue, 10 Nov 2015 15:06:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id A878940BBD84D
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 15:06:19 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n0uouBpLscJ1 for <ceph-devel@vger.kernel.org>;
	Tue, 10 Nov 2015 15:06:19 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 5E4A8405180DA
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 15:06:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm trying to build infernalis packages on debian jessie,
and I have this error on package build


dh_install: ceph missing files (usr/lib/libos_tp.so.*), aborting


I think it's related to lltng change from here

https://github.com/ceph/ceph/pull/6135


Maybe is it missing an option in debian rules to generate libos_tp.so ?

