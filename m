From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [ceph-users] O_DIRECT on deep-scrub read
Date: Wed, 7 Oct 2015 11:18:34 -0400
Message-ID: <CANP1eJHOsoUNi_ffKAE1jLduu8Q5nhmw73sLO-NL3pwBok8O5A@mail.gmail.com>
References: <56150598.1080604@sadziu.pl>
	<alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34308 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbbJGPSg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Oct 2015 11:18:36 -0400
Received: by lbbwt4 with SMTP id wt4so15368184lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Oct 2015 08:18:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?Q?Pawe=C5=82_Sadowski?= <ceph@sadziu.pl>, ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Oct 7, 2015 at 10:50 AM, Sage Weil <sage@newdream.net> wrote:
> It's not, but it would not be ahrd to do this.  There are fadvise-style
> hints being passed down that could trigger O_DIRECT reads in this case.
> That may not be the best choice, though--it won't use data that happens
> to be in cache and it'll also throw it out..
>
> On Wed, 7 Oct 2015, Pawe? Sadowski wrote:
>
>> Hi,
>>
>> Can anyone tell if deep scrub is done using O_DIRECT flag or not? I'm
>> not able to verify that in source code.
>>
>> If not would it be possible to add such feature (maybe config option) to
>> help keeping Linux page cache in better shape?
>>
>> Thanks,

When I was working on preadv2 somebody brought up a per operation
O_DIRECT flag. There wasn't a clear use case at the time (outside of
to saying Linus would "love that").

>>
>> --
>> PS
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
