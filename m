From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: G++ internal compiler error
Date: Wed, 10 Feb 2016 00:19:25 +0000
Message-ID: <BN1PR02MB05598CD4C9C59FC429B0B40F4D70@BN1PR02MB055.namprd02.prod.outlook.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C0561C17D6@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0093.outbound.protection.outlook.com ([157.56.110.93]:27405
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932205AbcBJAT2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 19:19:28 -0500
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C0561C17D6@SSIEXCH-MB3.ssi.samsung.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hope you have enough memory in the build system..

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James (Fei) Liu-SSI
Sent: Tuesday, February 09, 2016 4:10 PM
To: ceph-devel@vger.kernel.org
Subject: FW: G++ internal compiler error


Hi All,
 Compiler errors against Ceph master. Any clues?
 Here is my g++ version :
 g++ (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4  Copyright (C) 2013 Free Software Foundation, Inc.
 This is free software; see the source for copying conditions.  There is NO  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Errors output:
CXX      mon/MonCap.lo
  CXX      mon/MonClient.lo
  CXX      mon/MonMap.lo
  CXX      osd/OSDMap.lo
  CXX      osd/osd_types.lo
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
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
