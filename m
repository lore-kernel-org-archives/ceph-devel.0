From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: librados dependency
Date: Wed, 18 May 2011 10:15:14 -0700
Message-ID: <BANLkTikU53ZzycKLVxSugFkMXcbZ9A956A@mail.gmail.com>
References: <BANLkTin4zPSHQ7afkXRStuDJWbzZUCe9ew@mail.gmail.com>
	<Pine.LNX.4.64.1105180903510.1988@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35699 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab1ERRPQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 13:15:16 -0400
Received: by bwz15 with SMTP id 15so1611451bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2011 10:15:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105180903510.1988@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wed, May 18, 2011 at 9:04 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 18 May 2011, Yehuda Sadeh Weinraub wrote:
>> The ceph master branch was broken today, as librados was using some
>> undefined symbols (that are defined in libcrush). At the moment I
>> worked around the issue by adding libcrush to the linkage where
>> appropriate, however, we should definitely want to remove this
>> dependency.
>
> Which symbols?

Hmm.. had trouble reproducing it, but here it is:

./.libs/librados.so: undefined reference to `crush_bucket_adjust_item_weight'
./.libs/librados.so: undefined reference to `crush_bucket_add_item'
./.libs/librados.so: undefined reference to `crush_reweight_bucket'

I had to revert the two commits I pushed today and build from scratch,
so it might be some transient error related to the original issue, I'm
not too sure though.

Yehuda
