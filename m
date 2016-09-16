From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore memory leak
Date: Fri, 16 Sep 2016 00:49:11 +0000
Message-ID: <BL2PR02MB2115EF88536C15E0EF7E2986F4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
 <BL2PR02MB2115528CD794399F5E7D7A75F4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <777f0f87-864a-a88e-fd37-39ff7e309c62@redhat.com>
 <BL2PR02MB2115B854CD3ECBA130B8731AF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB211523F7620D138235D6B2CBF4FF0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <cc45aae1-a8b6-3a46-f4d1-ca0fe24437ac@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0079.outbound.protection.outlook.com ([104.47.38.79]:23457
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbcIPAtO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Sep 2016 20:49:14 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I think we still have unbounded data structure growth or leak. While test (=
4K RW) is going on fine (without unbounded memory growth) on my 40TB image =
without preconditioning , I ran out of memory quickly (~20 min or so)  on m=
y 4TB image (preconditioned).
Ran through Valgrind on that scenario and revealed this.

=3D=3D33713=3D=3D 16,962,048 (161,824 direct, 16,800,224 indirect) bytes in=
 5,057 blocks are definitely lost in loss record 139 of 142
=3D=3D33713=3D=3D    at 0x9FC22C0: operator new(unsigned long) (in /usr/lib=
/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D33713=3D=3D    by 0xC2DE6A: allocate (new_allocator.h:104)
=3D=3D33713=3D=3D    by 0xC2DE6A: _M_get_node (stl_list.h:334)
=3D=3D33713=3D=3D    by 0xC2DE6A: _M_create_node<ceph::buffer::ptr> (stl_li=
st.h:502)
=3D=3D33713=3D=3D    by 0xC2DE6A: _M_insert<ceph::buffer::ptr> (stl_list.h:=
1561)
=3D=3D33713=3D=3D    by 0xC2DE6A: push_back (stl_list.h:1021)
=3D=3D33713=3D=3D    by 0xC2DE6A: push_back (buffer.h:485)
=3D=3D33713=3D=3D    by 0xC2DE6A: ceph::buffer::list::append(ceph::buffer::=
ptr const&, unsigned int, unsigned int) (buffer.cc:1780)
=3D=3D33713=3D=3D    by 0xC34B35: ceph::buffer::list::iterator_impl<false>:=
:copy(unsigned int, ceph::buffer::list&) (buffer.cc:1170)
=3D=3D33713=3D=3D    by 0x86338A: decode (BlueStore.h:488)
=3D=3D33713=3D=3D    by 0x86338A: BlueStore::ExtentMap::decode_spanning_blo=
bs(BlueStore::Collection*, ceph::buffer::list::iterator&) (BlueStore.cc:176=
0)
=3D=3D33713=3D=3D    by 0x86BCFA: BlueStore::Collection::get_onode(ghobject=
_t const&, bool) (BlueStore.cc:2138)
=3D=3D33713=3D=3D    by 0x86E6A2: BlueStore::getattr(boost::intrusive_ptr<O=
bjectStore::CollectionImpl>&, ghobject_t const&, char const*, ceph::buffer:=
:ptr&) (BlueStore.cc:5003)
=3D=3D33713=3D=3D    by 0x69D333: PGBackend::objects_get_attr(hobject_t con=
st&, std::string const&, ceph::buffer::list*) (PGBackend.cc:212)
=3D=3D33713=3D=3D    by 0x6240C7: ReplicatedPG::get_object_context(hobject_=
t const&, bool, std::map<std::string, ceph::buffer::list, std::less<std::st=
ring>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*=
) (ReplicatedPG.cc:9148)
=3D=3D33713=3D=3D    by 0x6323F8: ReplicatedPG::find_object_context(hobject=
_t const&, std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*) (Replic=
atedPG.cc:9249)
=3D=3D33713=3D=3D    by 0x6611D0: ReplicatedPG::do_op(std::shared_ptr<OpReq=
uest>&) (ReplicatedPG.cc:1972)
=3D=3D33713=3D=3D    by 0x620F6B: ReplicatedPG::do_request(std::shared_ptr<=
OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1612)
=3D=3D33713=3D=3D    by 0x4DA0D4: OSD::dequeue_op(boost::intrusive_ptr<PG>,=
 std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8871)


=3D=3D33713=3D=3D 33,896,704 (362,976 direct, 33,533,728 indirect) bytes in=
 7,562 blocks are definitely lost in loss record 140 of 142
=3D=3D33713=3D=3D    at 0x9FC22C0: operator new(unsigned long) (in /usr/lib=
/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D33713=3D=3D    by 0x8AB755: allocate (new_allocator.h:104)
=3D=3D33713=3D=3D    by 0x8AB755: _M_get_node (stl_tree.h:370)
=3D=3D33713=3D=3D    by 0x8AB755: _M_create_node<const std::piecewise_const=
ruct_t&, std::tuple<unsigned int&&>, std::tuple<> > (stl_tree.h:403)
=3D=3D33713=3D=3D    by 0x8AB755: _M_emplace_hint_unique<const std::piecewi=
se_construct_t&, std::tuple<unsigned int&&>, std::tuple<> > (stl_tree.h:166=
9)
=3D=3D33713=3D=3D    by 0x8AB755: operator[] (stl_map.h:484)
=3D=3D33713=3D=3D    by 0x8AB755: bluestore_extent_ref_map_t::decode(ceph::=
buffer::list::iterator&) (bluestore_types.cc:366)
=3D=3D33713=3D=3D    by 0x86339D: BlueStore::ExtentMap::decode_spanning_blo=
bs(BlueStore::Collection*, ceph::buffer::list::iterator&) (BlueStore.cc:176=
1)
=3D=3D33713=3D=3D    by 0x86BCFA: BlueStore::Collection::get_onode(ghobject=
_t const&, bool) (BlueStore.cc:2138)
=3D=3D33713=3D=3D    by 0x88EF74: BlueStore::_txc_add_transaction(BlueStore=
::TransContext*, ObjectStore::Transaction*) (BlueStore.cc:6608)
=3D=3D33713=3D=3D    by 0x8954E1: BlueStore::queue_transactions(ObjectStore=
::Sequencer*, std::vector<ObjectStore::Transaction, std::allocator<ObjectSt=
ore::Transaction> >&, std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*) (B=
lueStore.cc:6435)
=3D=3D33713=3D=3D    by 0x67DDAB: queue_transactions (ObjectStore.h:1824)
=3D=3D33713=3D=3D    by 0x67DDAB: ReplicatedPG::queue_transactions(std::vec=
tor<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, =
std::shared_ptr<OpRequest>) (ReplicatedPG.h:277)
=3D=3D33713=3D=3D    by 0x74E99E: ReplicatedBackend::sub_op_modify(std::sha=
red_ptr<OpRequest>) (ReplicatedBackend.cc:1195)
=3D=3D33713=3D=3D    by 0x74F312: ReplicatedBackend::handle_message(std::sh=
ared_ptr<OpRequest>) (ReplicatedBackend.cc:217)
=3D=3D33713=3D=3D    by 0x620929: ReplicatedPG::do_request(std::shared_ptr<=
OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1589)
=3D=3D33713=3D=3D    by 0x4DA0D4: OSD::dequeue_op(boost::intrusive_ptr<PG>,=
 std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8871)
=3D=3D33713=3D=3D    by 0x4DA2FC: PGQueueable::RunVis::operator()(std::shar=
ed_ptr<OpRequest> const&) (OSD.cc:163)


=3D=3D33713=3D=3D 15,907,184 (1,118,568 direct, 14,788,616 indirect) bytes =
in 4,237 blocks are definitely lost in loss record 138 of 142
=3D=3D33713=3D=3D    at 0x9FC22C0: operator new(unsigned long) (in /usr/lib=
/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D33713=3D=3D    by 0x863079: BlueStore::ExtentMap::decode_spanning_blo=
bs(BlueStore::Collection*, ceph::buffer::list::iterator&) (BlueStore.cc:175=
6)
=3D=3D33713=3D=3D    by 0x86BCFA: BlueStore::Collection::get_onode(ghobject=
_t const&, bool) (BlueStore.cc:2138)
=3D=3D33713=3D=3D    by 0x86E6A2: BlueStore::getattr(boost::intrusive_ptr<O=
bjectStore::CollectionImpl>&, ghobject_t const&, char const*, ceph::buffer:=
:ptr&) (BlueStore.cc:5003)
=3D=3D33713=3D=3D    by 0x69D333: PGBackend::objects_get_attr(hobject_t con=
st&, std::string const&, ceph::buffer::list*) (PGBackend.cc:212)
=3D=3D33713=3D=3D    by 0x6240C7: ReplicatedPG::get_object_context(hobject_=
t const&, bool, std::map<std::string, ceph::buffer::list, std::less<std::st=
ring>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*=
) (ReplicatedPG.cc:9148)
=3D=3D33713=3D=3D    by 0x6323F8: ReplicatedPG::find_object_context(hobject=
_t const&, std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*) (Replic=
atedPG.cc:9249)
=3D=3D33713=3D=3D    by 0x6611D0: ReplicatedPG::do_op(std::shared_ptr<OpReq=
uest>&) (ReplicatedPG.cc:1972)
=3D=3D33713=3D=3D    by 0x620F6B: ReplicatedPG::do_request(std::shared_ptr<=
OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1612)
=3D=3D33713=3D=3D    by 0x4DA0D4: OSD::dequeue_op(boost::intrusive_ptr<PG>,=
 std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8871)
=3D=3D33713=3D=3D    by 0x4DA2FC: PGQueueable::RunVis::operator()(std::shar=
ed_ptr<OpRequest> const&) (OSD.cc:163)
=3D=3D33713=3D=3D    by 0x4FB49E: internal_visit<std::shared_ptr<OpRequest>=
 > (variant.hpp:1048)
=3D=3D33713=3D=3D    by 0x4FB49E: visitation_impl_invoke_impl<boost::detail=
::variant::invoke_visitor<PGQueueable::RunVis>, void*, std::shared_ptr<OpRe=
quest> > (visitation_impl.hpp:130)
=3D=3D33713=3D=3D    by 0x4FB49E: visitation_impl_invoke<boost::detail::var=
iant::invoke_visitor<PGQueueable::RunVis>, void*, std::shared_ptr<OpRequest=
>, boost::variant<std::shared_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecove=
ry>::has_fallback_type_> (visitation_impl.hpp:173)
=3D=3D33713=3D=3D    by 0x4FB49E: visitation_impl<mpl_::int_<0>, boost::det=
ail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mp=
l_::long_<4l>, std::shared_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3=
l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_=
item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l=
_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueuea=
ble::RunVis>, void*, boost::variant<std::shared_ptr<OpRequest>, PGSnapTrim,=
 PGScrub, PGRecovery>::has_fallback_type_> (visitation_impl.hpp:256)
=3D=3D33713=3D=3D    by 0x4FB49E: internal_apply_visitor_impl<boost::detail=
::variant::invoke_visitor<PGQueueable::RunVis>, void*> (variant.hpp:2367)
=3D=3D33713=3D=3D    by 0x4FB49E: internal_apply_visitor<boost::detail::var=
iant::invoke_visitor<PGQueueable::RunVis> > (variant.hpp:2378)
=3D=3D33713=3D=3D    by 0x4FB49E: apply_visitor<PGQueueable::RunVis> (varia=
nt.hpp:2401)
=3D=3D33713=3D=3D    by 0x4FB49E: apply_visitor<PGQueueable::RunVis, boost:=
:variant<std::shared_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> > (ap=
ply_visitor_unary.hpp:60)
=3D=3D33713=3D=3D    by 0x4FB49E: run (OSD.h:410)
=3D=3D33713=3D=3D    by 0x4FB49E: OSD::ShardedOpWQ::_process(unsigned int, =
ceph::heartbeat_handle_d*) (OSD.cc:8752)


Is this because spanning_blob_map is growing unbounded till the next reshar=
d which can happen much later ?
If the blob is spanned which is most likely happening in case of my precond=
itioned case (and small image), this could fill up memory very fast.

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy=20
Sent: Monday, September 12, 2016 6:35 PM
To: 'Mark Nelson'; 'ceph-devel'
Subject: RE: Bluestore memory leak

Mark/Sage,
Did some longer runs and it seems traces are similar and leaks are getting =
bigger over time.

=3D=3D1206464=3D=3D LEAK SUMMARY:
=3D=3D1206464=3D=3D    definitely lost: 25,115,152 bytes in 490,345 blocks
=3D=3D1206464=3D=3D    indirectly lost: 265,754,576 bytes in 1,587,729 bloc=
ks
=3D=3D1206464=3D=3D      possibly lost: 54,440 bytes in 166 blocks
=3D=3D1206464=3D=3D    still reachable: 771,078 bytes in 115 blocks
=3D=3D1206464=3D=3D         suppressed: 0 bytes in 0 blocks

OSD resident memory at this time is ~2G and out of that ~300 MB is *leaked*=
 or consumed by growing data structure it seems. Rest is used for 2Q cache =
it seems (I used default shard and default cache settings).

With further debugging it seems the following could be the reason for the g=
rowth.

1.  b->ref_map is growing on each op on either on the same blob or in a new=
 blob. It's 8 bytes on each op.

2. ExtentMap:: inline_bl can grow till bluestore_extent_map_shard_max_size =
(1200 bytes) , this is bounded , so, no problem I guess. By default, for a =
40TB image I was trying with it can grow ~20GB across cluster.

3. extent_map is growing on each op and it is storing the blob. So, it is b=
ig and it is only been discarded from punch_hole() which will put the exten=
t in the old_extents list based on conditions. That means depending on the =
io pattern extent_mpa can grow unbounded ?

4. The old_extents are supposed to be deleted from wctx_finish but I found =
only blobs are dereferenced , Extent objects are not deleted. Extent is als=
o not a ref counted object it seems..

Let me know if I am missing anything.

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy
Sent: Monday, September 12, 2016 2:40 PM
To: 'Mark Nelson'; ceph-devel
Subject: RE: Bluestore memory leak

I didn't run for long , but, 'definitely lost' is leak according to memchec=
k. I am not sure how good it is of detecting auto pointers though..
I can run longer and see if anything new is coming..

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com]
Sent: Monday, September 12, 2016 2:17 PM
To: Somnath Roy; ceph-devel
Subject: Re: Bluestore memory leak

On 09/12/2016 03:54 PM, Somnath Roy wrote:
> Mark,
> Thanks for soname* param , it worked with tcmalloc for me..
>
> Sage,
> Please find the valgrind memcheck output here..
> https://docs.google.com/document/d/12yx8jVmdkXrYPmq4DSxcdUBWc8xKrPjJDO
> TES299_do/edit?usp=3Dsharing
>
> It seems it is leaking memory (see 'definitely lost')..I will go=20
> through the code and try to find out if those are valid or not.
> Thought of sharing with you meanwhile as it will be much faster if you=20
> have time to look as well :-)

How big had the per-OSD RSS memory grown at this point?  Looks like we're o=
nly seeing about 408K definitely lost and 3953K indirectly lost in the tota=
ls at the end.  That's notable, but given the amounts of memory we are talk=
ing about, it doesn't seem like we are seeing the real culprit(s).

>
> Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Thursday, September 08, 2016 1:32 PM
> To: Mark Nelson; ceph-devel
> Subject: RE: Bluestore memory leak
>
> Yes, a bit probably :-)..Will try to find out from where it is leaking..
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Thursday, September 08, 2016 1:28 PM
> To: Somnath Roy; ceph-devel
> Subject: Re: Bluestore memory leak
>
> What I'm seeing is that after 5 minutes of 4k random writes, my OSDs are =
using about half the memory they were previously.  I'm not sure we have ent=
irely fixed it, but can you you confirm that it's at least growing slower t=
han it used to?
>
> Mark
>
> On 09/08/2016 03:24 PM, Somnath Roy wrote:
>> Sage/Mark,
>> Leak is still there with latest master, I can't complete a 5 min run , m=
emory is getting full.
>>
>> root@emsnode11:~/ceph-master/build# ceph -v
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***=20
>> ceph version v11.0.0-2173-g0985370
>> (0985370d2d729c6b8ef373e2dc4241b0eea474bf)
>> root@emsnode11:~/ceph-master/build#
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Wednesday, September 07, 2016 7:04 PM
>> To: Somnath Roy; ceph-devel
>> Subject: Re: Bluestore memory leak
>>
>> Hi Somnath,
>>
>> I complained loudly and often enough to get Sage to take a look and he f=
ixed a bunch of stuff. :)  The following PR dramatically improves things, t=
hough I haven't verified that it's totally fixed yet:
>>
>> https://github.com/ceph/ceph/pull/11011
>>
>> Mark
>>
>> On 09/07/2016 08:08 PM, Somnath Roy wrote:
>>> Sage,
>>> As Mark said, the latest code has severe memory leak , my system memory=
 (64GB) started swapping after 3 min of 4K RW run.
>>>
>>> Thanks & Regards
>>> Somnath
>>> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that you have received this message in error and that any review, d=
issemination, distribution, or copying of this message is strictly prohibit=
ed. If you have received this communication in error, please notify the sen=
der by telephone or e-mail (as shown above) immediately and destroy any and=
 all copies of this message in your possession (whether hard copies or elec=
tronically stored copies).
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
