From: Stefan Kleijkers <stefan@kleijkers.nl>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 22:32:17 +0100
Message-ID: <509198E1.1040402@kleijkers.nl>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com> <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out118.unilogicnetworks.net ([62.133.206.118]:48763 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760746Ab2JaVwl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Oct 2012 17:52:41 -0400
In-Reply-To: <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

Hello,

On 10/31/2012 10:24 PM, Tren Blackburn wrote:
> On Wed, Oct 31, 2012 at 2:18 PM, Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com> wrote:
>> In a multi replica cluster (for example, replica = 3) is safe to set
>> journal on a tmpfs?
>> As fa as I understood with journal enabled all writes are wrote on
>> journal and then to disk in a second time.
>> If node hangs when datas are still on journal (and journal is not on a
>> permanent disk), some data lost could happens.
>>
>> In a multi replica environment, other nodes should be able to write
>> the same datas to disk, right? I this case, using a journal on a tmpfs
>> should be safe enough.
> Unless you're using btrfs which writes to the journal and osd fs
> concurrently, if you lose the journal device (such as due to a
> reboot), you've lost the osd device, requiring it to be remade and
> re-added.
>
> This is what I understand at least. If I'm wrong one of the devs will
> strike me down I'm sure ;)

There's an option to recreate the journal, so you don't lose the OSD. 
Ofcourse you lose the data in the journal.
It's possible to have the journal on a tmpfs device, ofcourse it's not 
100% safe, in case you lose the three nodes with the replica's you can 
lose data. But then again if you have more replica's the change of 
losing them all gets smaller. It's a trade between speed, reliability 
and space.

Stefan

