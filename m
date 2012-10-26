From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Proper configuration of the SSDs in a storage brick
Date: Fri, 26 Oct 2012 15:55:35 +0200
Message-ID: <508A9657.3080006@widodh.nl>
References: <002401cdb2b4$f259c800$d70d5800$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56822 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab2JZNzj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 09:55:39 -0400
In-Reply-To: <002401cdb2b4$f259c800$d70d5800$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: ceph-devel@vger.kernel.org

On 10/25/2012 03:30 PM, Stephen Perkins wrote:
> Hi all,
>
> In looking at the design of a storage brick (just OSDs), I have found a dual
> power hardware solution that allows for 10 hot-swap drives and has a
> motherboard with 2 SATA III 6G ports (for the SSDs) and 8 SATA II 3G (for
> physical drives).  No RAID card. This seems a good match to me given my
> needs.  This system also supports 10G Ethernet via an add in card, so please
> assume that for the questions.  I'm also assuming 2TB or 3TB drives for the
> 8 hot swap.  My workload is throughput intensive (writes mainly) and not IOP
> heavy.
>
> I have 2 questions and would love to hear from the group.
>
> Question 1: What is the most appropriate configuration for the journal SSDs?
>
> I'm not entirely sure what happens when you lose a journal drive.  If the
> whole brick goes offline (i.e. all OSDs stop communicating with ceph), does
> it make since to configure the SSDs into RAID1?
>

When you loose the journal these OSDs will commit suicide and in this 
case you'd loose 8 OSDs.

Placing two SSDs in RAID-1 seems like overkill to me. I've been using 
hundreds of Intel SSDs over the past 3 years and I've never see one (not 
one!) die.

A SSD will die at some point due to extensive writes, but in RAID-1 they 
would burn through those writes in a identical matter.

> Alternatively, it seems that there is a performance benefit to having 2
> independent SSDs since you get potentially twice the journal rate.  If a
> journal drive goes offline. do you only have to recover half the brick?
>

If you place 4 OSDs on 1 SSD and the other 4 on the second SSD you'd 
indeed only loose 4 OSDs.

> If having 2 drives does not provide a performance benefit, it there a
> benefit other than RAID 1 for redundancy?
>

Something like RAID-1 would not, RAID-0 might do it. But I would split 
the OSDs up over 2 SSDs.

>
> Question 2:  How to handle the OS?
>
> I need to install an OS on each brick?   I'm guessing the SSDs are the
> device of choice. Not being entirely familiar with the journal drives:
>
> Should I create a separate drive partition for the OS?
>
> Or. can the journals write to the same partition as the OS?
>
> Should I dedicate one drive to the OS and one drive to the journal?
>

I'd suggest using Intel SSDs and shrinking them in size using HPA, Host 
Protected Area.

With that you can shrinkg a 180GB SSD to for example 60GB. By doing so 
the SSD can perform better wear-leveling and it would maintain optimal 
performance over time, it also extends the lifetime of the SSD. It has 
more "spare cells".

Under Linux you can change this with "hdparm" and the -N option.

Using a separate partition for the journal and OS would be preferred. 
Make sure to align the partition with the erase size of the SSD, 
otherwise you could run into write amplification of the SSD.

You would end up with:
* OS partition
* Swap?
* Journal #1
* Journal #2

Depends on what you are going to use.

Wido

> RAID1 or independent?
>
> Use a mechanical drive?
>
> Alternately. the 10G NIC cards support remote iSCSI boot.  This allows both
> SSDs to be dedicated to journaling. Seems like more complexity.
>
> I would appreciate hearing the thoughts of the group.
>
> Best regards,
>
> - Steve
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

