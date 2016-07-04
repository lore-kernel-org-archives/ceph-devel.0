From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Cmake, Clang and plugins
Date: Mon, 4 Jul 2016 13:09:15 +0200
Message-ID: <dca061d8-b93d-1247-1271-91409f90ca71@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:58778 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbcGDLJw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jul 2016 07:09:52 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 2C441153413
	for <ceph-devel@vger.kernel.org>; Mon,  4 Jul 2016 13:09:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm being pestered by:
 dlopen(/home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so):
/home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so: Undefined
symbol "ceph_arch_neon"
if I try to run anything that want as plugin.

Now the question is: what extra bui;ding/linker  options would this
require to actually fix this?
Symbol analysis is below.
--WjW


The complaint is right because:
# nm /home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so | grep arch
                 U ceph_arch_intel_pclmul
                 U ceph_arch_intel_sse2
                 U ceph_arch_intel_sse3
                 U ceph_arch_intel_sse41
                 U ceph_arch_intel_sse42
                 U ceph_arch_intel_ssse3
                 U ceph_arch_neon
                 U ceph_arch_probe

So it is not in the plugin .so.

But looking at the components it should be there:
# nm /home/wjw/Ceph/work.cmake/ceph/build/lib/libcommon.a | grep arch
0000000000003d00 T _ZN12CrushWrapper20get_parent_hierarchyEi
0000000000000950 T _ZNK12CrushWrapper19_search_item_existsEi
0000000000000050 t _Z19ceph_crc32c_aarch64jPKhj
                 U ceph_arch_aarch64_crc32
                 U ceph_arch_intel_sse42
                 U ceph_arch_probe
0000000000000020 T
_Z24ceph_resolve_file_searchRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERS5_
0000000000000020 T _ZN4ceph14ResolvHWrapper12__res_searchEPKciiPhi
                 U __res_search
0000000000000004 B ceph_arch_aarch64_crc32
0000000000000000 T ceph_arch_arm_probe
0000000000000000 B ceph_arch_neon
0000000000000000 B ceph_arch_intel_pclmul
0000000000000000 T ceph_arch_intel_probe
0000000000000014 B ceph_arch_intel_sse2
0000000000000010 B ceph_arch_intel_sse3
0000000000000008 B ceph_arch_intel_sse41
0000000000000004 B ceph_arch_intel_sse42
000000000000000c B ceph_arch_intel_ssse3
                 U ceph_arch_arm_probe
                 U ceph_arch_intel_probe
0000000000000000 T ceph_arch_probe
0000000000000000 B ceph_arch_probed
                 U
_Z24ceph_resolve_file_searchRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERS5_

It is in the library where it should be, but it is both defined and and
unresolved...

Looking at the .libs version from then automake build:
The libcommin.a library is more or less equal.
# nm /home/wjw/Ceph/work/ceph/src/.libs/libcommon.a | grep arch
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000000 W
_ZN5boost7phoenix8functionINS0_4impl13binary_searchEEC2ERKS3_
0000000000000000 W _ZN5boost7phoenix8functionINS0_4impl6searchEEC2ERKS3_
0000000000000083 b _ZN5boost7phoenixL13binary_searchE
000000000000007e b _ZN5boost7phoenixL6searchE
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000120 T
_Z24ceph_resolve_file_searchRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERS5_
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000070 T
_ZN4ceph14ResolvHWrapper13__res_nsearchEP11__res_statePKciiPhi
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
                 U __res_nsearch
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000080 t _Z19ceph_crc32c_aarch64jPKhj
                 U ceph_arch_aarch64_crc32
                 U ceph_arch_intel_sse42
                 U ceph_arch_probe
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
                 U
_Z24ceph_resolve_file_searchRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERS5_
0000000000000000 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
0000000000008e20 T _ZN12CrushWrapper20get_parent_hierarchyEi
0000000000001230 T _ZNK12CrushWrapper19_search_item_existsEi
0000000000000004 B ceph_arch_aarch64_crc32
0000000000000000 T ceph_arch_arm_probe
0000000000000000 B ceph_arch_neon
0000000000000000 B ceph_arch_intel_pclmul
0000000000000000 T ceph_arch_intel_probe
0000000000000014 B ceph_arch_intel_sse2
0000000000000010 B ceph_arch_intel_sse3
0000000000000008 B ceph_arch_intel_sse41
0000000000000004 B ceph_arch_intel_sse42
000000000000000c B ceph_arch_intel_ssse3
                 U ceph_arch_arm_probe
                 U ceph_arch_intel_probe
0000000000000000 T ceph_arch_probe
0000000000000000 B ceph_arch_probed

And the libec_jearasure.so is also suspiciously similar:
# nm /home/wjw/Ceph/work/ceph/src/.libs/libec_jerasure.so | grep arch
0000000000118220 T _ZN12CrushWrapper20get_parent_hierarchyEi
0000000000110630 T _ZNK12CrushWrapper19_search_item_existsEi
0000000000161820 W
_ZNSt3__18__searchIPFbccEPKcS4_EET0_S5_S5_T1_S6_T_NS_26random_access_iterator_tagES8_
                 U ceph_arch_intel_pclmul
                 U ceph_arch_intel_sse2
                 U ceph_arch_intel_sse3
                 U ceph_arch_intel_sse41
                 U ceph_arch_intel_sse42
                 U ceph_arch_intel_ssse3
                 U ceph_arch_neon
                 U ceph_arch_probe

But it works in the automake build. Not in the cmake build.
