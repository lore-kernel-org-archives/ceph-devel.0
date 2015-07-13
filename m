From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: head object read with range get on RGW
Date: Mon, 13 Jul 2015 11:42:41 -0400 (EDT)
Message-ID: <196456041.6274298.1436802161081.JavaMail.zimbra@redhat.com>
References: <06681238D8946F44A60AA400760A1CBF0200C12F@SHSMSX104.ccr.corp.intel.com> <06681238D8946F44A60AA400760A1CBF0200C61C@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:59552 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbGMPmm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 11:42:42 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF0200C61C@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuan Zhou <yuan.zhou@intel.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Yuan Zhou" <yuan.zhou@intel.com>
> To: "Ceph Devel" <ceph-devel@vger.kernel.org>, "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Sent: Monday, July 13, 2015 4:46:20 AM
> Subject: head object read with range get on RGW
> 
> Hi Yehuda,
> 
> I trace the code and the read op seems happen at RGWRados::raw_obj_stat()?
> This looks like some unnecessary if the range does not fall on to the head
> object.
> I tried to set the rgw_max_chunk_size = 0 and it's not working on the PUT
> side.
> Do you have any ideas on how to avoid this read?
> 

There's a call to RGWRados::set_prefetch_data() in RGWGetObj::verify_permission(), probably need to limit it there.

I also think you could come up with a system that will remove the need to completely read the head object's metadata, so that you won't need to access the remote osd if accessing the tail. The idea is from your proxy to send the object's metadata with the GET request in a special header, and then update the internal rgw structure that caches this data. Will require some special tweaking but might be worth it.

Yehuda
