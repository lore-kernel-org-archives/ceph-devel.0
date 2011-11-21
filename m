From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: The costs of logging and not logging
Date: Mon, 21 Nov 2011 12:08:35 -0800
Message-ID: <CAB2gnbVV3guH3R8_RkMkaL=Sk08HqmJwYqpf8KvvquX8rVrk5Q@mail.gmail.com>
References: <4ECA7C83.1090702@dreamhost.com>
	<Pine.LNX.4.64.1111211047330.24847@cobra.newdream.net>
	<4ECAA71C.10202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47386 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab1KUUIg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 15:08:36 -0500
Received: by wwe5 with SMTP id 5so11066336wwe.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2011 12:08:35 -0800 (PST)
In-Reply-To: <4ECAA71C.10202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Nov 21, 2011 at 11:31, Mark Kampe <mark.kampe@dreamhost.com> wr=
ote:
> But binary logging:
> =C2=A01. is much (e.g. 4-10x) smaller (especially for standard header=
 info)
> =C2=A02. is much faster to take (no formatting, less data to copy)
> =C2=A03. is much faster to process (no re-parsing)
> =C2=A04. is smaller to store on disk and faster to ship for diagnosis

Binary logging is great, and certainly do-able. Here is what I think
the negatives are:

The method by which binary logs can achieve reduced sizes, especially
when the bulk of the data is ascii-based context, is using schemas.
=46or example, log the function name as an enum and extrapolate back to
the readable form in post-processing. This is especially cumbersome
for code bases with ad-hoc logging and lots of churn, as the schema
must continually be maintained.

-Noah
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
