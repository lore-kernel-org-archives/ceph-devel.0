From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 14:08:53 +0000
Message-ID: <DB5PR05MB160792F236092F959E020E55A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
 <20160823112140.GH5955@rskikr.localdomain>
 <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz>
 <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0066.outbound.protection.outlook.com ([104.47.2.66]:37376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751640AbcHWVqB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 17:46:01 -0400
In-Reply-To: <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks.
So, what is the proper way for creating *.deb files

> -----Original Message-----
> From: Nathan Cutler [mailto:ncutler@suse.cz]
> Sent: Tuesday, August 23, 2016 15:59
> To: Brad Hubbard <bhubbard@redhat.com>; Avner Ben Hanoch
> <avnerb@mellanox.com>
> Cc: Gregory Farnum <gfarnum@redhat.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: errors in make-debs.sh because "make dist" fails on
> 'rocksdb/db/slice.cc'
>=20
> > That's a different make-deb(s).sh
>=20
> Allow me to qualify that statement. This thread seems to be about
>=20
> https://github.com/ceph/ceph/blob/master/make-debs.sh
>=20
> while the "make-deb.sh" I am working on is
>=20
> https://github.com/ceph/ceph-qa-
> suite/blob/master/tasks/buildpackages/make-deb.sh
>=20
> which is used with the teuthology-openstack backend. However, I see the t=
wo
> scripts are similar.
>=20
> In general, although the autotools stuff is still there in master, it is =
not
> maintained and should not be expected to work (or continue to work).
> All build infrastructure targeting master should be converted to cmake.
>=20
> Nathan
