From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Crc32 Challenge
Date: Wed, 18 Nov 2015 10:33:52 +0100
Message-ID: <CABZ+qqnJu-9Dp2bTShm=96qfPCqqp8asFn=oio4JLzF2uXBzVA@mail.gmail.com>
References: <564B5B04.8040503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36172 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbbKRJef (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 04:34:35 -0500
Received: by lbblt2 with SMTP id lt2so20998049lbb.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 01:34:33 -0800 (PST)
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com. [209.85.217.176])
        by smtp.gmail.com with ESMTPSA id l128sm296030lfe.27.2015.11.18.01.34.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 01:34:32 -0800 (PST)
Received: by lbbkw15 with SMTP id kw15so21018617lbb.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 01:34:31 -0800 (PST)
In-Reply-To: <564B5B04.8040503@canonical.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chris holcombe <chris.holcombe@canonical.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I checked the partial crc after each iteration in google's python
implementation and found that the crc of the last iteration matches
ceph's [1]:

>>> from crc32c import crc
>>> crc('foo bar baz')
crc 1197962378
crc 3599162226
crc 2946501991
crc 2501826906
crc 3132034983
crc 3851841059
crc 2745946046
crc 1047783679
crc 767476524
crc 4269731756
crc 4119623852

After finalize (crc ^ 0xFFFFFFFF) the crc becomes:

175343443L

So it looks like ceph_crc32c just isn't doing that final XOR step.

>>> 4119623852 ^ 0xFFFFFFFF
175343443

Cheers, Dan

[1] From test_crc32c.cc

const char *a = "foo bar baz";
ASSERT_EQ(4119623852u, ceph_crc32c(0, (unsigned char *)a, strlen(a)));

On Tue, Nov 17, 2015 at 5:51 PM, chris holcombe
<chris.holcombe@canonical.com> wrote:
> Hello Ceph Devs,
>
> I'm almost certain at this point that I have discovered a major bug in
> ceph's crc32c mechanism.  http://tracker.ceph.com/issues/13713 I'm totally
> open to be proven wrong and that's what this email is about.  Can someone
> out there write a piece of code using an outside library that produces the
> same crc32c checksums that Ceph does?  If they can I'll close my bug and
> stand corrected :).  I've tried 3 python libraries and 1 rust library so far
> and my conclusions are 1) they are all in agreement and 2) they all produce
> different checksums than ceph's checksums
> https://github.com/ceph/ceph/blob/83e10f7e2df0a71bd59e6ef2aa06b52b186fddaa/src/test/common/test_crc32c.cc#L21
>
> Start small and see if you can verify the "foo bar baz" checksum and then
> try some of the others.
>
> For a known good checksum to test your program against use this:
> http://www.pdl.cmu.edu/mailinglists/ips/mail/msg04970.html  In there Mark
> Bakke talks about a 32 byte array of all 00h should produce a checksum of
> 8A9136AA.  Printing that with python in decimal: 2324772522
>
> The implications of this are unfortunately tricky.  If I'm right and we fix
> ceph's algorithm then it won't be able to talk to any previous version of
> ceph past the beginning protocol handshake. There would have to be a
> mechanism introduced so that any x and older version would speak the
> previous crc and anything y and newer would speak the new version.  Another
> option is we could break ceph's crc code out into a library and make that
> available to everyone and call it ceph-crc32c.
>
> Thanks!
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
