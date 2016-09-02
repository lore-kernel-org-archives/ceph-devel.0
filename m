From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: Store test BluestoreStatFSTest failure
Date: Fri, 2 Sep 2016 13:10:43 +0000
Message-ID: <CY1PR0201MB182081F53BA9AFF2259FB75085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <CY1PR0201MB1820E737B99E2655DC28620085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <418d7e7b-bc7a-d747-e255-21c7e53940c2@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:35904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753393AbcIBNKq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 09:10:46 -0400
In-Reply-To: <418d7e7b-bc7a-d747-e255-21c7e53940c2@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes :).

That fixed it.

-Thanks

-Ramesh

> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Friday, September 02, 2016 5:41 PM
> To: Ramesh Chander; ceph-devel
> Subject: Re: Store test BluestoreStatFSTest failure
>
> Ramesh,
>
> this was fixed recently - please rebase to the latest master.
>
>
> Thanks,
>
> Igor
>
>
> On 02.09.2016 14:42, Ramesh Chander wrote:
> > I am trying to run ceph_test_objectstore with my changes and I see this
> intermittent failure.
> >
> >
> > Store_test.cc At line 1187:
> >
> > 1174     ObjectStore::Transaction t;
> > 1175     bufferlist bl;
> > 1176     bl.append("abcde");
> > 1177     t.write(cid, hoid, 0, 5, bl);
> > 1178     cerr << "Append 5 bytes" << std::endl;
> > 1179     r =3D apply_transaction(store, &osr, std::move(t));
> > 1180     ASSERT_EQ(r, 0);
> > 1181
> > 1182     struct store_statfs_t statfs;
> > 1183     int r =3D store->statfs(&statfs);
> > 1184     ASSERT_EQ(r, 0);
> > 1185     ASSERT_EQ(5, statfs.stored);
> > 1186     ASSERT_EQ(0x10000, statfs.allocated);
> > 1187     ASSERT_EQ(available0 - 0x10000, statfs.available);
> >
> > The total allocated are 1MB more than expected by this test.
> >
> > (gdb) p statfs
> > $50 =3D {total =3D 10737418240, available =3D 10722672640, allocated =
=3D
> > 65536, stored =3D 5, compressed =3D 0, compressed_allocated =3D 0,
> > compressed_original =3D 0}
> > (gdb) p available0
> > $51 =3D 10723786752
> > (gdb) p 10723786752-10722672640
> > $52 =3D 1114112
> > (gdb) p 1114112-65536
> > $53 =3D 1048576
> > (gdb) p $53 / 1024
> > $54 =3D 1024
> > (gdb) list
> >
> > I traced call and looks like there is really a 1MB allocation from Blue=
FS:
> _flush_range function.
> >
> > Is it possible that when we write an object BlueFS also allocated anoth=
er
> 1MB block and causing this difference?
> >
> > How to avoid this failure? Is it test case issue ?
> >
> > -Ramesh
> > PLEASE NOTE: The information contained in this electronic mail message =
is
> intended only for the use of the designated recipient(s) named above. If =
the
> reader of this message is not the intended recipient, you are hereby noti=
fied
> that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly prohi=
bited. If
> you have received this communication in error, please notify the sender b=
y
> telephone or e-mail (as shown above) immediately and destroy any and all
> copies of this message in your possession (whether hard copies or
> electronically stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
