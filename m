From: Abhay Sachan <abhaysac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-create-keys hung
Date: Tue, 8 Oct 2013 10:10:50 +0530
Message-ID: <CAK72ynaai=RAPvWoyc7p9Qrh1dFkuxUiEL3rzDRv66zoVySA_g@mail.gmail.com>
References: <CAK72ynaw9YqN8AUae2N1ZdkCaMhCEbQ8tKn_tYB=RUk6e7RFdA@mail.gmail.com>
	<524D86C3.3010307@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1710711273=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <524D86C3.3010307-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1710711273==
Content-Type: multipart/alternative; boundary=089e0158c410bb62d704e83360a0

--089e0158c410bb62d704e83360a0
Content-Type: text/plain; charset=UTF-8

Hi Joao,
Thanks for replying. All of my monitors are up and running and connected to
each other. "ceph -s" is failing on the cluster with following error:

2013-10-07 10:12:25.099261 7fd1b948d700 -1 monclient(hunting): ERROR:
missing keyring, cannot use cephx for authentication
2013-10-07 10:12:25.099271 7fd1b948d700  0 librados: client.admin
initialization error (2) No such file or directory
Error connecting to cluster: ObjectNotFound

And the logs on each monitor has lots of entries like this:
NODE 1:

2013-10-07 03:58:51.153847 7ff2864c6700  0 mon.jul@0(probing).data_health(0)
update_stats avail 76% total 42332700 used 7901820 avail 32280480
2013-10-07 03:59:51.154051 7ff2864c6700  0 mon.jul@0(probing).data_health(0)
update_stats avail 76% total 42332700 used 7901832 avail 32280468
2013-10-07 04:00:51.154256 7ff2864c6700  0 mon.jul@0(probing).data_health(0)
update_stats avail 76% total 42332700 used 7901828 avail 32280472

NODE 2:
2013-10-07 10:12:10.345491 7fa6145b0700  0 mon.dec@0(probing).data_health(0)
update_stats avail 75% total 42332700 used 8199004 avail 31983296
2013-10-07 10:13:10.345677 7fa6145b0700  0 mon.dec@0(probing).data_health(0)
update_stats avail 75% total 42332700 used 8199004 avail 31983296
2013-10-07 10:14:10.345921 7fa6145b0700  0 mon.dec@0(probing).data_health(0)
update_stats avail 75% total 42332700 used 8199024 avail 31983276

NODE 3:

2013-10-07 10:13:00.880250 7fcd6459e700  0 mon.julilo@0(probing).data_health(0)
update_stats avail 35% total 42332700 used 25105920 avail
150763802013-10-07 10:14:00.880470 7fcd6459e700  0
mon.julilo@0(probing).data_health(0)
update_stats avail 35% total 42332700 used 25105924 avail 15076376
2013-10-07 10:15:00.880668 7fcd6459e700  0 mon.julilo@0(probing).data_health(0)
update_stats avail 35% total 42332700 used 25105924 avail 15076376

If you need some other logs, then please tell me how to enable/fetch them.
I will upload them someplace.


Regards,
Abhay

On Thu, Oct 3, 2013 at 8:31 PM, Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>wrote:

> On 10/03/2013 02:44 PM, Abhay Sachan wrote:
>
>> Hi All,
>> I have tried setting up a ceph cluster with 3 nodes (3 monitors). I am
>> using RHEL 6.4 as OS with dumpling(0.67.3) release. Ceph cluster
>> creation (using ceph-deploy as well as mkcephfs), ceph-creates-keys
>> doesn't return on any of the servers. Whereas, if I create a cluster
>> with only 1 node (1 monitor), key creation goes through. Has anybody
>> seen this problem or any ideas what I might be missing??
>>
>> Regards,
>> Abhay
>>
>
> Those symptoms tell me that your monitors are not forming quorum.
> 'ceph-create-keys' needs the monitors to first establish a quorum,
> otherwise it will hang waiting for that to happen.
>
> Please make sure all your monitors are running.  If so, try running 'ceph
> -s' on your cluster.  If that hangs as well, try accessing each monitor's
> admin socket to check what's happening [1].  If that too fails, try looking
> into the logs for something obviously wrong.  If you are not able to
> discern anything useful at that point, upload the logs to some place and
> point us to them -- we'll then be happy to take a look.
>
> Hope this helps.
>
>   -Joao
>
> --
> Joao Eduardo Luis
> Software Engineer | http://inktank.com | http://ceph.com
>

--089e0158c410bb62d704e83360a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Joao,<br></div>Thanks for replying. All of my moni=
tors are up and running and connected to each other. &quot;ceph -s&quot; is=
 failing on the cluster with following error:<br><br>2013-10-07 10:12:25.09=
9261 7fd1b948d700 -1 monclient(hunting): ERROR: missing keyring, cannot use=
 cephx for authentication<br>

