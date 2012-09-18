From: John Axel Eriksson <john@insane.se>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 08:35:09 +0200
Message-ID: <CAMmJxtKLMmbPot=-QkvGGU9BhEXsqqqw2kUexkpcU1GWztQ48w@mail.gmail.com>
References: <5057649E02000099000EA57E@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35809 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab2IRGfK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 02:35:10 -0400
Received: by vcbfo13 with SMTP id fo13so7102368vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 23:35:09 -0700 (PDT)
In-Reply-To: <5057649E02000099000EA57E@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: mark.nelson@inktank.com, ross@inktank.com, ceph-devel@vger.kernel.org

Well I've used Btrfs on and off for two years now I think - in less
critical situations though (at home, on testing equipment at work and
on easily rebuildable systems). I've been bitten several times before
so I know there've been serious problems with it.
With Kernel 3.5 I had a pretty good feeling about it and I ran it for
some time without any issues at all so I based my decision to try it
on that and on the fact that we store to AWS S3 as well and can
actually switch over to that as the primary store if we need to,
though with much worse throughput (though throughput isn't extremely
important to us). So far it's been holding up pretty well, though I
guess we're neither the most write or read intensive out there.

For development we use VMs with Ceph on our laptops - those are
running Btrfs on Kernel 3.2 and we've had issues on them, so I think
something good happened to Btrfs on 3.4/3.5.

I'll keep you posted on how it works out for us on 3.5.

