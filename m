From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Small feature request for v0.55 release
Date: Wed, 14 Nov 2012 15:44:57 -0800
Message-ID: <CANLRBozXfYw6q1xFh-A_X0tccBVp+PwEX+KG86vYwqjAE83nZQ@mail.gmail.com>
References: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55052 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab2KNXo6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 18:44:58 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1083909vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 15:44:57 -0800 (PST)
In-Reply-To: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Nov 14, 2012 at 1:53 PM, Nick Bartos <nick@pistoncloud.com> wrote:
> I see that v0.55 will be the next stable release.  Would it be
> possible to use standard tarball naming conventions for this release?
>
> If I download http://ceph.com/download/ceph-0.48.2.tar.bz2, the top
> level directory is actually ceph-0.48.2argonaut, not ceph-0.48.2 as
> expected.  Downloading
> http://ceph.com/download/ceph-0.48.2argonaut.tar.bz2 yields a slightly
> more expected result, but still isn't the typical *ix style of
> name-version.tar.  This is very annoying in some build systems, which
> have that assumption.  I've actually been extracting the tarballs,
> renaming the top level directory, then recompressing them.
>
> It would be great if we didn't have to do that with the next release,
> e.g. extracting http://ceph.com/download/ceph-0.55.tar.bz2 would yield
> a top level directory of ceph-0.55.

+1

I'm glad to see I'm not the only one doing this. Gentoo's ebuild
system doesn't respond kindly to this either.

t.
