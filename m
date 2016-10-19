From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Building for Clang is broken for snap-types
Date: Wed, 19 Oct 2016 11:35:23 +0200
Message-ID: <0e42917f-707d-a5a2-141a-6c5c971ff021@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17596 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938725AbcJSOWN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Oct 2016 10:22:13 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 48E0E2BF36
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2016 11:35:25 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I guess somebody recently modified the type of either the ::encode() or
snapid_t. But Clang now really throws a fit.

--WjW

/usr/srcs/Ceph/work/ceph/src/common/snap_types.h:58:5: error: no
matching function for call to 'encode'
    ::encode(snaps, bl);
    ^~~~~~~~
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:68:1: note: candidate
function not viable: no known conversion from 'const vector<snapid_t>'
to 'const __u8' (aka 'const unsigned char') for 1st argument
WRITE_RAW_ENCODER(__u8)
^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
from macro 'WRITE_RAW_ENCODER'
  inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
{ encode_raw(v, bl); } \
              ^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:70:1: note: candidate
function not viable: no known conversion from 'const vector<snapid_t>'
to 'const __s8' (aka 'const signed char') for 1st argument
WRITE_RAW_ENCODER(__s8)
^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
from macro 'WRITE_RAW_ENCODER'
  inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
{ encode_raw(v, bl); } \
              ^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:72:1: note: candidate
function not viable: no known conversion from 'const vector<snapid_t>'
to 'const char' for 1st argument
WRITE_RAW_ENCODER(char)
^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
from macro 'WRITE_RAW_ENCODER'
  inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
{ encode_raw(v, bl); } \
              ^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:73:1: note: candidate
function not viable: no known conversion from 'const vector<snapid_t>'
to 'const ceph_le64' for 1st argument
WRITE_RAW_ENCODER(ceph_le64)
^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
from macro 'WRITE_RAW_ENCODER'
  inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
{ encode_raw(v, bl); } \
              ^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:74:1: note: candidate
function not viable: no known conversion from 'const vector<snapid_t>'
to 'const ceph_le32' for 1st argument
WRITE_RAW_ENCODER(ceph_le32)
^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
from macro 'WRITE_RAW_ENCODER'
  inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
{ encode_raw(v, bl); } \
              ^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:75:1: note: candidate
function not viable: no known conversion from 'const vector<snapid_t>'
to 'const ceph_le16' for 1st argument
WRITE_RAW_ENCODER(ceph_le16)
^
/usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
from macro 'WRITE_RAW_ENCODER'
  inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
{ encode_raw(v, bl); } \
