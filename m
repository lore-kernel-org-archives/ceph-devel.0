From: Samuel Just <sjust@redhat.com>
Subject: Re: About BUG #16279
Date: Fri, 2 Sep 2016 08:50:18 -0700
Message-ID: <CAN=+7FUwtmZYQ0wf4Juo5s9-QMpN7HBbehk+7mCY+qxRuhdKRw@mail.gmail.com>
References: <CALZt5jygWSRUBh4uJS1O69zw4ZageJ+pg4nkxUuByyRrqsQsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36262 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932465AbcIBPuU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2016 11:50:20 -0400
Received: by mail-qk0-f175.google.com with SMTP id l2so123144386qkf.3
        for <ceph-devel@vger.kernel.org>; Fri, 02 Sep 2016 08:50:19 -0700 (PDT)
In-Reply-To: <CALZt5jygWSRUBh4uJS1O69zw4ZageJ+pg4nkxUuByyRrqsQsQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 1, 2016 at 7:44 PM, Ning Yao <zay11022@gmail.com> wrote:
> Hi, all
>
> we got the same issue http://tracker.ceph.com/issues/16279
>
> I think it is possible objiter->second->version == last_divergent_update?
>
> If olog is [200'5 ~ 200'10, 202'11~ 202'20] with object A: [200'5, 200'8]
>    log is [200'3 ~ 200'11], object A : [200'5, 200'8]
>
> Then after merge log os [200'3 ~ 200'10, 202'11~202'20] with divergent entry:
> object A: 200'5 and 200'8

I think I'm misunderstanding your notation, but if I'm reading this
right, the entries at 200'5 and 200'8 would *not* be divergent -- the
only divergent entry would be 200'11.

>
> first_divergent_update will be 200'5 and last_divergent_update will be
> 200'8 for object A. If can find it in current log, and the possible
> version the object A is equal or greater than 200'8.  So I am not sure
> it must be greater than last_divergent_update but may be equal?
>
> Am I missing something else?
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
