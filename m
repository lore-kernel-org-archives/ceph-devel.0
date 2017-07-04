From: Z Will <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-mon leader election problem,
 should it be improved ?
Date: Tue, 4 Jul 2017 14:58:40 +0800
Message-ID: <CAGOEmcNH1KC-EomfOH_zmpo2OKG7THN6e5YwB7yEPsRMcmOhhA@mail.gmail.com>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
	<CA+eLJkaijRyLQf-O+3TYNC=7ztFTBokBw+bFY4X3WBnSAZZybg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+eLJkaijRyLQf-O+3TYNC=7ztFTBokBw+bFY4X3WBnSAZZybg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alvaro Soto <alsotoes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Users, Ceph" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Alvaro:
    From the code , I see unsigned need = monmap->size() / 2 + 1; So
for 2 mons , the quorum must be 2 so that it can start election.
That's  why I use 3 mons. I know if I stop mon.0 or mon.1 , everything
will work fine. And if this failure happens,  it must be handled by
human ?  Is there any way to handle it automaticly from design as you
know ?



On Tue, Jul 4, 2017 at 2:25 PM, Alvaro Soto <alsotoes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Z,
> You are forcing a byzantine failure, the paxos implemented to form the
> consensus ring of the mon daemons does not support this kind of failures,
> that is why you get and erratic behaviour, I believe is the common paxos
> algorithm implemented in mon daemon code.
>
> If you just gracefully shutdown a mon daemon everything will work fine, but
> with this you can not prove a split brain situation, because you will force
> the election of the leader by quorum.
>
> Maybe with 2 mon daemons and closing the communication between each of them
> every mon daemon will believe that can be a leader because every daemon will
> have the que quorum of 1 with no other vote.
>
> Just saying :)
>
>
> On Jul 4, 2017 12:57 AM, "Z Will" <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> Hi:
>>    I am testing ceph-mon brain split . I have read the code . If I
>> understand it right , I know it won't be brain split. But I think
>> there is still another problem. My ceph version is 0.94.10. And here
>> is my test detail :
>>
>> 3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
>> mon , and use iptables to block the communication between mon 0 and
>> mon 1. When the cluster is stable, start mon.1 .  I found the 3
>> monitors will all can not work well. They are all trying to call  new
>> leader  election . This means the cluster can't work anymore.
>>
>> Here is my analysis. Because mon will always respond to leader
>> election message, so , in my test, communication between  mon.0 and
>> mon.1 is blocked , so mon.1 will always try to be leader, because it
>> will always see mon.2, and it should win over mon.2. Mon.0 should
>> always win over mon.2. But mon.2 will always responsd to the election
>> message issued by mon.1, so this loop will never end. Am I right ?
>>
>> This should be a problem? Or is it  was just designed like this , and
>> should be handled by human ?
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
