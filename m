From: James Page <james.page@ubuntu.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Thu, 29 Jan 2015 12:51:47 +0000
Message-ID: <54CA2CE3.8020603@ubuntu.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB4EF94@FMSMSX106.amr.corp.intel.com> <54C959C4.1010305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49624 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbA2Mvv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 07:51:51 -0500
In-Reply-To: <54C959C4.1010305@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com, "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Mark

On 28/01/15 21:51, Mark Nelson wrote:
> Per Sage's suggestion in the perf meeting this morning I dumped
> sysctl -a on both systems and wrote a little script to compare an
> arbitrary number of sysctl output files.  It only lists settings
> that have different values and dumps out a csv.
> 
> So far it looks like the interesting differences are in:
> 
> scheduler numa ipv4 (and ipv6) vm
> 
> Script is here:
> 
> https://github.com/ceph/ceph-tools/blob/master/cbt/tools/compare_sysctl.py

Useful
> 
script - thanks!

I'd like to get the Ubuntu Server and Kernel teams investigating this
disparity as well - would it be possible for you to share the
configurations you are using in detail?

That way I can make sure we are looking at the same thing...

Cheers

James

- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJUyizjAAoJEL/srsug59jD9NgQAIKfj8w3LMYroO/GlXb3jjnu
6ponX2HTVDNaVqLaYtpevYDUbkgIIEOEcOtxxbORxGnWr7fcXzQtUcp7K0KLtU+r
/SwbEcsBRaS7im1/lqAlXOh67XSSzE0eSpqrWxCPKM6X0kmvD49G0fnTclmax/F6
beUm2Oz9UtRoB28mSIVMcUWbi2vsltbZx4khppu+1WpXqdlHr7fg9lKr2jeSbvXC
23nJ7IEd5zVdxaAxQtjjj9Gjk8TWCFICZIoHwvwOigvCnGihP3Ngnyabx7Gz9sJm
vnyibS+bXHPjIAdUGEtEanOt0lIO8TVbPZM4X3YDaCeEvaoLxqqE832EXShxQ76H
1fDHTu/OQeEyN3udYHit/xgEm3/nMg7Bwb1I4l5TtHgPq8mrXTGqI6zJv9Y1PZ/E
DhmgcTAEPx3/IWBiU1F55Ktgn6N7fIFCrTEDZ6tkuraeG5WJzqf4OEU7XP/8Z1bb
L4VrnBVgNrxDPJOO6u4YNDsacaO4rMCs2U1kQiGKruSXRKnw+RtowoIzIy8O0I6o
lspBJdLjSXXnP/MLVFifFkXyynz/uPIQbg76FA9mVIC3tc7yeXhjB/urrGbbZPuT
IsoVrlsb4IG9Ay4iRCE7yEw9gwqlEhCTtrY9WrhgA/23ihqn1+Hm/4h7ypP+AWmq
XmBsJ1VQyxHnsJgf9R+4
=Zfn0
-----END PGP SIGNATURE-----
