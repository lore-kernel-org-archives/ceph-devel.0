From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Tue, 22 Jan 2013 22:38:42 +0100
Message-ID: <CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
 <CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com> <CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:54664 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3AVVjF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:39:05 -0500
Received: by mail-lb0-f171.google.com with SMTP id gg13so4077129lbb.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:39:03 -0800 (PST)
In-Reply-To: <CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Well ideally you want to run the profiler during the scrubbing process
when the memory leaks appear :-).
--
Regards,
S=E9bastien Han.


On Tue, Jan 22, 2013 at 10:32 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>> I don't really want to try the mem profiler, I had quite a bad
>> experience with it on a test cluster. While running the profiler som=
e
>> OSD crashed...
>> The only way to fix this is to provide a heap dump. Could you provid=
e one?
>
> I just did:
>
> ceph osd tell 0 heap start_profiler
> ceph osd tell 0 heap dump
> ceph osd tell 0 heap stop_profiler
>
> and it produced osd.0.profile.0001.heap
>
> Is it enough or do I actually have to leave it running ?
>
> I had to stop the profiler because after doing the dump, the OSD
> process was taking 100% of CPU ... stopping the profiler restored it
> to normal.
>
> Cheers,
>
>     Sylvain
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
