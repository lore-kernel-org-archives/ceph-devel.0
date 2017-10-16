From: =?utf-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Subject: osd assertion failure during scrub
Date: Mon, 16 Oct 2017 20:58:27 +0800
Message-ID: <2C34118C-8D26-43B0-88A4-207CC7361440@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:47001 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdJPM6d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Oct 2017 08:58:33 -0400
Received: by mail-pg0-f43.google.com with SMTP id k7so6744627pga.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Oct 2017 05:58:33 -0700 (PDT)
Received: from [127.0.0.1] ([104.207.157.57])
        by smtp.gmail.com with ESMTPSA id z6sm14942388pfe.114.2017.10.16.05.58.30
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Oct 2017 05:58:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear Cephers,

ceph version: 10.2.5

log below here:
0> 2017-10-16 03:30:18.346892 7fa278797700 -1 os/filestore/LFNIndex.cc: =
In function 'int LFNIndex::list_objects(const =
std::vector<std::basic_string<char> >&, int, long int*, =
std::map<std::basic_string<char>, ghobject_t>*)' thread 7fa278797700 =
time 2017-10-16 03:30:18.342894
os/filestore/LFNIndex.cc: 443: FAILED assert(long_name =3D=3D =
short_name)

 ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char =
const*)+0x85) [0x55ca3e69a425]
 2: (LFNIndex::list_objects(std::vector<std::string, =
std::allocator<std::string> > const&, int, long*, std::map<std::string, =
ghobject_t, std::less<std::string>, std::allocator<std::pair<std::string =
const, ghobject_t> > >*)+0x282) [0x55ca3e399642]
 3: =
(HashIndex::get_path_contents_by_hash_bitwise(std::vector<std::string, =
std::allocator<std::string> > const&, ghobject_t const*, =
std::set<std::string, HashIndex::CmpHexdigitStringBitwise, =
std::allocator<std::string> >*, std::set<std::pair<std::string, =
ghobject_t>, HashIndex::CmpPairBitwise, =
std::allocator<std::pair<std::string, ghobject_t> > >*)+0x92) =
[0x55ca3e44c3c2]
 4: (HashIndex::list_by_hash_bitwise(std::vector<std::string, =
std::allocator<std::string> > const&, ghobject_t const&, int, =
ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> =
>*)+0x157) [0x55ca3e44ccd7]
 5: (HashIndex::list_by_hash_bitwise(std::vector<std::string, =
std::allocator<std::string> > const&, ghobject_t const&, int, =
ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> =
>*)+0x43b) [0x55ca3e44cfbb]
 6: (HashIndex::list_by_hash_bitwise(std::vector<std::string, =
std::allocator<std::string> > const&, ghobject_t const&, int, =
ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> =
>*)+0x43b) [0x55ca3e44cfbb]
 7: (HashIndex::list_by_hash_bitwise(std::vector<std::string, =
std::allocator<std::string> > const&, ghobject_t const&, int, =
ghobject_t*, std::vector<ghobject_t, std::allocator<ghobject_t> =
>*)+0x43b) [0x55ca3e44cfbb]
 8: (HashIndex::_collection_list_partial(ghobject_t const&, ghobject_t =
const&, bool, int, std::vector<ghobject_t, std::allocator<ghobject_t> =
>*, ghobject_t*)+0x1c2) [0x55ca3e44ea72]
 9: (FileStore::collection_list(coll_t const&, ghobject_t, ghobject_t, =
bool, int, std::vector<ghobject_t, std::allocator<ghobject_t> >*, =
ghobject_t*)+0x38e) [0x55ca3e3430fe]
 10: =
(ObjectStore::collection_list(boost::intrusive_ptr<ObjectStore::Collection=
Impl>&, ghobject_t, ghobject_t, bool, int, std::vector<ghobject_t, =
std::allocator<ghobject_t> >*, ghobject_t*)+0x1a8) [0x55ca3e2cc4b8]
 11: (PGBackend::objects_list_partial(hobject_t const&, int, int, =
std::vector<hobject_t, std::allocator<hobject_t> >*, hobject_t*)+0x4d4) =
[0x55ca3e1d89a4]
 12: (PG::chunky_scrub(ThreadPool::TPHandle&)+0x9af) [0x55ca3e0dfddf]
 13: (PG::scrub(unsigned int, ThreadPool::TPHandle&)+0x230) =
[0x55ca3e0e0fb0]
 14: (OSD::ShardedOpWQ::_process(unsigned int, =
ceph::heartbeat_handle_d*)+0x80e) [0x55ca3e012b3e]
 15: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) =
[0x55ca3e68a3c7]
 16: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) =
[0x55ca3e68c330]

Paste the failure code here:
-----------------------------------------
if (lfn_is_objecthort_name)) {
      r =3D lfn_translate(to_list, short_name, &obj);
      if (r =3D=3D -EINVAL) {
        continue;
      } else if (r < 0) {
        goto cleanup;
      } else {
        string long_name =3D lfn_generate_object_name(obj);=20
        if (!lfn_must_hash(long_name)) {
          assert(long_name =3D=3D short_name);     =E2=80=94 assert =
failure here.
        }
--------------------------------------
is there any way could let me know which object is causing this failure? =
=20
and what would cause such kind failure?=20

Regards,
Dongdong


