From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Proposing strategies for debuginfo size reduction
Date: Mon, 6 Mar 2017 19:23:49 +1000
Message-ID: <CAF-wwdE8hcCHdPksDPYse7gDnozqrcPZ4s_pCEi4t_GPbTg3eg@mail.gmail.com>
References: <CAF-wwdHTkEAGchaPD=qV0tuVNtrevhG0=ny1SdDz7-vbTXE3BQ@mail.gmail.com>
 <CAJE9aOP=bd8iLh3ay7uv6qRSqNU30LT8V2h+LTO48PtiZufAvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36176 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbdCFJbs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 04:31:48 -0500
Received: by mail-it0-f43.google.com with SMTP id h10so45578991ith.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 01:31:42 -0800 (PST)
In-Reply-To: <CAJE9aOP=bd8iLh3ay7uv6qRSqNU30LT8V2h+LTO48PtiZufAvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 6, 2017 at 6:37 PM, kefu chai <tchaikov@gmail.com> wrote:
>> First I went looking for an easy win and I believe there may be one to
>> be had in the fact that we include debuginfo for the ceph_test_*
>> binaries. Do we need to produce debuginfo for them? They currently
>> represent about 800+M on disk so could represent a quick and easy way
>> to reduce the size of the debuginfo we ship.
>
> we do, so we can perform post-mortem debugging with the coredump if any
> of them crashes in the qa run. but maybe their debuginfo is not necessary
> for the builds intended be used by our users. but we still need to patch
> rpm[1]. and looks like the upstream does not like this idea[2]. as discussed

Yes, I mentioned splitting them into
> over IRC, maybe we need to understand the "underlying problem", i.e.
> who/what is the biggest contributor of the 800+M debuginfo before going
> any further.

