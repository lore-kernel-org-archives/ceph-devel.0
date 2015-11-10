From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: infernalis build package on debian jessie : dh_install: ceph
 missing files (usr/lib/libos_tp.so.*), aborting
Date: Tue, 10 Nov 2015 17:07:30 +0100 (CET)
Message-ID: <1688972764.20825262.1447171650880.JavaMail.zimbra@oxygem.tv>
References: <1308176045.19397617.1447164379282.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59705 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbbKJQHd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 11:07:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 83A2D4439331C
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 17:07:31 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T3bXAgJQRPEI for <ceph-devel@vger.kernel.org>;
	Tue, 10 Nov 2015 17:07:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 56EBE443793B1
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 17:07:31 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wToJobI6VhMR for <ceph-devel@vger.kernel.org>;
	Tue, 10 Nov 2015 17:07:31 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 326DA44379384
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 17:07:31 +0100 (CET)
In-Reply-To: <1308176045.19397617.1447164379282.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sorry,my fault, I had an old --without-lttng flag in my build packages.


----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mardi 10 Novembre 2015 15:06:19
Objet: infernalis build package on debian jessie : dh_install: ceph mis=
sing files (usr/lib/libos_tp.so.*), aborting

Hi,=20

I'm trying to build infernalis packages on debian jessie,=20
and I have this error on package build=20


dh_install: ceph missing files (usr/lib/libos_tp.so.*), aborting=20


I think it's related to lltng change from here=20

https://github.com/ceph/ceph/pull/6135=20


Maybe is it missing an option in debian rules to generate libos_tp.so ?=
=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
