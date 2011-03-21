From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: RPM issues
Date: Mon, 21 Mar 2011 09:31:05 -0700
Message-ID: <AANLkTi=fABKn-ht+z6d9STxucv+wA7++UOUd7WyrOivd@mail.gmail.com>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
	<20110321160950.GA17804@dreamer>
	<AANLkTi=Q=49N5zKB51+VHimOM5K4Vn+TovwtqS_Zz2Oe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35773 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab1CUQbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 12:31:07 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6D40DC067
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 09:31:07 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1CAA9C066
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 09:31:06 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1563039eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 09:31:05 -0700 (PDT)
In-Reply-To: <AANLkTi=Q=49N5zKB51+VHimOM5K4Vn+TovwtqS_Zz2Oe@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Mon, Mar 21, 2011 at 9:22 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> The more annoying dependencies are things like GTK2, which don't
> really affect the behavior of the rest of the project, but which will
> have to be "mandatory" in the RPM, it seems. Also, as I said, tcmalloc
> will present somewhat of a problem because it's just not packaged on
> RedHat/CentOS at the moment for 64-bit. I will report a bug with Red
> Hat and see what they think...
I don't think it's okay to require gtk2 just for the gceph that nobody
uses...That at least should be an easy choice to kick out if
necessary.
tcmalloc is harder; we should get one of our lab users to submit a
ticket for that. If necessary I believe google-perftools makes it
pretty easy to build tcmalloc-minimal, which includes only the memory
allocator -- we'd have to adjust our machinery a bit so the heap
checker hooks are separate from the detection of tcmalloc but it'd be
doable, and unlike the other config bits wouldn't fundamentally change
non-dev behaviors.

libatomic-ops is separate and while Lazslo has disabled that on armel
for the moment I believe I will be able to get that fixed up pretty
soon (just need to check up on my QEMU instance once I get in and
handle the autobuild bits).
-Greg
