From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 10:31:35 -0800
Message-ID: <AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
	<87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
	<Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49033 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab1BYSby convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 13:31:54 -0500
Received: by bwz15 with SMTP id 15so2193129bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 10:31:53 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I kind of want to prefix all the object operations with "obj_" just to
make things clear. Then it would be rados_obj_rollback() /
PoolHandle::obj_rollback().
What do you think?

Colin


On Fri, Feb 25, 2011 at 9:05 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 25 Feb 2011, Gregory Farnum wrote:
>> I think you guys talked about this yesterday -- sorry I missed it --=
 but
>> what's the logic behind this new name "rados_rollback"? It's not qui=
te
>> working for me -- I think because it lacks the noun. :) Could we at
>> least do rados_object_rollback()? Or even
>> rados_object_rollback_to_snap()?
>
> It matches rados_write, read, remove, etc. =A0 Either they all get
> rados_object_ prefix or none do. =A0I'm fine with either...
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
