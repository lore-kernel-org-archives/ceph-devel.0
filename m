From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph does not work
Date: Thu, 23 Feb 2012 11:07:38 -0800
Message-ID: <CAF3hT9ALuVKcdQgsO-oJTP=KX9gnxGdSLLVjsvv69js=j+KXuA@mail.gmail.com>
References: <1329988516.4f4603a4d1995@mail.inbox.lv>
	<CAORUGqC_bDOzyo4nmwT6gUo_yOsyEz3nUFdZs5+m0WdHFMraYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43142 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2BWTHi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 14:07:38 -0500
Received: by yhoo21 with SMTP id o21so781936yho.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 11:07:38 -0800 (PST)
In-Reply-To: <CAORUGqC_bDOzyo4nmwT6gUo_yOsyEz3nUFdZs5+m0WdHFMraYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: =?UTF-8?B?0JTQtdC90LjRgdC60LAt0YDQtdC00LjRgdC60LA=?= <slim@inbox.lv>, ceph-devel@vger.kernel.org

On Thu, Feb 23, 2012 at 11:00 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Feb 23, 2012 at 01:15, =D0=94=D0=B5=D0=BD=D0=B8=D1=81=D0=BA=D0=
=B0-=D1=80=D0=B5=D0=B4=D0=B8=D1=81=D0=BA=D0=B0 <slim@inbox.lv> wrote:
>> ehllo here,
>>
>> i have tried to setup ceph .41 in simple configuration:
>> 3 nodes, each running mon, mds & osd with replication level 3 for da=
ta & metadata pools.
>> Each node mounts ceph locally via ceph-fuse
>> cluster seems running well until one of the nodes goes down for simp=
le reboot.
>> Then all mount points become inaccessible, data transfer hangs and c=
luster stop working
>>
>> What is the purpose of ceph software while such simple case does not=
 go through ?
>
> You have a replication factor of 3, and 3 OSDs. If one of them is
> down, the replication factor of 3 cannot be satisfied anymore. You
> need either more nodes, or a smaller replication factor.
>
> Ceph is not an eventually consistent system; building a POSIX
> filesystem on top of one is pretty much impossible. With Ceph, all
> replicas are always kept up to date.

Actually the OSDs will happily (well, not happily; the will complain.
But they will run) run in degraded mode. However, if you have 3 active
MDSes and you kill one of them without a standby available, you will
lose access to part of your tree. That's probably what happened
here...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
