From: Sahithi R V <sahithi.rv1@gmail.com>
Subject: Re: [PATCH]common/str_map: Removed unnecessary function overloading
 of get_str_map()
Date: Wed, 27 Jan 2016 16:37:50 +0530
Message-ID: <CAAKF69pPmS60vaHc8XUhZOcti2Sx-7VzdkB_2g1kq9kieFgqdg@mail.gmail.com>
References: <CAAKF69rJmAA2rNaFjDetkN5-1uQf+UZXhmD9xXx+89-S0goE4g@mail.gmail.com>
	<CAOi1vP-w+EHRON1QLALYGJQvmAuFux2mRBn26ZcCutSEF_HnMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34191 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbcA0LHu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 06:07:50 -0500
Received: by mail-io0-f179.google.com with SMTP id 1so15083394ion.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 03:07:50 -0800 (PST)
In-Reply-To: <CAOi1vP-w+EHRON1QLALYGJQvmAuFux2mRBn26ZcCutSEF_HnMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya,


I have made a pull request( #7266) . I have not received any comments.
Can you please check.(https://github.com/ceph/ceph/pull/7266).

Thanks,
Sahithi R V.

On Wed, Jan 27, 2016 at 3:13 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Jan 27, 2016 at 7:23 AM, Sahithi R V <sahithi.rv1@gmail.com> wrote:
>> Hello,
>>
>> This patch removes the function overloading of get_str_map() by using
>> CONST_DELIMS as default parameters to const char *delims .It also
>> replaces all the occurences of get_str_map() function with 2
>> arguments, in src directory.
>
> Hi Sahithi,
>
> Generally, pull requests on github are preferred for getting changes
> into ceph.  The only exception to that is the kernel client, which is
> a bit of a special snowflake.  We aren't picky and will forward patches
> back and forth, but a pull request on github would speed things up.
>
> See https://github.com/ceph/ceph/blob/master/SubmittingPatches.rst.
>
> Thanks,
>
>                 Ilya
