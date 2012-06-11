From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: radosgw authentication problems
Date: Sun, 10 Jun 2012 19:30:31 -0500
Message-ID: <4FD53C27.80809@inktank.com>
References: <CAMmJxt+QMPoY-6WOypGjoTDjXafk_-knRUhfrsoca3zRn=YcXA@mail.gmail.com> <CAC-hyiFaTvhORZ-TdYSxgdBmZYuvWFKobHs_qvq8J8FY+pr=-g@mail.gmail.com> <CAMmJxtKZryK+i6jzoqRp=ojQXs1c_3d3Xsmjx7+c9GDpfwc9pg@mail.gmail.com> <CADvuQRE=rUwwzByGSdiExNMOy8-d37DBmxcj=Ez-QwwW70BcjQ@mail.gmail.com> <CAMmJxt+LhrsiCYETb5KUA=rNthPY4y2Yyh53v9Hocgq+PmsKrA@mail.gmail.com> <CADvuQRH=MJjNL7KMSWXXcOgRv5nAfOiH9efGOq+NXHary5iovQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63443 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2FKAau (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Jun 2012 20:30:50 -0400
Received: by yhmm54 with SMTP id m54so2176799yhm.19
        for <ceph-devel@vger.kernel.org>; Sun, 10 Jun 2012 17:30:49 -0700 (PDT)
In-Reply-To: <CADvuQRH=MJjNL7KMSWXXcOgRv5nAfOiH9efGOq+NXHary5iovQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: John Axel Eriksson <john@insane.se>, ceph-devel@vger.kernel.org

On 06/07/2012 02:44 PM, Tommi Virtanen wrote:
> On Thu, Jun 7, 2012 at 11:52 AM, John Axel Eriksson<john@insane.se>  wrote:
>> Do you recommend btrfs or perhaps xfs for osds etc?
>
> Right now I think the preference order is xfs btrfs ext4, but we keep
> seeing performance&  reliability issues fairly evenly these days.
> Btrfs apparently still has a tendency to get slower as the filesystem
> ages.
>
> Mark, feel free to correct me here ;)

I think Tommi's got it right.  So far what we've seen is that XFS is 
slower on a fresh file system but over time ends up being faster for 
small IO and about on-par for large IO.  We just started testing EXT4 
again now that we have leveldb in place.  I'm a little concerned about 
data integrity after ext4 failed on some benchmark runs, but on the 
upside performance looks pretty good so far. We'll see how well it ages 
vs xfs/btrfs in the coming weeks.

Mark
