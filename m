From: kefu chai <tchaikov@gmail.com>
Subject: Re: jewel: bad rados_buffer_free from librados python bindings
Date: Tue, 25 Oct 2016 00:54:16 +0800
Message-ID: <CAJE9aOMwVnjwae7QyOGaaoMRtivJyPtXrVWi-ZnAyY26UGs6Bg@mail.gmail.com>
References: <580881D6.2070603@dachary.org> <alpine.DEB.2.11.1610201352030.21052@piezo.us.to>
 <2f802c6e-bf7b-9137-4335-7e991a95f4a6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:40832 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbcJXQyR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 12:54:17 -0400
Received: by mail-qk0-f178.google.com with SMTP id i68so3642956qke.7
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 09:54:17 -0700 (PDT)
In-Reply-To: <2f802c6e-bf7b-9137-4335-7e991a95f4a6@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 24, 2016 at 11:57 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 10/20/2016 06:52 AM, Sage Weil wrote:
>>
>> On Thu, 20 Oct 2016, Loic Dachary wrote:
>>>
>>> H Sage,
>>>
>>> It looks like http://tracker.ceph.com/issues/15454 surfaced in jewel
>>> (failed twice in a row at http://tracker.ceph.com/issues/17487#note-19). It
>>> did not occur before, therefore I suspect it's a side effect of some of the
>>> commits in the jewel backports integration branch (
>>> http://tracker.ceph.com/issues/17487#note-16 ), but I don't see which commit
>>> in that branch could have caused that kind of misbehavior.
>>>
>>> Since you marked http://tracker.ceph.com/issues/15454 as Resolved with no
>>> commits attached, I suppose it means it went away for some reason. Could you
>>> please confirm ?
>>
>>
>> Hmm, unfortunately I don't remember working on this one.  My guess is it
>> came up during a bug scrub discussion and that's when it got closed.
>> Hopefully Kefu or Josh remember?
>
>
> I don't think I've seen that particular bug before, so hopefully Kefu
> remembers it.

neither do i remember this, i investigated it a little bit. but had no
clues then. no idea why we closed it.

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
