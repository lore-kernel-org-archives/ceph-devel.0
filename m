From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: Brewer's theorem also known as CAP theorem
Date: Tue, 15 Sep 2015 18:29:31 -0400 (EDT)
Message-ID: <635851231.17112993.1442356171047.JavaMail.zimbra@redhat.com>
References: <1CB94550540AE44E9CAAE8CD5AF40BF846CEB60D@H3CMLB12-EX.srv.huawei-3com.com> <1CB94550540AE44E9CAAE8CD5AF40BF846CEB6A5@H3CMLB12-EX.srv.huawei-3com.com> <CABAwU-YFhMbrvT7ao6c605aJXi2kLiC7wjr3eSAQvAqrNNzCmg@mail.gmail.com> <6F3FA899187F0043BA1827A69DA2F7CC0361EE09@shsmsx102.ccr.corp.intel.com> <1CB94550540AE44E9CAAE8CD5AF40BF846CEC8F1@H3CMLB12-EX.srv.huawei-3com.com> <CAJ4mKGY7p+vDmSaPa5=WjbMHT4XXNK8a9RT19R6ir=A7SvsmRQ@mail.gmail.com> <20150915143820.700c62d0@linux-520c.site> <CAJ4mKGYVALXKdbwoV79WGqFoKJHdR2zSUfDZYze4oZ_=PeVSdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:41731 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbbIOW3h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 18:29:37 -0400
In-Reply-To: <CAJ4mKGYVALXKdbwoV79WGqFoKJHdR2zSUfDZYze4oZ_=PeVSdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Owen Synge <osynge@suse.com>, zhao mingyue <zhao.mingyue@h3c.com>, Xiaoxi Chen <xiaoxi.chen@intel.com>, huang jun <hjwsm1989@gmail.com>, ceph-devel@vger.kernel.org

Since I'm trying to write an article about distributed system, this thr=
ead is really really good to me.

I'm quite sure that my thought is not always perfects thought.
#inline

When I played with Lustre(2.6.x), I saw many times data inconsistency e=
specially metadata, and GPFS(2.6.18) as well, which CoW was really good=
 but sometimes really bad -;
Both of them were running on Kernel 2.6.32-431, and connected to client=
s over FDR infiniband.

So my conclusion at the moment is below:
But in summary, at this moment, there is a bunch of things need to be c=
onsider.

----- Original Message -----
=46rom: "Gregory Farnum" <gfarnum@redhat.com>
To: "Owen Synge" <osynge@suse.com>
Cc: "zhao mingyue" <zhao.mingyue@h3c.com>, "Xiaoxi Chen" <xiaoxi.chen@i=
ntel.com>, "huang jun" <hjwsm1989@gmail.com>, ceph-devel@vger.kernel.or=
g
Sent: Wednesday, September 16, 2015 1:09:20 AM
Subject: Re: Brewer's theorem also known as CAP theorem

Congratulations, you've just hit on my biggest pet peeve in
distributed systems discussions. Sorry if this gets a little hot. :)

On Tue, Sep 15, 2015 at 5:38 AM, Owen Synge <osynge@suse.com> wrote:
>> On Mon, 14 Sep 2015 13:57:26 -0700
>> Gregory Farnum <gfarnum@redhat.com> wrote:
>>=20
>> The OSD is supposed to stay down if any of the networks are missing.
>> Ceph is a CP system in CAP parlance; there's no such thing as a CA
>> system. ;)
>>=20
>> I know I am being fussy, but within my team your email was sited tha=
t
>> you cannot consider ceph as a CA system. Hence I make my argument in
>> public so I can be humbled in public.
>>=20
>> Just to clarify your opinion I site
>>=20
>> http://www.infoq.com/articles/cap-twelve-years-later-how-the-rules-h=
ave-changed
>>
>> suggests:
>>
>> <quote>
>> The CAP theorem states that any networked shared-data system can hav=
e
>> at most two of three desirable properties.
>>
>> * consistency (C) equivalent to having a single up-to-date copy of
>>     the data;
>> * high availability (A) of that data (for updates)
>> * tolerance to network partitions (P).
>> </quote>
>>=20
>> So I dispute that a CA system cannot exist.

