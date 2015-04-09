From: James Page <james.page@ubuntu.com>
Subject: Re: tcmalloc issue
Date: Thu, 09 Apr 2015 06:59:04 +0100
Message-ID: <55261528.7040607@ubuntu.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net> <551C1514.3060607@ubuntu.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36940 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbDIF7G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Apr 2015 01:59:06 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 01/04/15 18:54, Somnath Roy wrote:
> the tcmalloc bug is reported in the following link.
> 
> http://code.google.com/p/gperftools/issues/detail?id=585
> 
> So, do you want us to give the steps on how we are hitting the
> following trace or to reproduce the bug reported in the above link
> ?
> 
> If you are asking about hitting the stack trace I mentioned below,
> it is just running ceph with lot of IOs for longer period of time.

A minimal test case on how to reproduce the bug is sufficient; we can
of course complete the second activity as well as soon as we have the
update available.

Cheers

James


- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJhUoAAoJEL/srsug59jD/WoQAJqZYJ82xcDDxuD5C9RnUXha
2UtYNXZTK9O1NdiLqsNw14SPKtOQ6IDyfJjvB2v+ddfvRxhlfSM6LmC4ERa0t0SW
a3tfwx9fQ0WEz2r35nkupHwo+Z4yfTAuHgGom3rH6tq4gbAInn7J+4unsxghV1kf
op/c9qNJZV9jqfqMZFFgwwptK7rJ4mKJDvGIRU4ddc9HEKnqukJHQAHh3zUlNXC9
6y11RAHFh0FcgEEHys3o/ui0JVzNjmP8HJXISzyWSqO6J2NxqRNYoKGTk81zBvrf
IkWDDujCcTQoAU2aW6ERRvG1Dkzc9oTLdcmb0gGCKKpqa1m1GjnqS1B39rjheXio
HK5L9HO11Fs+9uONBXWvI6P0GXi3UQoe1NaVQB85EL+NPFbTdKr9zw8nOyyqZ9Y5
X55uVRAscLV/jb1vYIU5JxSNWof4BtPSjQzq29cithPqfWyF2N+eyQbCrAaIu1oP
QGSnryCsoWDARyvjMIFxcsd2X6nFnOd9DMgumi6O1ksKAe1P38k1iUWFwXXutby6
6eTdZtOj9Wc4VNRPb8SYBkBSlU+dCgRVMlNUImcCKWR6w8+Y9BbQU7OwQGEzj9Xw
f9sdi+4JA04l/BXdAtlVwSj4uSm2Q6R/YK4szpRGs24EOV6dX+aCMK5ezBIliPo0
D/7ZD03rXkiBzHuBqiay
=066U
-----END PGP SIGNATURE-----
