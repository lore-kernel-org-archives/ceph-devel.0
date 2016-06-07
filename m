From: Mustafa Muhammad <mustafa1024m@gmail.com>
Subject: Re: unfound object problem
Date: Tue, 7 Jun 2016 09:27:55 +0300
Message-ID: <CAFehDbCYFjrWMYc7erQWhGjOB7EOGDkfkfsNXggxX7Lfd=gV_g@mail.gmail.com>
References: <CAKE=UQJxaZPms82=qZeceSCW2+okmSPVGJ12ML0gd2JPW2uEEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36442 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbcFGG15 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 02:27:57 -0400
Received: by mail-wm0-f53.google.com with SMTP id n184so121244688wmn.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jun 2016 23:27:56 -0700 (PDT)
In-Reply-To: <CAKE=UQJxaZPms82=qZeceSCW2+okmSPVGJ12ML0gd2JPW2uEEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

As Sam said in an earlier message, maybe this is caused by setting
sortbitwise at the end of update, this happened to my cluster, and
unsetting it made everything go back to normal.
See http://tracker.ceph.com/issues/16113

Regards
Mustafa

On Mon, May 30, 2016 at 6:58 AM, Rui Xie <jerry.xr86@gmail.com> wrote:
> Hi
>
> I found an unfound object problem in my test environment (hammer).
> I suspect the reason is the wrong update of up_thru.
>
> from osdmap, the up_thru become smaller than before at an epoch.  some
> old PGTemp messages with smaller epoch are prepared and executed, and
> change the up_thru to smaller epoch.
> maybe_went_rw is wrong for that interval.
>
> I think prepare_pgtemp should not change up_thru if it is smaller than
> current, and duplicated PGTemp messages not be sent ?
>
> Is this a bug or something wrong for me?
>
> Thanks !
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
