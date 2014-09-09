From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: Better output of ceph df
Date: Tue, 9 Sep 2014 08:58:53 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC020A89A5@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7828 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbaIII70 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 04:59:26 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

Hi list,
      I tried to understand the output of "CEPH DF" , finally I got it but it's really confusing  in the POOLS section, so I sent out the mail and see if any good suggestion to make it better.

Here is an example from my cluster
	GLOBAL:
   		 SIZE      AVAIL     RAW USED     %%RAW USED 
    		8153G     5962G        2191G          26.88 
	POOLS:
   		 NAME           ID   USED     %%USED     MAX AVAIL     SIZE 
   		 base_tier      1         960G        11.77        2647G      245793 
   		 cache_tier     2      134G       1.65          212G       34526

Currently, the 
	USED	=  how many data in particular pool , so my base_tier has 960G data and cache_tier has 134G data
 	%%USED = USED /GLOBAL.SIZE,    this is really strange, users are likely to think the %%USED should be USED/ POOL.CAPACITY
	%%MAX_AVAIL = how many available space in particular pool ,calculated by max( osdi.avail / osdi. weight)
	OBJECTS = how many objects in the pool

I think it would be better to have 
	POOLS:
   		 NAME           ID        SIZE 		OBJECTS 	USED	%%USED	MAX_AVAIL	
   		 base_tier      1      7878G		245793                 960G      12.29   		   2647G     	 
   		 cache_tier     2      346G		34526		134G       38.72          	212G       
   


What do you think? Any impact to other tools?
						Xiaoxi
