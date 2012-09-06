From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Thu, 6 Sep 2012 11:02:20 -0700
Message-ID: <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com>
	<alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49473 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671Ab2IFSCX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 14:02:23 -0400
Received: by ieje11 with SMTP id e11so3519202iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 11:02:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: gcs@debian.hu, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 6, 2012 at 8:42 AM, Sage Weil <sage@inktank.com> wrote:
>
> Also, I noticed the automake patch removes CephException.java, added in
> the previous patch... probably an accident?

I left CephException out intentionally because it could be replaced by
generic exceptions in Java like IOException or FileNotFoundException.
My belief is that CephException (and specializations of this) will
need to be re-introduced as more error cases are covered. For example,
I think we'll want a CephBadFileDescriptor, but currently libcephfs
doesn't appear to return -EBADF (the client is crashing do to fd_map
assert). So, the Java wrappers should be as stable as the C API, but
both seem to need some loose ends tied up.

> Can't wait to pull this in!  BTW, Noah, do you know if this is still an
> issue?
>
>         http://tracker.newdream.net/issues/2778

It does appear that -ENOENT is now returned. I added a unit test that
expects FileNotFoundException and that works out nicely.

- Noah
