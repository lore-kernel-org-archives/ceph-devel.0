From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Redundancy with Ceph
Date: Sun, 4 Jul 2010 22:34:46 +0200
Message-ID: <201007042234.46732.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:54146 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab0GDUeu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jul 2010 16:34:50 -0400
Received: from sushi.unix-ag.uni-kl.de (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by mailgw1.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o64KYmwW015900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 4 Jul 2010 22:34:48 +0200
Received: from localhost.localdomain (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by sushi.unix-ag.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o64KYm3U022325
	for <ceph-devel@vger.kernel.org>; Sun, 4 Jul 2010 22:34:48 +0200
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Is it possible to tell Ceph that the user data is stored in a redundant=
 way across the osds?

Best Regards,
=A0 =A0Christian=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
