From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Re: the autobuild gpg key expired!
Date: Fri, 08 Feb 2013 18:52:52 +0100
Message-ID: <51153B74.3040203@de-punkt.de>
References: <alpine.DEB.2.00.1302072235180.28547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:34327 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946833Ab3BHRw4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:52:56 -0500
In-Reply-To: <alpine.DEB.2.00.1302072235180.28547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am 08.02.13 07:46, schrieb Sage Weil:
>  wget -q -O- https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo apt-key add -

This doesn't work because raw.github.com uses a certificate issued to CN
= *.a.ssl.fastly.net
for whatever reason, and wget will complain.

It complains rightly, because there is no way to verifiy that this is
*actually* github.com we're speaking to. If you want the key regardless,
you can use this line:

wget --no-check-certificate -q -O-
https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo
apt-key add -

Regards,

--ck
