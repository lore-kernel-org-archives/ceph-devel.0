From: Gregory Farnum <greg@inktank.com>
Subject: Re: "dup inode" error messages on MDS restart
Date: Tue, 23 Oct 2012 13:30:05 -0700
Message-ID: <CAPYLRzhkDKw2Av7F55yP_-Cez=1TJ1FY-5uDE8q8WN8DHK5TLA@mail.gmail.com>
References: <CADXA5U37_cXeLaYcCC4LM=o9YzqSr3994Jj0kS_XVS7D_1YFdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45373 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933884Ab2JWUaG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 16:30:06 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so630635lbo.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 13:30:05 -0700 (PDT)
In-Reply-To: <CADXA5U37_cXeLaYcCC4LM=o9YzqSr3994Jj0kS_XVS7D_1YFdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Roy <imjustmatthew@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

On Sat, Oct 20, 2012 at 6:42 AM, Matthew Roy <imjustmatthew@gmail.com> wrote:
> I'm getting some error messages along the lines of:
>
> 2012-10-20 09:35:09.038865 mds.0 [ERR] loaded dup inode 1000001d369
> [2,head] v18402 at ~mds0/stray8/1000001d369, but inode
> 1000001d369.head v18204 already exists at [valid file path]
> 2012-10-20 09:35:09.300528 mds.0 [ERR] loaded dup inode 10000007d44
> [2,head] v4493 at ~mds0/stray0/10000007d44, but inode 10000007d44.head
> v2220 already exists at [valid file path]
> 2012-10-20 09:35:09.382147 mds.0 [ERR] loaded dup inode 10000007d30
> [2,head] v4462 at ~mds0/stray6/10000007d30, but inode 10000007d30.head
> v2216 already exists at [valid file path]
>
> during MDS restart (shortly after the MDS goes up:active). Any
> thoughts on what to do about it?

Sorry this got dropped...
The warning message indicates that there are two copies of the inode
in the system, and it's definitely a bug. I *think* I've seen this
before in systems making heavy use of hard links and unlinking the
inode from the original location.
In any case, if you can reproduce with MDS debugging on, we might be
able to pull something out of the log. But probably we can't do
anything unless you can generate a log that has an inode going from
okay to having this happen...
-Greg
