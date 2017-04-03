From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: deep-scrubbing
Date: Mon, 3 Apr 2017 15:21:22 +0530
Message-ID: <CANA9Uk7=Q-TeYBuBSjQtd8OEBBu7A7ZkcnwXd2-fqfywPUAQcA@mail.gmail.com>
References: <CANA9Uk5W8AhOjRnxmdQXQL1g5KmP6_eDLYuhMEL_=50npW=x4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0537813960=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5W8AhOjRnxmdQXQL1g5KmP6_eDLYuhMEL_=50npW=x4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0537813960==
Content-Type: multipart/alternative; boundary=001a114bf2d21acb4f054c401abc

--001a114bf2d21acb4f054c401abc
Content-Type: text/plain; charset=UTF-8

I use a ceph cluster and its show the deeps scrub's PG distribution as
below from "ceph pg dump" command:

  ====
   2000 Friday
   1000 Saturday
   4000  Sunday
==

On Friday, I have disabled the deep-scrub due to some reason. If this case,
all Friday's PG deep-scrub will be performed on Saturday or is it will be
done on Next Friday?

Thanks
Swami


On Mon, Feb 27, 2017 at 3:54 PM, M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hello,
> I use a ceph cluster and its show the deeps scrub's PG distribution as
> below from "ceph pg dump" command:
>
>   ====
>    2000 Friday
>    1000 Saturday
>    4000  Sunday
> ==
>
> On Friday, I have disabled the deep-scrub due to some reason. If this
> case, all Friday's PG deep-scrub will be performed on Saturday or is it
> will be done on Next Friday?
>
> Thanks
> Swami
>

--001a114bf2d21acb4f054c401abc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I use a=C2=A0ceph=C2=A0cluster and i=
ts show the deeps scrub&#39;s PG distribution as below from &quot;ceph=C2=
=A0pg=C2=A0dump&quot; command:</div><div><br></div><div>=C2=A0 =3D=3D=3D=3D=
</div><div>=C2=A0 =C2=A02000 Friday</div><div>=C2=A0 =C2=A01000 Saturday</d=
iv><div>=C2=A0 =C2=A04000 =C2=A0Sunday</div><div>=3D=3D</div><div><br></div=
><div>On Friday, I have disabled the deep-scrub due to some reason. If this=
 case, all=C2=A0Friday&#39;s PG deep-scrub will be performed on Saturday or=
 is it will be done on Next Friday?</div><div><br></div><div>Thanks</div><s=
pan class=3D"gmail-HOEnZb"><font color=3D"#888888">Swami</font></span></div=
><div><span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></spa=
n></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, F=
eb 27, 2017 at 3:54 PM, M Ranga Swami Reddy <span dir=3D"ltr">&lt;<a href=
=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr">Hello,<div>I use a <span id=3D"e773c947-13d0-40fb-b77f-d347b4=
5b8b80" class=3D"gmail-GINGER_SOFTWARE_mark GINGER_SOFTWARE_mark">ceph</spa=
n> cluster and its show the deeps scrub&#39;s PG distribution as below from=
 &quot;<span id=3D"gmail-8403ee06-5fb2-42e4-ada5-8be2a31d31a1" class=3D"gma=
il-GINGER_SOFTWARE_mark">ceph</span> <span id=3D"gmail-702bbadd-2e64-4dc9-a=
dd2-b96ecc84486d" class=3D"gmail-GINGER_SOFTWARE_mark">pg</span> dump&quot;=
 command:</div><div><br></div><div>=C2=A0 =3D=3D=3D=3D</div><div>=C2=A0 =C2=
=A02000 Friday</div><div>=C2=A0 =C2=A01000 Saturday</div><div>=C2=A0 =C2=A0=
4000 =C2=A0Sunday</div><div>=3D=3D</div><div><br></div><div>On Friday, I ha=
ve disabled the deep-scrub due to some reason. If this case, all=C2=A0Frida=
y&#39;s PG deep-scrub will be performed on Saturday or is it will be done o=
n Next Friday?</div><div><br></div><div>Thanks</div><span class=3D"gmail-HO=
EnZb"><font color=3D"#888888"><div>Swami</div></font></span></div>
</blockquote></div><br></div></div>

--001a114bf2d21acb4f054c401abc--

--===============0537813960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0537813960==--
