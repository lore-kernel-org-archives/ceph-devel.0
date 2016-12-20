From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Bug in mempool::map?
Date: Tue, 20 Dec 2016 17:27:51 +0000
Message-ID: <EB02EE10422E4A40A1EE787A4AC27FBE0422B5@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
References: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com>
 <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal>
 <3117e8a5-e8dd-f323-25ef-dc6756ebb8f0@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:59680
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936484AbcLTRnt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Dec 2016 12:43:49 -0500
In-Reply-To: <3117e8a5-e8dd-f323-25ef-dc6756ebb8f0@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yes, Slab containers helps here by amortizing the malloc overhead for small=
 nodes.

Allen Samuels
SanDisk |a Western Digital brand
951 SanDisk Drive, Milpitas, CA 95035
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Tuesday, December 20, 2016 9:08 AM
> To: Sage Weil <sage@newdream.net>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: Re: Bug in mempool::map?
>=20
> Some update on map<uint64_t, uint32_t> mem usage.
>=20
> It looks like single entry map takes 48 bytes. And 40 bytes for
> map<uint32_t,uint32_t>.
>=20
> Hence 1024 trivial ref_maps for 1024 blobs takes >48K!
>=20
> These are my results taken from mempools. And they look pretty similar
> to what's been said in the following article:
>=20
> http://lemire.me/blog/2016/09/15/the-memory-usage-of-stl-containers-
> can-be-surprising/
>=20
>=20
> Sage, you mentioned that you're planning to do something with ref maps
> during the standup but I missed the details. Is that something about
> their mem use or anything else?
>=20
>=20
> Thanks,
>=20
> Igor
>=20
>=20
>=20
> On 20.12.2016 18:25, Sage Weil wrote:
> > On Tue, 20 Dec 2016, Igor Fedotov wrote:
> >> Hi Allen,
> >>
> >> It looks like mempools don't measure maps allocations properly.
> >>
> >> I extended unittest_mempool in the following way but corresponding
> output is
> >> always 0 for both 'before' and 'after' values:
> >>
> >>
> >> diff --git a/src/test/test_mempool.cc b/src/test/test_mempool.cc
> >> index 4113c53..b38a356 100644
> >> --- a/src/test/test_mempool.cc
> >> +++ b/src/test/test_mempool.cc
> >> @@ -232,9 +232,19 @@ TEST(mempool, set)
> >>   TEST(mempool, map)
> >>   {
> >>     {
> >> -    mempool::unittest_1::map<int,int> v;
> >> -    v[1] =3D 2;
> >> -    v[3] =3D 4;
> >> +    size_t before =3D mempool::buffer_data::allocated_bytes();
> > I think it's just that you're measuring the buffer_data pool...
> >
> >> +    mempool::unittest_1::map<int,int>* v =3D new
> mempool::unittest_1::map<int,int>;
> > but the map is in the unittest_1 pool?
> >
> >> +    (*v)[1] =3D 2;
> >> +    (*v)[3] =3D 4;
> >> +    size_t after =3D mempool::buffer_data::allocated_bytes();
> >> +    cout << "before " << before << " after " << after << std::endl;
> >> +    delete v;
> >> +    before =3D after;
> >> +    mempool::unittest_1::map<int64_t,int64_t> v2;
> >> +    v2[1] =3D 2;
> >> +    v2[3] =3D 4;
> >> +    after =3D mempool::buffer_data::allocated_bytes();
> >> +    cout << " before " << before << " after " << after << std::endl;
> >>     }
> >>     {
> >>       mempool::unittest_2::map<int,obj> v;
> >>
> >>
> >> Output:
> >>
> >> [ RUN      ] mempool.map
> >> before 0 after 0
> >>   before 0 after 0
> >> [       OK ] mempool.map (0 ms)
> >>
> >> It looks like we do not measure ref_map for BlueStore Blob and
> SharedBlob
> >> classes too.
> >>
> >> Any ideas?
> >>
> >> Thanks,
> >>
> >> Igor
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>