On Tue, Sep 18, 2012 at 1:57 AM, Nick Couchman <Nick.Couchman@seakr.com> wrote:
> John,
> I'd be really interested to hear how Btrfs goes over time.  I tried it out a few kernel versions ago and regretted it - lost some data after using it.  Hopefully the stability is better than it was before, and inline compression is always great!
>
> -Nick
>
>>>> John Axel Eriksson  09/17/12 5:26 PM >>>
> Our use of Ceph started pretty recently (this summer). We only use
> rados together with the radosgw. We moved from another distributed
> storage solution that had failed us more than once and we lost data.
> Since the old system had an http interface (not S3 compatible though)
> we looked around for another similar system. In the end we chose Ceph
> since it had been in development for quite some time, had been
> incorporated in the kernel (well, the client for the fs that is) and
> recently got a company behind it. Ceph felt pretty solid, even though
> it's still early days I guess.
>
> We obviously liked the fact that it has an S3 compatible interface,
> especially since we started backing up data to Amazon S3 some time ago
> - having the same interface simplified our client code tremendously.
> We don't actually need extreme throughput (yet anyway :-) but we do
> need replication. We're quite happy with the performance so far since
> it's better than our old system.
> We store medical data for archival and conversion from and to
> different formats. Since we (after previous failures in the old
> storage system) store everything in Amazon S3 as well, we made a bet
> on Kernel 3.5 and Btrfs with compression for some quite dramatic space
> savings - the data we store often compresses really well. So far we
> haven't regretted that choice, but we've only been running it in
> production for about two months while slowly phasing out the old
> storage system.
>
> John
>
> On Tue, Sep 18, 2012 at 12:53 AM, Mark Nelson  wrote:
>> Hi Nick,
>>
>> All I have to say, is that is totally awesome and scary at the same time. :)
>>
>> Glad to hear that it recovers well when people shut their desktops off!
>>
>> Mark
>>
>>
>> On 09/17/2012 05:47 PM, Nick Couchman wrote:
>>>
>>> My use of Ceph is probably pretty unique in some of the aspects of
>>> where/how I'm using it.  I run an IT department for a medium-sized
>>> engineering firm.  One of my goals is to try to make the best possible use
>>> of the hardware we're deploying to users' desktops.  Often times users
>>> cannot get by with a thin client and a VM somewhere, they actually need
>>> decent hardware on the desktop.  However, when the hardware isn't being
>>> used, it's nice to be able to have access to some of the free disk space,
>>> I/O bandwidth, memory, and CPU cycles available on the hardware.  So, Ceph
>>> is part of an overall strategy for making use of the hardware.  I'm guessing
>>> most folks run it on racked servers in datacenters, but I'm distributing it
>>> across desktops.
>>>
>>> I've started by rolling out Linux to the desktop bare metal rather than
>>> Windows.  I run openSuSE 12.1, probably moving to 12.2 here in the
>>> near-future (I have Ceph packages available and built for openSuSE 11.4,
>>> 12.1, and 12.2 on my OBS project).  I run the Xen kernel on this hardware so
>>> that I can run VMs on top of it for various purposes.  For folks who need
>>> Windows, I use Windows-based VMs on Xen.  For the types who are comfortable
>>> with switching between Linux and Windows, I use a Windows VM and then
>>> rdesktop to connect from the Linux desktop/window manager.  For the types
>>> who are only comfortable in Windows, I use VGA and PCI pass-through in Xen
>>> to pass the video card and the USB controllers to the Windows guest, making
>>> the Linux base install transparent to the end-user.
>>>
>>> To make use of free CPU cycles, in addition to VMs, I use the latest
>>> freely-available version of the software formerly known as the Sun Grid
>>> Engine to make these desktop systems part of the batching system that allows
>>> engineers to run HPC jobs.  They mount various filesystems from our NFS
>>> servers and jobs can execute on these systems on evenings and weekends.
>>>
>>> Ceph is a pretty recent addition to these configurations.  I wanted to
>>> find an easy way to make use of the free disk space on these systems, but in
>>> a useful way that aggregates it all together.  After looking at several
>>> distributed filesystems, Ceph came up as the one with the feature sets that
>>> made the most sense for me.  So, I've spent a bunch of time building
>>> packages, testing out Ceph, and have finally rolled it out on these two
>>> dozen Linux desktops, aggregating 100GB from each desktop's 250GB drive into
>>> a single pool that adds up to roughly 2.2TB of raw storage.  I currently do
>>> 3 replications for all of my pools in Ceph to try to protect against a
>>> desktop machine going down, getting shut down, etc., which does happen from
>>> time-to-time.  So far this has worked out pretty well, and Ceph seems to
>>> recover pretty well from these failures, moving blocks to different systems
>>> when necessary, then re-doing that when the systems come back online.
>>>
>>> My next steps for this setup, including Ceph, really get into more of a
>>> private cloud infrastructure using desktop commodity hardware.  I'd like to
>>> be able to install something like Openstack or the XAPI/XCP software on
>>> these systems and centrally manage the aggregated storage along with memory
>>> and CPU with a tool like that.  This would give me the ability to deploy
>>> these inexpensive systems across the organization, but make sure they're
>>> used to their best capacity, and it also allows for great flexibility when
>>> users move from machine to machine, or VMs need to move from place to place.
>>> I do keep a lot of my critical infrastructure in my datacenter on more
>>> traditional compute systems - a SAN, XenServer, fileservers/NAS with
>>> NFS/CIFS, etc. - but this is a good way for me to prove out the usefulness
>>> and reliability of systems like Ceph and other cloud-computing concepts and
>>> then take those and apply them to increasingly complex and critical needs in
>>> my organization.
>>>
>>> For Ceph improvements that would help me out, the ability to support POSIX
>>> and NFSv4 ACLs would be a fantastic addition.  We use these types of
>>> permissions on our main filesystems to control access better than the
>>> traditional UGO-style permissions, and I already miss it while using Ceph.
>>> Also, I know the concept of deduplication has been discussed, and this, too,
>>> would be great.  I was actually wondering about the feasibility of
>>> implementing post-processing deduplication on Ceph, first, rather than
>>> inline deduplication - obviously this increases disk space requirements
>>> since there has to be enough to store the duplicated data, but still seems
>>> to beat no deduplication at all.  Not a huge requirement at this point, but
>>> playing with FSs that support deduplication makes me want it everywhere :-).
>>>
>>> -Nick
>>>
>>>>>> On 2012/09/17 at 16:14, Ross Turk  wrote:
>>>>
>>>> Hi, all!
>>>>
>>>> One of the most important parts of Inktank's mission is to spread the
>>>> word about Ceph. We want everyone to know what it is and how to use
>>>> it.
>>>>
>>>> In order to tell a better story to potential new users, I'm trying to
>>>> get a sense for today's deployments. We've spent the last few months
>>>> talking to folks around the world, but I'm sure there are a few great
>>>> stories we haven't heard yet!
>>>>
>>>> If you've got a spare five minutes, I would love to hear what you're
>>>> up to. What kind of projects are you working on, and in what stage?
>>>> What is your workload? Are you using Ceph alongside other
>>>> technologies? How has your experience been?
>>>>
>>>> This is also a good opportunity for me to introduce myself to those I
>>>> haven't met yet! Feel free to copy the list if you think others would
>>>> be interested (and you don't mind sharing).
>>>>
>>>> Cheers,
>>>> Ross
>>>>
>>>> --
>>>> Ross Turk
>>>> Ceph Community Guy
>>>>
>>>> "Any sufficiently advanced technology is indistinguishable from magic."
>>>> -- Arthur C. Clarke
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>>> --------
>>> This e-mail may contain confidential and privileged material for the sole
>>> use of the intended recipient.  If this email is not intended for you, or
>>> you are not responsible for the delivery of this message to the intended
>>> recipient, please note that this message may contain SEAKR Engineering
>>> (SEAKR) Privileged/Proprietary Information.  In such a case, you are
>>> strictly prohibited from downloading, photocopying, distributing or
>>> otherwise using this message, its contents or attachments in any way.  If
>>> you have received this message in error, please notify us immediately by
>>> replying to this e-mail and delete the message from your mailbox.
>>> Information contained in this message that does not relate to the business
>>> of SEAKR is neither endorsed by nor attributable to SEAKR.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --------
>
> This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
