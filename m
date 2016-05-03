From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: building boost statically
Date: Tue, 3 May 2016 10:28:05 -0600
Message-ID: <CAANLjFp-mBz3Rzuv6DDR6mdaCQ9Lf5GLaEd9Rk30--uQWQQ-ug@mail.gmail.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
	<CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
	<CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
	<alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
	<BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
	<alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
	<alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33758 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbcECQ2G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 12:28:06 -0400
Received: by mail-oi0-f51.google.com with SMTP id v145so32732304oie.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 09:28:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jesse Williamson <jwilliamson@suse.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I really wanted to use intrusive maps that was in boost 1.59 for the
WPQ. So I think there are multiple places that could leverage the new
boost features if it were available.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJXKNGPCRDmVDuy+mK58QAAr3cP+wbXVtaBFTkvJQSAH+TQ
5C8NOQcmph0Nmf/tL9byox8USML8OS4RiKh2EI6MnbRLa6ZrE65irnkBEXX3
b+OM1JysNbLnyo+myTn7MEtGfjQCG4rsm0JtHX69cs35kLRtLdvRj7YTiWkf
MWjt9nIuiLDWJH9TyhO9aBQp+t52m3u1Lxrl7XL9ie7vFq8eQp4yXvESvj9t
5xawxNp3xaDLZHt48qA2kmuA1S9oqymqNWJU4yqeKqZY1OtGE1FN5bg1cn0d
ApvuI250jyWEV0pjyp0T8Auq+E0x7+Fn52FRfyZzMNO3FeRzAMn+y2z8djT9
XHf6j3Y/PAF9udASVguaUHPg4OnUihM+ffGmMCkSrpoNcc/cWRpB8bRyG/12
UKbwwREYQ+UhENohoblkl3zTqn3E7891/d34mObcmZUQKy5i5i1l+wl33cZO
NtXY/xC567kXAUv1zKEx+2bSUhQTtA4rJh7Kqrgk/lyJrNozRsK3lhQbucx7
a45VA2GW9RqI9zX9GSiDDZiZinOMExcN+E+5DadsdeOPGqswE7lgmDF7BH0L
TIJjnr+4r4vSQ+4/8OEHP05Gh5OZv5p/penzF+LCvkboYDDZGfwwbfbNE04P
96An6l8Yf+L2XbhJfptR0155zjhyBRCvm8FK8M6O/3BckSDEC7IvYVMVgp1F
RB99
=SK2q
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Sun, May 1, 2016 at 9:14 AM, Sage Weil <sage@newdream.net> wrote:
> On Sun, 1 May 2016, Jesse Williamson wrote:
>> On Sat, 30 Apr 2016, Allen Samuels wrote:
>>
>> > Let's not wait.
>> >
>> > As another option. If all we're looking for is "small_vector", then I looked
>> > at taking the equivalent out of the Folly library a while ago. It looked
>> > like it would be relatively easy to hack up the one header file to make it
>> > standalone.
>>
>> There's a utility in boost, "bcp", that might be useful:
>>
>> http://www.boost.org/doc/libs/1_60_0/tools/bcp/doc/html/index.html
>
> Given that this is the only piece we want immediately (that i know of),
> that there would be significant work to either pull boost inline as a
> submodule *or* to build and ship a proper package, let's go the bcp route
> for now.
>
> Jesse, is this something you can tackle?
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
