From: Will Zhao <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: is there any filesystem like wrapper that dont need to
 map and mount rbd ?
Date: Wed, 1 Aug 2018 15:33:33 +0800
Message-ID: <CAGOEmcONNKGJo+kuT=AmAmJgbr8r9SnnG0po66_cEX=0HKv9WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7193895235617341642=="
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
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============7193895235617341642==
Content-Type: multipart/alternative; boundary="000000000000ef9c8105725ab6e7"

--000000000000ef9c8105725ab6e7
Content-Type: text/plain; charset="UTF-8"

Hi:
   I want to use ceph rbd, because it shows better performance. But I dont
like kernal module and isci target process. So  here is my requirments:
   I dont want to map it and mount it ,   But I still want to use some
filesystem like api, or at least I can write multiple files to the rbd
volume and read them back later. This means I just need librbd api to
oprate the volume through network.
   I wonder if there is anyone who have done this , wrap librbd api to
provide a very simple filesystem like api ?   Or I can do this through
orther way ?  Thanks for giving me any advice.

--000000000000ef9c8105725ab6e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi:<div>=C2=A0 =C2=A0I want to use ceph rbd, because it sh=
ows better performance. But I dont like kernal module and isci target proce=
ss. So=C2=A0 here is my requirments:</div><div>=C2=A0 =C2=A0I dont want to =
map it and mount it ,=C2=A0 =C2=A0But I still want to use some filesystem l=
ike api, or at least I can write multiple files to the rbd volume and read =
them back later. This means I just need librbd api to oprate the volume thr=
ough network.=C2=A0</div><div>=C2=A0 =C2=A0I wonder if there is anyone who =
have done this , wrap librbd api to provide a very simple filesystem like a=
pi ?=C2=A0 =C2=A0Or I can do this through orther way ?=C2=A0 Thanks for giv=
ing me any advice.=C2=A0 =C2=A0</div></div>

--000000000000ef9c8105725ab6e7--

--===============7193895235617341642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7193895235617341642==--
