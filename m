From: Eric Jackson <ejackson@suse.com>
Subject: pull-request guidance
Date: Wed, 26 Aug 2015 08:52:02 -0400
Message-ID: <1515099.fctPuTxLi4@ruby>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1922185.aLWH4MiOlN"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56319 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbbHZMwk (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 26 Aug 2015 08:52:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--nextPart1922185.aLWH4MiOlN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,
  I have developed a small utility for configuring iSCSI targets and storing 
the configuration in extended attributes of Ceph objects.   I named it lrbd and 
it's at https://github.com/swiftgist/lrbd.  

  For supporting rbd backstores (as opposed to iblock backstores), I depend on 
a targetcli (and indirectly python-rtslib) that is not yet upstreamed and a 
kernel supporting tpg_enabled_sendtargets.  The primary purpose for using rbd 
backstores is an active-active redundant iSCSI target across different 
gateways.

  The utility does support iblock backstores and can be useful for other 
configurations.  Lrbd is written in python and the spec file is fairly simple.  
I have only packaged and tested on SUSE.

  Should I submit a pull request with these limitations?  

Eric

  
  

--nextPart1922185.aLWH4MiOlN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJV3bZ7AAoJEGKLgqb27CIaqYsH/1QKg7GYb+10Jvz0oFUCZJio
g8lFXi5xtZLjybRCKS4G9wxl6MENI+byTFHJ5ceGwTk/u6aCl8jUrRrGElL0U3HO
TEDpSnJIkjiu0ylo6u/CjzFNZfBS+yCdsSz0uWdtPXA53rNV++qrfYohHjKCjzhD
oBCvJOBO/5dL2WwpaK8hsOTtlNIViZ85inG1JmeFoSnjBr7tPD3m1NDYrf9VJrGV
CZsvLf9uOeVGE0MkhDf4yRH1dBOSDhseJL49gsGXlpoAxE6eOelvSPKv/RMsyUCv
Qr6jYxrMkG8Jcc0pNNSzuFIsq1YKleFEo47W3LZpAT0cZFHTIby7FDnI4E9Dojc=
=//+k
-----END PGP SIGNATURE-----

--nextPart1922185.aLWH4MiOlN--

