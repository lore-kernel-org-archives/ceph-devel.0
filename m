From: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Fri, 22 Feb 2019 12:59:41 +0100
Message-ID: <CAA6-MF9ki_eHY=ZHwreHJ1KpB1iFrJd-+k7CeaOtTdTMBmD=DA@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
 <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
 <CANrNMwUVupc80VWW_OKbYnH1JzB9fKRJFB7q7wVgJH9MY8fB6w@mail.gmail.com>
 <CANA9Uk5+D1GU55Goc0+TEjfYhtS8wQ0XRC-3QrSqBpEXPR9Z-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5832867499131958709=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5+D1GU55Goc0+TEjfYhtS8wQ0XRC-3QrSqBpEXPR9Z-g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============5832867499131958709==
Content-Type: multipart/alternative; boundary="00000000000026441805827a5487"

--00000000000026441805827a5487
Content-Type: text/plain; charset="UTF-8"

Den fre 22 feb. 2019 kl 12:35 skrev M Ranga Swami Reddy <
swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> No seen the CPU limitation because we are using the 4 cores per osd daemon.
> But still using "ms_crc_data = true and ms_crc_header = true". Will
> disable these and try the performance.
>

I am a bit sceptical to crc being so heavy that it would impact a CPU made
after 1990..

-- 
May the most significant bit of your life be positive.

--00000000000026441805827a5487
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Den fre 22 feb. 2019 kl 12:35 skrev M Ran=
ga Swami Reddy &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">swamireddy@gmail=
.com</a>&gt;:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">No seen the CPU limitation because we are using th=
e 4 cores per osd daemon.<br>
But still using &quot;ms_crc_data =3D true and ms_crc_header =3D true&quot;=
. Will<br>
disable these and try the performance.<br></blockquote><div><br></div><div>=
I am a bit sceptical to crc being so heavy that it would impact a CPU made =
after 1990..</div><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">May the most significant bit of your life be positive.<br><=
/div></div>

--00000000000026441805827a5487--

--===============5832867499131958709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5832867499131958709==--
