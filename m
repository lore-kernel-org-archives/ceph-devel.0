From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: client isn't responding to mclientcaps
Date: Tue, 16 Jan 2018 20:23:13 +1000
Message-ID: <CAF-wwdEe7t6gvkyxDrYgorM-fBkYpSYRdO8s0niNQWhvZMn3NQ@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44156 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeAPKXP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 05:23:15 -0500
Received: by mail-lf0-f68.google.com with SMTP id w23so16710661lfd.11
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 02:23:15 -0800 (PST)
In-Reply-To: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jan 16, 2018 at 7:06 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, everyone.
>
> In our online cephfs, we occasionally encounter the error "Client.
> isn't responding to mclientcaps", the client kernel we are using is
> centos's "3.10.0-514". Due to the massive deployment of our clients,
> it's difficult to update kernels, which means we can not confirm
> whether the error is the result of a relative older kernel or some
> kind of unresolved bug. Is there any way that we can find all the
> related bugs issued before? If we can, we believe it should be helpful
> for us to locate the cause of the problem

You can start with the following search.

http://tracker.ceph.com/projects/rbd/search?utf8=%E2%9C%93&q=mclientcaps&scope=all&all_words=&all_words=1&titles_only=&issues=1&attachments=0&options=0&commit=Submit

Which will probably lead you here...

http://tracker.ceph.com/issues/11482

Since you didn't mention your ceph cluster version I have no way of
knowing whether you have the patch for that issue or not.

>
> Thanks:-)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
