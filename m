From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: osd assertion failure during scrub
Date: Mon, 16 Oct 2017 15:30:52 -0700
Message-ID: <CAJ4mKGYUKKZXVSxiRXYCdCXds5-L12mNNwZOf790WUJ42=+BhA@mail.gmail.com>
References: <2C34118C-8D26-43B0-88A4-207CC7361440@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:54074 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdJPWay (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Oct 2017 18:30:54 -0400
Received: by mail-io0-f180.google.com with SMTP id 189so153573iow.10
        for <ceph-devel@vger.kernel.org>; Mon, 16 Oct 2017 15:30:54 -0700 (PDT)
In-Reply-To: <2C34118C-8D26-43B0-88A4-207CC7361440@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

[ Resend to avoid HTML email; sorry for the double. ]

On Mon, Oct 16, 2017 at 5:58 AM, 陶冬冬 <tdd21151186@gmail.com> wrote:
> Dear Cephers,
>
> ceph version: 10.2.5
>
> log below here:
> 0> 2017-10-16 03:30:18.346892 7fa278797700 -1 os/filestore/LFNIndex.cc: In function 'int LFNIndex::list_objects(const std::vector<std::basic_string<char> >&, int, long int*, std::map<std::basic_string<char>, ghobject_t>*)' thread 7fa278797700 time 2017-10-16 03:30:18.342894
> os/filestore/LFNIndex.cc: 443: FAILED assert(long_name == short_name)
>
>  ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x85) [0x55ca3e69a425]
>  2: (LFNIndex::list_objects(std::vector<std::string, std::allocator<std::string> > const&, int, long*, std::map<std::string, ghobject_t, std::less<std::string>, std::allocator<std::pair<std::string const, ghobject_t> > >*)+0x282) [0x55ca3e399642]
>  3: (HashIndex::get_path_contents_by_hash_bitwise(std::vector<std::string, std::allocator<std::string> > const&, ghobject_t const*, std::set<std::string, HashIndex::CmpHexdigitStringBitwise, std::allocator<std::string> >*, std::set<std::pair<std::string, ghobject_t>, HashIndex::CmpPairBitwise, std::allocator<std::pair<std::string, ghobject_t> > >*)+0x92) [0x55ca3e44c3c2]
>  4: (HashIndex::list_by_hash_bitwise(std::vector<std::string, std::allocator<std::string> > const&, ghobject_t const&, int, ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> >*)+0x157) [0x55ca3e44ccd7]
>  5: (HashIndex::list_by_hash_bitwise(std::vector<std::string, std::allocator<std::string> > const&, ghobject_t const&, int, ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> >*)+0x43b) [0x55ca3e44cfbb]
>  6: (HashIndex::list_by_hash_bitwise(std::vector<std::string, std::allocator<std::string> > const&, ghobject_t const&, int, ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> >*)+0x43b) [0x55ca3e44cfbb]
>  7: (HashIndex::list_by_hash_bitwise(std::vector<std::string, std::allocator<std::string> > const&, ghobject_t const&, int, ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> >*)+0x43b) [0x55ca3e44cfbb]
>  8: (HashIndex::_collection_list_partial(ghobject_t const&, ghobject_t const&, bool, int, std::vector<ghobject_t, std::allocator<ghobject_t> >*, ghobject_t*)+0x1c2) [0x55ca3e44ea72]
>  9: (FileStore::collection_list(coll_t const&, ghobject_t, ghobject_t, bool, int, std::vector<ghobject_t, std::allocator<ghobject_t> >*, ghobject_t*)+0x38e) [0x55ca3e3430fe]
>  10: (ObjectStore::collection_list(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t, ghobject_t, bool, int, std::vector<ghobject_t, std::allocator<ghobject_t> >*, ghobject_t*)+0x1a8) [0x55ca3e2cc4b8]
>  11: (PGBackend::objects_list_partial(hobject_t const&, int, int, std::vector<hobject_t, std::allocator<hobject_t> >*, hobject_t*)+0x4d4) [0x55ca3e1d89a4]
>  12: (PG::chunky_scrub(ThreadPool::TPHandle&)+0x9af) [0x55ca3e0dfddf]
>  13: (PG::scrub(unsigned int, ThreadPool::TPHandle&)+0x230) [0x55ca3e0e0fb0]
>  14: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x80e) [0x55ca3e012b3e]
>  15: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) [0x55ca3e68a3c7]
>  16: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55ca3e68c330]
>
> Paste the failure code here:
> -----------------------------------------
> if (lfn_is_objecthort_name)) {
>       r = lfn_translate(to_list, short_name, &obj);
>       if (r == -EINVAL) {
>         continue;
>       } else if (r < 0) {
>         goto cleanup;
>       } else {
>         string long_name = lfn_generate_object_name(obj);
>         if (!lfn_must_hash(long_name)) {
>           assert(long_name == short_name);     — assert failure here.
>         }
> --------------------------------------
> is there any way could let me know which object is causing this failure?
> and what would cause such kind failure?

If you post the whole log (you can upload it with ceph-post-file and
only Ceph devs will have access), it should be trivial to identify.
Generally you'll see a named object and request which is being
serviced by this lookup.

In this case, the LFNIndex is trying to convert the naive Long File
Name of an object into names short enough to play nicely with local
filesystems. It shortens them via hashing and has a bunch of extension
tricks to deal with collisions. The particular assert is that, if the
name is short enough to not need hashing, then the long and short
names should be identical. Apparently they aren't? I'm surprised you
found an issue here, though — this is pretty old and stable code. Has
anything strange happened to your cluster? Or are you running some
custom code?
-Greg
