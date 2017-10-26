From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: 12.2.2 status
Date: Thu, 26 Oct 2017 11:40:11 -0400
Message-ID: <CA+aFP1AVdD9Tt0q3ZThOQ7W24KdWHqp+C=fCjpJSAm5FCF56Vw@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:52596 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbdJZPkM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 11:40:12 -0400
Received: by mail-yw0-f170.google.com with SMTP id w2so3265654ywa.9
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 08:40:12 -0700 (PDT)
In-Reply-To: <87fua6c4xy.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

I would like to see the following additional tickets:

http://tracker.ceph.com/issues/21918
http://tracker.ceph.com/issues/21688
http://tracker.ceph.com/issues/21914

Thanks,

On Thu, Oct 26, 2017 at 11:19 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
> A first round of PRs were tested on Luminous integration branch, results
> updated at http://tracker.ceph.com/issues/21830,
> RADOS suite was green, RBD, RGW & FS hit some known failures
>
> ceph-disk has hit a failure with dmcrypt, details at
> http://tracker.ceph.com/issues/21830#note-10 which doesn't seem to have
> occured in QE runs before but there is a bug report, is anyone aware of
> past issues with ceph-disk & dmcrypt?
>
> Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
> critical PRs that we need to have in 12.2.2 so that we can include
> them in the next round of testing before handing over to QE?
>
> Best,
> Abhishek & Karol
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
