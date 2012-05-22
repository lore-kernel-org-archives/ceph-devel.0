From: Greg Farnum <greg@inktank.com>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 14:42:31 -0700
Message-ID: <6DEB34DCFE6447C1BEE4A3E374801FAC@inktank.com>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
 <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com>
 <loom.20120522T135204-38@post.gmane.org>
 <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com>
 <3E281FAE45D705468EBA19F32321E72B32A009D964@exch11>
 <9AF25259E69149DE97352565797966E1@inktank.com>
 <loom.20120522T232520-187@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40793 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2EVVmf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 17:42:35 -0400
Received: by dady13 with SMTP id y13so8799065dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 14:42:34 -0700 (PDT)
In-Reply-To: <loom.20120522T232520-187@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Grant Ashman <grant.ashman@mach.com.au>
Cc: ceph-devel@vger.kernel.org

On Tuesday, May 22, 2012 at 2:31 PM, Grant Ashman wrote:
> Greg Farnum <greg <at> inktank.com (http://inktank.com)> writes:
> > Oh, I got this conversation confused with another one.
> > You also need to specify the pool as a valid pool to
> > store filesystem data in, if you haven't done that already:
> > "ceph mds add_data_pool <poolname>"
> =20
> =20
> =20
> Thanks Greg,
> =20
> However, I still get the same error :(
> When I specify the add data pool I get the following:
> (with or without the additional values)
> =20
> root@dsan-test:~# ceph mds add_data_pool backup
> added data pool 0 to mdsmap

Okay, that's not right =E2=80=94 it should say pool 3.
According to the docs I found you ran that correctly, but let's try run=
ning "ceph mds add_data_pool 3" and see if that resolves correctly.
*goes to look at code*
Argh, yep, it's expecting a pool ID, not a pool name. Gah.
 =20
> root@dsan-test:~# cephfs /mnt/ceph-backup set_layout -p 3
> Error setting layout: Invalid argument
> =20
> Seems to be pointing at pool 0 instead of pool 3 like it should?
> =20
> Sorry if this has all been covered before, I've not found any =20
> resolution and the ability to mount specific pools I.E "data"
> for production data and "backup" for 1N backup data is a huge
> priority to begin using Ceph.

No problem =E2=80=94 we haven't generated docs for this yet and obvious=
ly we need to at some point.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
