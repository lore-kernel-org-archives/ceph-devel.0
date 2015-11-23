From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Crc32 Challenge
Date: Mon, 23 Nov 2015 09:47:16 -0600
Message-ID: <CAJ4mKGYiEhD-kLjjQ_nuDCTajuSpc_S+vivFbr-OjaU-LP_f_g@mail.gmail.com>
References: <564B5B04.8040503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38777 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbbKWPrR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 10:47:17 -0500
Received: by wmec201 with SMTP id c201so110943867wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 07:47:16 -0800 (PST)
In-Reply-To: <564B5B04.8040503@canonical.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chris holcombe <chris.holcombe@canonical.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 17, 2015 at 10:51 AM, chris holcombe
<chris.holcombe@canonical.com> wrote:
> Hello Ceph Devs,
>
> I'm almost certain at this point that I have discovered a major bug i=
n
> ceph's crc32c mechanism.  http://tracker.ceph.com/issues/13713 I'm to=
tally
> open to be proven wrong and that's what this email is about.  Can som=
eone
> out there write a piece of code using an outside library that produce=
s the
> same crc32c checksums that Ceph does?  If they can I'll close my bug =
and
> stand corrected :).  I've tried 3 python libraries and 1 rust library=
 so far
> and my conclusions are 1) they are all in agreement and 2) they all p=
roduce
> different checksums than ceph's checksums
> https://github.com/ceph/ceph/blob/83e10f7e2df0a71bd59e6ef2aa06b52b186=
fddaa/src/test/common/test_crc32c.cc#L21
>
> Start small and see if you can verify the "foo bar baz" checksum and =
then
> try some of the others.
>
> For a known good checksum to test your program against use this:
> http://www.pdl.cmu.edu/mailinglists/ips/mail/msg04970.html  In there =
Mark
> Bakke talks about a 32 byte array of all 00h should produce a checksu=
m of
> 8A9136AA.  Printing that with python in decimal: 2324772522
>
> The implications of this are unfortunately tricky.  If I'm right and =
we fix
> ceph's algorithm then it won't be able to talk to any previous versio=
n of
> ceph past the beginning protocol handshake. There would have to be a
> mechanism introduced so that any x and older version would speak the
> previous crc and anything y and newer would speak the new version.  A=
nother
> option is we could break ceph's crc code out into a library and make =
that
> available to everyone and call it ceph-crc32c.

I haven't checked the source for exactly where we use CRC32s, but I
think the basic messenger protocol isn't checksummed =E2=80=94 we ought=
 to be
able to use the feature bits exchanged in the protocol handshake to
decide which version of the crc to use?
At least if it's worth changing; I've no idea about that.
-Greg

>
> Thanks!
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
