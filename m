From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: AIO error
Date: Mon, 1 Feb 2016 10:01:32 +0100
Message-ID: <CAOi1vP8C=qqqHBRtcAnoBRr4uc7YrJdPX3FE=hyAUGKoj8jeqA@mail.gmail.com>
References: <56AB2BCB.80501@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33431 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbcBAJBe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Feb 2016 04:01:34 -0500
Received: by mail-wm0-f54.google.com with SMTP id l66so59528521wml.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Feb 2016 01:01:33 -0800 (PST)
In-Reply-To: <56AB2BCB.80501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 29, 2016 at 10:07 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> This time is not a udev related question. I think (hope ?) there won't be any other udev trick questions.
>
> A year ago I spent some time investigating the possible cause of http://tracker.ceph.com/issues/9570#note-8 I exhausted all options (the log of my research is at http://tracker.ceph.com/issues/9570#note-17 and following). The problem resurfaces, rarely but often enough to re-open the case and examine new logs.
>
> I would be grateful if you could share bits of wisdom regarding AIO, if you have some :-)

Hi Loic,

I posted my thoughts to the tracker and also made some adjustments -
I don't think the update-grub thing is a duplicate of this.

Thanks,

                Ilya
