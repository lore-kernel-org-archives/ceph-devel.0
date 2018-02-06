From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: v12.2.2 bluestore crash
Date: Tue, 6 Feb 2018 17:17:10 +0800
Message-ID: <30CAE375-C819-4565-9C64-9B321DAE9E23@gmail.com>
References: <53259473-2A66-468D-9A9F-1F5797A6B000@gmail.com>
 <CABbLZY1DgF1Z7ubZaR8TPMFqZQkS=HP4XUv=7WtaSW23hkgLqA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:46652 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBFJRN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 04:17:13 -0500
Received: by mail-pl0-f48.google.com with SMTP id 36so870305ple.13
        for <ceph-devel@vger.kernel.org>; Tue, 06 Feb 2018 01:17:13 -0800 (PST)
In-Reply-To: <CABbLZY1DgF1Z7ubZaR8TPMFqZQkS=HP4XUv=7WtaSW23hkgLqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <varada.kari@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Varada, i didn=A1=AFt find any useful message

> =D4=DA 2018=C4=EA2=D4=C26=C8=D5=A3=AC=CF=C2=CE=E71:43=A3=ACVarada Kari =
<varada.kari@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> Seems you are not able to read from disk. Could you kern.log and
> syslog for any disk errors?
>=20
> Varada
>=20
> On Tue, Feb 6, 2018 at 8:45 AM, =CC=D5=B6=AC=B6=AC =
<tdd21151186@gmail.com> wrote:
>> Dear Cephers,
>>=20
>>=20
>> crash stack:
>> c/os/bluestore/BlueStore.cc: 6661: FAILED assert(r =3D=3D 0)
>> ```
>> ceph version 12.2.2 (cf0baeeeeba3b47f9427c6c97e2144b094b7e5ba) =
luminous (stable)
>> 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char =
const*)+0x110) [0x55cc7bf20550]
>> 2: (BlueStore::_do_read(BlueStore::Collection*, =
boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, =
ceph::buffer::list&, unsigned int)+0x1e50) [0x55cc7bdeb360]
>> 3: =
(BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, =
ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, =
unsigned int)+0x61a) [0x55cc7bdec50a]
>> 4: (ReplicatedBackend::be_deep_scrub(hobject_t const&, unsigned int, =
ScrubMap::object&, ThreadPool::TPHandle&)+0x247) [0x55cc7bc5e697]
>> 5: (PGBackend::be_scan_list(ScrubMap&, std::vector<hobject_t, =
std::allocator<hobject_t> > const&, bool, unsigned int, =
ThreadPool::TPHandle&)+0x290) [0x55cc7bb99720]
>> 6: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool, =
unsigned int, ThreadPool::TPHandle&)+0x215) [0x55cc7ba47825]
>> 7: (PG::replica_scrub(boost::intrusive_ptr<OpRequest>, =
ThreadPool::TPHandle&)+0x5e6) [0x55cc7ba48116]
>> 8: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, =
ThreadPool::TPHandle&)+0x720) [0x55cc7bb05110]
>> 9: (OSD::dequeue_op(boost::intrusive_ptr<PG>, =
boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f9) =
[0x55cc7b98f899]
>> 10: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest> =
const&)+0x57) [0x55cc7bc07897]
>> 11: (OSD::ShardedOpWQ::_process(unsigned int, =
ceph::heartbeat_handle_d*)+0xfce) [0x55cc7b9bd43e]
>> 12: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x839) =
[0x55cc7bf26069]
>> 13: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) =
[0x55cc7bf28000]
>> 14: (()+0x7e25) [0x7f6de7a08e25]
>> 15: (clone()+0x6d) [0x7f6de6afc34d]
>>=20
>> could anyone please help to take a look, why would this happen ?
>> currently, this osd keep crashes because of this assertion failure.
>>=20
>> Regards,
>> Dongdong--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

