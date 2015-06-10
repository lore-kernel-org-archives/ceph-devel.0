From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Build RPMs from git
Date: Wed, 10 Jun 2015 09:44:37 -0600
Message-ID: <CAANLjFprkpfMdCk5HKMtCt1r2y8Og+8p2b3BjgxsoYWynCV8oA@mail.gmail.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
	<581259457.12927282.1433946627668.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37394 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964887AbbFJPoj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 11:44:39 -0400
Received: by wifx6 with SMTP id x6so51726451wif.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 08:44:37 -0700 (PDT)
In-Reply-To: <581259457.12927282.1433946627668.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jun 10, 2015 at 8:30 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> Here's how I do it.
>
> 1. Git clone
>
> 2. ./do_autogen.sh
>
> 3. ./configure --without-radosgw --without-fuse --without-tcmalloc --without-libatomic-ops --without-libxfs
>
> 4. # The "configure" step above creates a ceph.spec with the proper version number, which you can then copy:
>    cp ceph.spec ~/rpmbuild/SPECS/
>
> 5. # The "configure" step above also creates a Makefile, so you can run "make dist-bzip2" to get a properly-versioned tarball:
>    make dist-bzip2

This is really helpful, I was able to figure out what was needed in a
tarball manually, but this is what I was really looking for to create
the tarball.

Is there anyway to skip this step like in the deb build for really
fast builds? I guess if I don't have retar a dozen times to tweak
something every time because I forgot to add something to the tarball,
it won't be so bad...

> 6. # Now move the tarball in to place, along with the .patch file:
>    rm ~/rpmbuild/SOURCES/*
>    mv *.bz2 ~/rpmbuild/SOURCES/
>    cp rpm/*.patch ~/rpmbuild/SOURCES/
>
> 7. # Build a source RPM:
>    rpmbuild -bs ~/rpmbuild/SPECS/ceph.spec
>
> 8. # Lastly, rebuild that SRPM in mock:
>    mock -r epel-7-x86_64 rebuild ~/rpmbuild/SRPMS/ceph-....src.rpm
>
>
> This whole process needs to be improved :) We're moving towards getting rid of the ./configure operation in step #3 since that is only done in order to figure out the right version number for steps #4 and #5.
>
> Also, the .patch file in step #6 could be implemented in some other way. We could use sed during %prep to make the changes, which would avoid using a .patch file. Or, since src/init-ceph.in is an autoconf template anyway, we could conditionalize this with autoconf to print "Default-Start: 2 3 4 5" and "Default-Stop: 0 1 6" on Debian, and leave the values blank on Red Hat.

----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