$ cd usr
$ du . --max-depth=1
3414960 ./lib
57388   ./src
3472348 .
$ cd lib/debug/
$ du . --max-depth=1
136     ./.build-id
174596  ./.dwz
3240228 ./usr
3414960 .
$ cd usr
$ du . --max-depth=1
2868212 ./bin
371924  ./lib64
92      ./sbin
3240228 .
$ cd bin
$ ls -lhS|head -50
total 2.8G
-r--r--r--. 1 brad brad 220M Mar  6 14:11 ceph-osd.debug
-r--r--r--. 1 brad brad 171M Mar  6 14:10 ceph-mds.debug
-r--r--r--. 1 brad brad 164M Mar  6 14:10 ceph-dencoder.debug
-r--r--r--. 1 brad brad 151M Mar  6 14:11 ceph-objectstore-tool.debug
-r--r--r--. 1 brad brad 143M Mar  6 14:11 ceph-mon.debug
-r--r--r--. 1 brad brad 117M Mar  6 14:11 ceph_test_rbd_mirror.debug
-r--r--r--. 1 brad brad 103M Mar  6 14:11 cephfs-journal-tool.debug
-r--r--r--. 1 brad brad 100M Mar  6 14:11 ceph_test_librbd.debug
-r--r--r--. 1 brad brad 100M Mar  6 14:11 rbd-mirror.debug
-r--r--r--. 1 brad brad  98M Mar  6 14:11 cephfs-data-scan.debug
-r--r--r--. 1 brad brad  96M Mar  6 14:10 ceph-mgr.debug
-r--r--r--. 1 brad brad  96M Mar  6 14:11 cephfs-table-tool.debug
-r--r--r--. 1 brad brad  78M Mar  6 14:11 radosgw.debug
-r--r--r--. 1 brad brad  75M Mar  6 14:11 ceph_test_objectstore.debug
-r--r--r--. 1 brad brad  68M Mar  6 14:11
ceph_test_filestore_idempotent_sequence.debug
-r--r--r--. 1 brad brad  68M Mar  6 14:11 ceph_test_filejournal.debug
-r--r--r--. 1 brad brad  68M Mar  6 14:11 ceph_smalliobenchfs.debug
-r--r--r--. 1 brad brad  66M Mar  6 14:11 ceph_objectstore_bench.debug
-r--r--r--. 1 brad brad  66M Mar  6 14:11 ceph_xattr_bench.debug
-r--r--r--. 1 brad brad  51M Mar  6 14:11 radosgw-admin.debug
-r--r--r--. 1 brad brad  44M Mar  6 14:11 ceph_test_cls_rgw_meta.debug
-r--r--r--. 1 brad brad  42M Mar  6 14:11 radosgw-object-expirer.debug
-r--r--r--. 1 brad brad  41M Mar  6 14:11 ceph_rgw_jsonparser.debug
-r--r--r--. 1 brad brad  37M Mar  6 14:11 ceph-monstore-tool.debug
-r--r--r--. 1 brad brad  37M Mar  6 14:11 ceph-osdomap-tool.debug
-r--r--r--. 1 brad brad  37M Mar  6 14:11 ceph_test_keyvaluedb.debug
-r--r--r--. 1 brad brad  35M Mar  6 14:10 ceph-kvstore-tool.debug
-r--r--r--. 1 brad brad  26M Mar  6 14:11 ceph_test_rados_api_tier.debug
-r--r--r--. 1 brad brad  25M Mar  6 14:11 rbd.debug
-r--r--r--. 1 brad brad  19M Mar  6 14:11 ceph_test_rados_api_misc.debug
-r--r--r--. 1 brad brad  19M Mar  6 14:11 ceph_test_rados_api_snapshots.debug
-r--r--r--. 1 brad brad  18M Mar  6 14:11 ceph_test_rados_api_watch_notify.debug
-r--r--r--. 1 brad brad  18M Mar  6 14:11 ceph_test_rados_api_list.debug
-r--r--r--. 1 brad brad  18M Mar  6 14:11 ceph-syn.debug
-r--r--r--. 1 brad brad  18M Mar  6 14:11 ceph_test_rados_api_lock.debug
-r--r--r--. 1 brad brad  18M Mar  6 14:11 ceph_test_rados_api_stat.debug
-r--r--r--. 1 brad brad  17M Mar  6 14:11 ceph_test_rados_api_cmd.debug
-r--r--r--. 1 brad brad  17M Mar  6 14:11 ceph_test_rados_api_pool.debug
-r--r--r--. 1 brad brad  16M Mar  6 14:10 ceph-fuse.debug
-r--r--r--. 1 brad brad  15M Mar  6 14:10 ceph-client-debug.debug
-r--r--r--. 1 brad brad  13M Mar  6 14:11 ceph_test_librbd_api.debug
-r--r--r--. 1 brad brad  11M Mar  6 14:11 ceph_test_cls_rbd.debug
-r--r--r--. 1 brad brad  10M Mar  6 14:11 ceph_test_mon_workloadgen.debug
-r--r--r--. 1 brad brad 9.1M Mar  6 14:11 ceph_test_rados_api_aio.debug
-r--r--r--. 1 brad brad 8.5M Mar  6 14:11 ceph_test_libcephfs.debug
-r--r--r--. 1 brad brad 6.9M Mar  6 14:11 rados.debug
-r--r--r--. 1 brad brad 6.5M Mar  6 14:11 ceph_test_librbd_fsx.debug
-r--r--r--. 1 brad brad 6.1M Mar  6 14:11 ceph_test_rados_api_io.debug
-r--r--r--. 1 brad brad 6.0M Mar  6 14:10 ceph-bluefs-tool.debug

