From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: nuke the 32-bit pool id check
Date: Tue, 9 Aug 2016 16:51:43 +0200
Message-ID: <CAOi1vP9=aZd4mCay_C+GFyoYUDwSkSh+JJ=CEDM8TceVTyTbfA@mail.gmail.com>
References: <1470753737-5729-1-git-send-email-idryomov@gmail.com> <446d126b-1e14-e93f-456f-a9f48fdcdddf@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36414 "EHLO
	mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbcHIOvo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 10:51:44 -0400
Received: by mail-ua0-f181.google.com with SMTP id 97so23332000uav.3
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 07:51:44 -0700 (PDT)
In-Reply-To: <446d126b-1e14-e93f-456f-a9f48fdcdddf@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>

On Tue, Aug 9, 2016 at 4:45 PM, Alex Elder <elder@ieee.org> wrote:
> On 08/09/2016 09:42 AM, Ilya Dryomov wrote:
>> ceph_file_layout::pool_id is now s64.  rbd_add_get_pool_id() and
>> ceph_pg_poolid_by_name() both return an int, so it's bogus anyway.
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>
> If a pool id is really 64 bits (signed), shouldn't
> rbd_add_get_pool_id() and ceph_pg_poolid_by_name()
> be changed to return that type (first)?
>
> This otherwise looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Yeah, they should, along with s64/u64 inconsistencies...

Thanks,

                Ilya
