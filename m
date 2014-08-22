From: Kevin Cox <kevincox@kevincox.ca>
Subject: Re: Wireshark Dissector and the Future
Date: Fri, 22 Aug 2014 16:58:21 -0400
Message-ID: <53F7AEED.2070508@kevincox.ca>
References: <53E76408.9050000@kevincox.ca> <CAPYLRzhACDou35EOpeNp5zXf2uFRCT0EeYpTXrVGD0gYS9GQCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41108 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaHVU6Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 16:58:25 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so6919311iec.23
        for <ceph-devel@vger.kernel.org>; Fri, 22 Aug 2014 13:58:24 -0700 (PDT)
In-Reply-To: <CAPYLRzhACDou35EOpeNp5zXf2uFRCT0EeYpTXrVGD0gYS9GQCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 21/08/14 12:15, Gregory Farnum wrote:
> On Sun, Aug 10, 2014 at 5:22 AM, Kevin Cox <kevincox@kevincox.ca> wro=
te:
>> 3. Run the network traffic of automated tests (such as teuthology)
>> through Wireshark and check the warnings/errors.
>
> A little late now (I've been on vacation) but I just want to register
> a vote against option #1 =E2=80=94 nobody is going to consistently re=
member
> that. :) I suspect option #3 is the most practical and most likely to
> keep it up to date; I don't know exactly how would be best to dump th=
e
> network traffic but I think that it should be fairly simple to dump
> any gathered data into wireshark as part of a short teuthology test
> that's in all the suites.
I agree that #1 is probably not the long term solution.

=46or running test traffic through wireshark there are two options, one=
 is
to capture the traffic, then analyse in a separate step, or we could
just analyse on the fly.  While just dumping the network traffic and
analysing later is easier to set up it is probably better to run the
analysis on the fly as the output will be a lot smaller (unless we want
to keep the packet capture for another reason).

Actually capturing the traffic is not too hard.  Either tcpdump or
tshark can be used to capture the packets.  Then tshark can be used to
analyse them.  Of course if tshark is doing the dumping it can analyse
on the fly.  The display filter '-Y' option  can be used to restrict th=
e
output to "interesting" features.  Many are already filterable by the
dissector (for example '-Yceph.ver.tooold||ceph.ver.toonew' will detect
encoding versions not supported by the dissector) and more could be
added as desired.

I don't however, know anything about teuthology so I will need to look
into how to integrate that.

Cheers,
Kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlP3ru0ACgkQwHWKOzTVLnROSQD/dttXUaZLBH5DKXcOnjod/B8M
xZhEWDgjImDJpe+JSwAA/0EJGe0NvK6HldoNblDs8Mg+EWKslIvd7Z49p32KJjbc
=3DHwX/
-----END PGP SIGNATURE-----


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
