From: Viral Mehta <viral.vkm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Preliminary RDMA vs TCP numbers
Date: Wed, 8 Apr 2015 13:59:45 +0530
Message-ID: <CANX6Dam1VMBfDJDLp3sT54jB0=iKENJBZDAZgrm+O+zMZmYT0g@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75D78@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0570288784=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75D78-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0570288784==
Content-Type: multipart/alternative; boundary=047d7bfcee7a65d857051332550d

--047d7bfcee7a65d857051332550d
Content-Type: text/plain; charset=UTF-8

I am sorry, I am new to the discussion.

But, is it TCP offloaded (TOE) or otherwise ?

On Wed, Apr 8, 2015 at 1:47 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:

>
> Hi,
> Please find the preliminary performance numbers of TCP Vs RDMA (XIO)
> implementation (on top of SSDs) in the following link.
>
> http://www.slideshare.net/somnathroy7568/ceph-on-rdma
>
> The attachment didn't go through it seems, so, I had to use slideshare.
>
> Mark,
> If we have time, I can present it in tomorrow's performance meeting.
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If
> the reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please notify
> the sender by telephone or e-mail (as shown above) immediately and destroy
> any and all copies of this message in your possession (whether hard copies
> or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Thanks,
Viral Mehta

--047d7bfcee7a65d857051332550d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am sorry, I am new to the discussion.<br><br></div>=
But, is it TCP offloaded (TOE) or otherwise ?<br></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Wed, Apr 8, 2015 at 1:47 PM, Somna=
th Roy <span dir=3D"ltr">&lt;<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org" tar=
get=3D"_blank">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><br>
Hi,<br>
Please find the preliminary performance numbers of TCP Vs RDMA (XIO) implem=
entation (on top of SSDs) in the following link.<br>
<br>
<a href=3D"http://www.slideshare.net/somnathroy7568/ceph-on-rdma" target=3D=
"_blank">http://www.slideshare.net/somnathroy7568/ceph-on-rdma</a><br>
<br>
The attachment didn&#39;t go through it seems, so, I had to use slideshare.=
<br>
<br>
Mark,<br>
If we have time, I can present it in tomorrow&#39;s performance meeting.<br=
>
<br>
Thanks &amp; Regards<br>
Somnath<br>
<br>
________________________________<br>
<br>
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature">Thanks,<br>Viral Mehta</div>
</div>

--047d7bfcee7a65d857051332550d--

--===============0570288784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0570288784==--
