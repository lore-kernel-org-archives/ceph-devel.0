From: Grant Ashman <grant.ashman@mach.com.au>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 21:51:10 +0000 (UTC)
Message-ID: <loom.20120522T234403-146@post.gmane.org>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10> <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com> <loom.20120522T135204-38@post.gmane.org> <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com> <3E281FAE45D705468EBA19F32321E72B32A009D964@exch11> <9AF25259E69149DE97352565797966E1@inktank.com> <loom.20120522T232520-187@post.gmane.org> <6DEB34DCFE6447C1BEE4A3E374801FAC@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46196 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389Ab2EVVv1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 May 2012 17:51:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SWwzD-0003pd-UZ
	for ceph-devel@vger.kernel.org; Tue, 22 May 2012 23:51:23 +0200
Received: from 60-240-78-43.static.tpgi.com.au ([60.240.78.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:51:23 +0200
Received: from grant.ashman by 60-240-78-43.static.tpgi.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:51:23 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Greg Farnum <greg <at> inktank.com> writes:

> > When I specify the add data pool I get the following:
> > (with or without the additional values)
> > =20
> > root <at> dsan-test:~# ceph mds add_data_pool backup
> > added data pool 0 to mdsmap
>=20
> Okay, that's not right =E2=80=94 it should say pool 3.
> According to the docs I found you ran that correctly, but let's try r=
unning=20
"ceph mds add_data_pool 3" and
> see if that resolves correctly.
> *goes to look at code*
> Argh, yep, it's expecting a pool ID, not a pool name. Gah.
>=20
> > root <at> dsan-test:~# cephfs /mnt/ceph-backup set_layout -p 3
> > Error setting layout: Invalid argument
> > =20
> > Seems to be pointing at pool 0 instead of pool 3 like it should?
> > =20

Awesome, that seemed to work!
However, I feel a bit silly - what I'm after is:

/mnt/ceph-data - mounted to pool 0 (data)
/mnt/ceph-backup - mounted to pool 3 (backup)

but this seemed to change both to mount to pool 3?

Am I simply doing something wrong at my mount stage?

The process to mount my specific pool as I understand it is;

1. mount -t ceph 1.2.3.4:/ /mnt/ceph-backup
2. ceph mds add_data_pool 3
3. cephfs /mnt/ceph-backup/ -p 3=20

Which should give me /ceph-backup mounted to the backup pool.

Should I simply then do a=20
mount -t ceph 1.2.3.4:/ /mnt/ceph-data/
to get the /ceph-data/ pool mounted to the pool 0 data pool?




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
