From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Ceph Luminous - pg is down due to src/osd/SnapMapper.cc: 246:
 FAILED assert(r == -2)
Date: Wed, 17 Jan 2018 08:43:46 +0100
Message-ID: <1d5aacc3-5a99-fc53-5f97-555020333f16@profihost.ag>
References: <a02d6d40-e4e7-5f9a-0f9a-b3939f376c70@profihost.ag>
 <CAJ4mKGYOzVdhBPT+ZEa92czYb5aYznxWPR-_rr=yCLdg1bVhbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:53960 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750953AbeAQHns (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 17 Jan 2018 02:43:48 -0500
In-Reply-To: <CAJ4mKGYOzVdhBPT+ZEa92czYb5aYznxWPR-_rr=yCLdg1bVhbQ@mail.gmail.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

if i export the pg and try to reimport it - ceph-object-tool crashes with:

Importing pgid 3.80e
Write #3:7010005d:::rbd_data.e60f906b8b4567.000000000000dcf4:head#
snapset afdd4=[afdd4]:{}
Write #3:701002ed:::rbd_data.f9c2596b8b4567.000000000000c5e1:b0de1#
Write #3:701002ed:::rbd_data.f9c2596b8b4567.000000000000c5e1:head#
snapset b0de1=[b0de1]:{b0de1=[b0de1]}
Write #3:70100587:::rbd_data.13649df6b8b4567.000000000000a666:head#
snapset ad7de=[]:{}
Write #3:70100a0c:::rbd_data.8aceeb6b8b4567.0000000000001fc0:head#
snapset b0362=[]:{}
Write #3:70100cdb:::rbd_data.c1b6676b8b4567.0000000000023316:head#
snapset 9fb49=[]:{}
Write #3:70100de8:::rbd_data.89d7f56b8b4567.0000000000004ffa:b0ca9#
/build/ceph/src/osd/SnapMapper.cc: In function 'void
SnapMapper::add_oid(const hobject_t&, const std::set<snapid_t>&,
MapCacher::Transaction<std::basic_string<char>, ceph::buffer::list>*)'
thread 7fbda9926280 time 2018-01-17 08:42:50.490570
/build/ceph/src/osd/SnapMapper.cc: 246: FAILED assert(r == -2)
 ceph version 12.2.2-93-gd6da8d7
(d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x102) [0x7fbd9fe07802]
 2: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
std::less<snapid_t>, std::allocator<snapid_t> > const&,
MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
[0x55de1ca2c4ab]
 3: (get_attrs(ObjectStore*, coll_t, ghobject_t,
ObjectStore::Transaction*, ceph::buffer::list&, OSDriver&,
SnapMapper&)+0x467) [0x55de1c7af867]
 4: (ObjectStoreTool::get_object(ObjectStore*, coll_t,
ceph::buffer::list&, OSDMap&, bool*, ObjectStore::Sequencer&)+0x8a9)
[0x55de1c7b0d79]
 5: (ObjectStoreTool::do_import(ObjectStore*, OSDSuperblock&, bool,
std::string, ObjectStore::Sequencer&)+0x1417) [0x55de1c7b5077]
 6: (main()+0x3a89) [0x55de1c704689]
 7: (__libc_start_main()+0xf5) [0x7fbd9d2afb45]
 8: (()+0x3450a0) [0x55de1c7a20a0]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
*** Caught signal (Aborted) **
 in thread 7fbda9926280 thread_name:ceph-objectstor
 ceph version 12.2.2-93-gd6da8d7
(d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
 1: (()+0x91853c) [0x55de1cd7553c]
 2: (()+0xf890) [0x7fbd9e6b1890]
 3: (gsignal()+0x37) [0x7fbd9d2c3067]
 4: (abort()+0x148) [0x7fbd9d2c4448]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x27f) [0x7fbd9fe0797f]
 6: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
std::less<snapid_t>, std::allocator<snapid_t> > const&,
MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
[0x55de1ca2c4ab]
 7: (get_attrs(ObjectStore*, coll_t, ghobject_t,
ObjectStore::Transaction*, ceph::buffer::list&, OSDriver&,
SnapMapper&)+0x467) [0x55de1c7af867]
 8: (ObjectStoreTool::get_object(ObjectStore*, coll_t,
ceph::buffer::list&, OSDMap&, bool*, ObjectStore::Sequencer&)+0x8a9)
[0x55de1c7b0d79]
 9: (ObjectStoreTool::do_import(ObjectStore*, OSDSuperblock&, bool,
std::string, ObjectStore::Sequencer&)+0x1417) [0x55de1c7b5077]
 10: (main()+0x3a89) [0x55de1c704689]
 11: (__libc_start_main()+0xf5) [0x7fbd9d2afb45]
 12: (()+0x3450a0) [0x55de1c7a20a0]
Aborted

Stefan

Am 16.01.2018 um 23:24 schrieb Gregory Farnum:
> On Mon, Jan 15, 2018 at 5:23 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hello,
>>
>> currently one of my clusters is missing a whole pg due to all 3 osds
>> being down.
>>
>> All of them fail with:
>>     0> 2018-01-16 02:05:33.353293 7f944dbfe700 -1
>> /build/ceph/src/osd/SnapMapper.cc: In function 'void
>> SnapMapper::add_oid(const hobject_t&, const std::set<snapid_t>&,
>> MapCacher::Transaction<std::basic_string<char>, ceph::buffer::list>*)'
>> thread 7f944dbfe700 time 2018-01-16 02:05:33.349946
>> /build/ceph/src/osd/SnapMapper.cc: 246: FAILED assert(r == -2)
>>
>>  ceph version 12.2.2-93-gd6da8d7
>> (d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x102) [0x561f9ff0b1e2]
>>  2: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
>> std::less<snapid_t>, std::allocator<snapid_t> > const&,
>> MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
>> [0x561f9fb76f3b]
>>  3: (PG::update_snap_map(std::vector<pg_log_entry_t,
>> std::allocator<pg_log_entry_t> > const&,
>> ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
>>  4: (PG::append_log(std::vector<pg_log_entry_t,
>> std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
>> ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
>>  5: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
>> std::allocator<pg_log_entry_t> > const&,
>> boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
>> eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
>>  6: (ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
>> [0x561f9fc314b2]
>>  7:
>> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
>> [0x561f9fc374f4]
>>  8: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
>> [0x561f9fb5cf10]
>>  9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
>> ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
>>  10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
>> [0x561f9f955bc7]
>>  11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
>> const&)+0x57) [0x561f9fbcd947]
>>  12: (OSD::ShardedOpWQ::_process(unsigned int,
>> ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
>>  13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
>> [0x561f9ff10e6d]
>>  14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
>>  15: (()+0x8064) [0x7f949afcb064]
>>  16: (clone()+0x6d) [0x7f949a0bf62d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
> 
> By the time it gets there, something else has gone wrong. The OSD is
> adding a snapid/object pair to its "SnapMapper", and discovering that
> there are already entries (which it thinks there shouldn't be).
> 
> You'll need to post more of a log, along with background, if anybody's
> going to diagnose it: is there cache tiering on the cluster? What is
> this pool used for? Were there other errors on this PG in the past?
> 
> I also notice a separate email about deleting the data; I don't have
> any experience with this but you'd probably have to export the PG
> using ceph-objectstore-tool and then find a way to delete the object
> out of it. I see options to remove both an object and
> "remove-clone-metadata" on a particular ID, but I've not used any of
> them myself.
> -Greg
> 
