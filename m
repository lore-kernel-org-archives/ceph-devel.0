From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Fri, 30 Jan 2015 10:46:06 +0800
Message-ID: <CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:41682 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbA3CqI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 21:46:08 -0500
Received: by mail-we0-f170.google.com with SMTP id w55so19326689wes.1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 18:46:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Chris Pacejo <cpacejo@clearskydata.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Chris,

For metadata overhead, we need to resolve it at upper level,
keyvaluestore won't add extra metadata in normal io except rarely
header save which only update when header changed.

As for active write, why do you think it there only one active write
in keyvaluestore threads? I just check runtime perf data again, it
looks fine that multi write can do concurrently submit transaction.

On Fri, Jan 30, 2015 at 6:51 AM, Sage Weil <sage@newdream.net> wrote:
> Hi Chris,
>
> [Moving this thread to ceph-devel, which is probably a bit more
> appropriate.]
>
> On Thu, 29 Jan 2015, Chris Pacejo wrote:
>> Hi, we've been experimenting with the keyvaluestore backend, and have found
>> that, on every object write (e.g. with `rados put`), a single transaction is
>> issued containing an additional 9 KeyValueDB writes, beyond those which
>> constitute the object data.  Given the key names, these are clearly all
>> metadata of some sort, but this poses a problem when the objects themselves
>> are very small.  Given the default strip block size of 4 KiB, with objects
>> of size 36 KiB or less, half or more of all key-value store writes are
>> metadata writes.  With objects of size 4 KiB or less, the metadata overhead
>> grows to 90%+.
>>
>> Is there any way to reduce the number of metadata rows which must be written
>> with each object?
>
> There is a level (or two) of indirection in KeyValueStore's
> GenericObjectMap that is there to allow object cloning.  I wonder if we
> will want to facilitate a backend that doesn't implement clone and can
> only be used for pools that disallow clone and snap operations.
>
> There is also some key consolidation in the OSD layer we talked about in
> the wednesday performance call that will cut this down some!
>
>> (Alternatively, if there is a way to convince the OSD to issue multiple
>> concurrent write transactions, that would also help.  But even with
>> "keyvaluestore op threads" set as high as 64, and `rados bench` issuing 64
>> concurrent writes, we never see more than a single active write transaction
>> on the (multithread-capable) backend.  Is there some other option we're
>> missing?)
>
> sage



-- 
Best Regards,

Wheat
