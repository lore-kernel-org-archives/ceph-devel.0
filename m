From: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Subject: RE: tcmalloc issue
Date: Thu, 9 Apr 2015 09:00:36 +0000
Message-ID: <9E914F5BD7F48A4782456CEB550A422824489892@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net>
 <551C1514.3060607@ubuntu.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
 <55261528.7040607@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0066.outbound.protection.outlook.com ([157.56.110.66]:3360
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933539AbbDIJQk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Apr 2015 05:16:40 -0400
In-Reply-To: <55261528.7040607@ubuntu.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

Please find source of the test program to verify this bug at http://pastebin.com/KAxQZARm
compile it with  -ltcmalloc
To test:
Export a non-default value of the cache size, for eg
# export TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=67108864
Run the test prog, For the buggy version you will see

Tcmalloc BUG! TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES: 67108864 Internal Size: 33554432 different

With the bug fixed, you should see

"Tcmalloc Internal and Env cache size are same:67108864"

Hope this helps.

Regards,
Chaitanya

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James Page
Sent: Thursday, April 09, 2015 11:29 AM
To: Somnath Roy; Sage Weil; ceph-maintainers@ceph.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: tcmalloc issue

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 01/04/15 18:54, Somnath Roy wrote:
> the tcmalloc bug is reported in the following link.
>
> http://code.google.com/p/gperftools/issues/detail?id=585
>
> So, do you want us to give the steps on how we are hitting the
> following trace or to reproduce the bug reported in the above link ?
>
> If you are asking about hitting the stack trace I mentioned below, it
> is just running ceph with lot of IOs for longer period of time.

A minimal test case on how to reproduce the bug is sufficient; we can of course complete the second activity as well as soon as we have the update available.

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

