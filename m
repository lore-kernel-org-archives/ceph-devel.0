From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Implication of using rados_ioctx_locator_set_key
Date: Tue, 28 Feb 2012 10:49:16 -0800
Message-ID: <CAF3hT9AfZBVw+RQPCowDxsswECPE5kZXOMTh6XWBc34XAPmeng@mail.gmail.com>
References: <8CC04085-3786-4230-8793-0D9097F261F0@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41089 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965988Ab2B1StR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 13:49:17 -0500
Received: by yhmm54 with SMTP id m54so1209231yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 10:49:17 -0800 (PST)
In-Reply-To: <8CC04085-3786-4230-8793-0D9097F261F0@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Adam Manzanares <nmtadam@gmail.com>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

On Tue, Feb 28, 2012 at 10:07 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
> I'm curious about what performance implications there may be when usi=
ng rados_ioctx_locator_set_key.
>
> If a large number of objects are forced into a single PG using a fixe=
d locator key, are there performance implications for subsequent look-u=
ps by object name? Is some type of index structure used under the hood =
since the PG isn't chosen using locator_key =3D object_name?

The placement path with a locator defined is the same as without a
locator defined =97=A0the difference is that with a locator you're plac=
ing
based on hash(locator) instead of hash(object_name).

Used sparingly (mapping a couple objects to the same locator), this
won't have any performance implications. Used to great excess, you can
run into a variety of problems:
reducing the amount of hash space used, increasing variance in PG sizes
forcing a large number of objects into a single folder on the OSD disk
store (because it won't split apart a single hash)
=2E..actually, that's all I can come up with off-hand.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
