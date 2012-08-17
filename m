From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to know the Rados pools path.
Date: Fri, 17 Aug 2012 09:09:25 -0700
Message-ID: <CADvuQRGnuVkCXhsmbpbfPruK=z9gtuDsGn68swngiUm895bxpA@mail.gmail.com>
References: <loom.20120816T141547-773@post.gmane.org> <502CF312.7030008@widodh.nl>
 <CAPYLRzgYqR7RPuE6o-SzL4kGYMZdPDpRquQsqy4mnPSaaLPSSQ@mail.gmail.com> <loom.20120817T062906-355@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54375 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab2HQQJr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 12:09:47 -0400
Received: by lbbgj3 with SMTP id gj3so2209941lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 09:09:46 -0700 (PDT)
In-Reply-To: <loom.20120817T062906-355@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 16, 2012 at 9:31 PM, ramu <ramu.freesystems@gmail.com> wrote:
>     Thank u for your reply,Is there any option for the created pool is
>  mounting to another volume.

RADOS pools are not filesystems. They cannot be mounted.

The Ceph Distributed File System stores it's metadata in one pool
(default "metadata") and data in one or more pools (default "data"),
but that is more like a database that is actually stored in a file --
that doesn't mean every file knows SQL.
