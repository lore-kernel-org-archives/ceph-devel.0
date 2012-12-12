From: James Page <james.page@ubuntu.com>
Subject: Re: Debian packaging question
Date: Wed, 12 Dec 2012 21:12:04 +0000
Message-ID: <50C8F324.40600@ubuntu.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com> <50C864A8.1010707@ubuntu.com> <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40393 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab2LLVMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:12:08 -0500
In-Reply-To: <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gary Lowell <gary.lowell@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/12/12 15:44, Sage Weil wrote:
>>> I thought this was going to be the easy solution, but on
>>> running a
>>>>> quick test, we are already calling pbuilder with the
>>>>> --binary-arch option and it its building the java package
>>>>> anyway.    It looks like there is a deeper issue in that we
>>>>> building the java package in the default target.  It looks
>>>>> like for this to work, we need to move the java library
>>>>> build to it's own target in the Makefile, and build that
>>>>> target from the binary-indep target in the debian rules 
>>>>> file.   Does this sound like I'm on the right track ?
>>> 
>>> Gah - this will bite when I do the next upload to Ubuntu as
>>> well then; Can I suggest that we rework debian/rules for
>>> debhelper >= 7 and use overrides rather than the current 'old
>>> style' rules which define all tasks?  I was toying with doing
>>> this anyway (and have it working locally) - it does cut out
>>> some of the content from d/rules and makes it a bit more
>>> *magic*
>>> 
>>> Thoughts?  I'm happy to raise a pull request for this.
> Yes, please!  In the meantime, does build-indep sound like a valid
>  workaround?  (This hiccup has been delaying some simple fixes in
> 0.55.1, but unless there is a quick fix I think we'll just release
> it without the java bindings for now to get those fixes out to
> people.)

Yes; I'd recommend looking at the postfix source package on how todo
this with the binary-arch and binary-indep targets:

http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/raring/postfix/raring/view/head:/debian/rules

- -i and -a flags and the differentiator between -i(ndependent) and
- -a(rchitecture) builds

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQyPMkAAoJEL/srsug59jD10EP/iO9IFmSgIetIEJVCdvxuTvE
Vb9eLt9fT1Z3Www63RLzQJZUi870slQM8/62ivjTRDn+zMvf2TJFeU+tVBF3tmT+
/fSwJPkMld/uC92uQUS4NHwnmVdeD4Ns5MNDSJ6XgLAm+7uZgGD0k9SAj7ILIBzm
QzTnLon1DxTG77nUxkyj0aNxaDH9SeOAxy3K6DL/qieQH1vYaUB6xWTqZjk4LoiH
CBGU289PGKkmQmX52CLXCyITjDGrZrJxpsiv7PiFL5Uz7v+udLkkjaOaiS5r5Hv3
eXgXkNGt3sQvFpQbcNXViP5BjZ9+m20KLxizazKaXsnxMpcq7K3qfblm4SoBtPvu
YsORgD1osY2jyJtBiqAnbYA3N32uMM9jxJ4Gk36Mkh5ksJPkzQULKYaJyskLTfXE
v5akVn+6p/G3Jl8DXE7+QzQCTYc7A9DvF3I3GWDFQMaDtsQtm4IwXpyAuURt6EJ6
EsLCb6wWG2UfMzk8cvltNDelfYuQMqQqx1jEY/BlhRt9uu13oJEe6pGB1DAd9iax
fEpUr/0sicqn7ElgK+cuBiT13qi1+klYHfEYlHS/+JdGcmaN2q5lUPkvfc3D8A9g
30736F0+s+LNCHIqIip1sav5JAC7ZmhTCcb+1ll+J+qvGO1kKzbsHc4D932EuBbo
T+HX0+YTFvrt8pUATjLd
=IHTl
-----END PGP SIGNATURE-----
