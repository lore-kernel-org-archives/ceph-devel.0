From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore memory leak
Date: Thu, 22 Sep 2016 16:41:53 -0500
Message-ID: <dfb6302d-2c2e-04da-0619-4bb855aa55f5@redhat.com>
References: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
 <BL2PR02MB2115528CD794399F5E7D7A75F4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <777f0f87-864a-a88e-fd37-39ff7e309c62@redhat.com>
 <BL2PR02MB2115B854CD3ECBA130B8731AF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB211523F7620D138235D6B2CBF4FF0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <cc45aae1-a8b6-3a46-f4d1-ca0fe24437ac@redhat.com>
 <BL2PR02MB2115EF88536C15E0EF7E2986F4F30@BL2PR02MB2115.namprd02.prod.outlook.com>
 <d035816c-af64-95f5-bca3-ca59226cf037@redhat.com>
 <BY2PR02MB3960459E5E99A72260BE043F4C90@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965168AbcIVVmP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Sep 2016 17:42:15 -0400
In-Reply-To: <BY2PR02MB3960459E5E99A72260BE043F4C90@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Somnath,

I don't have too much to add, other than that I'm seeing a lot of time 
spent iterating through the spanning_blob_map in encode_spanning_blobs 
during 4k random writes:

-    7.10%     1.30%  tp_osd_tp        ceph-osd                     [.] 
BlueStore::ExtentMap::encode_spanning_blobs
    - 5.81% BlueStore::ExtentMap::encode_spanning_blobs
         5.35% std::_Rb_tree_increment

Sage made the keen observation that this might make sense given what you 
are seeing.

Mark

