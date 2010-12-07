From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Dependence on libcrypto++
Date: Tue, 7 Dec 2010 09:25:12 -0700
Message-ID: <1291739112.4879.366.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:34597 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab0LGQZU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 11:25:20 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 130C94935FE
	for <ceph-devel@vger.kernel.org>; Tue,  7 Dec 2010 09:25:16 -0700 (MST)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oB7GP3sR001201 for
 <ceph-devel@vger.kernel.org>; Tue, 7 Dec 2010 09:25:05 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Commit 15d8bdf3bf switched to libcrypto++ (AKA libcryptopp)
for aes, rather than openssl.

It appears that RedHat does not package this
library for either Enterprise 5
  http://ftp.redhat.com/pub/redhat/linux/enterprise/5Client/en/os/SRPMS/
or Enterprise 6
  http://ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/

According to
 http://www.cryptopp.com/wiki/Linux#Distributions_Offering_Crypto.2B.2B
it's the only major distro that doesn't.

So, what's the right thing to do?  Will it be feasible to
fall back to openssl if libcryto++ isn't available?

Are there any RedHat employees on the list who can learn
whether there is any chance that RedHat can package
libcrypto++/libcryptopp?

-- Jim


