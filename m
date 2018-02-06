From: Varada Kari <varada.kari@gmail.com>
Subject: Re: v12.2.2 bluestore crash
Date: Tue, 6 Feb 2018 11:13:17 +0530
Message-ID: <CABbLZY1DgF1Z7ubZaR8TPMFqZQkS=HP4XUv=7WtaSW23hkgLqA@mail.gmail.com>
References: <53259473-2A66-468D-9A9F-1F5797A6B000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55807 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeBFFnT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 00:43:19 -0500
Received: by mail-wm0-f42.google.com with SMTP id 143so1308454wma.5
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 21:43:19 -0800 (PST)
In-Reply-To: <53259473-2A66-468D-9A9F-1F5797A6B000@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Seems you are not able to read from disk. Could you kern.log and
syslog for any disk errors?

Varada

On Tue, Feb 6, 2018 at 8:45 AM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@gm=
ail.com> wrote:
> Dear Cephers,
>
>
> crash stack:
> c/os/bluestore/BlueStore.cc: 6661: FAILED assert(r =3D=3D 0)
> ```
>  ceph version 12.2.2 (cf0baeeeeba3b47f9427c6c97e2144b094b7e5ba) luminous =
(stable)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)=
+0x110) [0x55cc7bf20550]
>  2: (BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<Blu=
eStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned=
 int)+0x1e50) [0x55cc7bdeb360]
>  3: (BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, =
ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsig=
ned int)+0x61a) [0x55cc7bdec50a]
>  4: (ReplicatedBackend::be_deep_scrub(hobject_t const&, unsigned int, Scr=
ubMap::object&, ThreadPool::TPHandle&)+0x247) [0x55cc7bc5e697]
>  5: (PGBackend::be_scan_list(ScrubMap&, std::vector<hobject_t, std::alloc=
ator<hobject_t> > const&, bool, unsigned int, ThreadPool::TPHandle&)+0x290)=
 [0x55cc7bb99720]
>  6: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool, uns=
igned int, ThreadPool::TPHandle&)+0x215) [0x55cc7ba47825]
>  7: (PG::replica_scrub(boost::intrusive_ptr<OpRequest>, ThreadPool::TPHan=
dle&)+0x5e6) [0x55cc7ba48116]
>  8: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPoo=
l::TPHandle&)+0x720) [0x55cc7bb05110]
>  9: (OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpReq=
uest>, ThreadPool::TPHandle&)+0x3f9) [0x55cc7b98f899]
>  10: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest> con=
st&)+0x57) [0x55cc7bc07897]
>  11: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)=
+0xfce) [0x55cc7b9bd43e]
>  12: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x839) [0=
x55cc7bf26069]
>  13: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55cc7bf28000=
]
>  14: (()+0x7e25) [0x7f6de7a08e25]
>  15: (clone()+0x6d) [0x7f6de6afc34d]
>
> could anyone please help to take a look, why would this happen ?
> currently, this osd keep crashes because of this assertion failure.
>
> Regards,
> Dongdong--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
