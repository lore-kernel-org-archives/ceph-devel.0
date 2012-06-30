From: Brian Edmonds <mornir@gmail.com>
Subject: Re: ceph performance under xen?
Date: Sat, 30 Jun 2012 10:02:09 -0700
Message-ID: <CAMsVa3up+yCJQ3bV6nYx=6Gy4s0SZL7J79V20tWjf3EvsVgWUw@mail.gmail.com>
References: <CAMsVa3t8foWYguozDeFCiHf0jrK6b2+L4pKtU__-G1mTVVHzWg@mail.gmail.com>
 <CAPYLRzgMAPuTKOeZC78J48V1wCuL_7v-5Aj6YQX2Q=0BgQ5Cuw@mail.gmail.com>
 <CAMsVa3tJOf0JcY6Maq2SJaor_=e-iMyxsOihuLJNSzTZ23ydtg@mail.gmail.com>
 <CAPYLRzjoNKEiG3UWxxyRGzpAmCFyGt5RvM9kkGpx8a+hu103EQ@mail.gmail.com> <CAMsVa3s8hEMcwPQdkWw=DhBwUU=as6CoKcFeOexPaNDoQ95OAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47500 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2F3RCa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jun 2012 13:02:30 -0400
Received: by qcro28 with SMTP id o28so2275402qcr.19
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jun 2012 10:02:30 -0700 (PDT)
In-Reply-To: <CAMsVa3s8hEMcwPQdkWw=DhBwUU=as6CoKcFeOexPaNDoQ95OAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 2:14 PM, Brian Edmonds <mornir@gmail.com> wrote:
> In any case, I'll rebuild the current four machines into one MON, one
> MDS and two OSDs and see how that goes.  Thanks for the advice.

Just rebuilt as described, and it is significantly more stable.
Changing and listing directories is essentially snappy now, bonnie++
completed without issue, and I can run ceph commands with reasonable
latency.  (Previously they would block for sometimes minutes at a time
before responding.)  I'd obviously prefer more redundancy, but I
expect I can live with this sort of arrangement for the present while
I'm playing around with it.

Thanks for the help.  I should have all the parts here to build the
bare metal cluster the week after next.  In the mean time I'm going to
play with some operational issues so I'm all ready to go with the real
thing.

Brian.
