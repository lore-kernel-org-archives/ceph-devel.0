From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #1408
Date: Fri, 3 Nov 2017 17:25:52 -0400
Message-ID: <c6fffd21-7eb3-64cb-e404-92fe37fb733d@redhat.com>
References: <14085029.62.1509737256278.JavaMail.jenkins@cephdev.digiware.nl>
 <fe5aaa26-d32e-916f-2af6-91ba5a4ab11e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:50569 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdKCVZz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Nov 2017 17:25:55 -0400
Received: by mail-ot0-f182.google.com with SMTP id 15so3799145otj.7
        for <ceph-devel@vger.kernel.org>; Fri, 03 Nov 2017 14:25:55 -0700 (PDT)
In-Reply-To: <fe5aaa26-d32e-916f-2af6-91ba5a4ab11e@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Willem, (and resending to list because the first one bounced)

I think this one is related to your boost version. In my builds, I see 
that boost::beast::string_ref is typedef'd to boost::string_ref and this 
builds. Your output implies that it's typedef'ed to boost::string_view.

https://github.com/boostorg/beast/commit/64ff766b2304c751e1a46d2b7ca948cd274c5739 
added some preprocessor stuff that switches from one to the other based 
on whether BOOST_VERSION >= 106400. You might try defining 
BEAST_NO_BOOST_STRING_VIEW to work around that for now.

Going forward, we'll probably just need to add an overload to 
RGWEnv::set() that takes boost::string_view.

Sorry about the trouble - we'll probably have more issues in the future 
because we're currently using Beast as a submodule, but it will also be 
in boost in 1.66 iirc.

Casey


