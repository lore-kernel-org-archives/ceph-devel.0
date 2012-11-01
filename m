From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Assertion failure in ceph_readlink()
Date: Thu, 1 Nov 2012 16:22:03 -0700
Message-ID: <CAPrxi595hE+TWXA=9FTg=3aKhEqR+-yuYQYcNFk=u4oi2mL5hA@mail.gmail.com>
References: <5092F9CB.7020501@cs.ucsc.edu>
	<5093022E.3040604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54698 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab2KAXWF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 19:22:05 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3235753vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 16:22:03 -0700 (PDT)
In-Reply-To: <5093022E.3040604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

>    filepath path(relpath);
>    Inode *in;
> -  int r = path_walk(path, &in);
> +  int r = path_walk(path, &in, false);
>    if (r < 0)
>      return r;

Fixes both cases. Thanks!
