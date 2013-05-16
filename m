From: Dewan Shamsul Alam <dewan.shamsul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using Ceph and CloudStack? Let us know!
Date: Thu, 16 May 2013 20:34:12 +0600
Message-ID: <CAMj00WYSUJCDyCnKprHVo9GuqGfNJb_mQHyKdwa=mFq9msh87Q@mail.gmail.com>
References: <CAP8Oy=K3qa7dcVxAab9m=whUD+JoUsLxy5ZoX5DPM09x4_aPaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2122920756=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAP8Oy=K3qa7dcVxAab9m=whUD+JoUsLxy5ZoX5DPM09x4_aPaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Patrick McGarry <patrick-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2122920756==
Content-Type: multipart/alternative; boundary=089e0115e76097fc1004dcd6c210

--089e0115e76097fc1004dcd6c210
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I will be deploying CloudStack and will use Ceph. Too bad CloudStack
requires NFS as the primary storage for System VM. So I have to use a
DRBD+NFS for that. The setup is as follows:

3 Node Ceph Cluster [Bobtail] - Planning to upgrade to Cuttle fish after
trying this.
2 Node for DRBD+NFS
1 VM for the management system - I'm not worried about high availability of
this node at this point.
3 Compute nodes
All commodity hardware backed by a gigabit switch

I will have this setup running after next week. I will let you guys know
how it went.

Best Regards,
Dewan Shamsul Alam




On Thu, May 16, 2013 at 8:02 PM, Patrick McGarry <patrick-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>wrote:

> Greetings ceph-ers,
>
> As you may have noticed lately, there has been a lot of talk about
> Ceph and OpenStack.  While we love all of the excitement that this has
> generated, we want to make sure that other cloud setups aren't getting
> neglected or ignored.  CloudStack, for instance, also has a great Ceph
> integration thanks to some enterprising work from Wido at 42on.com.
>
> So, are you using CloudStack and Ceph?  If so we'd love to hear from
> you.  Whether it's just a quiet note for our eyes only, or whether you
> have a story to share with the world, we'd love to know.  Of course,
> we'd love to hear about anything you're working on.  So, if you have
> notes to share about Ceph with other cloud flavors, massive storage
> clusters, or custom work, we'd treasure them appropriately.
>
> Feel free to just reply to this email, send a message to
> community-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org, message 'scuttlemonkey' on irc.oftc.net, or tie
> a note to our ip-over-carrier-pigeon network.  Thanks, and happy
> Ceph-ing.
>
>
> Best Regards,
>
> Patrick McGarry
> Director, Community || Inktank
>
> http://ceph.com  ||  http://inktank.com
> @scuttlemonkey || @ceph || @inktank
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e0115e76097fc1004dcd6c210
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>Hi,<br><br></=
div>I will be deploying CloudStack and will use Ceph. Too bad CloudStack re=
quires NFS as the primary storage for System VM. So I have to use a DRBD+NF=
S for that. The setup is as follows:<br>
<br></div>3 Node Ceph Cluster [Bobtail] - Planning to upgrade to Cuttle fis=
h after trying this.<br></div>2 Node for DRBD+NFS<br></div>1 VM for the man=
agement system - I&#39;m not worried about high availability of this node a=
t this point.<br>
</div>3 Compute nodes<br></div>All commodity hardware backed by a gigabit s=
witch<br><br></div>I will have this setup running after next week. I will l=
et you guys know how it went.<br><br></div>Best Regards,<br></div>Dewan Sha=
msul Alam<br>
<div><div><div><div><div><div><div><div><br><br></div></div></div></div></d=
iv></div></div></div></div><div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">On Thu, May 16, 2013 at 8:02 PM, Patrick McGarry <span dir=3D=
"ltr">&lt;<a href=3D"mailto:patrick-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">patrick@=
inktank.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Greetings ceph-ers,<br>
<br>
As you may have noticed lately, there has been a lot of talk about<br>
Ceph and OpenStack. =A0While we love all of the excitement that this has<br=
>
generated, we want to make sure that other cloud setups aren&#39;t getting<=
br>
neglected or ignored. =A0CloudStack, for instance, also has a great Ceph<br=
>
integration thanks to some enterprising work from Wido at <a href=3D"http:/=
/42on.com" target=3D"_blank">42on.com</a>.<br>
<br>
So, are you using CloudStack and Ceph? =A0If so we&#39;d love to hear from<=
br>
you. =A0Whether it&#39;s just a quiet note for our eyes only, or whether yo=
u<br>
have a story to share with the world, we&#39;d love to know. =A0Of course,<=
br>
we&#39;d love to hear about anything you&#39;re working on. =A0So, if you h=
ave<br>
notes to share about Ceph with other cloud flavors, massive storage<br>
clusters, or custom work, we&#39;d treasure them appropriately.<br>
<br>
Feel free to just reply to this email, send a message to<br>
<a href=3D"mailto:community-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">community-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>, message=
 &#39;scuttlemonkey&#39; on <a href=3D"http://irc.oftc.net" target=3D"_blan=
k">irc.oftc.net</a>, or tie<br>
a note to our ip-over-carrier-pigeon network. =A0Thanks, and happy<br>
Ceph-ing.<br>
<br>
<br>
Best Regards,<br>
<br>
Patrick McGarry<br>
Director, Community || Inktank<br>
<br>
<a href=3D"http://ceph.com" target=3D"_blank">http://ceph.com</a> =A0|| =A0=
<a href=3D"http://inktank.com" target=3D"_blank">http://inktank.com</a><br>
@scuttlemonkey || @ceph || @inktank<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--089e0115e76097fc1004dcd6c210--

--===============2122920756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2122920756==--