2013-10-07 10:12:25.099271 7fd1b948d700=C2=A0 0 librados: client.admin init=
ialization error (2) No such file or directory<br>Error connecting to clust=
er: ObjectNotFound<br><br><div class=3D"gmail_extra">And the logs on each m=
onitor has lots of entries like this:<br>

NODE 1:<br><br>2013-10-07 03:58:51.153847 7ff2864c6700=C2=A0 0 mon.jul@0(pr=
obing).data_health(0) update_stats avail 76% total 42332700 used 7901820 av=
ail 32280480<br>2013-10-07 03:59:51.154051 7ff2864c6700=C2=A0 0 mon.jul@0(p=
robing).data_health(0) update_stats avail 76% total 42332700 used 7901832 a=
vail 32280468<br>

2013-10-07 04:00:51.154256 7ff2864c6700=C2=A0 0 mon.jul@0(probing).data_hea=
lth(0) update_stats avail 76% total 42332700 used 7901828 avail 32280472<br=
><br></div><div class=3D"gmail_extra">NODE 2:<br>2013-10-07 10:12:10.345491=
 7fa6145b0700=C2=A0 0 mon.dec@0(probing).data_health(0) update_stats avail =
75% total 42332700 used 8199004 avail 31983296<br>

2013-10-07 10:13:10.345677 7fa6145b0700=C2=A0 0 mon.dec@0(probing).data_hea=
lth(0) update_stats avail 75% total 42332700 used 8199004 avail 31983296<br=
>2013-10-07 10:14:10.345921 7fa6145b0700=C2=A0 0 mon.dec@0(probing).data_he=
alth(0) update_stats avail 75% total 42332700 used 8199024 avail 31983276<b=
r>

<br></div><div class=3D"gmail_extra">NODE 3:<br><br>2013-10-07 10:13:00.880=
250 7fcd6459e700=C2=A0 0 mon.julilo@0(probing).data_health(0) update_stats =
avail 35% total 42332700 used 25105920 avail 150763802013-10-07 10:14:00.88=
0470 7fcd6459e700=C2=A0 0 mon.julilo@0(probing).data_health(0) update_stats=
 avail 35% total 42332700 used 25105924 avail 15076376<br>

2013-10-07 10:15:00.880668 7fcd6459e700=C2=A0 0 mon.julilo@0(probing).data_=
health(0) update_stats avail 35% total 42332700 used 25105924 avail 1507637=
6<br><br></div><div class=3D"gmail_extra">If you need some other logs, then=
 please tell me how to enable/fetch them. I will upload them someplace.<br>

<br><br></div><div class=3D"gmail_extra">Regards,<br></div><div class=3D"gm=
ail_extra">Abhay<br></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Thu, Oct 3, 2013 at 8:31 PM, Joao Eduardo Luis <span dir=3D"ltr=
">&lt;<a href=3D"mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">joao.luis@=
inktank.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D""><div clas=
s=3D"h5">On 10/03/2013 02:44 PM, Abhay Sachan wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Hi All,<br>
I have tried setting up a ceph cluster with 3 nodes (3 monitors). I am<br>
using RHEL 6.4 as OS with dumpling(0.67.3) release. Ceph cluster<br>
creation (using ceph-deploy as well as mkcephfs), ceph-creates-keys<br>
doesn&#39;t return on any of the servers. Whereas, if I create a cluster<br=
>
with only 1 node (1 monitor), key creation goes through. Has anybody<br>
seen this problem or any ideas what I might be missing??<br>
<br>
Regards,<br>
Abhay<br>
</blockquote>
<br></div></div>
Those symptoms tell me that your monitors are not forming quorum. &#39;ceph=
-create-keys&#39; needs the monitors to first establish a quorum, otherwise=
 it will hang waiting for that to happen.<br>
<br>
Please make sure all your monitors are running. =C2=A0If so, try running &#=
39;ceph -s&#39; on your cluster. =C2=A0If that hangs as well, try accessing=
 each monitor&#39;s admin socket to check what&#39;s happening [1]. =C2=A0I=
f that too fails, try looking into the logs for something obviously wrong. =
=C2=A0If you are not able to discern anything useful at that point, upload =
the logs to some place and point us to them -- we&#39;ll then be happy to t=
ake a look.<br>


<br>
Hope this helps.<span class=3D""><font color=3D"#888888"><br>
<br>
=C2=A0 -Joao<br>
<br>
-- <br>
Joao Eduardo Luis<br>
Software Engineer | <a href=3D"http://inktank.com" target=3D"_blank">http:/=
/inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">http://cep=
h.com</a><br>
</font></span></blockquote></div><br></div></div>

--089e0158c410bb62d704e83360a0--

--===============1710711273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1710711273==--
