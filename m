From: Martin Palma <martin-0Gz4coKHHX0@public.gmane.org>
Subject: Re: Question about user's key
Date: Fri, 20 Jan 2017 07:35:39 +0000
Message-ID: <CANMxC7AaineGxz6N7EogxsQo6Ha--wL+4xZOjSEULUOWrCmYxQ@mail.gmail.com>
References: <C5A0092C63E939488005F15F736A81125B261330@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1110569203=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <C5A0092C63E939488005F15F736A81125B261330-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "Chen, Wei D" <wei.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1110569203==
Content-Type: multipart/alternative; boundary=001a113fb18aef2e8b054681b299

--001a113fb18aef2e8b054681b299
Content-Type: text/plain; charset=UTF-8

Hi,

They are stored on the monitore nodes.

Best,
Martin

On Fri, 20 Jan 2017 at 04:53, Chen, Wei D <wei.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
>
>
>
> I have read through some documents about authentication and user
> management about ceph, everything works fine with me, I can create
>
> a user and play with the keys and caps of that user. But I cannot find
> where those keys or capabilities stored, obviously, I can
>
> export those info to a file but where are they if I don't export them out?
>
>
>
> Looks like these information (keys and caps) of the user is stored in
> memory? but I still can list them out after rebooting my
>
> machine. Or these info are persisted in some type of DB I didn't aware?
>
>
>
> Can anyone help me out?
>
>
>
>
>
> Best Regards,
>
> Dave Chen
>
>
>
>

--001a113fb18aef2e8b054681b299
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div><br></div><div>They are stored on the monitore nodes.</d=
iv><div><br></div><div>Best,</div><div>Martin</div><div><br><div class=3D"g=
mail_quote"><div>On Fri, 20 Jan 2017 at 04:53, Chen, Wei D &lt;<a href=3D"m=
ailto:wei.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">wei.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Hi,<br class=3D"gmail_msg"><br><br class=3D"gm=
ail_msg"><br>I have read through some documents about authentication and us=
er management about ceph, everything works fine with me, I can create<br cl=
ass=3D"gmail_msg"><br>a user and play with the keys and caps of that user. =
But I cannot find where those keys or capabilities stored, obviously, I can=
<br class=3D"gmail_msg"><br>export those info to a file but where are they =
if I don&#39;t export them out?<br class=3D"gmail_msg"><br><br class=3D"gma=
il_msg"><br>Looks like these information (keys and caps) of the user is sto=
red in memory? but I still can list them out after rebooting my<br class=3D=
"gmail_msg"><br>machine. Or these info are persisted in some type of DB I d=
idn&#39;t aware?<br class=3D"gmail_msg"><br><br class=3D"gmail_msg"><br>Can=
 anyone help me out?<br class=3D"gmail_msg"><br><br class=3D"gmail_msg"><br=
><br class=3D"gmail_msg"><br>Best Regards,<br class=3D"gmail_msg"><br>Dave =
Chen<br class=3D"gmail_msg"><br><br class=3D"gmail_msg"><br></blockquote></=
div></div>

--001a113fb18aef2e8b054681b299--

--===============1110569203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1110569203==--
