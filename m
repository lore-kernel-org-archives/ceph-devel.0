From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/6] rbd: fix leak of format 2 snapshot names
Date: Mon, 29 Apr 2013 08:18:38 -0700
Message-ID: <517E8F4E.1000303@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DD1.2080102@inktank.com> <517E8EDE.1020106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:50397 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3D2PST (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:18:19 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so1993184pbc.23
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:18:19 -0700 (PDT)
In-Reply-To: <517E8EDE.1020106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/29/2013 08:16 AM, Josh Durgin wrote:
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

That was meant for v2 of this patch.

> On 04/26/2013 05:06 AM, Alex Elder wrote:
>> When the snapshot context for an rbd device gets updated (or the
>> initial one is recorded) a a list of snapshot structures is created
>> to represent them, one entry per snapshot.  Each entry includes a
>> dynamically-allocated copy of the snapshot name.
>>
>> Currently the name is allocated in rbd_snap_create(), as a duplicate
>> of the passed-in name.
>>
>> For format 1 images, the snapshot name provided is just a pointer to
>> an existing name.  But for format 2 images, the passed-in name is
>> already dynamically allocated, and in the the process of duplicating
>> it here we are leaking the passed-in name.
>>
>> Fix this by dynamically allocating the name for format 1 snapshots
>> also, and then stop allocating a duplicate in rbd_snap_create().
>>
>> Change rbd_dev_v1_snap_info() so none of its parameters is
>> side-effected unless it's going to return success.
>>
>> This is part of:
>>      http://tracker.ceph.com/issues/4803
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
