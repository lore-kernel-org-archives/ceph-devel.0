From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: "ceph -v" doesn't work
Date: Wed, 06 Mar 2013 14:42:38 +0100
Message-ID: <1362577358.30983.50.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:56570 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3CFNmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 08:42:40 -0500
Received: from local.plusdinfo.com ([82.232.160.30] helo=[192.168.0.10])
	by licorne.daevel.fr with esmtpsa (SSL3.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <ceph.list@daevel.fr>)
	id 1UDEcA-00023x-Vb
	for ceph-devel@vger.kernel.org; Wed, 06 Mar 2013 14:42:39 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

since I compile Debian packages, "ceph -v" doesn't work.

I follow this steps :
- git clone XXX
- git checkout origin/bobtail
- dch -i
- dpkg-source -b ceph
- cowbuilder --build ceph*dsc


and I obtain :

        root! okko:~# ceph -v
        ceph version  ()
        root! okko:~# 

or with strace :

        write(1, "ceph version  ()\n", 17ceph version  ()
        )      = 17
        exit_group(0)                           = ?
        root! okko:~# 


Do you know how can I fix that ?

Thanks,

Olivier

PS : I compile that packages to enable syncfs support on Debian 6
(Squeeze), since I use a recent kernel.

