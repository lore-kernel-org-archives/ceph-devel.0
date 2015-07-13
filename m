From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: head object read with range get on RGW
Date: Mon, 13 Jul 2015 11:46:20 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF0200C61C@SHSMSX104.ccr.corp.intel.com>
References: <06681238D8946F44A60AA400760A1CBF0200C12F@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46731 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbbGMLqY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 07:46:24 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF0200C12F@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Ceph Devel' <ceph-devel@vger.kernel.org>, 'Yehuda Sadeh-Weinraub' <yehuda@redhat.com>

Hi Yehuda,

I trace the code and the read op seems happen at RGWRados::raw_obj_stat()? This looks like some unnecessary if the range does not fall on to the head object. 
I tried to set the rgw_max_chunk_size = 0 and it's not working on the PUT side.
Do you have any ideas on how to avoid this read? 

Thanks, -yuan

