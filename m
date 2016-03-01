From: Marcus Watts <mwatts@redhat.com>
Subject: Re: ceph + -lssl
Date: Mon, 29 Feb 2016 20:31:02 -0500
Message-ID: <20160301013102.GB25207@degu.b.linuxbox.com>
References: <20160224050912.GA6585@degu.b.linuxbox.com>
 <CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
 <20160227075001.GA21701@degu.b.linuxbox.com>
 <56D19B44.9080005@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47454 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcCABbG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Feb 2016 20:31:06 -0500
Content-Disposition: inline
In-Reply-To: <56D19B44.9080005@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Feb 27, 2016 at 01:49:08PM +0100, Willem Jan Withagen wrote:
> On 27-2-2016 08:50, Marcus Watts wrote:
> > On Fri, Feb 26, 2016 at 12:43:24PM -0800, Yehuda Sadeh-Weinraub wrote:
> >> I rebased these 4 commits on top of a recent master, and here's the
> >> new pull request:
> >> https://github.com/ceph/ceph/pull/7825
> >>
> >> On Tue, Feb 23, 2016 at 9:09 PM, Marcus Watts <mwatts@redhat.com> wrote:
> >>> I've been working on better integrating ssl int ceph.
> > ...
> > 
> > Thanks Yehuda for doing this.
> > 
> > Matt pointed out in the pull request that cmake builds were failing
> > on this branch.  I've pushed a commit to fix that.
> 
> I know I'm not doing the work, but would it be possible to base the work
> on for example LibreSSL from OpenBSD or BoringSSL from Google.
> 
> From the things I've seen and read about it, these libraries are (good)
> attempts to shed a lot of cruft of openssl resulting in a compacter and
> better build lib.
> 
> Next to the history of OpenBSD which is "not all that bad" for security.
> And I'd expect Ceph to only use the more modern parts of the lib, and
> thus historical compatibility is not that important here.
> --WjW
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I looked at libressl a bit.  It still has the same license emcumbrances
as openssl.  So no real win there.  And, since it's not packaged as part
of many linux distributions, the gpl/ssleay license incompatibility issue
becomes a real problem here.  Hopefully a future version of libressl will
adopt a plain bsd license.  I know they were working hard to discard
the crufty openssl build system, a good thing.  When I worked with an
earlier version of openssl (adding a new hash or encryption algorithm,
I don't remember which today), I remember being disappointed at finding
internal interfaces that just assumed various max sizes of things.  I hope
the libressl folks work on making those things better too.

I'm not familiar with google's "boringSSL".  Do you have some references
for it?  I won't have the time to look at it right now - but I don't mind
learning at least a bit more about it.  I see from wikipedia that it's
yet another fork of openssl - will they fix the license issue?

I did look (mostly superficially) at,
	botan libressl gnutls matrixssl mbed wolfssl cryptlib nss
	& apple's "secure transport"
It was mostly superficial because my first question was "are there
a lot of other people using this" aka "am I going to be debugging
and supporting this myself"?

					-Marcus
