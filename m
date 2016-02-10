From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: FW: G++ internal compiler error
Date: Wed, 10 Feb 2016 00:10:14 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C0561C17D6@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:35795 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbcBJAKQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 19:10:16 -0500
Received: from ssiexch-casht1.ssi.samsung.com ([105.128.134.172]) by mx2.ssi.samsung.com with ESMTP id cGbIaLo8vLU038sq for <ceph-devel@vger.kernel.org>; Tue, 09 Feb 2016 16:10:15 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi All,
 Compiler errors against Ceph master. Any clues?
 Here is my g++ version :
 g++ (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4
 Copyright (C) 2013 Free Software Foundation, Inc.
 This is free software; see the source for copying conditions.=A0 There=
 is NO
 warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE.


Errors output:
CXX=A0=A0=A0=A0=A0 mon/MonCap.lo
=A0 CXX=A0=A0=A0=A0=A0 mon/MonClient.lo
=A0 CXX=A0=A0=A0=A0=A0 mon/MonMap.lo
=A0 CXX=A0=A0=A0=A0=A0 osd/OSDMap.lo
=A0 CXX=A0=A0=A0=A0=A0 osd/osd_types.lo
g++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-4.8/README.Bugs> for instructions.
make[3]: *** [mon/MonCap.lo] Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: Leaving directory `/home/jamesliu/WorkSpace/omni_ceph/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/jamesliu/WorkSpace/omni_ceph/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/jamesliu/WorkSpace/omni_ceph/src'
make: *** [all-recursive] Error 1


Regards,
James
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
