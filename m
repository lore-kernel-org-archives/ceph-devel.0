From: Fred Yang <frederic.yang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: experimental features
Date: Mon, 08 Dec 2014 12:57:13 +0000
Message-ID: <CAPHS-z7cOLokgHe7Ky+SJQMGPbZmY26o+EeA1i=qo+i_XnYg5g@mail.gmail.com>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
	<CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
	<5481EF6B.4010901@redhat.com>
	<CAOGLoJN2wSxMgtok6aATSW5o-Abqcv2bdVo+dVfaEbG4iyiQSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2066353841=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Justin Erenkrantz <justin-XWYNqclEDWm2WkX4dyxwcA@public.gmane.org>, mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2066353841==
Content-Type: multipart/alternative; boundary=001a1133e4cc2131f10509b3f796

--001a1133e4cc2131f10509b3f796
Content-Type: text/plain; charset=UTF-8

You will have to consider in the real world whoever built the cluster might
not document the dangerous option to let support stuff or successor aware.
Thus any experimental feature considered not safe for production should be
included in a warning message in 'ceph health', and logs, either log it
periodically or log the warning msg upon restart.
Feature-wise, 'ceph health detail' should give you a report over all
important features/options of the cluster as well.

-Fred

On Sun, Dec 7, 2014, 11:15 PM Justin Erenkrantz <justin-XWYNqclEDWm2WkX4dyxwcA@public.gmane.org>
wrote:

> On Fri, Dec 5, 2014 at 12:46 PM, Mark Nelson <mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
> wrote:
> > I'm in favor of the "allow experimental features" but instead call it:
> >
> > "ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES" which makes things a
> little
> > more explicit. With great power comes great responsibility.
>
> +1.
>
> For Subversion, we utilize SVN_I_LOVE_CORRUPTED_XXX for a few options
> that can cause data corruption.  -- justin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a1133e4cc2131f10509b3f796
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

You will have to consider in the real world whoever built the cluster might=
 not document the dangerous option to let support stuff or successor aware.=
 Thus any experimental feature considered not safe for production should be=
 included in a warning message in &#39;ceph health&#39;, and logs, either l=
og it periodically or log the warning msg upon restart. <br>Feature-wise, &=
#39;ceph health detail&#39; should give you a report over all important fea=
tures/options of the cluster as well.<br><br>-Fred<br><br><div class=3D"gma=
il_quote">On Sun, Dec 7, 2014, 11:15 PM=C2=A0Justin Erenkrantz &lt;<a href=
=3D"mailto:justin-XWYNqclEDWm2WkX4dyxwcA@public.gmane.org">justin-XWYNqclEDWm2WkX4dyxwcA@public.gmane.org</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Fri, Dec 5, 2014 at 12:46 PM, Mark Nelson =
&lt;<a href=3D"mailto:mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">mark.nelso=
n@inktank.com</a>&gt; wrote:<br>
&gt; I&#39;m in favor of the &quot;allow experimental features&quot; but in=
stead call it:<br>
&gt;<br>
&gt; &quot;ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES&quot; which makes t=
hings a little<br>
&gt; more explicit. With great power comes great responsibility.<br>
<br>
+1.<br>
<br>
For Subversion, we utilize SVN_I_LOVE_CORRUPTED_XXX for a few options<br>
that can cause data corruption.=C2=A0 -- justin<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.htm=
l</a><br>
</blockquote></div>

--001a1133e4cc2131f10509b3f796--

--===============2066353841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2066353841==--
