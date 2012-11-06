From: Gregory Farnum <greg@inktank.com>
Subject: Re: Cleaning up CephFS pool
Date: Tue, 6 Nov 2012 11:24:24 -0800
Message-ID: <CAPYLRziv=4a-oETkSLnAkXV=oUjZ5vEZFmSr626Km-NbNBLdLw@mail.gmail.com>
References: <5099631F.6090802@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:42497 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2KFTY0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 14:24:26 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so641047lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 11:24:24 -0800 (PST)
In-Reply-To: <5099631F.6090802@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Deleting files on CephFS doesn't instantaneously remove the underlying
objects because they could still be in use by other clients, and
removal takes time proportional to the size of the file. Instead the
MDS queues it up to be removed asynchronously. You should see the
number of objects counter going down over time.
-Greg

On Tue, Nov 6, 2012 at 11:21 AM, Denis Fondras <ceph@ledeuns.net> wrote:
> Hello all,
>
> I noticed that removing files on CephFS doesn't reclaim free space using
> ceph version 0.52(commit:e48859474c4944d4ff201ddc9f5fd400e8898173)
>
> I created 2 500GB files on CephFS (mounted with ceph-fuse) and then removed
> them. Now "rados df -p data" shows a 1GB usage :
> --8<----------------
> pool name       category                 KB      objects       clones
> degraded      unfound           rd        rd KB           wr        wr KB
> data            -                 1048580595       257696            0
> 0           0            0            0       628853   1629192870
> --8<----------------
>
> Is there a way to clean it up ? "rados cleanup" needs a prefix I don't
> know...
> Of course, I could "rm" every objects but what if I had other files that I
> don't want to remove from CephFS ?
>
> Thanks in advance,
> Denis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