On 11/03/2017 04:49 PM, Willem Jan Withagen wrote:
>
> Hi Casey,
>
> Something you changed in rgw does not really sit very well with
> FreeBSD/clang. I guess some of the std <> Boost <> Beast conversion is 
> being handled a bit more picky by Clang.
>
> Do you have a suggestion on how to fix?
>
> Thanx
> --WjW
>
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #1408
> Date: Fri, 3 Nov 2017 20:27:34 +0100 (CET)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
>
> See 
> <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1408/display/redirect?page=changes>
>
> Changes:
>
> [cbodley] rgw: update beast frontend/submodule to v116
>
> [cbodley] rgw: set header/body size limits on beast parser
>
> [cbodley] rgw: beast frontend uses callbacks instead of coroutines
>
> [cbodley] rgw: beast frontend discards unread body before next header
>
> [cbodley] rgw: remove boost::coroutine and context deps
>
> [cbodley] rgw: ask beast parser about keepalive/close
>
> ------------------------------------------
> [...truncated 3.45 MB...]
>   void set(const boost::string_ref& name, const boost::string_ref& val);
> ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_asio_client.cc:56:18: 
> error: no viable conversion from 'const boost::basic_string_view<char, 
> std::__1::char_traits<char> >' to 'const boost::string_ref' (aka 
> 'const basic_string_ref<char, std::char_traits<char> >')
>     env.set(buf, value);
>                  ^~~~~
> /usr/local/include/boost/utility/string_ref.hpp:70:25: note: candidate 
> constructor not viable: no known conversion from 'const 
> boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const boost::basic_string_ref<char, std::__1::char_traits<char> > &' 
> for 1st argument
>         BOOST_CONSTEXPR basic_string_ref (const basic_string_ref &rhs) 
> BOOST_NOEXCEPT
>                         ^
> /usr/local/include/boost/utility/string_ref.hpp:88:9: note: candidate 
> constructor not viable: no known conversion from 'const 
> boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const char *' for 1st argument
>         basic_string_ref(const charT* str) BOOST_NOEXCEPT
>         ^
> /usr/local/include/boost/utility/string_ref.hpp:92:9: note: candidate 
> template ignored: could not match 'basic_string' against 
> 'basic_string_view'
>         basic_string_ref(const std::basic_string<charT, traits, 
> Allocator>& str)
>         ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_common.h:406:68: note: 
> passing argument to parameter 'val' here
>   void set(const boost::string_ref& name, const boost::string_ref& val);
> ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_asio_client.cc:64:29: 
> error: no viable conversion from 'boost::beast::string_view' (aka 
> 'basic_string_view<char, std::char_traits<char> >') to 'const 
> boost::string_ref' (aka 'const basic_string_ref<char, 
> std::char_traits<char> >')
>   env.set("REQUEST_METHOD", request.method_string());
>                             ^~~~~~~~~~~~~~~~~~~~~~~
> /usr/local/include/boost/utility/string_ref.hpp:70:25: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::beast::string_view' (aka 'basic_string_view<char, 
> std::char_traits<char> >') to 'const boost::basic_string_ref<char, 
> std::__1::char_traits<char> > &' for 1st argument
>         BOOST_CONSTEXPR basic_string_ref (const basic_string_ref &rhs) 
> BOOST_NOEXCEPT
>                         ^
> /usr/local/include/boost/utility/string_ref.hpp:88:9: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::beast::string_view' (aka 'basic_string_view<char, 
> std::char_traits<char> >') to 'const char *' for 1st argument
>         basic_string_ref(const charT* str) BOOST_NOEXCEPT
>         ^
> /usr/local/include/boost/utility/string_ref.hpp:92:9: note: candidate 
> template ignored: could not match 'basic_string' against 
> 'basic_string_view'
>         basic_string_ref(const std::basic_string<charT, traits, 
> Allocator>& str)
>         ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_common.h:406:68: note: 
> passing argument to parameter 'val' here
>   void set(const boost::string_ref& name, const boost::string_ref& val);
> ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_asio_client.cc:72:26: 
> error: no viable conversion from 'boost::basic_string_view<char, 
> std::__1::char_traits<char> >' to 'const boost::string_ref' (aka 
> 'const basic_string_ref<char, std::char_traits<char> >')
>   env.set("REQUEST_URI", url);
>                          ^~~
> /usr/local/include/boost/utility/string_ref.hpp:70:25: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const boost::basic_string_ref<char, std::__1::char_traits<char> > &' 
> for 1st argument
>         BOOST_CONSTEXPR basic_string_ref (const basic_string_ref &rhs) 
> BOOST_NOEXCEPT
>                         ^
> /usr/local/include/boost/utility/string_ref.hpp:88:9: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const char *' for 1st argument
>         basic_string_ref(const charT* str) BOOST_NOEXCEPT
>         ^
> /usr/local/include/boost/utility/string_ref.hpp:92:9: note: candidate 
> template ignored: could not match 'basic_string' against 
> 'basic_string_view'
>         basic_string_ref(const std::basic_string<charT, traits, 
> Allocator>& str)
>         ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_common.h:406:68: note: 
> passing argument to parameter 'val' here
>   void set(const boost::string_ref& name, const boost::string_ref& val);
> ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_asio_client.cc:73:27: 
> error: no viable conversion from 'boost::basic_string_view<char, 
> std::__1::char_traits<char> >' to 'const boost::string_ref' (aka 
> 'const basic_string_ref<char, std::char_traits<char> >')
>   env.set("QUERY_STRING", query);
>                           ^~~~~
> /usr/local/include/boost/utility/string_ref.hpp:70:25: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const boost::basic_string_ref<char, std::__1::char_traits<char> > &' 
> for 1st argument
>         BOOST_CONSTEXPR basic_string_ref (const basic_string_ref &rhs) 
> BOOST_NOEXCEPT
>                         ^
> /usr/local/include/boost/utility/string_ref.hpp:88:9: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const char *' for 1st argument
>         basic_string_ref(const charT* str) BOOST_NOEXCEPT
>         ^
> /usr/local/include/boost/utility/string_ref.hpp:92:9: note: candidate 
> template ignored: could not match 'basic_string' against 
> 'basic_string_view'
>         basic_string_ref(const std::basic_string<charT, traits, 
> Allocator>& str)
>         ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_common.h:406:68: note: 
> passing argument to parameter 'val' here
>   void set(const boost::string_ref& name, const boost::string_ref& val);
> ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_asio_client.cc:74:25: 
> error: no viable conversion from 'boost::basic_string_view<char, 
> std::__1::char_traits<char> >' to 'const boost::string_ref' (aka 
> 'const basic_string_ref<char, std::char_traits<char> >')
>   env.set("SCRIPT_URI", url); /* FIXME */
>                         ^~~
> /usr/local/include/boost/utility/string_ref.hpp:70:25: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const boost::basic_string_ref<char, std::__1::char_traits<char> > &' 
> for 1st argument
>         BOOST_CONSTEXPR basic_string_ref (const basic_string_ref &rhs) 
> BOOST_NOEXCEPT
>                         ^
> /usr/local/include/boost/utility/string_ref.hpp:88:9: note: candidate 
> constructor not viable: no known conversion from 
> 'boost::basic_string_view<char, std::__1::char_traits<char> >' to 
> 'const char *' for 1st argument
>         basic_string_ref(const charT* str) BOOST_NOEXCEPT
>         ^
> /usr/local/include/boost/utility/string_ref.hpp:92:9: note: candidate 
> template ignored: could not match 'basic_string' against 
> 'basic_string_view'
>         basic_string_ref(const std::basic_string<charT, traits, 
> Allocator>& str)
>         ^
> /home/jenkins/workspace/ceph-master/src/rgw/rgw_common.h:406:68: note: 
> passing argument to parameter 'val' here
>   void set(const boost::string_ref& name, const boost::string_ref& val);
> ^
> 7 errors generated.
> gmake[2]: *** [src/rgw/CMakeFiles/radosgw_a.dir/build.make:159: 
> src/rgw/CMakeFiles/radosgw_a.dir/rgw_asio_client.cc.o] Error 1
> gmake[2]: *** Waiting for unfinished jobs....
> [ 99%] Linking CXX executable ../../bin/ceph_rgw_jsonparser
> cd /home/jenkins/workspace/ceph-master/build/src/rgw && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_rgw_jsonparser.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_rgw_jsonparser.dir/rgw_jsonparser.cc.o  -o 
> ../../bin/ceph_rgw_jsonparser  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../lib/librgw_a.a ../../lib/libglobal.a -lrt 
> ../../lib/librados.so.2.0.0 ../../lib/libcls_lock_client.a 
> ../../lib/libcls_rgw_client.a ../../lib/libcls_refcount_client.a 
> ../../lib/libcls_log_client.a ../../lib/libcls_statelog_client.a 
> ../../lib/libcls_timeindex_client.a ../../lib/libcls_version_client.a 
> ../../lib/libcls_replica_log_client.a ../../lib/libcls_user_client.a 
> ../../lib/libceph-common.so.0 ../../lib/libjson_spirit.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread ../../lib/libcommon_utf8.a 
> /usr/local/lib/libcurl.so /usr/local/lib/libexpat.so 
> /usr/local/lib/libldap.so /usr/local/lib/liblber.so 
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
> /usr/local/lib/libnspr4.so gmake[2]: Leaving directory 
> '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_rgw_jsonparser
> [ 99%] Linking CXX shared library ../../lib/librgw.so
> cd /home/jenkins/workspace/ceph-master/build/src/rgw && 
> /usr/local/bin/cmake -E cmake_link_script CMakeFiles/rgw.dir/link.txt 
> --verbose=1
> ccache /usr/bin/c++ -fPIC  -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -shared -Wl,-soname,librgw.so.2 -o 
> ../../lib/librgw.so.2.0.0 CMakeFiles/rgw.dir/librgw.cc.o 
> CMakeFiles/rgw.dir/rgw_file.cc.o -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../lib/librgw_a.a ../../lib/librados.so.2.0.0 
> ../../lib/libcls_rgw_client.a ../../lib/libcls_lock_client.a 
> ../../lib/libcls_refcount_client.a ../../lib/libcls_log_client.a 
> ../../lib/libcls_statelog_client.a ../../lib/libcls_timeindex_client.a 
> ../../lib/libcls_version_client.a 
> ../../lib/libcls_replica_log_client.a ../../lib/libcls_user_client.a 
> ../../lib/libglobal.a /usr/local/lib/libcurl.so 
> /usr/local/lib/libexpat.so -lrt ../../lib/libceph-common.so.0 
> ../../lib/libjson_spirit.a ../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread ../../lib/libcommon_utf8.a 
> /usr/local/lib/libldap.so /usr/local/lib/liblber.so 
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
> /usr/local/lib/libnspr4.so [ 99%] Linking CXX executable 
> ../../bin/ceph_rgw_multiparser
> cd /home/jenkins/workspace/ceph-master/build/src/rgw && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_rgw_multiparser.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_rgw_multiparser.dir/rgw_multiparser.cc.o  -o 
> ../../bin/ceph_rgw_multiparser  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../lib/librgw_a.a ../../lib/libglobal.a -lrt 
> ../../lib/librados.so.2.0.0 ../../lib/libcls_lock_client.a 
> ../../lib/libcls_rgw_client.a ../../lib/libcls_refcount_client.a 
> ../../lib/libcls_log_client.a ../../lib/libcls_statelog_client.a 
> ../../lib/libcls_timeindex_client.a ../../lib/libcls_version_client.a 
> ../../lib/libcls_replica_log_client.a ../../lib/libcls_user_client.a 
> ../../lib/libceph-common.so.0 ../../lib/libjson_spirit.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread ../../lib/libcommon_utf8.a 
> /usr/local/lib/libcurl.so /usr/local/lib/libexpat.so 
> /usr/local/lib/libldap.so /usr/local/lib/liblber.so 
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
> /usr/local/lib/libnspr4.so cd 
> /home/jenkins/workspace/ceph-master/build/src/rgw && 
> /usr/local/bin/cmake -E cmake_symlink_library 
> ../../lib/librgw.so.2.0.0 ../../lib/librgw.so.2 ../../lib/librgw.so
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target rgw
> gmake -f src/pybind/rgw/CMakeFiles/cython_rgw.dir/build.make 
> src/pybind/rgw/CMakeFiles/cython_rgw.dir/depend
> gmake -f src/test/CMakeFiles/ceph_test_rgw_token.dir/build.make 
> src/test/CMakeFiles/ceph_test_rgw_token.dir/depend
> gmake -f 
> src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/depend
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/depend
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/depend
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/depend
> gmake -f 
> src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/depend
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file.dir/depend
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/pybind/rgw 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/pybind/rgw 
> /home/jenkins/workspace/ceph-master/build/src/pybind/rgw/CMakeFiles/cython_rgw.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_rgw_token.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file.dir/DependInfo.cmake 
> --color=
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/pybind/rgw/CMakeFiles/cython_rgw.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/pybind/rgw/CMakeFiles/cython_rgw.dir/depend.internal".
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/DependInfo.cmake 
> --color=
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/pybind/rgw/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/pybind/rgw/CMakeFiles/cython_rgw.dir/depend.internal".
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/DependInfo.cmake 
> --color=
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test 
> /home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/DependInfo.cmake 
> --color=
> Scanning dependencies of target cython_rgw
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/pybind/rgw/CMakeFiles/cython_rgw.dir/build.make 
> src/pybind/rgw/CMakeFiles/cython_rgw.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/src/pybind/rgw && env 
> CC="ccache /usr/bin/cc" CXX="ccache /usr/bin/c++" LDSHARED="ccache 
> /usr/bin/cc -shared" OPT="-DNDEBUG -g -fwrapv -O2 -w" 
> LDFLAGS=-L/home/jenkins/workspace/ceph-master/build/lib 
> CYTHON_BUILD_DIR=/home/jenkins/workspace/ceph-master/build/src/pybind/rgw 
> CEPH_LIBDIR=/home/jenkins/workspace/ceph-master/build/lib 
> CFLAGS="-iquote/home/jenkins/workspace/ceph-master/src/include -w" 
> /usr/local/bin/python2.7 
> /home/jenkins/workspace/ceph-master/src/pybind/rgw/setup.py build 
> --verbose --build-base 
> /home/jenkins/workspace/ceph-master/build/lib/cython_modules 
> --build-platlib 
> /home/jenkins/workspace/ceph-master/build/lib/cython_modules/lib.2
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_rgw_token.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_rgw_token.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_rgw_token.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/depend.internal".
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_rgw_multiparser
> Scanning dependencies of target ceph_test_librgw_file_aw
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/build
> Scanning dependencies of target ceph_test_librgw_file_gp
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/build
> Scanning dependencies of target ceph_test_librgw_file
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> Scanning dependencies of target ceph_test_librgw_file_cd
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/build
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_librgw_file_aw.dir/librgw_file_aw.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_librgw_file_aw.dir/librgw_file_aw.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/librgw_file_aw.cc
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_librgw_file_gp.dir/librgw_file_gp.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_librgw_file_gp.dir/librgw_file_gp.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/librgw_file_gp.cc
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_librgw_file.dir/librgw_file.cc.o
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> Scanning dependencies of target ceph_test_rgw_token
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_librgw_file.dir/librgw_file.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/librgw_file.cc
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/CMakeFiles/ceph_test_rgw_token.dir/build.make 
> src/test/CMakeFiles/ceph_test_rgw_token.dir/build
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_librgw_file_cd.dir/librgw_file_cd.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_librgw_file_cd.dir/librgw_file_cd.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/librgw_file_cd.cc
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_rgw_token.dir/test_rgw_token.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/rocksdb/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_rgw_token.dir/test_rgw_token.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/test_rgw_token.cc
> Scanning dependencies of target ceph_test_librgw_file_nfsns
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> Scanning dependencies of target ceph_test_librgw_file_marker
> gmake -f 
> src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/build
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/build.make 
> src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_librgw_file_nfsns.dir/librgw_file_nfsns.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_librgw_file_nfsns.dir/librgw_file_nfsns.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/librgw_file_nfsns.cc
> [ 99%] Building CXX object 
> src/test/CMakeFiles/ceph_test_librgw_file_marker.dir/librgw_file_marker.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include 
> -I/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__ 
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_librgw_file_marker.dir/librgw_file_marker.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/librgw_file_marker.cc
> [ 99%] Linking CXX executable ../../bin/radosgw-object-expirer
> cd /home/jenkins/workspace/ceph-master/build/src/rgw && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/radosgw-object-expirer.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/radosgw-object-expirer.dir/rgw_object_expirer.cc.o  -o 
> ../../bin/radosgw-object-expirer  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../lib/librgw_a.a ../../lib/librados.so.2.0.0 
> ../../lib/libcls_rgw_client.a ../../lib/libcls_lock_client.a 
> ../../lib/libcls_refcount_client.a ../../lib/libcls_log_client.a 
> ../../lib/libcls_statelog_client.a ../../lib/libcls_timeindex_client.a 
> ../../lib/libcls_version_client.a 
> ../../lib/libcls_replica_log_client.a ../../lib/libcls_user_client.a 
> ../../lib/libglobal.a /usr/local/lib/libcurl.so 
> /usr/local/lib/libexpat.so -lrt ../../lib/libceph-common.so.0 
> ../../lib/libjson_spirit.a ../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread ../../lib/libcommon_utf8.a 
> /usr/local/lib/libldap.so /usr/local/lib/liblber.so 
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
> /usr/local/lib/libnspr4.so gmake[2]: Leaving directory 
> '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target radosgw-object-expirer
> [ 99%] Linking CXX executable ../../bin/ceph_test_rgw_token
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_rgw_token.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_test_rgw_token.dir/test_rgw_token.cc.o  -o 
> ../../bin/ceph_test_rgw_token  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/libos.a ../../lib/libglobal.a 
> ../../lib/libgmock_main.a ../../lib/libgmock.a ../../lib/libgtest.a 
> -lpthread -lrt /usr/local/lib/libfuse.so ../../lib/libkv.a 
> /usr/local/lib/libleveldb.so ../rocksdb/librocksdb.a 
> /usr/local/lib/libsnappy.so -lz -lbz2 /usr/local/lib/liblz4.so 
> ../../lib/libceph-common.so.0 ../../lib/libjson_spirit.a 
> ../../lib/libcommon_utf8.a ../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_test_rgw_token
> Compiling rgw.pyx because it changed.
> [1/1] Cythonizing rgw.pyx
> running build
> running build_ext
> building 'rgw' extension
> creating 
> /home/jenkins/workspace/ceph-master/build/lib/cython_modules/temp.freebsd-12.0-CURRENT-amd64-2.7/home/jenkins/workspace/ceph-master/build/src/pybind/rgw
> ccache /usr/bin/cc -DNDEBUG 
> -iquote/home/jenkins/workspace/ceph-master/src/include -w -fPIC 
> -I/usr/local/include/python2.7 -I/usr/local/include/python2.7 
> -I/usr/local/include/python2.7 -c 
> /home/jenkins/workspace/ceph-master/build/src/pybind/rgw/rgw.c -o 
> /home/jenkins/workspace/ceph-master/build/lib/cython_modules/temp.freebsd-12.0-CURRENT-amd64-2.7/home/jenkins/workspace/ceph-master/build/src/pybind/rgw/rgw.o 
> -fno-strict-aliasing -O2 -pipe -fstack-protector -fno-strict-aliasing 
> -DNDEBUG -lpython2.7 -lintl -lutil -lm -Wl,--export-dynamic
> [ 99%] Linking CXX executable ../../bin/ceph_test_librgw_file_cd
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_librgw_file_cd.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_test_librgw_file_cd.dir/librgw_file_cd.cc.o  -o 
> ../../bin/ceph_test_librgw_file_cd  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/librados.so.2.0.0 
> ../../lib/libceph-common.so.0 ../../lib/libgmock_main.a 
> ../../lib/libgmock.a ../../lib/libgtest.a -lpthread -lrt 
> ../../lib/libjson_spirit.a ../../lib/libcommon_utf8.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_test_librgw_file_cd
> [ 99%] Linking CXX executable ../../bin/ceph_test_librgw_file
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_librgw_file.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_test_librgw_file.dir/librgw_file.cc.o  -o 
> ../../bin/ceph_test_librgw_file  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/librados.so.2.0.0 
> ../../lib/libceph-common.so.0 ../../lib/libgmock_main.a 
> ../../lib/libgmock.a ../../lib/libgtest.a -lpthread -lrt 
> ../../lib/libjson_spirit.a ../../lib/libcommon_utf8.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread [ 99%] 
> Linking CXX executable ../../bin/ceph_test_librgw_file_aw
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_librgw_file_aw.dir/link.txt --verbose=1
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_test_librgw_file
> [ 99%] Linking CXX executable ../../bin/ceph_test_librgw_file_gp
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_librgw_file_gp.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_test_librgw_file_aw.dir/librgw_file_aw.cc.o  -o 
> ../../bin/ceph_test_librgw_file_aw  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/librados.so.2.0.0 
> ../../lib/libceph-common.so.0 ../../lib/libgmock_main.a 
> ../../lib/libgmock.a ../../lib/libgtest.a -lpthread -lrt 
> ../../lib/libjson_spirit.a ../../lib/libcommon_utf8.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread ccache 
> /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers -Winit-self 
> -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
> -fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
> -Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
> -Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
> -ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
> -Wno-unknown-pragmas -Wno-inconsistent-missing-override 
> -Wno-mismatched-tags -Wno-unused-private-field 
> -Wno-address-of-packed-member -fdiagnostics-color=auto 
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr  -O0 -g 
> -Wl,--export-dynamic 
> CMakeFiles/ceph_test_librgw_file_gp.dir/librgw_file_gp.cc.o  -o 
> ../../bin/ceph_test_librgw_file_gp  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/librados.so.2.0.0 
> ../../lib/libceph-common.so.0 ../../lib/libgmock_main.a 
> ../../lib/libgmock.a ../../lib/libgtest.a -lpthread -lrt 
> ../../lib/libjson_spirit.a ../../lib/libcommon_utf8.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_test_librgw_file_aw
> [ 99%] Built target ceph_test_librgw_file_gp
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake[1]: *** [CMakeFiles/Makefile2:19860: 
> src/rgw/CMakeFiles/radosgw_a.dir/all] Error 2
> gmake[1]: *** Waiting for unfinished jobs....
> ccache /usr/bin/cc -shared 
> -L/home/jenkins/workspace/ceph-master/build/lib 
> -iquote/home/jenkins/workspace/ceph-master/src/include -w 
> /home/jenkins/workspace/ceph-master/build/lib/cython_modules/temp.freebsd-12.0-CURRENT-amd64-2.7/home/jenkins/workspace/ceph-master/build/src/pybind/rgw/rgw.o 
> -L/usr/local/lib -L/usr/local/lib -L/usr/local/lib -lrados -lrgw 
> -lpython2.7 -lintl -lutil -lm -lpython2.7 -o 
> /home/jenkins/workspace/ceph-master/build/lib/cython_modules/lib.2/rgw.so
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Linking CXX executable ../../bin/radosgw-admin
> cd /home/jenkins/workspace/ceph-master/build/src/rgw && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/radosgw-admin.dir/link.txt --verbose=1
> [ 99%] Built target cython_rgw
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/radosgw-admin.dir/rgw_admin.cc.o 
> CMakeFiles/radosgw-admin.dir/rgw_orphan.cc.o  -o 
> ../../bin/radosgw-admin  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../lib/librgw_a.a ../../lib/librados.so.2.0.0 
> ../../lib/libcls_rgw_client.a ../../lib/libcls_lock_client.a 
> ../../lib/libcls_refcount_client.a ../../lib/libcls_log_client.a 
> ../../lib/libcls_statelog_client.a ../../lib/libcls_timeindex_client.a 
> ../../lib/libcls_version_client.a 
> ../../lib/libcls_replica_log_client.a ../../lib/libcls_user_client.a 
> ../../lib/libglobal.a /usr/local/lib/libcurl.so 
> /usr/local/lib/libexpat.so /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so -lrt ../../lib/libceph-common.so.0 
> ../../lib/libjson_spirit.a ../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread ../../lib/libcommon_utf8.a 
> /usr/local/lib/libldap.so /usr/local/lib/liblber.so 
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
> /usr/local/lib/libnspr4.so gmake[2]: Leaving directory 
> '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target radosgw-admin
> [ 99%] Linking CXX executable ../../bin/ceph_test_librgw_file_marker
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_librgw_file_marker.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_test_librgw_file_marker.dir/librgw_file_marker.cc.o -o 
> ../../bin/ceph_test_librgw_file_marker  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/librados.so.2.0.0 
> ../../lib/libceph-common.so.0 ../../lib/libgmock_main.a 
> ../../lib/libgmock.a ../../lib/libgtest.a -lpthread -lrt 
> ../../lib/libjson_spirit.a ../../lib/libcommon_utf8.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 99%] Built target ceph_test_librgw_file_marker
> [100%] Linking CXX executable ../../bin/ceph_test_librgw_file_nfsns
> cd /home/jenkins/workspace/ceph-master/build/src/test && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_librgw_file_nfsns.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph_test_librgw_file_nfsns.dir/librgw_file_nfsns.cc.o -o 
> ../../bin/ceph_test_librgw_file_nfsns  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../lib/librgw.so.2.0.0 ../../lib/librados.so.2.0.0 
> ../../lib/libceph-common.so.0 ../../lib/libgmock_main.a 
> ../../lib/libgmock.a ../../lib/libgtest.a -lpthread -lrt 
> ../../lib/libjson_spirit.a ../../lib/libcommon_utf8.a 
> ../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [100%] Built target ceph_test_librgw_file_nfsns
> [100%] Linking CXX executable ../bin/ceph-dencoder
> cd /home/jenkins/workspace/ceph-master/build/src && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph-dencoder.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -Wl,--export-dynamic 
> CMakeFiles/ceph-dencoder.dir/test/encoding/ceph_dencoder.cc.o 
> CMakeFiles/ceph-dencoder.dir/rgw/rgw_dencoder.cc.o 
> CMakeFiles/common_texttable_obj.dir/common/TextTable.cc.o  -o 
> ../bin/ceph-dencoder  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../lib/libglobal.a ../lib/libos.a ../lib/libosd.a ../lib/libmds.a 
> ../lib/libmon.a ../lib/libjournal.a ../lib/librgw_a.a 
> ../lib/libcls_rgw_client.a ../lib/libcls_rbd_client.a 
> ../lib/librbd_mirror_types.a ../lib/librbd_types.a 
> ../lib/librbd_replay_types.a ../lib/libcls_lock_client.a 
> ../lib/libcls_refcount_client.a ../lib/libcls_log_client.a 
> ../lib/libcls_statelog_client.a ../lib/libcls_version_client.a 
> ../lib/libcls_replica_log_client.a ../lib/libcls_user_client.a 
> ../lib/libcls_journal_client.a ../lib/libcls_timeindex_client.a -lrt 
> /usr/local/lib/libfuse.so ../lib/libkv.a rocksdb/librocksdb.a 
> /usr/local/lib/libsnappy.so -lz -lbz2 /usr/local/lib/liblz4.so 
> /usr/local/lib/libleveldb.so ../lib/libdmclock.a ../lib/libosdc.a 
> ../lib/liblua.a -lm ../lib/libglobal.a -lrt ../lib/libceph-common.so.0 
> ../lib/libjson_spirit.a ../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread ../lib/librados.so.2.0.0 ../lib/libcommon_utf8.a 
> /usr/local/lib/libcurl.so /usr/local/lib/libexpat.so 
> /usr/local/lib/libldap.so /usr/local/lib/liblber.so 
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
> /usr/local/lib/libnspr4.so gmake[2]: Leaving directory 
> '/home/jenkins/workspace/ceph-master/build'
> [100%] Built target ceph-dencoder
> gmake[1]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake: *** [Makefile:141: all] Error 2
> Build step 'Execute shell' marked build as failure

