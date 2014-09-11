From: Gregory Farnum <greg@inktank.com>
Subject: Re: set_alloc_hint old osds
Date: Thu, 11 Sep 2014 13:30:16 -0700
Message-ID: <CAPYLRziC+VH87z3A2yv1hRQX3H8-jSHuC1Or3T+VF2oe92xE4A@mail.gmail.com>
References: <CA+4uBUaAW7Umzg=jb-ksWx_ief2f1oq498KrBJY22ZBATU6EMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:42479 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146AbaIKUaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 16:30:19 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so11613594qgd.15
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 13:30:17 -0700 (PDT)
In-Reply-To: <CA+4uBUaAW7Umzg=jb-ksWx_ief2f1oq498KrBJY22ZBATU6EMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ilya Dryomov <idryomov@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Sep 11, 2014 at 1:19 PM, Samuel Just <sam.just@inktank.com> wrote:
> http://tracker.ceph.com/issues/9419
>
> librbd unconditionally sends set_alloc_hint.  Do we require that users
> upgrade the osds first?  Also, should the primary respond with
> ENOTSUPP if any replicas don't support it?

Something closer to the second option, I think...but then you run into
the problem where maybe the PG gets moved from a set of new OSDs to a
set of old ones that don't support the op. :/ I think for anything
that goes to disk you need to go through a full features-in-the-osdmap
process like we did for erasure coding.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
