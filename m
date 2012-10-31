From: Stefan Kleijkers <stefan@kleijkers.nl>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 23:04:30 +0100
Message-ID: <5091A06E.20407@kleijkers.nl>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com> <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com> <CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out118.unilogicnetworks.net ([62.133.206.118]:34358 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750936Ab2JaWEc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Oct 2012 18:04:32 -0400
In-Reply-To: <CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

Hello,

On 10/31/2012 10:58 PM, Gandalf Corvotempesta wrote:
> 2012/10/31 Tren Blackburn <tren@eotnetworks.com>:
>> Unless you're using btrfs which writes to the journal and osd fs
>> concurrently, if you lose the journal device (such as due to a
>> reboot), you've lost the osd device, requiring it to be remade and
>> re-added.
> I don't understood.
> Loosing a journal, will result in the whole OSD lost?
>
> AFAIK, Ceph will write to journal. After this write it will return an "OK".
> After that, the journal is wrote (in background) to a disk, so,
> loosing a journal should result in loosing that portion of data, not
> the whole osd.
>
> Now, in case of 3 replicated nodes, ceph will write the same data at
> the same time to the three journals? If yes, loosing a single
> journal/osd should not result in loss of data, because the same data
> are still on other 2 nodes. In this case, should be possible to use a
> tmpfs as journal and using the replica as redundancy.

As far as I know, this is correct. You get a ACK (on the write) back 
after it landed on ALL three journals (or/and osds in case of BTRFS in 
parallel mode). So If you lose one node, you still have it in two more 
nodes and they will commit it to disk. After recovering the missing 
node/osd it will get the data from one of the other nodes. So you won't 
lose any data.

Stefan
