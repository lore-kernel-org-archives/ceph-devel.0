From: Wade Holler <wade.holler@gmail.com>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of
 objects in pool
Date: Wed, 22 Jun 2016 21:41:32 -0400
Message-ID: <CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl> <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
 <CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
 <CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
 <D38DCB57.131AE%warren.wang@walmart.com> <20160621075856.3ad471d1@batzmaru.gol.ad.jp>
 <CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com> <CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:32926 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcFWBle (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 21:41:34 -0400
Received: by mail-oi0-f44.google.com with SMTP id u201so49153416oie.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 18:41:34 -0700 (PDT)
In-Reply-To: <CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Christian Balzer <chibi@gol.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Blairo,

We'll speak in pre-replication numbers, replication for this pool is 3.

23.3 Million Objects / OSD
pg_num 2048
16 OSDs / Server
3 Servers
660 GB RAM Total, 179 GB Used (free -t) / Server
vm.swappiness = 1
vm.vfs_cache_pressure = 100

Workload is native librados with python.  ALL 4k objects.

Best Regards,
Wade


On Wed, Jun 22, 2016 at 9:33 PM, Blair Bethwaite
<blair.bethwaite@gmail.com> wrote:
> Wade, good to know.
>
> For the record, what does this work out to roughly per OSD? And how
> much RAM and how many PGs per OSD do you have?
>
> What's your workload? I wonder whether for certain workloads (e.g.
> RBD) it's better to increase default object size somewhat before
> pushing the split/merge up a lot...
>
> Cheers,
>
> On 23 June 2016 at 11:26, Wade Holler <wade.holler@gmail.com> wrote:
>> Based on everyones suggestions; The first modification to 50 / 16
>> enabled our config to get to ~645Mill objects before the behavior in
>> question was observed (~330 was the previous ceiling).  Subsequent
>> modification to 50 / 24 has enabled us to get to 1.1 Billion+
>>
>> Thank you all very much for your support and assistance.
>>
>> Best Regards,
>> Wade
>>
>>
>> On Mon, Jun 20, 2016 at 6:58 PM, Christian Balzer <chibi@gol.com> wrote:
>>>
>>> Hello,
>>>
>>> On Mon, 20 Jun 2016 20:47:32 +0000 Warren Wang - ISD wrote:
>>>
>>>> Sorry, late to the party here. I agree, up the merge and split
>>>> thresholds. We're as high as 50/12. I chimed in on an RH ticket here.
>>>> One of those things you just have to find out as an operator since it's
>>>> not well documented :(
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1219974
>>>>
>>>> We have over 200 million objects in this cluster, and it's still doing
>>>> over 15000 write IOPS all day long with 302 spinning drives + SATA SSD
>>>> journals. Having enough memory and dropping your vfs_cache_pressure
>>>> should also help.
>>>>
>>> Indeed.
>>>
>>> Since it was asked in that bug report and also my first suspicion, it
>>> would probably be good time to clarify that it isn't the splits that cause
>>> the performance degradation, but the resulting inflation of dir entries
>>> and exhaustion of SLAB and thus having to go to disk for things that
>>> normally would be in memory.
>>>
>>> Looking at Blair's graph from yesterday pretty much makes that clear, a
>>> purely split caused degradation should have relented much quicker.
>>>
>>>
>>>> Keep in mind that if you change the values, it won't take effect
>>>> immediately. It only merges them back if the directory is under the
>>>> calculated threshold and a write occurs (maybe a read, I forget).
>>>>
>>> If it's a read a plain scrub might do the trick.
>>>
>>> Christian
>>>> Warren
>>>>
>>>>
>>>> From: ceph-users
>>>> <ceph-users-bounces@lists.ceph.com<mailto:ceph-users-bounces@lists.ceph.com>>
>>>> on behalf of Wade Holler
>>>> <wade.holler@gmail.com<mailto:wade.holler@gmail.com>> Date: Monday, June
>>>> 20, 2016 at 2:48 PM To: Blair Bethwaite
>>>> <blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com>>, Wido den
>>>> Hollander <wido@42on.com<mailto:wido@42on.com>> Cc: Ceph Development
>>>> <ceph-devel@vger.kernel.org<mailto:ceph-devel@vger.kernel.org>>,
>>>> "ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>"
>>>> <ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>> Subject:
>>>> Re: [ceph-users] Dramatic performance drop at certain number of objects
>>>> in pool
>>>>
>>>> Thanks everyone for your replies.  I sincerely appreciate it. We are
>>>> testing with different pg_num and filestore_split_multiple settings.
>>>> Early indications are .... well not great. Regardless it is nice to
>>>> understand the symptoms better so we try to design around it.
>>>>
>>>> Best Regards,
>>>> Wade
>>>>
>>>>
>>>> On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite
>>>> <blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com>> wrote: On
>>>> 20 June 2016 at 09:21, Blair Bethwaite
>>>> <blair.bethwaite@gmail.com<mailto:blair.bethwaite@gmail.com>> wrote:
>>>> > slow request issues). If you watch your xfs stats you'll likely get
>>>> > further confirmation. In my experience xs_dir_lookups balloons (which
>>>> > means directory lookups are missing cache and going to disk).
>>>>
>>>> Murphy's a bitch. Today we upgraded a cluster to latest Hammer in
>>>> preparation for Jewel/RHCS2. Turns out when we last hit this very
>>>> problem we had only ephemerally set the new filestore merge/split
>>>> values - oops. Here's what started happening when we upgraded and
>>>> restarted a bunch of OSDs:
>>>> https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-xs_dir_lookup.png
>>>>
>>>> Seemed to cause lots of slow requests :-/. We corrected it about
>>>> 12:30, then still took a while to settle.
>>>>
>>>> --
>>>> Cheers,
>>>> ~Blairo
>>>>
>>>> This email and any files transmitted with it are confidential and
>>>> intended solely for the individual or entity to whom they are addressed.
>>>> If you have received this email in error destroy it immediately. ***
>>>> Walmart Confidential ***
>>>
>>>
>>> --
>>> Christian Balzer        Network/Systems Engineer
>>> chibi@gol.com           Global OnLine Japan/Rakuten Communications
>>> http://www.gol.com/
>
>
>
> --
> Cheers,
> ~Blairo
