From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Fri, 15 Sep 2017 10:55:42 -0700
Message-ID: <b6d9a156-f200-8435-eb10-6ea7a31bd4d5@redhat.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com>
 <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com>
 <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com>
 <87inglfqsp.fsf@suse.com> <87fubofiji.fsf@suse.com> <877ex0f9qu.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbdIORzq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Sep 2017 13:55:46 -0400
In-Reply-To: <877ex0f9qu.fsf@suse.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

On 09/15/2017 05:04 AM, Abhishek Lekshmanan wrote:
> RADOS suite saw a failure at
> http://pulpito.ceph.com/abhi-2017-09-15_08:47:22-rados-wip-luminous-2017-09-14-distro-basic-smithi/1635585/
> 
> on  (workunit test cephtool/test.sh), other than the same ansible
> related env. failures.

This was a timeout checking the crush rule during pool creation - it's
safe to ignore.

It seems that https://github.com/ceph/ceph/pull/17179 did not eliminate
the problem.

Josh
