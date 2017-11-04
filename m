From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #1408
Date: Sat, 4 Nov 2017 18:40:22 +0100
Message-ID: <6bfee3c0-2320-cc93-2815-429040ccac47@digiware.nl>
References: <14085029.62.1509737256278.JavaMail.jenkins@cephdev.digiware.nl>
 <fe5aaa26-d32e-916f-2af6-91ba5a4ab11e@digiware.nl>
 <dc1cdc3e-4b95-85dd-5ccd-94fe0cbecba0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:51556 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932111AbdKDRk1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 4 Nov 2017 13:40:27 -0400
In-Reply-To: <dc1cdc3e-4b95-85dd-5ccd-94fe0cbecba0@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 3-11-2017 22:24, Casey Bodley wrote:
> Hi Willem, (and cc list)
> 
> I think this one is related to your boost version. In my builds, I see 
> that boost::beast::string_ref is typedef'd to boost::string_ref and this 
> builds. Your output implies that it's typedef'ed to boost::string_view.
> 
> https://github.com/boostorg/beast/commit/64ff766b2304c751e1a46d2b7ca948cd274c5739 
> added some preprocessor stuff that switches from one to the other based 
> on whether BOOST_VERSION >= 106400. You might try defining 
> BEAST_NO_BOOST_STRING_VIEW to work around that for now.

That did not do it.
So we might need to change some of the functions-sigs and conversion is 
possible.

--WjW

cd /home/jenkins/workspace/ceph-master/build/src/test && ccache 
/usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto -I/usr/local/include/nss/nss 
-I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++11 -o 
CMakeFiles/ceph_test_librgw_file_aw.dir/librgw_file_aw.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/librgw_file_aw.cc
/home/jenkins/workspace/ceph-master/src/rgw/rgw_asio_client.cc:35:33: 
error: no viable conversion from 'const boost::basic_string_view<char, 
std::__1::char_traits<char> >' to 'const boost::string_ref' (aka 'const 
basic_string_ref<char, std::char_traits<char> >')
       env.set("CONTENT_LENGTH", value);
                                 ^~~~~
/usr/local/include/boost/utility/string_ref.hpp:70:25: note: candidate 
constructor not viable: no known conversion from 'const 
boost::basic_string_view<char, std::__1::char_traits<char> >' to 'const 
boost::basic_string_ref<char, std::__1::char_traits<char> > &' for 1st 
argument
         BOOST_CONSTEXPR basic_string_ref (const basic_string_ref &rhs) 
BOOST_NOEXCEPT
                         ^


