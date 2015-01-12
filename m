From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: ceph_test_librbd_fsx fails with thrasher
Date: Mon, 12 Jan 2015 20:13:44 +0300
Message-ID: <CALFYKtDPdH4NHmEFQiVxjOx-qieYPxfoKjg0rLmj03d7GwRJGA@mail.gmail.com>
References: <54B3D9B0.2050906@dachary.org>
	<54B3FD59.6070808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:38362 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbALRNo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 12:13:44 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so18829298qcz.10
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jan 2015 09:13:44 -0800 (PST)
In-Reply-To: <54B3FD59.6070808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 12, 2015 at 7:59 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 01/12/2015 06:26 AM, Loic Dachary wrote:
>>
>> Hi Josh,
>>
>> While looking at errors from a giant (plus backports) run of the RBD
>> suite, I stumbled upon:
>>
>>     http://tracker.ceph.com/issues/10513
>>
>> and the error is unclear (at least to me ;-). Would you have an idea ? For
>> information the backports included are all the pull requests mentionned at
>> http://tracker.ceph.com/issues/10501.
>
>
> Thanks for organizing these Loic!
>
> There's no trace of the actual error in the teuthology or ceph client
> logs. Looking at the syslogs, this and several other failures from that
> run were from running out of memory. This happened with and without
> caching, so I suspect these tests may simply need more memory in their
> current configuration, since osds are sharing it too, and they use much
> more with thrashing.

Speaking of fsx and thrasher.  Last time I tried fsx (both kernel and
librbd) couldn't survive thrashing due to watch/notify troubles.  Are
all the new watch/notify pieces that were supposed to fix this in?

Thanks,

                Ilya
