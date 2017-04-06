From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 06 Apr 2017 02:40:45 -0700
Message-ID: <58e60d1d7b8fe_703d12f732070283@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:38254 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753908AbdDFJkr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 05:40:47 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id IdRTFBFCTGWHRW0EHjW7rA
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 09:40:45.548 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

10 new defect(s) introduced to ceph found with Coverity Scan.
16 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 10 of 10 defect(s)


** CID 1394846:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/tools/rbd/Utils.cc: 371 in rbd::utils::get_pool_image_snapshot_names(const boost::program_options::variables_map &, rbd::argument_types::ArgumentModifier, unsigned long *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, rbd::utils::SnapshotPresence, rbd::utils::SpecValidation, bool)()


________________________________________________________________________________________________________
*** CID 1394846:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/tools/rbd/Utils.cc: 371 in rbd::utils::get_pool_image_snapshot_names(const boost::program_options::variables_map &, rbd::argument_types::ArgumentModifier, unsigned long *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, rbd::utils::SnapshotPresence, rbd::utils::SpecValidation, bool)()
365           if (r < 0) {
366             return r;
367           }
368         }
369       }
370     
>>>     CID 1394846:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "pool_name" to null implies that "pool_name" might be null.
371       if (pool_name != nullptr && pool_name->empty()) {
372         *pool_name = at::DEFAULT_POOL_NAME;
373       }
374     
375       if (image_name != nullptr && image_required && image_name->empty()) {
376         std::string prefix = at::get_description_prefix(mod);

** CID 1404864:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 778 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int, unsigned long)()


________________________________________________________________________________________________________
*** CID 1404864:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 778 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int, unsigned long)()
772             goto done;
773           }
774           assert(bdev_size >= 0);
775           size = (uint64_t) bdev_size;
776         }
777     #ifdef HAVE_POSIX_FADVISE
>>>     CID 1404864:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
778         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
779     #endif
780       }
781     
782       r = do_import_header(fd, import_format, size, opts);
783       if (r < 0) {

** CID 1404865:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI6MgrMapE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1404865:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI6MgrMapE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1404865:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1404866:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI14creating_pgs_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1404866:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI14creating_pgs_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1404866:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1404867:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 835 in __event_prepare_filter_stack__librbd___copy4_enter()


________________________________________________________________________________________________________
*** CID 1404867:  Integer handling issues  (NO_EFFECT)
/include/tracing/librbd.h: 835 in __event_prepare_filter_stack__librbd___copy4_enter()
829             int, retval),
830         TP_FIELDS(
831             ctf_integer(int, retval, retval)
832         )
833     )
834     
>>>     CID 1404867:  Integer handling issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. "18446744073709551615UL < 0UL".
835     TRACEPOINT_EVENT(librbd, copy4_enter,
836         TP_ARGS(
837             void*, src_imagectx,
838             const char*, src_name,
839             const char*, src_snap_name,
840             char, src_read_only,

** CID 1404868:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1404868:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/mon/CreatingPGs.h: 15 in creating_pgs_t::encode(ceph::buffer::list &) const()
9     
10     struct creating_pgs_t {
11       epoch_t last_scan_epoch = 0;
12       std::map<pg_t, std::pair<epoch_t, utime_t> > pgs;
13       std::set<int64_t> created_pools;
14       void encode(bufferlist& bl) const {
>>>     CID 1404868:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
15         ENCODE_START(1, 1, bl);
16         ::encode(last_scan_epoch, bl);
17         ::encode(pgs, bl);
18         ::encode(created_pools, bl);
19         ENCODE_FINISH(bl);
20       }

** CID 1404869:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/mgr/DaemonServer.cc: 1 in ()


________________________________________________________________________________________________________
*** CID 1404869:  Parse warnings  (PARSE_ERROR)
/home/brad/working/src/ceph/src/mgr/DaemonServer.cc: 1 in ()
>>>     CID 1404869:  Parse warnings  (PARSE_ERROR)
>>>     The Coverity compiler fails to compile this file. Please see the build output log for more information.
1     // -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
2     // vim: ts=8 sw=2 smarttab
3     /*
4      * Ceph - scalable distributed file system
5      *
6      * Copyright (C) 2016 John Spray <john.spray@redhat.com>

** CID 1404870:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()


________________________________________________________________________________________________________
*** CID 1404870:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404870:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;

** CID 1404871:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()


________________________________________________________________________________________________________
*** CID 1404871:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404871:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404871:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404871:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404871:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404871:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;

** CID 1404872:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()


________________________________________________________________________________________________________
*** CID 1404872:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404872:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404872:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404872:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;
/home/brad/working/src/ceph/src/os/bluestore/bluestore_tool.cc: 28 in main()
22     
23     void usage(po::options_description &desc)
24     {
25       cout << desc << std::endl;
26     }
27     
>>>     CID 1404872:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
28     int main(int argc, char **argv)
29     {
30       string out_dir;
31       vector<string> devs;
32       string path;
33       string action;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8ESAs-2By74XaS-2B3Sav9bPnm1S5ZHtHAVePRnf4ZDGWX0Rwi4aWJ9xFGZJmkqePxx6ljblODBpSCl-2BfxIlMebw-2BOSVXPZmnPQU33miY3DT33DIwN1bzt-2BJEx-2FwNiZGOqlzP8SGSHjwGg4BFdptgCJ610o6X64ZaQ5cDxiuG-2FC6kq00KEfIWoD07f68S6GWASxBeU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8ESAs-2By74XaS-2B3Sav9bPnm1S5ZHtHAVePRnf4ZDGWX0R-2FAk3-2BU7l-2F-2Fty6HM-2F7UV1v758q-2FEhCe6GEEcRMKWDekfoJIsd0-2BUBBFSKgMPiTAhPqqJY6fCDrJg6KTOOBRY5A4oPw6adtBMVR3vh-2FGGCpP8aHGQ1WvbjVIZxjj1iTtTo8eeNxO-2B1B1shxEvpLnMgX4-3D

