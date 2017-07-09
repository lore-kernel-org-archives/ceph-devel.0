From: Z Will <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-mon leader election problem,
	should it be improved ?
Date: Sun, 9 Jul 2017 11:58:33 +0800
Message-ID: <CAGOEmcPEbqPABgK9Af1dqMF5Ms8qo+-p-TtDMRjboXhAZ6T=6g@mail.gmail.com>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
	<cfb3c139-7423-644f-ce4c-00d55cce5756@suse.de>
	<CAGOEmcNwuHGoXyAPr51P73pbZL5XOiORhL4P6w7R2yi19e71vA@mail.gmail.com>
	<52301842-ce14-1a1d-72cb-816633f2b860@suse.de>
	<CAGOEmcNvNr523e7YH66-4Gv45krA1-53r-My=RvSRpCCj=otrg@mail.gmail.com>
	<alpine.DEB.2.11.1707061429420.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1707061429420.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sage:
    After these days consideration, and reading some  related  papers
, I think we can just make a very little change to solve the problems
above and make monitors to tolerate most of the network partition .
The most of logic are still same as before except one :

    - send a probe to each  monitor in monmap
    - receive acks, and remember it , if got > 1/2 , or get a quorum
    - if get a quorum, it will try to reach current leader to  join
current quorum , not try to call a new election. If timeout to joining
, it should stand by and try later, and it will  sync states from
other mons when needed for increasing performance.
      other logic  is  same as before

     What do you think of it ?

