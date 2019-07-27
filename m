From: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Sat, 27 Jul 2019 18:08:58 +0530
Message-ID: <CAEbG6hE1s=wJ7hGAPSiFee7iLu7QPrC-s4zDf1kZa3xMsVscdw@mail.gmail.com>
References: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
 <20190726093147.GA31242@gmail.com>
 <CAEbG6hFgvWFMgaYHRRtZdth-OkJ7ib4vWxf__b7QvGPd1rF6Qg@mail.gmail.com>
 <20190726132546.GA6825@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4887155585420644587=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20190726132546.GA6825-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============4887155585420644587==
Content-Type: multipart/alternative; boundary="00000000000054a15a058ea8f2bd"

--00000000000054a15a058ea8f2bd
Content-Type: text/plain; charset="UTF-8"

Thanks for the clarification


*1) Will there be any folder related to rbd-mirroring in /var/lib/ceph ? *


*2) Is ceph rbd-mirror authentication mandatory?*


*3)when even i create any cinder volume loaded with glance image i get the
following error.. *

2019-07-27 17:26:46.762571 7f93eb0a5780 20 librbd::api::Mirror: peer_list:
2019-07-27 17:27:07.541701 7f939d7fa700  0 rbd::mirror::ImageReplayer:
0x7f93c800e9e0 [19/b6656be7-6006-4246-ba93-a49a220e33ce] handle_shut_down:
remote image no longer exists: scheduling deletion
2019-07-27 17:27:16.766199 7f93eb0a5780 20 librbd::api::Mirror: peer_list:
2019-07-27 17:27:22.568970 7f939d7fa700  0 rbd::mirror::ImageReplayer:
0x7f93c800e9e0 [19/b6656be7-6006-4246-ba93-a49a220e33ce] handle_shut_down:
mirror image no longer exists
2019-07-27 17:27:46.769158 7f93eb0a5780 20 librbd::api::Mirror: peer_list:
2019


*4) Finally,*


*Attimes i can able to create bootable cinder volume apart from the above
errors, *


*but certain times i face the following*


example, For a 50 gb volume, Local image get created, but it couldnt create
a mirror image

Logs of the image status showed as replaying but pls see the rbd-mirror log

http://paste.openstack.org/show/754917/


rbd-mirror.log

http://paste.openstack.org/show/754916/




On Fri, Jul 26, 2019 at 6:55 PM Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On Fri, Jul 26, 2019 at 04:40:35PM +0530, Ajitha Robert wrote:
> > Thank you for the clarification.
> >
> > But i was trying with openstack-cinder.. when i load some data into the
> > volume around 50gb, the image sync will stop by 5 % or something within
> > 15%...  What could be the reason?
>
> I suppose you see image sync stop in mirror status output? Could you
> please provide an example? And I suppose you don't see any other
> messages in rbd-mirror log apart from what you have already posted?
> Depending on configuration rbd-mirror might log in several logs. Could
> you please try to find all its logs? `lsof |grep 'rbd-mirror.*log'`
> may be useful for this.
>
> BTW, what rbd-mirror version are you running?
>
> --
> Mykola Golub
>


-- 


*Regards,Ajitha R*

--00000000000054a15a058ea8f2bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><p style=3D"margin-bottom:0in;line-height:100%">Thanks for the cl=
arification</p><p style=3D"margin-bottom:0in;line-height:100%"><br></p><p s=
tyle=3D"margin-bottom:0in;line-height:100%"><b>1) Will there be any folder =
related to rbd-mirroring in /var/lib/ceph ? </b><br></p><p style=3D"margin-=
bottom:0in;line-height:100%"><br></p><p style=3D"margin-bottom:0in;line-hei=
ght:100%"><b>2) Is ceph rbd-mirror authentication mandatory?</b><br></p><p =
style=3D"margin-bottom:0in;line-height:100%"><br></p><p style=3D"margin-bot=
tom:0in;line-height:100%"><b>3)when even i create any cinder volume loaded =
with glance image i get the following error.. </b><br></p><p style=3D"margi=
n-bottom:0in;line-height:100%">2019-07-27 17:26:46.762571 7f93eb0a5780 20 l=
ibrbd::api::Mirror: peer_list: <br>2019-07-27
 17:27:07.541701 7f939d7fa700=C2=A0 0 rbd::mirror::ImageReplayer:=20
