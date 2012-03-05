From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 1/3] java: add Java and C++ source files
Date: Mon, 5 Mar 2012 09:25:37 -0800
Message-ID: <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
References: <4F516A75.6020500@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48005 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab2CERZ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 12:25:57 -0500
Received: by pbcun15 with SMTP id un15so3001982pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 09:25:57 -0800 (PST)
In-Reply-To: <4F516A75.6020500@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, Mar 2, 2012 at 16:48, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> This adds all of the Java and C++ source files that make up the
> libcephfs Java wrappers package.
...
> +2. Set CEPHFS_CONF environment variable to point to a ceph.conf. This can be
> +ommitted if the desired configuration file can be found in a default location.

Simple typo, "omitted".

> +package net.newdream.ceph.fs;

I think com.ceph.fs would be a smaller punishment on the programmers
using this, and we have that domain name.

> diff --git a/src/java/test/CephMountCreateTest.java b/src/java/test/CephMountCreateTest.java
...
> + * This tests the mount root dir functionality. It creates an empty
> + * directory in the real root, then it re-mounts the file system
> + * with the empty directory specified as the root. Assertions are
> + * that the "/" in the normal mount is non-empty, and that "/" is
> + * empty in the mount with the empty directory as the root.

So the JUnit tests require a functional ceph cluster to run. Can you
state that explicitly in the source/docs, please?



I did not dig deep, and I'm no Java expert, but more client-side
support is exciting stuff!
