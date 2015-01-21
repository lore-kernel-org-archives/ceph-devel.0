From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Memstore issue on v0.91
Date: Wed, 21 Jan 2015 08:13:03 -0600
Message-ID: <54BFB3EF.1030800@redhat.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB3CD9F@FMSMSX106.amr.corp.intel.com>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57661 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbAUONH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 09:13:07 -0500
Received: by mail-ie0-f169.google.com with SMTP id rl12so17997776iec.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2015 06:13:06 -0800 (PST)
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120AB3CD9F@FMSMSX106.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 01/21/2015 01:48 AM, Blinick, Stephen L wrote:
> Moved to 0.91 yesterday and ran into some issues, with a Memstore OSD of default size.  After a few hundred K OPS client gets a FULL message and the avail space looks like:
>
> [root@cephtestnode0 bmpa]# rados df
> pool name                 KB      objects       clones     degraded     unfound           rd        rd KB           wr        wr KB
> rbd                        0            0            0            0          0            0            0            0            0
> testmemstore         1505052       376263            0            0          0            0            0       376263      1505052
>    total used         1494247       376263
>    total avail   18014398508987737
>    total space        1000000
>
> I was looking at pull request #2836 and found a case where there could be an unsigned int underflow in MemStore.cc:statfs:
>
>     st->f_bfree = st->f_bavail = MAX((st->f_blocks - used_bytes / st->f_bsize), 0);
>
> But that wasn't the final issue.. I put some asserts where used_bytes could underflow as well and didn't catch anything.  I will keep digging but wanted to find out if anyone else was seeing the issue as well.

FWIW, I hit this yesterday too.  I hadn't started debugging it yet 
though.  Looks like you are farther along than I am, thanks Stephen! :)

>
> Thanks,
>
> Stephen
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
