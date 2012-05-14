From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:03:23 -0700
Message-ID: <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37450 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab2ENRDo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 13:03:44 -0400
Received: by dady13 with SMTP id y13so6154360dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 10:03:44 -0700 (PDT)
In-Reply-To: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>

On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
> Return an error rather than a segfault if a client uses the interface
> when unmounted. The Java bindings were explicitly enforcing the
> mounted state, but this was overly complicated, uncommon, and better
> handled with a simple exception that can be checked at libcephfs leve=
l.
=2E..
> + =C2=A0if (!cmount->is_mounted())
> + =C2=A0 =C2=A0return -EDOM;

Noah, this is not really about your patch, as existing code already
has return -EDOM, but... oh boy does the API abuse POSIX errors.

"Numerical argument out of domain".
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
