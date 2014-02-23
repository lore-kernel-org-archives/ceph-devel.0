From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 0/6] libceph: CEPH_OSD_OP_SETALLOCHINT osd op
Date: Sun, 23 Feb 2014 10:15:41 -0600
Message-ID: <530A1EAD.6020908@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <alpine.DEB.2.00.1402230807110.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49215 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaBWQPk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 11:15:40 -0500
Received: by mail-ie0-f174.google.com with SMTP id as1so2640328iec.5
        for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 08:15:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402230807110.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/23/2014 10:14 AM, Sage Weil wrote:
> Reviewed-by: Sage Weil <sage@inktank.com>
> 
> It would be great if Josh or Alex could also look (at 6 especially) as 
> they are more familiar with the RBD code than I am, but I think it's safe 
> to put this in testing for now.

I will.  I have been planning on it but I didn't have time
on Friday.  I think I'll be able to today though.

					-Alex

> Thanks!
> sage
> 
> 
> On Fri, 21 Feb 2014, Ilya Dryomov wrote:
> 
>> Hello,
>>
>> This series adds support for CEPH_OSD_OP_SETALLOCHINT osd op to libceph
>> along with adjusting rbd to make use of it.  The rationale and the
>> basic desing was outlined in the "rados io hints" thread on ceph-devel
>> about a month ago.
>>
>> Thanks,
>>
>>                 Ilya
>>
>>
>> Ilya Dryomov (6):
>>   libceph: encode CEPH_OSD_OP_FLAG_* op flags
>>   libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
>>   libceph: bump CEPH_OSD_MAX_OP to 3
>>   rbd: do not hard-code CEPH_OSD_MAX_OP in rbd_osd_req_callback()
>>   rbd: num_ops parameter for rbd_osd_req_create()
>>   rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT osd op
>>
>>  drivers/block/rbd.c             |   90 ++++++++++++++++++++++++++++-----------
>>  include/linux/ceph/osd_client.h |   12 +++++-
>>  include/linux/ceph/rados.h      |   10 ++++-
>>  net/ceph/osd_client.c           |   32 ++++++++++++++
>>  4 files changed, 117 insertions(+), 27 deletions(-)
>>
>> -- 
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

