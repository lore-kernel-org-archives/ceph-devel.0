From: Josh Pieper <jjp@pobox.com>
Subject: Re: 0.40 OSD - Address family not supported by protocol
Date: Sat, 14 Jan 2012 17:51:38 -0500
Message-ID: <20120114225138.GQ4585@rcn.com>
References: <20120114145550.GN4585@rcn.com>
 <Pine.LNX.4.64.1201140923530.2935@cobra.newdream.net>
 <20120114183339.GO4585@rcn.com>
 <Pine.LNX.4.64.1201141433510.24825@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:17535 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab2ANWvs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 17:51:48 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1201141433510.24825@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sage,

Those two are attached.

-Josh

Sage Weil wrote:
> Hi Josh,
> 
> Can you attach one of your OSDmaps with the poison entries?  Between
> 
> 	ceph osd getmap 149 -o /tmp/149
> 	ceph osd getmap 155 -o /tmp/155
> 
> I should see one of them.
> 
> Thanks!
> sage

--r5Pyd7+fXNt84Ff3
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="osdmaps.tar.gz"
Content-Transfer-Encoding: base64

H4sIANwGEk8AA+1XvW/TQBS/O4e0BCG1KwsRO3B27FqVGBiKKBJSOiKhItzEKKKNL8SOMsCA
xMBKUkr5mJgRDMxISPwDDMxs/BFI/YA7+86+GgqlyPEV7ic938d79+7Z9/zsHwnbXa8XngcF
AmNsua7DWtN1sNwKANN0sW3jRsOidqZpmS6oO0UGJTAII69fr4PbJOz8yu53+iMKws/fdIp7
2uyA52x7v/N3LMvKzt/E7PxtuwHquLCIJPzn518F9y987L6pLtx7+Onl1c2lmYsv6OyHpZnm
zZNf8Jlns81rr95hQ1pRgQggAGmPCgKJwANud1aypY7goR0Bbs8dob9ytOf2qLS9yBPrp6l0
/chjc0iy76+0kbSkEs8bRiV1BFPJ5tTAg7v0gk49qsHa5TLjeNtK41gsM47Py3EcIxrHlTLj
WIgTCsYpx1JM5NU3CiPuGXFG7dBxYpHk1i4dJz2YZp2ce8we8fUGt9+mshX7yfI0n7PbOb8o
53crpzckvYxUB2EN8vthw6qkr/zEHv6hPTqgveizNfT7J9QdEkaI9/tea1UcQY+QtWl+uydo
Gwy6K34/6vR9nz2h49nUkOxwm0GwGpBhwNzs7rEhgc/Cm6ITbf+WN1iL2PbHkkjOmUgaWIY0
aBhS8KI+5WsTr0tTqlacsSIVZ1x2xcmDV6D1SVag5L3dB/A6vdyhwv4GNqg8F4plrnjKZVMo
2N8R4UomvdxeKoHn40iRfByVnY/vTwMlvoAak0bK/+z5wvY4FP+b0/xvEviR/7FqL/jf643Z
5tcnlzT/+6f4X2sIlOB/8zeAEl8/zf80/wOa/xUIXnFK53958Aq0rkgFUpD/sb+BMZXHQiH4
X8TbUCiOEv/j+Vg6/1vMeJfmfxoaGhoaGhoaGhoaBeM7MO3UtAAoAAA=

--r5Pyd7+fXNt84Ff3--
