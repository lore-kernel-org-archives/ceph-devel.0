From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Tue, 19 Feb 2019 12:26:41 -0500
Message-ID: <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8817465392738494558=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============8817465392738494558==
Content-Type: multipart/alternative; boundary="000000000000fe65f70582428b35"

--000000000000fe65f70582428b35
Content-Type: text/plain; charset="UTF-8"

With a RACK failure domain, you should be able to have an entire rack
powered down without noticing any major impact on the clients.  I regularly
take down OSDs and nodes for maintenance and upgrades without seeing any
problems with client IO.

On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hello - I have a couple of questions on ceph cluster stability, even
> we follow all recommendations as below:
> - Having separate replication n/w and data n/w
> - RACK is the failure domain
> - Using SSDs for journals (1:4ratio)
>
> Q1 - If one OSD down, cluster IO down drastically and customer Apps
> impacted.
> Q2 - what is stability ratio, like with above, is ceph cluster
> workable condition, if one osd down or one node down,etc.
>
> Thanks
> Swami
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000fe65f70582428b35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">With a RACK failure domain, you should be able to have an =
entire rack powered down without noticing any major impact on the clients.=
=C2=A0 I regularly take down OSDs and nodes for maintenance and upgrades wi=
thout seeing any problems with client IO.</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 5:01 AM M =
Ranga Swami Reddy &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">swamireddy@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hello - I have a couple of questions on ceph cluster stability, even=
<br>
we follow all recommendations as below:<br>
- Having separate replication n/w and data n/w<br>
- RACK is the failure domain<br>
- Using SSDs for journals (1:4ratio)<br>
<br>
Q1 - If one OSD down, cluster IO down drastically and customer Apps impacte=
d.<br>
Q2 - what is stability ratio, like with above, is ceph cluster<br>
workable condition, if one osd down or one node down,etc.<br>
<br>
Thanks<br>
Swami<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--000000000000fe65f70582428b35--

--===============8817465392738494558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8817465392738494558==--
