From: Alex Gorbachev <ag-VxEtxStO0vCD5NdjQRoWIEEOCMrvLtNR@public.gmane.org>
Subject: Re: Block Storage Image Creation Process
Date: Sat, 11 Jul 2015 23:35:25 -0400
Message-ID: <CADb9450nrCzSQAAfvvcAOzC3-mgRsxetWdUtMP2y7u3jxMtLyw@mail.gmail.com>
References: <CAJe5gkBvJUuQQ08PtBB_dEp5bXZZHyeVw-7zCyOfLFid8vsqGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1930426819=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJe5gkBvJUuQQ08PtBB_dEp5bXZZHyeVw-7zCyOfLFid8vsqGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jiwan N <jiwan.ninglekhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1930426819==
Content-Type: multipart/alternative; boundary=001a113f9048b9c055051aa54bac

--001a113f9048b9c055051aa54bac
Content-Type: text/plain; charset=UTF-8

Hi Jiwan,

On Sat, Jul 11, 2015 at 4:44 PM, Jiwan N <jiwan.ninglekhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi  Ceph-Users,
>
> I am quite new to Ceph Storage (storage tech in general). I have been
> investigating Ceph to understand the precise process clearly.
>
> *Q: What actually happens When I create a block image of certain size?*
>
> The ceph documentation from  http://docs.ceph.com/docs/v0.67.9/man/8/rbd/
> says, the block devices (images)
> are stripped over objects and stored in a RADOS object store.
>
> This is the process of storage allocation. So, do objects that are broken
> down allocate space (themselves) where they reside? Or are these objects
> (state and behavior ) information kept (scattered) into the OSDs
> (eventually into the disks)? Or does the monitor server keep these info and
> allocate those positions (locations) in Object storage disks so that later
> on some data can be put into those locations?
>
> Any precise documentation or explanation will help.
>

I found this description of the internal architecture most helpful:

http://ceph.com/docs/master/architecture/

Best regards,
Alex


>
> --
> Sincerely,
> Jiwan Ninglekhu
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--001a113f9048b9c055051aa54bac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jiwan,<div><br></div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote">On Sat, Jul 11, 2015 at 4:44 PM, Jiwan N <span dir=3D"l=
tr">&lt;<a href=3D"mailto:jiwan.ninglekhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">jiwa=
n.ninglekhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D=
"ltr">Hi =C2=A0Ceph-Users,<div><br></div><div>I am quite new to Ceph Storag=
e (storage tech in general). I have been investigating Ceph to understand t=
he precise process clearly.=C2=A0</div><div><br></div><div><b>Q: What actua=
lly happens When I create a block image of certain size?</b></div><div><br>=
</div><div>The ceph documentation from =C2=A0<a href=3D"http://docs.ceph.co=
m/docs/v0.67.9/man/8/rbd/" target=3D"_blank">http://docs.ceph.com/docs/v0.6=
7.9/man/8/rbd/</a> says, the block devices (images)</div><div><div>are stri=
pped over objects and stored in a RADOS object store.</div><div><br></div><=
div>This is the process of storage allocation. So, do objects that are brok=
en down allocate space (themselves) where they reside? Or are these objects=
 (state and behavior ) information kept (scattered) into the OSDs (eventual=
ly into the disks)? Or does the monitor server keep these info and allocate=
 those positions (locations) in Object storage disks so that later on some =
data can be put into those locations?</div><div><br></div><div>Any precise =
documentation or explanation will help.</div></div></div></blockquote><div>=
<br></div><div>I found this description of the internal architecture most h=
elpful:</div><div><br></div><div><a href=3D"http://ceph.com/docs/master/arc=
hitecture/">http://ceph.com/docs/master/architecture/</a><br></div><div><br=
></div><div>Best regards,</div><div>Alex</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><div dir=3D"ltr"><div><span class=3D""><font color=3D"#888888"><div><b=
r></div>-- <br><div>Sincerely,<div>Jiwan Ninglekhu</div></div>
</font></span></div></div>
<br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
<br></blockquote></div><br></div></div>

--001a113f9048b9c055051aa54bac--

--===============1930426819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1930426819==--
