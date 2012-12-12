From: James Page <james.page@ubuntu.com>
Subject: Re: Debian packaging question
Date: Wed, 12 Dec 2012 11:04:08 +0000
Message-ID: <50C864A8.1010707@ubuntu.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37288 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2LLLEL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 06:04:11 -0500
In-Reply-To: <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 11/12/12 23:00, Gary Lowell wrote:
> On Dec 11, 2012, at 2:06 AM, James Page wrote:
> 
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA256
>>> 
>>> On 11/12/12 06:32, Gary Lowell wrote:
>>>>>>>>> 
>>>>>>>>> I assume you are building with "dpkg-buildpackage"
>>>>>>>>> ?
>>>>>>>>> 
>>>>>>>>> The manpage shows:
>>>>>>>>> 
>>>>>>>>> "-B     Specifies a binary-only build, limited to
>>>>>>>>> architecture dependent packages.  Passed to
>>>>>>>>> dpkg-genchanges."
>>>>>>>>> 
>>>>>>>>> "-A     Specifies a binary-only build, limited to
>>>>>>>>> architecture independent packages. Passed to
>>>>>>>>> dpkg-genchanges."
>>>>>>>>> 
>>>>>>>>> So on the i386 and amd64 machines you'd run with -B
>>>>>>>>> and sync them to ceph.com
>>>>>>>>> 
>>>>>>>>> On one of the machines you'd also run with -A which
>>>>>>>>> should produce the architecture independent
>>>>>>>>> packages like libcephfs-java.
>>>>>>>>> 
>>>>>>>>> That's the theory, I haven't tested it :)
>>>>>>>>> 
>>>>>>>>> Wido
>>>>> Thanks Wido.  We're using pbuilder, but it looks like it
>>>>> has similar options, or can pass an option string to
>>>>> dpkg_buildpackage. I'll do some testing.
>>> 
>>> "--binary-arch" will limit a pbuilder build to the target
>>> binary architecture only; I would recommend you use this with
>>> the amd64 build and build the arch: all packages out of the
>>> i386 build; this is what happens in the official Ubuntu
>>> builders.
>>> 
> Hi James,
> 
> I thought this was going to be the easy solution, but on running a
> quick test, we are already calling pbuilder with the --binary-arch
> option and it its building the java package anyway.    It looks
> like there is a deeper issue in that we building the java package
> in the default target.  It looks like for this to work, we need to
> move the java library build to it's own target in the Makefile, and
> build that target from the binary-indep target in the debian rules
> file.   Does this sound like I'm on the right track ?

Gah - this will bite when I do the next upload to Ubuntu as well then;
 Can I suggest that we rework debian/rules for debhelper >= 7 and use
overrides rather than the current 'old style' rules which define all
tasks?  I was toying with doing this anyway (and have it working
locally) - it does cut out some of the content from d/rules and makes
it a bit more *magic*

Thoughts?  I'm happy to raise a pull request for this.

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQyGSnAAoJEL/srsug59jDkCUP/jq71IWWEnh8kMNhJgIBkjay
x6NLdTgmaLySC2MUgMFoa4XPwPF2YmtH2oLf8dNDvHPB7yijeOblhjIzjmCAg7Ui
EHE6IKS5IaDGTfyOnskdjUESZkH7BlqLul+vx7hHm2ucEiJcUcv4Zey0RpgHApTq
UqSKJUBG7z54y9Lf5cPGCnr4ox2d3I5+RKLCLrwSpht8VPC3R3yCFzOe2ZSKCKna
NQ5PeNbSgiwsdI+DmcgPdc7ztbJ6DA8MGHL2CPUr50xDDh/rC7uU2ag9qq7TEYh3
AQf5UoauJtmGxtG//U0RgNG7LEwSXn87qeY5bGaOVXiQ4gVKzaZLKW1M3CU97g/R
TXwm3jLaNn0hF3x/lbJcGhT0yggrsgOCHjO23PYLarOzg0I81FcubZydujJDbHUK
52dD+Hb4OHyNQCxg0YUsI5PzASPoiRzbMny1cGEEgR+ypdy+Phezfc2aaYx29x0P
RqKyw36T8kuDjLWaQVoiQPi3A05K/AX3G0Mn4zCBqPMKQnzYhSj7uezh6fzY6uxd
oh8q7yCgSBI/5LzvjIssqUZ3bXG7fSZYO5Yz8+7lNHkb0gIhDMH1HTKnHlvxW/Tg
YyaXX1o1TFdc/SNDulqRYaDe2juzud7oTmiH30/FcFHUfqkTnnFTzv7OL8n+07YN
RPhPOAE7CeWHDkbJl4D4
=f4FX
-----END PGP SIGNATURE-----
