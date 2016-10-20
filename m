From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Building for Clang is broken for snap-types
Date: Thu, 20 Oct 2016 02:21:46 +0200
Message-ID: <d2873553-7338-dc43-c98d-2ce0e6a7c956@digiware.nl>
References: <0e42917f-707d-a5a2-141a-6c5c971ff021@digiware.nl>
 <CAJE9aOP7gYJzgZaT25bJy1y8nOS8Hqmmb0wttc63KN+hg=AoTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:42115 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755846AbcJTAVz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Oct 2016 20:21:55 -0400
In-Reply-To: <CAJE9aOP7gYJzgZaT25bJy1y8nOS8Hqmmb0wttc63KN+hg=AoTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 19-10-2016 20:58, kefu chai wrote:
> should have been fixed in master.

Ehh,

Not really.
Just tested by running
cd Ceph/master/ceph
git pull
./do_freebsd.sh

And I still get the same error.

Guess I'll have to start bisecting to see where it went wrong.

--WjW


> Willem Jan Withagen <wjw@digiware.nl <mailto:wjw@digiware.nl>>于2016年10
> 月20日 周四00:10写道：
> 
>     I guess somebody recently modified the type of either the ::encode() or
>     snapid_t. But Clang now really throws a fit.
> 
>     --WjW
> 
>     /usr/srcs/Ceph/work/ceph/src/common/snap_types.h:58:5: error: no
>     matching function for call to 'encode'
>         ::encode(snaps, bl);
>         ^~~~~~~~
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:68:1: note: candidate
>     function not viable: no known conversion from 'const vector<snapid_t>'
>     to 'const __u8' (aka 'const unsigned char') for 1st argument
>     WRITE_RAW_ENCODER(__u8)
>     ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
>     from macro 'WRITE_RAW_ENCODER'
>       inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
>     { encode_raw(v, bl); } \
>                   ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:70:1: note: candidate
>     function not viable: no known conversion from 'const vector<snapid_t>'
>     to 'const __s8' (aka 'const signed char') for 1st argument
>     WRITE_RAW_ENCODER(__s8)
>     ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
>     from macro 'WRITE_RAW_ENCODER'
>       inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
>     { encode_raw(v, bl); } \
>                   ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:72:1: note: candidate
>     function not viable: no known conversion from 'const vector<snapid_t>'
>     to 'const char' for 1st argument
>     WRITE_RAW_ENCODER(char)
>     ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
>     from macro 'WRITE_RAW_ENCODER'
>       inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
>     { encode_raw(v, bl); } \
>                   ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:73:1: note: candidate
>     function not viable: no known conversion from 'const vector<snapid_t>'
>     to 'const ceph_le64' for 1st argument
>     WRITE_RAW_ENCODER(ceph_le64)
>     ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
>     from macro 'WRITE_RAW_ENCODER'
>       inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
>     { encode_raw(v, bl); } \
>                   ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:74:1: note: candidate
>     function not viable: no known conversion from 'const vector<snapid_t>'
>     to 'const ceph_le32' for 1st argument
>     WRITE_RAW_ENCODER(ceph_le32)
>     ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
>     from macro 'WRITE_RAW_ENCODER'
>       inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
>     { encode_raw(v, bl); } \
>                   ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:75:1: note: candidate
>     function not viable: no known conversion from 'const vector<snapid_t>'
>     to 'const ceph_le16' for 1st argument
>     WRITE_RAW_ENCODER(ceph_le16)
>     ^
>     /usr/srcs/Ceph/work/ceph/src/include/encoding.h:65:15: note: expanded
>     from macro 'WRITE_RAW_ENCODER'
>       inline void encode(const type &v, bufferlist& bl, uint64_t features=0)
>     { encode_raw(v, bl); } \
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

