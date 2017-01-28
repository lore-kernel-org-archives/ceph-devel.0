From: "Mahalingam, Ganesh" <ganesh.mahalingam@intel.com>
Subject: Debugging rados for bug #18576
Date: Sat, 28 Jan 2017 01:35:26 +0000
Message-ID: <B209D98D8385BE41BC4DE002C072AEBE5AEB6FEA@fmsmsx118.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35062 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbdA1Bi3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 27 Jan 2017 20:38:29 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
I have been trying to figure out the actual error for bug #18576 [0] using a vstart environment, but have been unsuccessful in generating a proper backtrace for the issue. I have enabled debugging in the build using 
"-DCMAKE_C_FLAGS="-O0 -g3 -gdwarf-4" -DCMAKE_BUILD_TYPE=Debug". 

Thanks to Nathan Cutler who identified and linked the bug to #18696 [1] which shows a proper backtrace and might be the reason for the segfault experienced in the initial bug.  

I have enabled all possible debug messages in ceph.conf

[global]
                debug rados = 25
                debug client = 25
                debug finisher = 25
                debug rbd = 25

Are there other settings I am missing which will help me generate a proper gdb trace for this issue? Appreciate all the help.

--Ganesh

[0] http://tracker.ceph.com/issues/18576
[1] http://tracker.ceph.com/issues/18696



