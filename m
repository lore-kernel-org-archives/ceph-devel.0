From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: which mds server is damaged?
Date: Thu, 14 Sep 2017 13:17:15 -0700
Message-ID: <CAKRxpuurKQp6vQmt2_mc5ckHZMjHajnivDob58eMpcUXodOupw@mail.gmail.com>
References: <CAKRxpus_QKHx=Wi8UU-g50i8g3nkEKdg2mGVcu_uO5FbAoHHFA@mail.gmail.com>
 <CALe9h7fhfWQ1paK7TpCMVv+FA0Ta4_5X5FGWdWdgwyLjDmZxgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:46279 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdINURS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 16:17:18 -0400
Received: by mail-it0-f43.google.com with SMTP id 6so1198957itl.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 13:17:18 -0700 (PDT)
In-Reply-To: <CALe9h7fhfWQ1paK7TpCMVv+FA0Ta4_5X5FGWdWdgwyLjDmZxgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>> I don't think there is a Troubleshooting MDS section. Nice to have one.
>If you google "ceph troubleshooting mds" you'll find that the first
>hit is the cephfs troubleshooting page here:
>docs.ceph.com/docs/master/cephfs/troubleshooting/

Thanks. I actually did see that. I thought to myself, "not the right
page" as I was explicitly looking for Troubleshooting MDS in the title
under Ceph storage cluster/operations where the troubleshooting MON
and OSD sections are. Based on the diagrams I've seen where MON - OSD
- MDS are all in the same row,  I thought the flow was Ceph storage
cluster -> mds (daemons) -> cephfs.(upper layers) I'm stilll getting
use to the doc layout.

>> how do I go from mds.0 to a physical hostname?
>The thing that's damaged is a logical mds rank (0), not a physical MDS
>daemon.  What this is telling you is that there is some serious
>corruption in your metadata pool that prevents that particular rank
>from starting.

Zhang helped identify the bug and put it in tracker. I didn't fully
understand the problem but related to mds replay not happening and the
write_pos being off. He fixed it after a full scrub was done, the
degraded file system came back online. After a couple more hours of
stress testing, the file system went back to degraded(earlier today).

>So if I recall correctly, you had a system with some unfound/damaged
>PGs.  I would strongly suspect that to be the underlying cause of the
>damaged to your CephFS metadata, so unless you've got something
>irreplaceable in your CephFS filesystem, just blow it away and create
>a fresh one.

The unfound pg was mds related that was reverted. My understanding is
that doesn't affect a large number of files.

I know Ceph is not ready for production data yet but  I'm also tasked
to identify the show stoppers and a timeline. I need to include in my
report all the symptoms I encountered and the fixes. blow away the
file system is not an option in this evaluation. Part of the
evaluation includes ceph's ability to recovery.


On Thu, Sep 14, 2017 at 1:55 AM, John Spray <jspray@redhat.com> wrote:
> On Thu, Sep 14, 2017 at 2:49 AM, Two Spirit <twospirit6905@gmail.com> wrote:
>> I don't think there is a Troubleshooting MDS section. Nice to have one.
>
> If you google "ceph troubleshooting mds" you'll find that the first
> hit is the cephfs troubleshooting page here:
> docs.ceph.com/docs/master/cephfs/troubleshooting/
>
>> I'm not sure how to read "cephfs-0/1/1" as to what the 3 digits are.
>> It is unclear to me if I have 3 or 4 MDS. I thought i only setup 3,
>> but I think it telling me I actually have 4.
>> I can't figure out which server is the damaged MDS. The ceph mds dump
>> said "damaged 0".
>> Since "ceph -s' is saying I only have 1 damaged mds, I should be able
>> to remove it.
>>
>> how do I go from mds.0 to a physical hostname?
>
> The thing that's damaged is a logical mds rank (0), not a physical MDS
> daemon.  What this is telling you is that there is some serious
> corruption in your metadata pool that prevents that particular rank
> from starting.
>
>>
>> $ ceph mds rmfailed 0 --yes-i-really-mean-it
>> removed failed mds.1:0
>>
>> I thought I asked it to remove mds.0, but it looks like I'm removing mds.1
>
> Two things:
>  * You ignored the part where rmfailed tells you "WARNING: this can
> make your filesystem inaccessible!".  Please don't just ignore
> messages like that, they're there for a reason.  Fortunately in this
> situation rmfailed did not actually change anything, because you
> didn't have any "failed" MDS ranks, just a damaged one.
>  * the "mds.1:0" syntax is telling you that it's rank 0 in a
> filesystem with ID 1.
>
>> $ ceph health detail
>> MDS_DAMAGE 1 mds daemon damaged
>>     fs cephfs mds.0 is damaged
>
> So if I recall correctly, you had a system with some unfound/damaged
> PGs.  I would strongly suspect that to be the underlying cause of the
> damaged to your CephFS metadata, so unless you've got something
> irreplaceable in your CephFS filesystem, just blow it away and create
> a fresh one.
>
> John
>
>>   services
>>     mds: cephfs-0/1/1 up , 3 up:standby, 1 damaged
>>
>> $ ceph mds dump
>> dumped fsmap epoch 632
>> fs_name cephfs
>> epoch   632
>> flags   d
>> created 2017-08-24 14:35:33.735399
>> modified        2017-08-24 14:35:33.735400
>> tableserver     0
>> root    0
>> session_timeout 60
>> session_autoclose       300
>> max_file_size   1099511627776
>> last_failure    0
>> last_failure_osd_epoch  1828
>> compat  compat={},rocompat={},incompat={1=base v0.20,2=client
>> writeable ranges,3=default file layouts on dirs,4=dir inode in
>> separate object,5=mds uses versioned encoding,6=dirfrag is stored in
>> omap,8=file layout v2}
>> max_mds 1
>> in      0
>> up      {}
>> failed
>> damaged 0
>> stopped
>> data_pools      [5]
>> metadata_pool   6
>> inline_data     disabled
>> balancer
>> standby_count_wanted    1
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