0x7f93c800e9e0 [19/b6656be7-6006-4246-ba93-a49a220e33ce]=20
handle_shut_down: remote image no longer exists: scheduling deletion<br>201=
9-07-27 17:27:16.766199 7f93eb0a5780 20 librbd::api::Mirror: peer_list: <br=
>2019-07-27
 17:27:22.568970 7f939d7fa700=C2=A0 0 rbd::mirror::ImageReplayer:=20
0x7f93c800e9e0 [19/b6656be7-6006-4246-ba93-a49a220e33ce]=20
handle_shut_down: mirror image no longer exists<br>2019-07-27 17:27:46.7691=
58 7f93eb0a5780 20 librbd::api::Mirror: peer_list: <br>2019</p><p style=3D"=
margin-bottom:0in;line-height:100%"><br></p><p style=3D"margin-bottom:0in;l=
ine-height:100%"><b>4) Finally,</b></p><p style=3D"margin-bottom:0in;line-h=
eight:100%"><b>Attimes i can able to create bootable cinder volume apart fr=
om the above errors, <br></b></p><p style=3D"margin-bottom:0in;line-height:=
100%"><b><br></b></p><p style=3D"margin-bottom:0in;line-height:100%"><b>but=
 certain times i face the following</b></p><p style=3D"margin-bottom:0in;li=
ne-height:100%"><br></p><p style=3D"margin-bottom:0in;line-height:100%">exa=
mple, For a 50 gb volume, Local image get
created, but it couldnt create a mirror image
</p><p style=3D"margin-bottom:0in;line-height:100%">Logs of the image
status showed as replaying but pls see the rbd-mirror log<br></p>
<p style=3D"margin-bottom:0in;line-height:100%"><a href=3D"http://paste.ope=
nstack.org/show/754917/">http://paste.openstack.org/show/754917/</a></p>
<p style=3D"margin-bottom:0in;line-height:100%"><br></p><p style=3D"margin-=
bottom:0in;line-height:100%">rbd-mirror.log</p>

<p style=3D"margin-bottom:0in;line-height:100%"><a href=3D"http://paste.ope=
nstack.org/show/754916/">http://paste.openstack.org/show/754916/</a></p>
<p style=3D"margin-bottom:0in;line-height:100%"><br>

</p><p style=3D"margin-bottom:0in;line-height:100%"><br>

</p>

</div></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jul 26, 2019 at 6:55 PM Mykola Golub &lt;<a=
 href=3D"mailto:to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jul=
 26, 2019 at 04:40:35PM +0530, Ajitha Robert wrote:<br>
&gt; Thank you for the clarification.<br>
&gt; <br>
&gt; But i was trying with openstack-cinder.. when i load some data into th=
e<br>
&gt; volume around 50gb, the image sync will stop by 5 % or something withi=
n<br>
&gt; 15%...=C2=A0 What could be the reason?<br>
<br>
I suppose you see image sync stop in mirror status output? Could you<br>
please provide an example? And I suppose you don&#39;t see any other<br>
messages in rbd-mirror log apart from what you have already posted?<br>
Depending on configuration rbd-mirror might log in several logs. Could<br>
you please try to find all its logs? `lsof |grep &#39;rbd-mirror.*log&#39;`=
<br>
may be useful for this.<br>
<br>
BTW, what rbd-mirror version are you running?<br>
<br>
-- <br>
Mykola Golub<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><b><i style=3D"background-color:rgb(255,25=
5,255);color:rgb(102,0,0)">Regards,<span></span><br>Ajitha R</i><br></b></d=
iv></div>

--00000000000054a15a058ea8f2bd--

--===============4887155585420644587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4887155585420644587==--
