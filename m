From: Alvaro Soto <alsotoes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-mon leader election problem,
 should it be improved ?
Date: Tue, 4 Jul 2017 01:25:40 -0500
Message-ID: <CA+eLJkaijRyLQf-O+3TYNC=7ztFTBokBw+bFY4X3WBnSAZZybg@mail.gmail.com>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1345614303=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Z Will <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Users, Ceph" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1345614303==
Content-Type: multipart/alternative; boundary="001a113cfc1edd6c01055377f3c6"

--001a113cfc1edd6c01055377f3c6
Content-Type: text/plain; charset="UTF-8"

Z,
You are forcing a byzantine failure, the paxos implemented to form the
consensus ring of the mon daemons does not support this kind of failures,
that is why you get and erratic behaviour, I believe is the common paxos
algorithm implemented in mon daemon code.

If you just gracefully shutdown a mon daemon everything will work fine, but
with this you can not prove a split brain situation, because you will force
the election of the leader by quorum.

Maybe with 2 mon daemons and closing the communication between each of them
every mon daemon will believe that can be a leader because every daemon
will have the que quorum of 1 with no other vote.

Just saying :)


On Jul 4, 2017 12:57 AM, "Z Will" <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi:
>    I am testing ceph-mon brain split . I have read the code . If I
> understand it right , I know it won't be brain split. But I think
> there is still another problem. My ceph version is 0.94.10. And here
> is my test detail :
>
> 3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
> mon , and use iptables to block the communication between mon 0 and
> mon 1. When the cluster is stable, start mon.1 .  I found the 3
> monitors will all can not work well. They are all trying to call  new
> leader  election . This means the cluster can't work anymore.
>
> Here is my analysis. Because mon will always respond to leader
> election message, so , in my test, communication between  mon.0 and
> mon.1 is blocked , so mon.1 will always try to be leader, because it
> will always see mon.2, and it should win over mon.2. Mon.0 should
> always win over mon.2. But mon.2 will always responsd to the election
> message issued by mon.1, so this loop will never end. Am I right ?
>
> This should be a problem? Or is it  was just designed like this , and
> should be handled by human ?
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113cfc1edd6c01055377f3c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Z,=C2=A0<div dir=3D"auto">You are forcing a byzantin=
e failure, the paxos implemented to form the consensus ring of the mon daem=
ons does not support this kind of failures, that is why you get and erratic=
 behaviour, I believe is the common paxos algorithm implemented in mon daem=
on code.=C2=A0<div dir=3D"auto"><br></div><div dir=3D"auto">If you just gra=
cefully shutdown a mon daemon everything will work fine, but with this you =
can not prove a split brain situation, because you will force the election =
of the leader by quorum.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Maybe with 2 mon daemons and closing the communication between each =
of them every mon daemon will believe that can be a leader because every da=
emon will have the que quorum of 1 with no other vote.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Just saying :)=C2=A0</div></div><br><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Jul 4, 2017 12:=
57 AM, &quot;Z Will&quot; &lt;<a href=3D"mailto:zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Hi:<br>
=C2=A0 =C2=A0I am testing ceph-mon brain split . I have read the code . If =
I<br>
understand it right , I know it won&#39;t be brain split. But I think<br>
there is still another problem. My ceph version is 0.94.10. And here<br>
is my test detail :<br>
<br>
3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1<br>
mon , and use iptables to block the communication between mon 0 and<br>
mon 1. When the cluster is stable, start mon.1 .=C2=A0 I found the 3<br>
monitors will all can not work well. They are all trying to call=C2=A0 new<=
br>
leader=C2=A0 election . This means the cluster can&#39;t work anymore.<br>
<br>
Here is my analysis. Because mon will always respond to leader<br>
election message, so , in my test, communication between=C2=A0 mon.0 and<br=
>
mon.1 is blocked , so mon.1 will always try to be leader, because it<br>
will always see mon.2, and it should win over mon.2. Mon.0 should<br>
always win over mon.2. But mon.2 will always responsd to the election<br>
message issued by mon.1, so this loop will never end. Am I right ?<br>
<br>
This should be a problem? Or is it=C2=A0 was just designed like this , and<=
br>
should be handled by human ?<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div></div>
</div></div>

--001a113cfc1edd6c01055377f3c6--

--===============1345614303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1345614303==--