>
>>
>> Another option that has been discussed may be to split the debuginfo
>> package into various sub-packages that align somewhat with the
>> sub-packages we currently generate. I believe this already happens to
>> some degree in the deb packaging. Unfortunately, this is not
>> straight-forward to achieve with rpm based distros although I note
>> that OpenSUSE have gone down this path.A the problem with these two
>> approaches IMHO is that they don't directly address the issue of why
>
> please see http://tracker.ceph.com/issues/19099#note-16.
>
>
>> the debuginfo package is so large.
>>
>> I then looked at compiler options that may help.
>>
>> With the addition of the following line to CMakeLists.txt we see a
>> significant reduction in the size of the debuginfo.
>>
>> set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -femit-struct-debug-reduced")
>>
>> ceph-debuginfo-12.0.0-812.g60fccb2.el7.x86_64.rpm  06-Mar-2017 01:08
>>         661507672
>>
>> Changing that CMakeLists.txt line to the following reduces it further.
>>
>> set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -femit-struct-debug-baseonly")
>>
>> ceph-debuginfo-12.0.0-812.gac37464.el7.x86_64.rpm  06-Mar-2017 02:37
>>         513097340
>>
>> These flags seem to be the only ones that make a significant difference
>> [1].
>>
>> The scary part here is that these flags result in some loss of
>> debuginfo, how much and how that would affect debugging I'm still
>> trying to determine. There are strategies to include debuginfo that
>> may be omitted [2]. I'd suggest thought that this option would need a
>> lot more research and some testing.
>>
>> The final suggestion is based on speculation and therefore requires
>> further investigation, discussion, planning and testing before moving
>> forward. I *suspect* that the reason our debuginfo package is so large
>> is due to all the static linking we do and I would suggest that
>> reducing the amount of static linking would go a long way to reduce
>> the size of the debuginfo. Currently we statically link rocksdb,
>> boost, civetweb, zstd, and isa-l at least as well as libceph-common
>> and possibly others on a per-binary basis but these are the main ones.
>
> this is not accurate. currently, libceph-common statically links against
> these libraries. and our tests and client side tools are linked against
> libceph-common, so they are not duplicated among them.
>
> but because this library is included by librados2 which is not depended
> by the daemons, like, ceph-osd, ceph-mon. and these daemons have
> their own copy of these libraries. so if we want to dedup the shared
> code/debuginfo further, we should create a dedicated package so
> both client/tests and daemons can depend on it. because i don't think
> that the ceph-osd and its friends should depend on librados, which
> is a client side library/package.
>
>> One possible solution to this may be to build our own shared objects
>> and dynamically link to them (libcephboost_system.so,
>> libcephboost_program_options.so, libcephrocksdb.so, etc.) We would
>> then, of course, have to package these but I suspect it would actually
>> lead to a smaller on-disk footprint. If my suspicion is right this
>> will significantly reduce the size of the debuginfo we package but, of
>> course, this would need to be validated and I welcome the thoughts and
>> opinions of others about the merit of this approach as well as the
>> others mentioned.
>
> i don't think the downstreams would be in favor of this solution. as the
> only
> point of splitting them is to have smaller debuginfo. these so will be only
> used by libceph-common. even if we go this way, we still have problem
> for packaging the debuginfo of them: we cannot do this without patching
> the rpm, see
>
> ---
> [1] SuSE's patch of rpm for splitting debuginfo into subpackage,
>
> https://build.opensuse.org/package/view_file?file=debugsubpkg.diff&package=rpm&project=openSUSE%3AFactory.
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=185590

Don't underestimate the power and influence of Frank :) The fact he
has updated this six years after it was WONTFIXed and the fact that it
is still open at all means it has some ongoing support and will likely
be revisited periodically however I agree with you that we should look
to address the underlying cause and ask ourselves what are we doing
that is so out of step with everyone else and leading to this huge
amount of debuginfo. I can site examples of people both within the
project and without complaining about the size of our debuginfo so
it's not just me ;)

>
>>
>> Looking forward to people's thoughts on this.
>>
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
>> [2] http://opengrok.baylibre.com/source/history/linux/lib/debug_info.c
>>
>>
>> --
>> Cheers,
>> Brad
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai



-- 
Cheers,
Brad
