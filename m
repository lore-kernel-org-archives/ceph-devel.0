From: Nick Bartos <nick@pistoncloud.com>
Subject: Small feature request for v0.55 release
Date: Wed, 14 Nov 2012 13:53:04 -0800
Message-ID: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33069 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab2KNVxG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 16:53:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1336548iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 13:53:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I see that v0.55 will be the next stable release.  Would it be
possible to use standard tarball naming conventions for this release?

If I download http://ceph.com/download/ceph-0.48.2.tar.bz2, the top
level directory is actually ceph-0.48.2argonaut, not ceph-0.48.2 as
expected.  Downloading
http://ceph.com/download/ceph-0.48.2argonaut.tar.bz2 yields a slightly
more expected result, but still isn't the typical *ix style of
name-version.tar.  This is very annoying in some build systems, which
have that assumption.  I've actually been extracting the tarballs,
renaming the top level directory, then recompressing them.

It would be great if we didn't have to do that with the next release,
e.g. extracting http://ceph.com/download/ceph-0.55.tar.bz2 would yield
a top level directory of ceph-0.55.
