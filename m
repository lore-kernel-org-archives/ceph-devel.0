From: Gregory Farnum <greg@gregs42.com>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 11:05:54 -0800
Message-ID: <CAC6JEv8KsfAqJ0Ou4zf-B+z39BXqiRrhFYry55N5RHVZXyYwww@mail.gmail.com>
References: <54DA541E.9000608@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38380 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbbBJTF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 14:05:56 -0500
Received: by iecrd18 with SMTP id rd18so15056759iec.5
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 11:05:56 -0800 (PST)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id fr4sm8396478igd.4.2015.02.10.11.05.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 11:05:54 -0800 (PST)
Received: by mail-ig0-f173.google.com with SMTP id a13so25834366igq.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 11:05:54 -0800 (PST)
In-Reply-To: <54DA541E.9000608@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 10, 2015 at 10:55 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hello,
>
> last year in june i already reported this but there was no real result.
> (http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-July/041070.html)
>
> I then had the hope that this will be fixed itself when hammer is released.
> Now i tried hammer an the results are bad as before.
>
> Since firefly librbd1 / librados2 are 20% slower for 4k random iop/s than
> dumpling - this is also the reason why i still stick to dumpling.
>
> I've now modified my test again to be a bit more clear.
>
> Ceph cluster itself completely dumpling.
>
> librbd1 / librados from dumpling (fio inside qemu): 23k iop/s for random 4k
> writes
>
> - stopped qemu
> - cp -ra firefly_0.80.8/usr/lib/librados.so.2.0.0 /usr/lib/
> - cp -ra firefly_0.80.8/usr/lib/librbd.so.1.0.0 /usr/lib/
> - start qemu
>
> same fio, same qemu, same vm, same host, same ceph dumpling storage,
> different librados / librbd: 16k iop/s for random 4k writes
>
> What's wrong with librbd / librados2 since firefly?

We're all going to have the same questions now as we did last time,
about what the cluster looks like, what the perfcounters are reporting
on both versions of librados, etc.

Also, please give us the results from Giant rather than Firefly, for
the reasons I mentioned previously.
-Greg
