From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: what's the exact meaning of cap?
Date: Wed, 1 Dec 2010 08:11:37 -0800
Message-ID: <AANLkTim=08MJ_0tcasrJZuqrrSVwB9tB5MPHLJOjx5_W@mail.gmail.com>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
	<Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net>
	<1291175401.2397.14.camel@node1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58646 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0LAQLk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 11:11:40 -0500
Received: by ewy5 with SMTP id 5so3601112ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Dec 2010 08:11:38 -0800 (PST)
In-Reply-To: <1291175401.2397.14.camel@node1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wchen <wchen@tnsoft.com.cn>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 30, 2010 at 7:50 PM, wchen <wchen@tnsoft.com.cn> wrote:
> hi, Sage,
>
> I'm reading the source code of ceph. Recently I'm very confused with
> struct InodeCap's issued, implemented, wanted fields. I just have a
> preliminary understanding of them, but what's the exact difference
> between them? there are lots of code to reflect the relation between
> them. Can you explain it for me? or any documents about it?
Unfortunately we don't have a lot of documentation about the source
code itself. Sage's thesis (which is available on the website) is the
best resource, and does describe caps some.

Briefly, caps are short for capabilities. They are issued by the MDS
to clients to describe what the client is allowed to do with an inode
and its associated file. There are capabilities to, for instance, let
the client buffer writes, cache reads, and adjust certain kinds of
metadata (mtime, et al).
The wanted capabilities are caps the client wants but doesn't have.
Issued caps are ones the client has been granted, and (IIRC)
implemented caps are a subset of the issued caps describing which caps
the client has actually made use of. It's useful for determining
whether the client has dirty metadata and whatnot. :)
-Greg