On 09/22/2016 03:37 PM, Somnath Roy wrote:
> Sage,
> As we discussed today morning , I did the following change within _wctx_finish(). I couldn't do it from b->put_ref() as spanning_blob_map is not available there.
>
> @@ -7423,6 +7440,13 @@ void BlueStore::_wctx_finish(
>          txc->statfs_delta.compressed_allocated() -= e.length;
>        }
>      }
> +    if (b->is_spanning()) {
> +      auto p = o->extent_map.spanning_blob_map.find(*b);
> +      assert(p != o->extent_map.spanning_blob_map.end());
> +      o->extent_map.spanning_blob_map.erase(p);
> +      p->id = -1;
> +      p->put();
> +    }
>      delete &lo;
>    }
>  }
>
> This worked fine for a bit without any growth but it then crashed with the following.
>
> 2016-09-22 10:14:26.126671 7f7173a83700 -1 /root/ceph-master/src/os/bluestore/BlueStore.cc: In function 'BlueStore::BlobRef BlueStore::ExtentMap::get_spanning_blob(int)' thread 7f7173a83700 time 2016-09-22 10:14:26.121455
> /root/ceph-master/src/os/bluestore/BlueStore.cc: 1785: FAILED assert(p != spanning_blob_map.end())
>
>  ceph version v11.0.0-2367-gd5a9d0e (d5a9d0eefa7618718fc3703463903b0ddf83003a)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x80) [0x55e3983e3600]
>  2: (BlueStore::ExtentMap::get_spanning_blob(int)+0x22f) [0x55e398116e2f]
>  3: (BlueStore::ExtentMap::decode_some(ceph::buffer::list&)+0xe56) [0x55e398119726]
>  4: (BlueStore::ExtentMap::fault_range(KeyValueDB*, unsigned int, unsigned int)+0x2fd) [0x55e39811a17d]
>  5: (BlueStore::_txc_write_nodes(BlueStore::TransContext*, std::shared_ptr<KeyValueDB::TransactionImpl>)+0x2d8) [0x55e398127de8]
>  6: (BlueStore::queue_transactions(ObjectStore::Sequencer*, std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x877) [0x55e3981514d7]
>  7: (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<OpRequest>)+0x81) [0x55e397efeba1]
>  8: (ReplicatedBackend::submit_transaction(hobject_t const&, eversion_t const&, std::unique_ptr<PGBackend::PGTransaction, std::default_delete<PGBackend::PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, std::shared_ptr<OpRequest>)+0x85f) [0x55e397fddbff]
>  9: (ReplicatedPG::issue_repop(ReplicatedPG::RepGather*, ReplicatedPG::OpContext*)+0x6e4) [0x55e397e87684]
>  10: (ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*)+0x19bc) [0x55e397edbc3c]
>  11: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x3844) [0x55e397edff04]
>  12: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&)+0x609) [0x55e397e9eb09]
>  13: (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x418) [0x55e397d44538]
>  14: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&)+0x52) [0x55e397d44792]
>  15: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x5ac) [0x55e397d6532c]
>  16: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9) [0x55e3983e83b9]
>  17: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55e3983eb770]
>  18: (()+0x76fa) [0x7f718d0996fa]
>  19: (clone()+0x6d) [0x7f718b984b5d]
>
> This is the assert I was battling yesterday as well and that's why I was trying to hack it around... I have the following question regarding deleting from spanning_blob_map and spanning blobs.
>
> 1. I suspect just removing the spanning blob from the map and decreasing the blob ref is not enough , what about corresponding shards/etc ? If spanning blobs are gone , shouldn't we update the extent_map_shards as well ?
>
> So, it seems the spanning blobs are the root cause of the memory growth and any help on resolving this will be helpful,
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Friday, September 16, 2016 5:46 AM
> To: Somnath Roy; ceph-devel
> Subject: Re: Bluestore memory leak
>
> Yeah, I'm still seeing high memory usage as well in my tests.  Not as bad as before.  At the end of a large test sequence I'm seeing ~9GB instead of 11GB of RSS like before.
>
> Mark
>
> On 09/15/2016 07:49 PM, Somnath Roy wrote:
>> Sage,
>> I think we still have unbounded data structure growth or leak. While test (4K RW) is going on fine (without unbounded memory growth) on my 40TB image without preconditioning , I ran out of memory quickly (~20 min or so)  on my 4TB image (preconditioned).
>> Ran through Valgrind on that scenario and revealed this.
>>
>> ==33713== 16,962,048 (161,824 direct, 16,800,224 indirect) bytes in 5,057 blocks are definitely lost in loss record 139 of 142
>> ==33713==    at 0x9FC22C0: operator new(unsigned long) (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>> ==33713==    by 0xC2DE6A: allocate (new_allocator.h:104)
>> ==33713==    by 0xC2DE6A: _M_get_node (stl_list.h:334)
>> ==33713==    by 0xC2DE6A: _M_create_node<ceph::buffer::ptr> (stl_list.h:502)
>> ==33713==    by 0xC2DE6A: _M_insert<ceph::buffer::ptr> (stl_list.h:1561)
>> ==33713==    by 0xC2DE6A: push_back (stl_list.h:1021)
>> ==33713==    by 0xC2DE6A: push_back (buffer.h:485)
>> ==33713==    by 0xC2DE6A: ceph::buffer::list::append(ceph::buffer::ptr const&, unsigned int, unsigned int) (buffer.cc:1780)
>> ==33713==    by 0xC34B35: ceph::buffer::list::iterator_impl<false>::copy(unsigned int, ceph::buffer::list&) (buffer.cc:1170)
>> ==33713==    by 0x86338A: decode (BlueStore.h:488)
>> ==33713==    by 0x86338A: BlueStore::ExtentMap::decode_spanning_blobs(BlueStore::Collection*, ceph::buffer::list::iterator&) (BlueStore.cc:1760)
>> ==33713==    by 0x86BCFA: BlueStore::Collection::get_onode(ghobject_t const&, bool) (BlueStore.cc:2138)
>> ==33713==    by 0x86E6A2: BlueStore::getattr(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, char const*, ceph::buffer::ptr&) (BlueStore.cc:5003)
>> ==33713==    by 0x69D333: PGBackend::objects_get_attr(hobject_t const&, std::string const&, ceph::buffer::list*) (PGBackend.cc:212)
>> ==33713==    by 0x6240C7: ReplicatedPG::get_object_context(hobject_t const&, bool, std::map<std::string, ceph::buffer::list, std::less<std::string>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*) (ReplicatedPG.cc:9148)
>> ==33713==    by 0x6323F8: ReplicatedPG::find_object_context(hobject_t const&, std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*) (ReplicatedPG.cc:9249)
>> ==33713==    by 0x6611D0: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:1972)
>> ==33713==    by 0x620F6B: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1612)
>> ==33713==    by 0x4DA0D4: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8871)
>>
>>
>> ==33713== 33,896,704 (362,976 direct, 33,533,728 indirect) bytes in 7,562 blocks are definitely lost in loss record 140 of 142
>> ==33713==    at 0x9FC22C0: operator new(unsigned long) (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>> ==33713==    by 0x8AB755: allocate (new_allocator.h:104)
>> ==33713==    by 0x8AB755: _M_get_node (stl_tree.h:370)
>> ==33713==    by 0x8AB755: _M_create_node<const std::piecewise_construct_t&, std::tuple<unsigned int&&>, std::tuple<> > (stl_tree.h:403)
>> ==33713==    by 0x8AB755: _M_emplace_hint_unique<const std::piecewise_construct_t&, std::tuple<unsigned int&&>, std::tuple<> > (stl_tree.h:1669)
>> ==33713==    by 0x8AB755: operator[] (stl_map.h:484)
>> ==33713==    by 0x8AB755: bluestore_extent_ref_map_t::decode(ceph::buffer::list::iterator&) (bluestore_types.cc:366)
>> ==33713==    by 0x86339D: BlueStore::ExtentMap::decode_spanning_blobs(BlueStore::Collection*, ceph::buffer::list::iterator&) (BlueStore.cc:1761)
>> ==33713==    by 0x86BCFA: BlueStore::Collection::get_onode(ghobject_t const&, bool) (BlueStore.cc:2138)
>> ==33713==    by 0x88EF74: BlueStore::_txc_add_transaction(BlueStore::TransContext*, ObjectStore::Transaction*) (BlueStore.cc:6608)
>> ==33713==    by 0x8954E1: BlueStore::queue_transactions(ObjectStore::Sequencer*, std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*) (BlueStore.cc:6435)
>> ==33713==    by 0x67DDAB: queue_transactions (ObjectStore.h:1824)
>> ==33713==    by 0x67DDAB: ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<OpRequest>) (ReplicatedPG.h:277)
>> ==33713==    by 0x74E99E: ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>) (ReplicatedBackend.cc:1195)
>> ==33713==    by 0x74F312: ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>) (ReplicatedBackend.cc:217)
>> ==33713==    by 0x620929: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1589)
>> ==33713==    by 0x4DA0D4: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8871)
>> ==33713==    by 0x4DA2FC: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
>>
>>
>> ==33713== 15,907,184 (1,118,568 direct, 14,788,616 indirect) bytes in 4,237 blocks are definitely lost in loss record 138 of 142
>> ==33713==    at 0x9FC22C0: operator new(unsigned long) (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>> ==33713==    by 0x863079: BlueStore::ExtentMap::decode_spanning_blobs(BlueStore::Collection*, ceph::buffer::list::iterator&) (BlueStore.cc:1756)
>> ==33713==    by 0x86BCFA: BlueStore::Collection::get_onode(ghobject_t const&, bool) (BlueStore.cc:2138)
>> ==33713==    by 0x86E6A2: BlueStore::getattr(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, char const*, ceph::buffer::ptr&) (BlueStore.cc:5003)
>> ==33713==    by 0x69D333: PGBackend::objects_get_attr(hobject_t const&, std::string const&, ceph::buffer::list*) (PGBackend.cc:212)
>> ==33713==    by 0x6240C7: ReplicatedPG::get_object_context(hobject_t const&, bool, std::map<std::string, ceph::buffer::list, std::less<std::string>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*) (ReplicatedPG.cc:9148)
>> ==33713==    by 0x6323F8: ReplicatedPG::find_object_context(hobject_t const&, std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*) (ReplicatedPG.cc:9249)
>> ==33713==    by 0x6611D0: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:1972)
>> ==33713==    by 0x620F6B: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1612)
>> ==33713==    by 0x4DA0D4: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8871)
>> ==33713==    by 0x4DA2FC: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
>> ==33713==    by 0x4FB49E: internal_visit<std::shared_ptr<OpRequest> > (variant.hpp:1048)
>> ==33713==    by 0x4FB49E: visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, std::shared_ptr<OpRequest> > (visitation_impl.hpp:130)
>> ==33713==    by 0x4FB49E: visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, std::shared_ptr<OpRequest>, boost::variant<std::shared_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_> (visitation_impl.hpp:173)
>> ==33713==    by 0x4FB49E: visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, std::shared_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<std::shared_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_> (visitation_impl.hpp:256)
>> ==33713==    by 0x4FB49E: internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*> (variant.hpp:2367)
>> ==33713==    by 0x4FB49E: internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> > (variant.hpp:2378)
>> ==33713==    by 0x4FB49E: apply_visitor<PGQueueable::RunVis> (variant.hpp:2401)
>> ==33713==    by 0x4FB49E: apply_visitor<PGQueueable::RunVis, boost::variant<std::shared_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> > (apply_visitor_unary.hpp:60)
>> ==33713==    by 0x4FB49E: run (OSD.h:410)
>> ==33713==    by 0x4FB49E: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (OSD.cc:8752)
>>
>>
>> Is this because spanning_blob_map is growing unbounded till the next reshard which can happen much later ?
>> If the blob is spanned which is most likely happening in case of my preconditioned case (and small image), this could fill up memory very fast.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Somnath Roy
>> Sent: Monday, September 12, 2016 6:35 PM
>> To: 'Mark Nelson'; 'ceph-devel'
>> Subject: RE: Bluestore memory leak
>>
>> Mark/Sage,
>> Did some longer runs and it seems traces are similar and leaks are getting bigger over time.
>>
>> ==1206464== LEAK SUMMARY:
>> ==1206464==    definitely lost: 25,115,152 bytes in 490,345 blocks
>> ==1206464==    indirectly lost: 265,754,576 bytes in 1,587,729 blocks
>> ==1206464==      possibly lost: 54,440 bytes in 166 blocks
>> ==1206464==    still reachable: 771,078 bytes in 115 blocks
>> ==1206464==         suppressed: 0 bytes in 0 blocks
>>
>> OSD resident memory at this time is ~2G and out of that ~300 MB is *leaked* or consumed by growing data structure it seems. Rest is used for 2Q cache it seems (I used default shard and default cache settings).
>>
>> With further debugging it seems the following could be the reason for the growth.
>>
>> 1.  b->ref_map is growing on each op on either on the same blob or in a new blob. It's 8 bytes on each op.
>>
>> 2. ExtentMap:: inline_bl can grow till bluestore_extent_map_shard_max_size (1200 bytes) , this is bounded , so, no problem I guess. By default, for a 40TB image I was trying with it can grow ~20GB across cluster.
>>
>> 3. extent_map is growing on each op and it is storing the blob. So, it is big and it is only been discarded from punch_hole() which will put the extent in the old_extents list based on conditions. That means depending on the io pattern extent_mpa can grow unbounded ?
>>
>> 4. The old_extents are supposed to be deleted from wctx_finish but I found only blobs are dereferenced , Extent objects are not deleted. Extent is also not a ref counted object it seems..
>>
>> Let me know if I am missing anything.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Somnath Roy
>> Sent: Monday, September 12, 2016 2:40 PM
>> To: 'Mark Nelson'; ceph-devel
>> Subject: RE: Bluestore memory leak
>>
>> I didn't run for long , but, 'definitely lost' is leak according to memcheck. I am not sure how good it is of detecting auto pointers though..
>> I can run longer and see if anything new is coming..
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Monday, September 12, 2016 2:17 PM
>> To: Somnath Roy; ceph-devel
>> Subject: Re: Bluestore memory leak
>>
>> On 09/12/2016 03:54 PM, Somnath Roy wrote:
>>> Mark,
>>> Thanks for soname* param , it worked with tcmalloc for me..
>>>
>>> Sage,
>>> Please find the valgrind memcheck output here..
>>> https://docs.google.com/document/d/12yx8jVmdkXrYPmq4DSxcdUBWc8xKrPjJD
>>> O
>>> TES299_do/edit?usp=sharing
>>>
>>> It seems it is leaking memory (see 'definitely lost')..I will go
>>> through the code and try to find out if those are valid or not.
>>> Thought of sharing with you meanwhile as it will be much faster if
>>> you have time to look as well :-)
>>
>> How big had the per-OSD RSS memory grown at this point?  Looks like we're only seeing about 408K definitely lost and 3953K indirectly lost in the totals at the end.  That's notable, but given the amounts of memory we are talking about, it doesn't seem like we are seeing the real culprit(s).
>>
>>>
>>> Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
>>> Sent: Thursday, September 08, 2016 1:32 PM
>>> To: Mark Nelson; ceph-devel
>>> Subject: RE: Bluestore memory leak
>>>
>>> Yes, a bit probably :-)..Will try to find out from where it is leaking..
>>>
>>> -----Original Message-----
>>> From: Mark Nelson [mailto:mnelson@redhat.com]
>>> Sent: Thursday, September 08, 2016 1:28 PM
>>> To: Somnath Roy; ceph-devel
>>> Subject: Re: Bluestore memory leak
>>>
>>> What I'm seeing is that after 5 minutes of 4k random writes, my OSDs are using about half the memory they were previously.  I'm not sure we have entirely fixed it, but can you you confirm that it's at least growing slower than it used to?
>>>
>>> Mark
>>>
>>> On 09/08/2016 03:24 PM, Somnath Roy wrote:
>>>> Sage/Mark,
>>>> Leak is still there with latest master, I can't complete a 5 min run , memory is getting full.
>>>>
>>>> root@emsnode11:~/ceph-master/build# ceph -v
>>>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>>>> ceph version v11.0.0-2173-g0985370
>>>> (0985370d2d729c6b8ef373e2dc4241b0eea474bf)
>>>> root@emsnode11:~/ceph-master/build#
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>>
>>>> -----Original Message-----
>>>> From: Mark Nelson [mailto:mnelson@redhat.com]
>>>> Sent: Wednesday, September 07, 2016 7:04 PM
>>>> To: Somnath Roy; ceph-devel
>>>> Subject: Re: Bluestore memory leak
>>>>
>>>> Hi Somnath,
>>>>
>>>> I complained loudly and often enough to get Sage to take a look and he fixed a bunch of stuff. :)  The following PR dramatically improves things, though I haven't verified that it's totally fixed yet:
>>>>
>>>> https://github.com/ceph/ceph/pull/11011
>>>>
>>>> Mark
>>>>
>>>> On 09/07/2016 08:08 PM, Somnath Roy wrote:
>>>>> Sage,
>>>>> As Mark said, the latest code has severe memory leak , my system memory (64GB) started swapping after 3 min of 4K RW run.
>>>>>
>>>>> Thanks & Regards
>>>>> Somnath
>>>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
