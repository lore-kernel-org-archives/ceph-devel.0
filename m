From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to integrate ceph with opendedup.
Date: Tue, 31 Jul 2012 11:35:50 -0700
Message-ID: <CADvuQRHFEa=zetvNwZCzRuy+KjSm95xCgYyjs1y5nbNrOVb82g@mail.gmail.com>
References: <loom.20120731T111530-776@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59744 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab2GaSgL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 14:36:11 -0400
Received: by vcbfk26 with SMTP id fk26so6159850vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 11:36:10 -0700 (PDT)
In-Reply-To: <loom.20120731T111530-776@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 31, 2012 at 2:18 AM, ramu <ramu.freesystems@gmail.com> wrote:
> I want to integrate ceph with opendedup(sdfs) using java-rados.
> Please help me to integration of ceph with opendedup.

It sounds like you could use radosgw and just use S3ChunkStore.

If you really want to implement your own ChunkStore straight on top of
RADOS, well, it sounds like FileBasedChunkStore should be an easy
model; copy-paste it, and replace all file operations with RADOS
object reads/writes/etc.


BTW it sounds like SDFS is not really a distributed file system, or at
least the architecture slides don't point at anything about multiple
mounting the same metadata store. It sounds like they made all
operations for one file system go through the same metadata server.
