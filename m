From: Sage Weil <sage@newdream.net>
Subject: Re: Crc32 Challenge
Date: Mon, 23 Nov 2015 07:50:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511230748460.11017@cobra.newdream.net>
References: <564B5B04.8040503@canonical.com> <CAJ4mKGYiEhD-kLjjQ_nuDCTajuSpc_S+vivFbr-OjaU-LP_f_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34792 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbKWPu7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 10:50:59 -0500
In-Reply-To: <CAJ4mKGYiEhD-kLjjQ_nuDCTajuSpc_S+vivFbr-OjaU-LP_f_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: chris holcombe <chris.holcombe@canonical.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 23 Nov 2015, Gregory Farnum wrote:
> On Tue, Nov 17, 2015 at 10:51 AM, chris holcombe
> <chris.holcombe@canonical.com> wrote:
> > Hello Ceph Devs,
> >
> > I'm almost certain at this point that I have discovered a major bug in
> > ceph's crc32c mechanism.  http://tracker.ceph.com/issues/13713 I'm totally
> > open to be proven wrong and that's what this email is about.  Can someone
> > out there write a piece of code using an outside library that produces the
> > same crc32c checksums that Ceph does?  If they can I'll close my bug and
> > stand corrected :).  I've tried 3 python libraries and 1 rust library so far
> > and my conclusions are 1) they are all in agreement and 2) they all produce
> > different checksums than ceph's checksums
> > https://github.com/ceph/ceph/blob/83e10f7e2df0a71bd59e6ef2aa06b52b186fddaa/src/test/common/test_crc32c.cc#L21
> >
> > Start small and see if you can verify the "foo bar baz" checksum and then
> > try some of the others.
> >
> > For a known good checksum to test your program against use this:
> > http://www.pdl.cmu.edu/mailinglists/ips/mail/msg04970.html  In there Mark
> > Bakke talks about a 32 byte array of all 00h should produce a checksum of
> > 8A9136AA.  Printing that with python in decimal: 2324772522
> >
> > The implications of this are unfortunately tricky.  If I'm right and we fix
> > ceph's algorithm then it won't be able to talk to any previous version of
> > ceph past the beginning protocol handshake. There would have to be a
> > mechanism introduced so that any x and older version would speak the
> > previous crc and anything y and newer would speak the new version.  Another
> > option is we could break ceph's crc code out into a library and make that
> > available to everyone and call it ceph-crc32c.
> 
> I haven't checked the source for exactly where we use CRC32s, but I
> think the basic messenger protocol isn't checksummed ? we ought to be
> able to use the feature bits exchanged in the protocol handshake to
> decide which version of the crc to use?
> At least if it's worth changing; I've no idea about that.

The difference turned out to be a reasonable common convention of doing an 
xor ~0 with the final result.  We don't do that, and I don't think we 
should since it would (1) be a really painful change and (2) makes 
chaining together the xor values of multiple buffers more error-prone.  
So we're off the hook!

sage
