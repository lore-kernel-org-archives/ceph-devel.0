From: James Page <james.page@ubuntu.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Fri, 20 Feb 2015 15:58:33 +0000
Message-ID: <54E759A9.8020800@ubuntu.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <54E6F96B.9080202@ubuntu.com> <54E7580B.5020300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45964 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbbBTP6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 10:58:38 -0500
In-Reply-To: <54E7580B.5020300@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Colin Ian King <colin.king@canonical.com>, Patricia Gaughen <patricia.gaughen@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Mark

On 20/02/15 15:51, Mark Nelson wrote:
>> I've CC'ed both Colin and Jay on this mail - so if anyone has
>> any specific questions about the testing they can chime in with
>> responses.
> Good testing!  Other than the NUMA questions in the other posts, is
> it possible the disparity we saw could be related to the network 
> hardware/driver?  Our nodes just are using 1GbE Intel I350s.  I'm
> not sure what Stephen's uses, but given that he's at Intel I
> suspect it would also be an Intel NIC.  Any chance you could post
> the specs of the boxes you guys tested on so we could try to look
> for other differences?

I know the Dell R610's have Broadcom cards:

  Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet

I need to check with Colin in the other machine we used.

> Also, was there any additional tuning done on either of the boxes
> (other than disabling RHEL's firewall)?

No - apart from the firewall disable, that's the only change over
default config we made.

- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJU51mpAAoJEL/srsug59jDTiMQANJMiLacrGRDcPojBm28a1dr
dGifSxO2Vz1EEzH1XpuWYvUf55XYkOubsWSqPtMdzUKVvjIkvedT7rwZWdUoAih4
5z46RvEpMFEdlorg9G09HiVZkCccYJSyN1OkxgLV215jAqbx2fCOKoNEYCZNTjw3
l1wUFR2DNazUvyzTUDx6U0oICqFUYrih/3V6Ip6XFzwc3YxTIRqPvqKxy/4EH/Q4
RFo+PAJmNQAI6mC8oOJ45FCZcGqajN8LOzaMjGQiUrJcB8mYKnXOceb23+UfgpSS
TjprLs2wTTRKerOqvVV8pJdEnz+JYET5gJ1WhkCwYf+dT8eJTmpW3nmI/EwmCLKK
dLnUd6GbIsfe30/rRGBnYRWKlHWxyXe3DM3BWA/GPExyhNPVDO17pZtvBt30PEJS
cQAt4rrndqy0iJwF7T1h+VV0Z9hQ3zpM/cHvJaqhksdcBiRyx/Ac8RC5Eqd0NZov
9wFplIKisci7Nx44tpsOozmOYO2IikwiP45RHdAutV/UOVcAVFLWSHXU2PcqhMSz
H0TuUmpSYA9MSkIgza+ueTsFITb/QEZxyCYpvB7Gzrn04g6qZySEjHbma/lKflwZ
JUyrQdnCX0nLMMBGjgeH/WmJ7xdlTgDb+W1Vii+KIPLAjRqt/C0V8kk5tqNygi0g
KTUDGfuO5UF8VS8Ulg+t
=MXKB
-----END PGP SIGNATURE-----
