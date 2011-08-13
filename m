From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: remove user function of radosgw
Date: Sat, 13 Aug 2011 22:11:19 +0800
Message-ID: <CAPE_ny+gYP8_0cce_OEgRxzrzLQFO5JRTZqThNDxKLhm=vpAsw@mail.gmail.com>
References: <CAPE_nyKvv5SG1wE0iVT0crTMpUHr6RfwWxBnhQuwKN-XqbGkeQ@mail.gmail.com>
	<CAORUGqADXgzWi=bg3CcXNHsyUMpSQ7qc4CzM8k3uLkL5UWZ6_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62304 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1HMOLU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Aug 2011 10:11:20 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2169522bke.19
        for <ceph-devel@vger.kernel.org>; Sat, 13 Aug 2011 07:11:20 -0700 (PDT)
In-Reply-To: <CAORUGqADXgzWi=bg3CcXNHsyUMpSQ7qc4CzM8k3uLkL5UWZ6_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Tommi,
Thanks for your reply.
My environment is ceph v0.30 and installed on Ubuntu 10.10 by
compiling source, not debian package.
It showed nothing when I did "user rm".
And I know the user still exists because I did "rados -p .users.uid
ls" and saw the user's name still exists.
Still, I can use Cyberduck to connect to radosgw by the user's key.
"BUT" it worked well when I created another v0.30 radosgw environment
installed on Fedora 15 .
So I am confusing now why this is happening.......><

2011/8/12 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Fri, Aug 12, 2011 at 08:14, Sylar Shen <kimulaaa@gmail.com> wrote:
>> I am using radosgw right now.
>> It worked great but there is a strange thing - I cannot remove a radosgw user.
>> I've read the usage information of "radosgw_admin" and knew that it
>> has "user rm" command.
>> So my command was "radosgw_admin user rm --uid=test" but the test
>> account wasn't deleted.
>> I am wondering if my command was wrong or something.
>
> Can you give us more info -- what did the "user rm" command output,
> how did you determine that the user still exists?
>
> I just tested this and it Works For Me(tm); requests get 403 Forbidden
> as soon as I do the "user rm".
>



-- 
Best Regards,
Sylar Shen
