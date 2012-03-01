From: Wido den Hollander <wido@widodh.nl>
Subject: Re: PG state issue
Date: Thu, 01 Mar 2012 11:34:06 +0100
Message-ID: <4F4F509E.1040905@widodh.nl>
References: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:37862 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab2CAKeJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Mar 2012 05:34:09 -0500
In-Reply-To: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 03/01/2012 10:43 AM, Henry C Chang wrote:
> Hi,
> With version 0.42, I found that the pg's state is not in "degrade" any
> more if the number of osds is smaller than that of the replication.
> For example, if I create a cluster of one osd with replication 2, all
> pgs are in active+clean state. (The pgs were in active+clean+degrade
> state in the earlier versions.)

Just a conformation from my side.

Currently I have 3 OSD's which our down/out and only one PG went into 
degraded state. The weird thing is, these OSD's are not acting for this PG.

The OSD's for this PG are all up and in.

Wido

>
> I think it should be a bug in terms of cluster status although it does
> not cause any other problems to me so far.
>
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
