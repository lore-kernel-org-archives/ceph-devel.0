From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: CephFS hangs when writing 10GB files in loop
Date: Thu, 18 Dec 2014 16:32:34 +0000
Message-ID: <EE4ECAFA-D981-44A6-B72F-63EC012E71EF@ornl.gov>
References: <5491B0E1.7050203@42on.com>
 <CAC6JEv9JBUjKgVzFcribvxLSn+HGhXbpdaymVWYi1RoD+YCqeg@mail.gmail.com>
 <5492A8D6.1020802@42on.com> <5492F8B5.4000408@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta02.ornl.gov ([128.219.177.12]:16989 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbaLRQcj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Dec 2014 11:32:39 -0500
In-Reply-To: <5492F8B5.4000408@42on.com>
Content-Language: en-US
Content-ID: <FE568BA510FAB047BC189FC63EE97A50@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Dec 18, 2014, at 10:54 AM, Wido den Hollander <wido@42on.com> wrote:

> On 12/18/2014 11:13 AM, Wido den Hollander wrote:
>> On 12/17/2014 07:42 PM, Gregory Farnum wrote:
>>> On Wed, Dec 17, 2014 at 8:35 AM, Wido den Hollander <wido@42on.com> wrote:
>>>> Hi,
>>>> 
>>>> Today I've been playing with CephFS and the morning started great with
>>>> CephFS playing along just fine.
>>>> 
>>>> Some information first:
>>>> - Ceph 0.89
>>>> - Linux kernel 3.18
>>>> - Ceph fuse 0.89
>>>> - One Active MDS, one Standby
>>>> 
>>>> This morning I could write a 10GB file like this using the kclient:
>>>> $ dd if=/dev/zero of=10GB.bin bs=1M count=10240 conv=fsync
>>>> 
>>>> That gave me 850MB/sec (all 10G network) and I could read the same file
>>>> again with 610MB/sec.
>>>> 
>>>> After writing to it multiple times it suddenly started to hang.
>>>> 
>>>> No real evidence on the MDS (debug mds set to 20) or anything on the
>>>> client. That specific operation just blocked, but I could still 'ls' the
>>>> filesystem in a second terminal.
>>>> 
>>>> The MDS was showing in it's log that it was checking active sessions of
>>>> clients. It showed the active session of my single client.
>>>> 
>>>> The client renewed it's caps and proceeded.
>>> 
>>> Can you clarify this? I'm not quite sure what you mean.
>>> 
>> 
>> I currently don't have the logs available. That was my problem when
>> typing the original e-mail.
>> 
>>>> I currently don't have any logs, but I'm just looking for a direction to
>>>> be pointed towards.
>>>> 
>>>> Any ideas?
>>> 
>>> Well, now that you're on v0.89 you should explore the admin
>>> socket...there are commands on the MDS to dump ops in flight (and
>>> maybe to look at session states? I don't remember when that merged).
>> 
>> Sage's pointer towards the kernel debugging and the new admin socket
>> showed me that it were RADOS calls which were hanging.
>> 
>> I investigated even further and it seems that this is not a CephFS
>> problem, but a local TCP issue which is only triggered when using CephFS.
>> 
>> At some point, which is still unclear to me, data transfer becomes very
>> slow. The MDS doesn't seem to be able to update the journal and the
>> client can't write to the OSDs anymore.
>> 
>> It happened after I did some very basic TCP tuning (timestamp, rmem,
>> wmem, sack, fastopen).
>> 
> 
> So it was tcp_sack. With tcp_sack=0 the MDS has problems talking to
> OSDs. Other clients still work fine, but the MDS couldn't replay it's
> journal and such.
> 
> Enabling tcp_sack again resolved the problem. The new admin socket
> really helped there!

What was the reasoning behind disabling SACK to begin with? Without it, any drops or reordering might require resending potentially a lot of data.

> 
>> Reverting back to the Ubuntu 14.04 defaults resolved it all and CephFS
>> is running happily now.
>> 
>> I'll dig some deeper to see why this system was affected by those
>> changes. I applied these settings earlier on a RBD-only cluster without
>> any problems.
>> 
>>> -Greg
>>> 
>> 
>> 
> 
> 
> -- 
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

