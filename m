From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FW: G++ internal compiler error
Date: Wed, 10 Feb 2016 01:18:03 +0100
Message-ID: <56BA81BB.2030906@digiware.nl>
References: <99767EA2E27DD44DB4E9F9B9ACA458C0561C17D6@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:59848 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbcBJAuJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Feb 2016 19:50:09 -0500
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C0561C17D6@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10-2-2016 01:10, James (Fei) Liu-SSI wrote:
> 
> Hi All,
>  Compiler errors against Ceph master. Any clues?
>  Here is my g++ version :
>  g++ (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4
>  Copyright (C) 2013 Free Software Foundation, Inc.
>  This is free software; see the source for copying conditions.  There is NO
>  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> 
> Errors output:
> CXX      mon/MonCap.lo
>   CXX      mon/MonClient.lo
>   CXX      mon/MonMap.lo
>   CXX      osd/OSDMap.lo
>   CXX      osd/osd_types.lo
> g++: internal compiler error: Killed (program cc1plus)
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <file:///usr/share/doc/gcc-4.8/README.Bugs> for instructions.
> make[3]: *** [mon/MonCap.lo] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[3]: Leaving directory `/home/jamesliu/WorkSpace/omni_ceph/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/home/jamesliu/WorkSpace/omni_ceph/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/jamesliu/WorkSpace/omni_ceph/src'
> make: *** [all-recursive] Error 1

I've seen this this happen when compiling in a small VM with too much
parallel and running out of swap. (actually the VM did not have any swap
configured.)

--WjW


