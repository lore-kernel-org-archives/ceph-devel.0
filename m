From: Andrei Mikhailovsky <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>
Subject: Re: Preliminary RDMA vs TCP numbers
Date: Wed, 8 Apr 2015 10:22:05 +0100 (BST)
Message-ID: <6442513.754.1428484840531.JavaMail.andrei@tuchka>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75D78@SACMBXIP01.sdcorp.global.sandisk.com>
	<CABYiri_ihguSripu=gs-MA7Qr8GRDk7H5hw5BNKf-9OSFu1z8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0495740272=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABYiri_ihguSripu=gs-MA7Qr8GRDk7H5hw5BNKf-9OSFu1z8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Andrey Korolyov <andrey-5vqebrSIFTo@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0495740272==
Content-Type: multipart/alternative;
	boundary="----=_Part_753_14911911.1428484840530"

------=_Part_753_14911911.1428484840530
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

Am I the only person noticing disappointing results from the preliminary RDMA testing, or am I reading the numbers wrong? 

Yes, it's true that on a very small cluster you do see a great improvement in rdma, but in real life rdma is used in large infrastructure projects, not on a few servers with a handful of osds. In fact, from what i've seen from the slides, the rdma implementation scales horribly to the point that it becomes slower the more osds you through at it. 

From my limited knowledge, i have expected a much higher performance gains with rdma, taking into account that you should have much lower latency and overhead and lower cpu utilisation when using this transport in comparison with tcp. 

Are we likely to see a great deal of improvement with ceph and rdma in a near future? Is there a roadmap for having a stable and reliable rdma protocol support? 

Thanks 

Andrei 
----- Original Message -----

> From: "Andrey Korolyov" <andrey-5vqebrSIFTo@public.gmane.org>
> To: "Somnath Roy" <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, "ceph-devel"
> <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Sent: Wednesday, 8 April, 2015 9:28:12 AM
> Subject: Re: [ceph-users] Preliminary RDMA vs TCP numbers

> On Wed, Apr 8, 2015 at 11:17 AM, Somnath Roy
> <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > Hi,
> > Please find the preliminary performance numbers of TCP Vs RDMA
> > (XIO) implementation (on top of SSDs) in the following link.
> >
> > http://www.slideshare.net/somnathroy7568/ceph-on-rdma
> >
> > The attachment didn't go through it seems, so, I had to use
> > slideshare.
> >
> > Mark,
> > If we have time, I can present it in tomorrow's performance
> > meeting.
> >
> > Thanks & Regards
> > Somnath
> >

> Those numbers are really impressive (for small numbers at least)!
> What
> are TCP settings you using?For example, difference can be lowered on
> scale due to less intensive per-connection acceleration on CUBIC on a
> larger number of nodes, though I do not believe that it was a main
> reason for an observed TCP catchup on a relatively flat workload such
> as fio generates.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

------=_Part_753_14911911.1428484840530
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: arial,helvetica,sans-serif; font-size: 10pt; colo=
r: #000000'>Hi,<br><br>Am I the only person noticing disappointing results =
from the preliminary RDMA testing, or am I reading the numbers wrong? <br><=
br>Yes, it's true that on a very small cluster you do see a great improveme=
nt in rdma, but in real life rdma is used in large infrastructure projects,=
 not on a few servers with a handful of osds. In fact, from what i've seen =
from the slides, the rdma implementation scales horribly to the point that =
it becomes slower the more osds you through at it.<br><br>From my limited k=
nowledge, i have expected a much higher performance gains with rdma, taking=
 into account that you should have much lower latency and overhead and lowe=
r cpu utilisation when using this transport in comparison with tcp.<br><br>=
Are we likely to see a great deal of improvement with ceph and rdma in a ne=
ar future? Is there a roadmap for having a stable and reliable rdma protoco=
l support?<br><br>Thanks<br><br>Andrei<br><hr id=3D"zwchr"><blockquote styl=
e=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-lef=
t: 5px; color: rgb(0, 0, 0); font-weight: normal; font-style: normal; text-=
decoration: none; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;=
"><b>From: </b>"Andrey Korolyov" &lt;andrey-5vqebrSIFTo@public.gmane.org&gt;<br><b>To: </b>"Somn=
ath Roy" &lt;Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org&gt;<br><b>Cc: </b>ceph-users-idqoXFIVOFJ4Eiagz67IpQ@public.gmane.org=
h.com, "ceph-devel" &lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br><b>Sent: </b>Wedn=
esday, 8 April, 2015 9:28:12 AM<br><b>Subject: </b>Re: [ceph-users] Prelimi=
nary RDMA vs TCP numbers<br><br>On Wed, Apr 8, 2015 at 11:17 AM, Somnath Ro=
y &lt;Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org&gt; wrote:<br>&gt;<br>&gt; Hi,<br>&gt; Please=
 find the preliminary performance numbers of TCP Vs RDMA (XIO) implementati=
on (on top of SSDs) in the following link.<br>&gt;<br>&gt; http://www.slide=
share.net/somnathroy7568/ceph-on-rdma<br>&gt;<br>&gt; The attachment didn't=
 go through it seems, so, I had to use slideshare.<br>&gt;<br>&gt; Mark,<br=
>&gt; If we have time, I can present it in tomorrow's performance meeting.<=
br>&gt;<br>&gt; Thanks &amp; Regards<br>&gt; Somnath<br>&gt;<br><br>Those n=
umbers are really impressive (for small numbers at least)! What<br>are TCP =
settings you using?For example, difference can be lowered on<br>scale due t=
o less intensive per-connection acceleration on CUBIC on a<br>larger number=
 of nodes, though I do not believe that it was a main<br>reason for an obse=
rved TCP catchup on a relatively flat workload such<br>as fio generates.<br=
>_______________________________________________<br>ceph-users mailing list=
<br>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>http://lists.ceph.com/listinfo.cgi/ceph-us=
ers-ceph.com<br></blockquote><br></div></body></html>
------=_Part_753_14911911.1428484840530--

--===============0495740272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0495740272==--
