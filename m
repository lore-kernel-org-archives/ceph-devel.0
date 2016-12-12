From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Is Hammer end of life now?
Date: Mon, 12 Dec 2016 11:35:04 -0800
Message-ID: <CADRKj5SJ4C57HSG4Ys3eC0LUWGXid=E7oCGRNjbsV0pKaaT3Eg@mail.gmail.com>
References: <CALqRxCxMvAZTgA5sO4cJzFhzVjL=0xYnXrLO2n57VZf21R3b9Q@mail.gmail.com>
 <71343bb5-fb1f-a389-3e8c-bbb38a42496e@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35506 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbcLLTfL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 14:35:11 -0500
Received: by mail-vk0-f53.google.com with SMTP id w194so46404412vkw.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 11:35:05 -0800 (PST)
In-Reply-To: <71343bb5-fb1f-a389-3e8c-bbb38a42496e@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Need to have 18187 and 17985 backported.

On Mon, Dec 12, 2016 at 11:24 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Is Hammer EOL now? Should I put "December 2016" for actual retirement?
>
>
> We are preparing a 0.94.10 point release, which will possibly be the last.
> If the retirement month is the month in which the last point release is
> published, you could put December 2016 or January 2017.
>
> People keep earmarking issues for hammer backport, so I am getting ready to
> do another round of PR testing/merging, after which I will ask Abhishek if a
> 0.94.10 should be published.
>
> Does anyone have anything in particular they would like to see in 0.94.10?
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