>Right, you can create a system that assumes no partitions and thus is
>always consistent and available in the absence of partitions. The
>problem is that partitions *do* exist and happen. The stereotypical
>example is that a simple hard power-off on one server is
>indistinguishable from a (very small) partition to the other nodes.
>Even leaving aside stuff like that, networks partition, or undergo
>partition-like events (huge packet loss over some link). When that
>happens, your system is going to...do something. If you don't want
>that something to be widespread data corruption, it will be designed
>to handle partitions.
>
>There are no real "CA" systems in the world.
>
>> I think you are too absolute even in interpretation of this vague
>> theory. A further quote from the author of said theorem from the sam=
e
>> article:
>>=20
>> <quote>
>> The "2 of 3" formulation was always misleading because it tended to
>> oversimplify the tensions among properties.
>> </quote>

> Right. This is the cause of a lot of problems for students of
> distributed systems. Another quote from that article:

>> CAP prohibits only a tiny part of the design space: perfect availabi=
lity and consistency in the presence of partitions, which are rare.

> Lots of users forget that the CAP theorem is very precise, and that
> precision is important. Some quick-and-dirty (but precise enough)
> definitions:
> Available: any request received by a well-behaved node of the system
> will receive a (correct!) response (within some bounded amount of
> time)

To make this realize as much as possible, we have to have one real mast=
er node which has true data and metadata
just directly coming clients.

> Consistent: All nodes in the system agree on the status of a
> particular piece of state. (Eg, that an object is at version 12345 an=
d
> not 12344.)

In side this node, every single device must be redundant.
This is to make distributed system keep simple.

> Partition-tolerant: the system continues to function correctly in the
> presence of message loss between some set of nodes.

It's almost impossible to provide 100% accuracy guarantee partition-tol=
erant.
Because there is always latency difference between:

 CPU and RAM
 RAM and HDD
  ...
 Network between each end point=20
 Protocol itself(TCP/IP)
  ...
 512 bytes limitation for async
  ...
 Etc, etc...

To make system simple as much as possible, and provide 99.999...% data =
consistency including metadata with distributed system, it's necessary =
to have one real master node is not necessary to serve all data permane=
ntly. But this node must have responsibility that all distributed nodes=
 have no inconsistency data.=20

But it's not necessary for us to use really really expensive hardware f=
or the master node.

> As I understand it:
>
> Ceph as a cluster always provides "Consistency". (or else you found a
> bug)
>
> If a ceph cluster is operating it will always provide acknowledgment
> (it may block) to the client if the operation has succeeded
> or failed hence provides "availability".

> This is the part you're missing: blocking a request is not allowed
> under the CAP theorem's definition of availability. If a PG might hav=
e
> been updated by a set of nodes which are now partitioned away, we
> can't respond to the client request (despite it being a valid,
> well-behaved request) and so the system is not big-A Available.
> Now, we are little-a available for *other* kinds of work. The cluster
> keeps going and will process requests for all the state which it know=
s
> it is authoritative for. But we do not satisfy the availability
> criteria of the CAP theorem. This is part of the wide design space
> which CAP does not demonstrate is impossible.

>> if a ceph cluster is partitioned, only one partition will continue
>> operation, hence you cannot consider the system "partition" tolerant
>> as multiple parts of the system cannot operate when partitioned.

> Nope, that's not what partition-tolerant means in the context of the
> CAP theorem. This shortcut =E2=80=94 in which we treat one side of th=
e
> partition as a misbehaving node =E2=80=94 is pretty common, but what =
you're
> citing here is actually associated with the "Available" side of the
> spectrum.

> The proof of the CAP theorem is relatively elegant and can be
> summarized as: if a node disappears/is partitioned, you must either
> ignore any updates it handled (sacrificing consistency) or refuse to
> answer until the node reappears (sacrificing availability). No
> combination of clever data replication or distribution can eliminate
> the choice a system has to make when it goes to look at data and
> discovers the data isn't there.

> Now, that discussion of Ceph's classification under the CAP theorem
> obviously leaves out lots of stuff: Ceph is small-a available in that
> it takes a lot more than one disk failure to render data inaccessible=
!
> Much has been made of this design space, with many vendors and
> developers pretending that this means they've somehow beaten CAP. But
> when faced with requests for data that are not currently accessible,
> Ceph chooses to block and remain Consistent over making up a value an=
d
> remaining Available; every distributed system must make that choice
> one way or another. Most CP systems endeavor to remain available for
> as long as possible; AP systems expend varying amounts of effort to b=
e
> consistent up until they're faced with either blocking or making up a
> value.
>-Greg
>--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
