From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: handling lost objects
Date: Thu, 21 Oct 2010 16:59:36 -0700
Message-ID: <AANLkTimdhDv_Xd5JanvOhso08GN9DbUVv59LZukSqKN-@mail.gmail.com>
References: <Pine.LNX.4.64.1010211631150.27821@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34701 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab0JUX7h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Oct 2010 19:59:37 -0400
Received: by fxm16 with SMTP id 16so188021fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Oct 2010 16:59:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010211631150.27821@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Oct 21, 2010 at 4:41 PM, Sage Weil <sage@newdream.net> wrote:
> I wonder if a better strategy would be to _not_ delete the objects, b=
ut to
> create a placeholder, and mark it such that any attempts to read it r=
eturn
> EIO or ESTALE or something along those lines. =A0That would let an
> application know when data is gone instead of 'silently' (well, at th=
e
> behest of a desperate administrator) losing the data. =A0Things like =
remove
> and replace would succeed, but reads would not. =A0Stale objects coul=
d then
> always be removed on a per-object basis.

It sounds promising. I wonder what the metadata servers should do if
they get an ESTALE?

Others using the object store would probably appreciate the
flexibility of being able to read other objects which didn't get lost.

We probably want to make the "ceph health" command comment about lost
objects if they exist.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
