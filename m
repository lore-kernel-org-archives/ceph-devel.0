From: James Page <james.page@ubuntu.com>
Subject: Re: Debian packaging question
Date: Wed, 12 Dec 2012 22:17:55 +0000
Message-ID: <50C90293.4060407@ubuntu.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com> <50C864A8.1010707@ubuntu.com> <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40571 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab2LLWSB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 17:18:01 -0500
In-Reply-To: <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gary Lowell <gary.lowell@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/12/12 15:44, Sage Weil wrote:
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

Try this -
https://github.com/javacruft/ceph/commit/eb9516b92fbf1d09376ad86bc081d927f47656c0

I've given it a quick sniff locally to check the package build process
generates the arch:all packages when requested (and does not when a
architecture specific build is requested).

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQyQKTAAoJEL/srsug59jD0PwQAI10ecrN/GFNF6OU+3/uL7mP
ieTB47CDDZZRSxnBLgPwy1Lcc8DEN1HjigWZEjyWmglQ5DWF+VLLUwU4kAKRT8Xp
vPo+xbLWNl28TzlPFY7swMhPwMOV/PksAt7d6/lcmUmyoZJIojz2fjB/NY44uucg
IyJn/A4jttlgm6lTaTUNrjjX6O3vuxsWu9MiGAAStVufHEaR8ILs/sGBDP30eHsf
rh1YWIHdzYelupfr5ONVwqkl4RNG8wDP3g+pSOmg0aUJbGUowHkaHADR2fgWKUuL
CYvl2+MSXqQv6ZqeqWl3Hvl4zqlUW9eOG50YnUguAjZefoejBP5/bBY/NgPfTeqO
p1KxqCv4vZ9ZSJhXrIMLIXClgvB46LcvjnaatM6wba7EZM3fotSaL+oP3Y1gF1BO
qYb3V0xtZaSVrZIVnh/nkCYz5vRuURGwAxoZGJBpsvB+hZtQc14pnlokuL6qOMFA
zfDa8kz4cn9oVqJT2gYuMoP+VBwz0oVtNZmj9d02U0b0Z5oG4ZcyD0uBNUZU+AMH
OpO44yA3JFcNv+7ygSNavWLRzf82sly1QN4HIhQZt476HVc79+DWzUwnWpY7UyB9
xoYTbKtZNya/SaNd5OWknmwvSof+iUbQGKvFaOo0dpyWRmde+edohzSqlMR9hn2G
9ZLKGRcFKWdl/Kslz0eq
=D6vl
-----END PGP SIGNATURE-----
