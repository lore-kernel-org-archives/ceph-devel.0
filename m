From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Query regarding storage of objects in ceph
Date: Tue, 6 Sep 2016 15:05:32 +1000
Message-ID: <CAF-wwdE0bg7vQ=HfMqzWqv5W5ZKB+3tCf2mCt6os_Jpf_tX8Ug@mail.gmail.com>
References: <CAA8xDw2jFn_C-Cj1mZ5w9UUxNpe3Z4SeM-2=xcUPJGOg=v4R9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38097 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbcIFFFe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 01:05:34 -0400
Received: by mail-wm0-f41.google.com with SMTP id 1so167750368wmz.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Sep 2016 22:05:33 -0700 (PDT)
In-Reply-To: <CAA8xDw2jFn_C-Cj1mZ5w9UUxNpe3Z4SeM-2=xcUPJGOg=v4R9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 6, 2016 at 2:31 PM, Elita Lobo <loboelita@gmail.com> wrote:
> Hello,
>
> I am using Ceph in my research project and hence need to know a bit
> about how it works internally.  I would be grateful if someone would
> answer my queries.
>
>  When chunks of 2 objects have to be stored on an osd, are they put
> into the same file or are these chunks stored in separate file. Is
> there any way I could see this data using some command? And in which
> folder of the osd are they stored in?

Working your way through this may help.

http://cephnotes.ksperis.com/blog/2013/08/20/ceph-osd-where-is-my-data

>
> Also, is there a way I can see the whole flow of function calls made
> when a node repair is going on?
>
> Lastly, could someone please suggest some resources ( other than docs)
> which would help me understand the internal implementation and give me
> an idea how to debug in ceph. (Attaching gdb to ceph daemons running
> in the background etc)
>
> Thanking you,
> Yours sincerely,
> Elita Lobo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
