From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 14:09:27 +0000
Message-ID: <DB5PR05MB160796FAC0A385F2682873DCA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
 <20160823112140.GH5955@rskikr.localdomain>
 <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz>
 <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
 <DB5PR05MB1607E0FC452D4FF419A78542A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <a48780cc-bfbf-7b24-32b9-0cd3581b00df@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:64435
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757641AbcHWOLf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 10:11:35 -0400
In-Reply-To: <a48780cc-bfbf-7b24-32b9-0cd3581b00df@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks.
So, what is the proper way for creating *.deb files

> -----Original Message-----
> From: Nathan Cutler [mailto:ncutler@suse.cz]
> Sent: Tuesday, August 23, 2016 16:34
> To: Avner Ben Hanoch <avnerb@mellanox.com>; Brad Hubbard
> <bhubbard@redhat.com>
> Cc: Gregory Farnum <gfarnum@redhat.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: errors in make-debs.sh because "make dist" fails on
> 'rocksdb/db/slice.cc'
>=20
> > Thanks for the clarification Nathan,
> >
> > I am using the updated master branch from https://github.com/ceph/ceph =
.
> Anyhow, I don't think the problem is in the file make-debs.sh itself, but=
 in
> something that is invoked from it regarding make dist with regard to the =
file
> db/slice.cc from rocksdb submodule.
> >
> > Do you have any idea if someone execute make-debs.sh on the updated
> ceph master branch?
>=20
> AFAIK you are the first to try it on master.
>=20
> Since the script uses autotools (not cmake) to do the build, it is not ex=
pected
> to work on master. IMO the script needs to be modified.
