From: James Page <james.page@ubuntu.com>
Subject: Re: Debian packaging question
Date: Tue, 11 Dec 2012 10:06:33 +0000
Message-ID: <50C705A9.1030603@ubuntu.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59339 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab2LKKGi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 05:06:38 -0500
In-Reply-To: <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 11/12/12 06:32, Gary Lowell wrote:
>>> 
>>> I assume you are building with "dpkg-buildpackage" ?
>>> 
>>> The manpage shows:
>>> 
>>> "-B     Specifies a binary-only build, limited to architecture
>>> dependent packages.  Passed to dpkg-genchanges."
>>> 
>>> "-A     Specifies a binary-only build, limited to architecture
>>> independent packages. Passed to dpkg-genchanges."
>>> 
>>> So on the i386 and amd64 machines you'd run with -B and sync
>>> them to ceph.com
>>> 
>>> On one of the machines you'd also run with -A which should
>>> produce the architecture independent packages like
>>> libcephfs-java.
>>> 
>>> That's the theory, I haven't tested it :)
>>> 
>>> Wido
> Thanks Wido.  We're using pbuilder, but it looks like it has
> similar options, or can pass an option string to dpkg_buildpackage.
> I'll do some testing.

"--binary-arch" will limit a pbuilder build to the target binary
architecture only; I would recommend you use this with the amd64 build
and build the arch: all packages out of the i386 build; this is what
happens in the official Ubuntu builders.

Cheers

James

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQxwWpAAoJEL/srsug59jDCRcP/i7IEUboQANGevKBVsh4bIeV
PiHAJGyHX/ljEkxhCpVI2dKxJxW2d6oZDKHwJarZlrPmYxGV5GXdcRcDlR2Z5Qvt
MD0Hy8JnigJ+dvpo5pKLAFPA0HbKw/5bNyYhkLUwAyVjkPxhG2EEgbggUtQVgWjm
nNlsvgvV5czR8HKgKoqQvfNzP4vBpq5STLt3TFqG8qDxYbAQK9ZyBsJVpH710aCn
gALasDTODjY9AttadvYnJbjKoaIkgmlrGZbin5Zdy87XD41mG9HtlNKbAeJ2rAPM
BEDLcMAeg6BXSuu9sSUrgNl36UmEkwnDudMZzezin/ubhQXsHDfaDjd3Dgdl8brx
LsX5fziLPvWPdCs9LzAiPYiMPde9+911Wk/N3Jbf8mLL3M5/U/5sYv0M9SD70NGA
67JbktN66RApA0WV9IZqDOgGNLLImI+nXmlHNkGRlm9XFez2pVjYI0CSq0vZonYN
wU/ISi7V94AF6TAb7LxF8O8JDFBXlz2fHrFS9T2CLvb4jRP8TLFPHoWLRu+3lGbD
pdimZK9fd35XNdI/1167Yafj9A8VvNUgZcGFb4bc4u5GJsND+0S6khTI2ZStv2a8
SyXdh4LxRePB1TC/jpMV/JKjYktMU7dhGDWM6Phgod/gUUA/cyWU9ROXXukCV98M
CzC76vescwKVjRxBogR7
=N76U
-----END PGP SIGNATURE-----
