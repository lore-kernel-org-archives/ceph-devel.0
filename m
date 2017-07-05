From: Z Will <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-mon leader election problem,
	should it be improved ?
Date: Wed, 5 Jul 2017 15:01:28 +0800
Message-ID: <CAGOEmcNwuHGoXyAPr51P73pbZL5XOiORhL4P6w7R2yi19e71vA@mail.gmail.com>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
	<cfb3c139-7423-644f-ce4c-00d55cce5756@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <cfb3c139-7423-644f-ce4c-00d55cce5756-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Joao:
    I think this is all because we choose the monitor with the
smallest rank number to be leader. For this kind of network error, no
matter which mon has lost connection with the  mon who has the
smallest rank num , will be constantly calling an election, that say
,will constantly affact the cluster until it is stopped by human . So
do you think it make sense if I try to figure out a way to choose the
monitor who can see the most monitors ,  or with  the smallest rank
num if the view num is same , to be leader ?
    In probing phase:
       they will know there own view, so can set a view num.
    In election phase:
       they send the view num , rank num .
       when receiving the election message, it compare the view num (
higher is leader ) and rank num ( lower is leader).

On Tue, Jul 4, 2017 at 9:25 PM, Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org> wrote:
> On 07/04/2017 06:57 AM, Z Will wrote:
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
>
>
> This is a known behaviour, quite annoying, but easily identifiable by having
> the same monitor constantly calling an election and usually timing out
> because the peon did not defer to it.
>
> In a way, the elector algorithm does what it is intended to. Solving this
> corner case would be nice, but I don't think there's a good way to solve it.
> We may be able to presume a monitor is in trouble during the probe phase, to
> disqualify a given monitor from the election, but in the end this is a
> network issue that may be transient or unpredictable and there's only so
> much we can account for.
>
> Dealing with it automatically would be nice, but I think, thus far, the
> easiest way to address this particular issue is human intervention.
>
>   -Joao
