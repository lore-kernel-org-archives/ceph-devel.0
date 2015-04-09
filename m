From: James Page <james.page@ubuntu.com>
Subject: Re: tcmalloc issue
Date: Thu, 09 Apr 2015 15:13:20 +0100
Message-ID: <55268900.1090909@ubuntu.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net> <551C1514.3060607@ubuntu.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com> <55261528.7040607@ubuntu.com> <9E914F5BD7F48A4782456CEB550A422824489892@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39394 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbbDIONX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Apr 2015 10:13:23 -0400
In-Reply-To: <9E914F5BD7F48A4782456CEB550A422824489892@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Thanks Chaitanya

I've tested and uploaded the patched version to trusty-proposed - the
SRU team should accept that into testing in the next day or so - they
will update the bug when that happens.

On 09/04/15 10:00, Chaitanya Huilgol wrote:
> Hi James,
> 
> Please find source of the test program to verify this bug at
> http://pastebin.com/KAxQZARm compile it with  -ltcmalloc To test: 
> Export a non-default value of the cache size, for eg # export
> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=67108864 Run the test prog,
> For the buggy version you will see
> 
> Tcmalloc BUG! TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES: 67108864
> Internal Size: 33554432 different
> 
> With the bug fixed, you should see
> 
> "Tcmalloc Internal and Env cache size are same:67108864"
> 
> Hope this helps.
> 
> Regards, Chaitanya
> 
> -----Original Message----- From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James Page 
> Sent: Thursday, April 09, 2015 11:29 AM To: Somnath Roy; Sage Weil;
> ceph-maintainers@ceph.com Cc: ceph-devel@vger.kernel.org Subject:
> Re: tcmalloc issue
> 
> On 01/04/15 18:54, Somnath Roy wrote:
>> the tcmalloc bug is reported in the following link.
> 
>> http://code.google.com/p/gperftools/issues/detail?id=585
> 
>> So, do you want us to give the steps on how we are hitting the 
>> following trace or to reproduce the bug reported in the above
>> link ?
> 
>> If you are asking about hitting the stack trace I mentioned
>> below, it is just running ceph with lot of IOs for longer period
>> of time.
> 
> A minimal test case on how to reproduce the bug is sufficient; we
> can of course complete the second activity as well as soon as we
> have the update available.
> 
> Cheers
> 
> James
> 
> 
> -- To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail
> message is intended only for the use of the designated recipient(s)
> named above. If the reader of this message is not the intended
> recipient, you are hereby notified that you have received this
> message in error and that any review, dissemination, distribution,
> or copying of this message is strictly prohibited. If you have
> received this communication in error, please notify the sender by
> telephone or e-mail (as shown above) immediately and destroy any
> and all copies of this message in your possession (whether hard
> copies or electronically stored copies).
> 

- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJokAAAoJEL/srsug59jDnNsQAM1h8T+XbzbyxIk31MSGuh6h
TfFs4ioBmv6IJFn7E+Le3WES3/Yqmhy1Sf1AHr1QtQNARJ9qqmNuU+M7IA/84A6o
6VvxKBb3fHWGJieG/ymaVVREuJUHJLfEEaqyZOrh++nsyuzf/nAymKSzJMl5Z8o1
ugOSqS/GryXORW2nzuWIHeAh3feETyBe2rFBeYTYkR65fsFyjMK5DTHNLh0SFTR3
Elc+qdyamau+XwlRZOz9ClyELk0vP2iWsaNj/KJrXGm104aCaf2NhnsX4IW4yz1s
GkcPhaFtR/V9d/txS8syMmh9b01rQL6Zxje3n0C63E0/AqLqBHF7NX60xbeiqAvw
5xPTK/6e4dARPaIzzCgY4vEjX/CQ38kFQYikU6lSIww873LgtdPAzJp15axH40E4
1YdtMAoSva/hVwkkjPLK7a8SVg4+sfVOho4FH7m8TZmLxpMXSH+ea4SFN9s9uuEa
jnA3mo5T50EeXQuYvmO87A4ABKGrOwBOvr3rmF4q/GnHGdONI+fctQW7JSmjJsMH
WrOwAWyte+A5hRRySiPw7EXqrj583l/iTaP+pd0eyWTcpoKKxp3Ver2nIsWGEe7+
Mq1lFii8Z3Z4rqthjWEg4iVw3HwQS+ArjYISuy4TnQUcnbG/Avp0liMM4VaBndF1
gefiZ4SMb5yxPriWndzf
=H69u
-----END PGP SIGNATURE-----