On Thu, Jul 6, 2017 at 10:31 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Thu, 6 Jul 2017, Z Will wrote:
>> Hi Joao :
>>
>>  Thanks for thorough analysis . My initial concern is that , I think
>> in some cases ,  network failure will make low rank monitor see little
>> siblings (not enough to form a quorum ) , but some high rank mointor
>> can see more siblings, so I want to try to choose  the one who can see
>> the most to be leader, to tolerate the netwok error to the biggiest
>> extent , not just to solve the corner case.   Yes , you are right.
>> This kind of complex network failure is rare to occure. Trying to find
>> out  who can contact the highest number of monitors can only cover
>> some of the situation , and will  introduce some other complexities
>> and slow effcient. This is not good. Blacklisting a problematic
>> monitor is simple and good idea.  The implementation in monitor now is
>> like this, no matter which one  with high rank num lost connection
>> with the leader, this lost monitor  will constantly try to call leader
>> election, affect its siblings, and then affect the whole cluster.
>> Because the leader election procedure is fast, it will be OK for a
>> short time , but soon leader election start again, the cluster will
>> become unstable. I think the probability of this kind of network error
>> is high, YES ?  So based on your idea,  make a little change :
>>
>>  - send a probe to all monitors
>>  - receive acks
>>  - After receiving acks, it will konw the current quorum and how much
>> monitors it can reach to .
>>        If it can reach to current leader, then it will try to join
>> current quorum
>>        If it can not reach to current leader, then it will decide
>> whether to stand by for a while and try later or start a leader
>> election  based on the information got from probing phase.
>>
>> Do you think this will be OK ?
>
> I'm worried that even if we can form an initial quorum, we are currently
> very casual about the "call new election" logic.  If a mon is not part of
> the quorum it will currently trigger a new election... and with this
> change it will then not be included in it because it can't reach all mons.
> The logic there will also have to change so that it confirms that it can
> reach a majority of mon peers before requesting a new election.
>
> sage
>
>
>>
>>
>> On Wed, Jul 5, 2017 at 6:26 PM, Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org> wrote:
>> > On 07/05/2017 08:01 AM, Z Will wrote:
>> >>
>> >> Hi Joao:
>> >>     I think this is all because we choose the monitor with the
>> >> smallest rank number to be leader. For this kind of network error, no
>> >> matter which mon has lost connection with the  mon who has the
>> >> smallest rank num , will be constantly calling an election, that say
>> >> ,will constantly affact the cluster until it is stopped by human . So
>> >> do you think it make sense if I try to figure out a way to choose the
>> >> monitor who can see the most monitors ,  or with  the smallest rank
>> >> num if the view num is same , to be leader ?
>> >>     In probing phase:
>> >>        they will know there own view, so can set a view num.
>> >>     In election phase:
>> >>        they send the view num , rank num .
>> >>        when receiving the election message, it compare the view num (
>> >> higher is leader ) and rank num ( lower is leader).
>> >
>> >
>> > As I understand it, our elector trades-off reliability in case of network
>> > failure for expediency in forming a quorum. This by itself is not a problem
>> > since we don't see many real-world cases where this behaviour happens, and
>> > we are a lot more interested in making sure we have a quorum - given without
>> > a quorum your cluster is effectively unusable.
>> >
>> > Currently, we form a quorum with a minimal number of messages passed.
>> > From my poor recollection, I think the Elector works something like
>> >
>> > - 1 probe message to each monitor in the monmap
>> > - receives defer from a monitor, or defers to a monitor
>> > - declares victory if number of defers is an absolute majority (including
>> > one's defer).
>> >
>> > An election cycle takes about 4-5 messages to complete, with roughly two
>> > round-trips (in the best case scenario).
>> >
>> > Figuring out which monitor is able to contact the highest number of
>> > monitors, and having said monitor being elected the leader, will necessarily
>> > increase the number of messages transferred.
>> >
>> > A rough idea would be
>> >
>> > - all monitors will send probes to all other monitors in the monmap;
>> > - all monitors need to ack the other's probes;
>> > - each monitor will count the number of monitors it can reach, and then send
>> > a message proposing itself as the leader to the other monitors, with the
>> > list of monitors they see;
>> > - each monitor will propose itself as the leader, or defer to some other
>> > monitor.
>> >
>> > This is closer to 3 round-trips.
>> >
>> > Additionally, we'd have to account for the fact that some monitors may be
>> > able to reach all other monitors, while some may only be able to reach a
>> > portion. How do we handle this scenario?
>> >
>> > - What do we do with monitors that do not reach all other monitors?
>> > - Do we ignore them for electoral purposes?
>> > - Are they part of the final quorum?
>> > - What if we need those monitors to form a quorum?
>> >
>> > Personally, I think the easiest solution to this problem would be
>> > blacklisting a problematic monitor (for a given amount a time, or until a
>> > new election is needed due to loss of quorum, or by human intervention).
>> >
>> > For example, if a monitor believes it should be the leader, and if all other
>> > monitors are deferring to someone else that is not reachable, the monitor
>> > could then enter a special case branch:
>> >
>> > - send a probe to all monitors
>> > - receive acks
>> > - share that with other monitors
>> > - if that list is missing monitors, then blacklist the monitor for a period,
>> > and send a message to that monitor with that decision
>> > - the monitor would blacklist itself and retry in a given amount of time.
>> >
>> > Basically, this would be something similar to heartbeats. If a monitor can't
>> > reach all monitors in an existing quorum, then just don't do anything.
>> >
>> > In any case, you are more than welcome to propose a solution. Let us know
>> > what you come up with and if you want to discuss this a bit more ;)
>> >
>> >   -Joao
>> >
>> >>
>> >> On Tue, Jul 4, 2017 at 9:25 PM, Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org> wrote:
>> >>>
>> >>> On 07/04/2017 06:57 AM, Z Will wrote:
>> >>>>
>> >>>>
>> >>>> Hi:
>> >>>>    I am testing ceph-mon brain split . I have read the code . If I
>> >>>> understand it right , I know it won't be brain split. But I think
>> >>>> there is still another problem. My ceph version is 0.94.10. And here
>> >>>> is my test detail :
>> >>>>
>> >>>> 3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
>> >>>> mon , and use iptables to block the communication between mon 0 and
>> >>>> mon 1. When the cluster is stable, start mon.1 .  I found the 3
>> >>>> monitors will all can not work well. They are all trying to call  new
>> >>>> leader  election . This means the cluster can't work anymore.
>> >>>>
>> >>>> Here is my analysis. Because mon will always respond to leader
>> >>>> election message, so , in my test, communication between  mon.0 and
>> >>>> mon.1 is blocked , so mon.1 will always try to be leader, because it
>> >>>> will always see mon.2, and it should win over mon.2. Mon.0 should
>> >>>> always win over mon.2. But mon.2 will always responsd to the election
>> >>>> message issued by mon.1, so this loop will never end. Am I right ?
>> >>>>
>> >>>> This should be a problem? Or is it  was just designed like this , and
>> >>>> should be handled by human ?
>> >>>
>> >>>
>> >>>
>> >>> This is a known behaviour, quite annoying, but easily identifiable by
>> >>> having
>> >>> the same monitor constantly calling an election and usually timing out
>> >>> because the peon did not defer to it.
>> >>>
>> >>> In a way, the elector algorithm does what it is intended to. Solving this
>> >>> corner case would be nice, but I don't think there's a good way to solve
>> >>> it.
>> >>> We may be able to presume a monitor is in trouble during the probe phase,
>> >>> to
>> >>> disqualify a given monitor from the election, but in the end this is a
>> >>> network issue that may be transient or unpredictable and there's only so
>> >>> much we can account for.
>> >>>
>> >>> Dealing with it automatically would be nice, but I think, thus far, the
>> >>> easiest way to address this particular issue is human intervention.
>> >>>
>> >>>   -Joao
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >
>>
>>
