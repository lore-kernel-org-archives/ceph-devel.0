From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Need some help with the RBD Java bindings
Date: Thu, 22 Aug 2013 07:43:31 -0700
Message-ID: <CA+Hcz5_BzObbwJ=qu+mfdgmawNdTVe0=TLvrowjZV=nJOQWHQA@mail.gmail.com>
References: <520CF90B.2070106@42on.com>
	<CA+Hcz59PTw9u6s8J3pZpbPgyMdh78zd3qzkBmb_+S+w4_JjMOg@mail.gmail.com>
	<CA+Hcz58M-fz_qq6ZgEvxovj3OEGF6zG8TSFtsOOMkKUo-YZznw@mail.gmail.com>
	<5214AE76.7070304@42on.com>
	<CA+Hcz5_uDJcOv_RiSswGmu6sfikp=rdX4=rn3WrxZA21DsHSMg@mail.gmail.com>
	<5215ADB9.2010607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:50735 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3HVOnc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 10:43:32 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so1640777veb.9
        for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 07:43:31 -0700 (PDT)
In-Reply-To: <5215ADB9.2010607@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 21, 2013 at 11:20 PM, Wido den Hollander <wido@42on.com> wrote:
>
> Yes, seems like a good thing to do. I wasn't sure myself when I was writing
> the bindings on how the packaging should be.

I'm not entirely sure either. With JNI it's pretty simple, but JNA
introduces all sorts of additional classes. Do you know of any large
projects using JNA? It'd be nice to find some references to examine.

> One of the things I haven't tested thoroughly enough is if you as a user of
> the bindings are able to crash the JVM. Since that should never happen.

I think that JNA is safe in that it will prevent itself from being
used incorrectly, but I don't think anything would prevent someone
from say creating a pointer off into space with JNA and then passing
it to a external library that would dereference it.
