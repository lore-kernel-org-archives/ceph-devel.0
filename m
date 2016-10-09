From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: [ceph-users] Fwd: if ceph tracker says the source was QA, what
 version that I have to checkout?
Date: Mon, 10 Oct 2016 09:28:04 +1000
Message-ID: <CAF-wwdG8AEqQJZqhpJb74Y5h-T7i_TZBsb+aYstyha3UhmrYmQ@mail.gmail.com>
References: <CAJ+86MN1GkiO1coWEXeEkKxmijKRL8zEvszeXPpa-Ky4vXfxSA@mail.gmail.com>
 <CAJ+86MOjgonJk-x9CfucTYy-+UTr16qU3J_9Y1hf0SdozZkZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35697 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbcJIX2H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Oct 2016 19:28:07 -0400
Received: by mail-lf0-f45.google.com with SMTP id l131so95440883lfl.2
        for <ceph-devel@vger.kernel.org>; Sun, 09 Oct 2016 16:28:06 -0700 (PDT)
In-Reply-To: <CAJ+86MOjgonJk-x9CfucTYy-+UTr16qU3J_9Y1hf0SdozZkZUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: agung Laksono <agung.smarts@gmail.com>
Cc: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 10, 2016 at 9:21 AM, agung Laksono <agung.smarts@gmail.com> wrote:
>
> Hi All ceph users,
>
> I am interesting to learn ceph bug.
>
> Some bugs that I learned pointing particular ceph version or tags for their
> buggy part.
> However I found some bugs put Q/A as the source.
> For instance http://tracker.ceph.com/issues/9301
>
> when I checked out on giant and firefly version, I saw the significant
> different between
> the version and the revision that changed by the developer.
>
> My question is how to have a buggy version( version when the patch has not
> been implemented)?

For this particular commit we can ask git.

http://tracker.ceph.com/projects/ceph/repository/revisions/c421b55e8e15ef04ca8aeb47f7d090375eaa8573

$ git describe c421b55e8e15ef04ca8aeb47f7d090375eaa8573
v0.85-884-gc421b55

So this was the 884th commit after the v0.85 tag and you need to check
out a copy of the source before that.

>
> Thanks
>
> --
> Cheers,
>
> Agung Laksono
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Cheers,
Brad
