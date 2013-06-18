From: Cameron Bahar <cbahar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-deploy problems on weird /dev device names?
Date: Tue, 18 Jun 2013 15:55:22 -0700
Message-ID: <CANPdUhNH-Zpfy1ka7F8kOCFnQ2--cqXAJ0s45ernLBYsYpXFjQ@mail.gmail.com>
References: <alpine.DEB.2.00.1306181341430.1089@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1703115213=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1306181341430.1089-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1703115213==
Content-Type: multipart/alternative; boundary=047d7bdc77aaa4c62704df759b1f

--047d7bdc77aaa4c62704df759b1f
Content-Type: text/plain; charset=ISO-8859-1

We solved this problem at ParaScale by enabling users to enter any fancy
device names in the device discovery logic so that HP servers like the
DL185 which use older Compaq RAID controllers would work.  This is common.

Best,
Cameron
--


On Tue, Jun 18, 2013 at 1:43 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> I remember seeing a few reports of problems from users with strange block
> device names in /dev (sdaa*, c0d1p2* etc.) and have a bug open
> (http://tracker.ceph.com/issues/5345), but looking at the code I don't
> immediately see the problem, and I don't have any machines that have this
> problem.  Are there any users who have seen this problem who can try the
> latest version and/or help test a fix?
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bdc77aaa4c62704df759b1f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

We solved this problem at ParaScale by enabling users to enter any fancy de=
vice names in the device discovery logic so that HP servers like the DL185 =
which use older Compaq RAID controllers would work. =A0This is common.<div>
<br></div><div>Best,</div><div>Cameron</div><div>--</div><div><br><br><div =
class=3D"gmail_quote">On Tue, Jun 18, 2013 at 1:43 PM, Sage Weil <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">sage@ink=
tank.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I remember seeing a few reports of problems =
from users with strange block<br>
device names in /dev (sdaa*, c0d1p2* etc.) and have a bug open<br>
(<a href=3D"http://tracker.ceph.com/issues/5345" target=3D"_blank">http://t=
racker.ceph.com/issues/5345</a>), but looking at the code I don&#39;t<br>
immediately see the problem, and I don&#39;t have any machines that have th=
is<br>
problem. =A0Are there any users who have seen this problem who can try the<=
br>
latest version and/or help test a fix?<br>
<br>
Thanks!<br>
sage<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</blockquote></div><br></div>

--047d7bdc77aaa4c62704df759b1f--

--===============1703115213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1703115213==--
