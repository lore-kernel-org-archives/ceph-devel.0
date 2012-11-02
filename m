From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Assertion failure in ceph_readlink()
Date: Fri, 2 Nov 2012 07:54:08 -0700
Message-ID: <CAPrxi58x2Vqz+kJYdHjU6n+=j+Z+pFU2SqGouvA8VozzN5dt5g@mail.gmail.com>
References: <5092F9CB.7020501@cs.ucsc.edu>
	<5093022E.3040604@inktank.com>
	<CAPrxi595hE+TWXA=9FTg=3aKhEqR+-yuYQYcNFk=u4oi2mL5hA@mail.gmail.com>
	<509321F6.9060200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62385 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2KBOyK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 10:54:10 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3813027vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 07:54:08 -0700 (PDT)
In-Reply-To: <509321F6.9060200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 1, 2012 at 6:29 PM, Sam Lang <sam.lang@inktank.com> wrote:
> On 11/01/2012 06:22 PM, Noah Watkins wrote:
>
> I discovered a few more bugs in path_walk() for the symlink case while
> debugging your problem.  I've pushed fixes and a test case to
> wip-fix-symlinks.

Thanks! These are not giving me any problems.
