From: kefu chai <tchaikov@gmail.com>
Subject: Re: Pool creation fails: 'failed run crushtool: fork failed: (12)
 Cannot allocate memory'
Date: Tue, 26 Jul 2016 11:13:14 +0800
Message-ID: <CAJE9aOOYrZeRiBY3gqi9U8wLQSxVqUfi5ab6d82HRCJPsF4thw@mail.gmail.com>
References: <976529875.1339.1469116197418@ox.pcextreme.nl> <CAJ4mKGaCvH9uj49340wXqLr5fScBYjRqh7YosGH48vOoDxk2sQ@mail.gmail.com>
 <1117268583.1343.1469126502597@ox.pcextreme.nl> <20160721235726.GA31519@rskikr.localdomain>
 <1891032362.1371.1469180486335@ox.pcextreme.nl> <20160722104649.GA24794@rskikr.localdomain>
 <393109848.1432.1469432830352@ox.pcextreme.nl> <20160726001226.GA12749@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36381 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbcGZDNP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2016 23:13:15 -0400
Received: by mail-qk0-f181.google.com with SMTP id x1so181502959qkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2016 20:13:15 -0700 (PDT)
In-Reply-To: <20160726001226.GA12749@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 26, 2016 at 8:12 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
>> So it seems this monitor ran into LimitNPROC since the open files are so low that it probably didn't run into that limit.
>
> I suspect we are missing something here. It seems unlikely to me that you are
> hitting such a high process limit and, if you were, I would suggest the error
> returned would be something other than ENOMEM. I admit that the evidence

fork(2) sets errno to EAGAIN if

> A system-imposed limit on the number of threads was encountered.  There are a number of limits that may trigger this error: the RLIMIT_NPROC soft resource  limit (set  via  setrlimit(2)),  which limits the number of processes and threads for a real user ID, was reached; the kernel's system-wide limit on the number of processes and threads, /proc/sys/kernel/threads-max, was reached (see proc(5)); or the maximum number of PIDs, /proc/sys/kernel/pid_max, was reached (see proc(5)).

which (partly) matches with what we found in case. the conflict fast
is that we didn't have EAGAIN in the error message. that's
interesting... so the root cause of this failure is still unknown.

> so far appears to indicate that this limit is somehow involved but I'm
> suspicious that it is not the entire story here and there is more to be
> learned.
>
>>
>> Wido
>>
>> > HTH,
>> > Brad
>> >
>> > > Wido
>> > >
>> > > > HTH,
>> > > > Brad
>> > > >
>> > > > >
>> > > > > I also checked, SELinux is disabled. 'setenforce 0'.
>> > > > >
>> > > > > Wido
>> > > > >
>> > > > > > --
>> > > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > > > > > the body of a message to majordomo@vger.kernel.org
>> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > > > > --
>> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > > > > the body of a message to majordomo@vger.kernel.org
>> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > > > --
>> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > > > the body of a message to majordomo@vger.kernel.org
>> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> > --
>> > Cheers,
>> > Brad
>
> --
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
