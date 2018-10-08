From: Daniel Carrasco <d.carrasco-RJazjCFaYHwAvxtiuMwx3w@public.gmane.org>
Subject: Re: Don't upgrade to 13.2.2 if you use cephfs
Date: Mon, 8 Oct 2018 11:53:01 +0200
Message-ID: <CAGG0Mq0Nkbrexry9VLFw+GYgimkajquy1fF7EyST3mEHY1a7WQ@mail.gmail.com>
References: <CAAM7YAnkjiujm8dqgeG6uOhPGL+ccC71Q0F15-ez=4Qgj6Fomw@mail.gmail.com>
 <28a7ec84-864a-8f61-a223-b307217919ce@gmail.com>
 <CAGG0Mq0XB=+y5xhfKQcAdbHtDTEzN64OZ8UjN-g9kQ7BqJ4WBg@mail.gmail.com>
 <CAAM7YAnev9fK8rGyCYHLa_a9+0cjY178pL2h8_-Oc8LwZh+O9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3045593440299278670=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YAnev9fK8rGyCYHLa_a9+0cjY178pL2h8_-Oc8LwZh+O9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3045593440299278670==
Content-Type: multipart/alternative; boundary="0000000000003fa9ca0577b49811"

--0000000000003fa9ca0577b49811
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun., 8 oct. 2018 5:44, Yan, Zheng <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> escribi=C3=B3:

> On Mon, Oct 8, 2018 at 11:34 AM Daniel Carrasco <d.carrasco-RJazjCFaYHwAvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > I've got several problems on 12.2.8 too. All my standby MDS uses a lot
> of memory (while active uses normal memory), and I'm receiving a lot of
> slow MDS messages (causing the webpage to freeze and fail until MDS are
> restarted)... Finally I had to copy the entire site to DRBD and use NFS t=
o
> solve all problems...
> >
>
> was standby-replay enabled?
>

I've tried both and I've seen more less the same behavior, maybe less when
is not in replay mode.

Anyway, we've deactivated CephFS for now there. I'll try with older
versions on a test environment


> > El lun., 8 oct. 2018 a las 5:21, Alex Litvak (<
> alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) escribi=C3=B3:
> >>
> >> How is this not an emergency announcement?  Also I wonder if I can
> >> downgrade at all ?  I am using ceph with docker deployed with
> >> ceph-ansible.  I wonder if I should push downgrade or basically wait f=
or
> >> the fix.  I believe, a fix needs to be provided.
> >>
> >> Thank you,
> >>
> >> On 10/7/2018 9:30 PM, Yan, Zheng wrote:
> >> > There is a bug in v13.2.2 mds, which causes decoding purge queue to
> >> > fail. If mds is already in damaged state, please downgrade mds to
> >> > 13.2.1, then run 'ceph mds repaired fs_name:damaged_rank' .
> >> >
> >> > Sorry for all the trouble I caused.
> >> > Yan, Zheng
> >> >
> >>
> >>
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
> >
> > --
> > _________________________________________
> >
> >       Daniel Carrasco Mar=C3=ADn
> >       Ingenier=C3=ADa para la Innovaci=C3=B3n i2TIC, S.L.
> >       Tlf:  +34 911 12 32 84 Ext: 223
> >       www.i2tic.com
> > _________________________________________
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000003fa9ca0577b49811
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
El lun., 8 oct. 2018 5:44, Yan, Zheng &lt;<a href=3D"mailto:ukernel@gmail.c=
om">ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; escribi=C3=B3:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On Mon, Oct 8, 2018 at 11:34 AM Daniel Carrasco &lt;<a href=3D"ma=
ilto:d.carrasco-RJazjCFaYHwAvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">d.carrasco@=
i2tic.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I&#39;ve got several problems on 12.2.8 too. All my standby MDS uses a=
 lot of memory (while active uses normal memory), and I&#39;m receiving a l=
ot of slow MDS messages (causing the webpage to freeze and fail until MDS a=
re restarted)... Finally I had to copy the entire site to DRBD and use NFS =
to solve all problems...<br>
&gt;<br>
<br>
was standby-replay enabled?<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I&#39;ve tried both and I&#39;ve seen more less =
the same behavior, maybe less when is not in replay mode.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Anyway, we&#39;ve deactivated CephFS for =
now there. I&#39;ll try with older versions on a test environment</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt; El lun., 8 oct. 2018 a las 5:21, Alex Litvak (&lt;<a href=3D"mailto:al=
exander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">alexander.=
v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;) escribi=C3=B3:<br>
&gt;&gt;<br>
&gt;&gt; How is this not an emergency announcement?=C2=A0 Also I wonder if =
I can<br>
&gt;&gt; downgrade at all ?=C2=A0 I am using ceph with docker deployed with=
<br>
&gt;&gt; ceph-ansible.=C2=A0 I wonder if I should push downgrade or basical=
ly wait for<br>
&gt;&gt; the fix.=C2=A0 I believe, a fix needs to be provided.<br>
&gt;&gt;<br>
&gt;&gt; Thank you,<br>
&gt;&gt;<br>
&gt;&gt; On 10/7/2018 9:30 PM, Yan, Zheng wrote:<br>
&gt;&gt; &gt; There is a bug in v13.2.2 mds, which causes decoding purge qu=
eue to<br>
&gt;&gt; &gt; fail. If mds is already in damaged state, please downgrade md=
s to<br>
&gt;&gt; &gt; 13.2.1, then run &#39;ceph mds repaired fs_name:damaged_rank&=
#39; .<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Sorry for all the trouble I caused.<br>
&gt;&gt; &gt; Yan, Zheng<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; ceph-users mailing list<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank" rel=
=3D"noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">http://lists.ceph.com/list=
info.cgi/ceph-users-ceph.com</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; _________________________________________<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Daniel Carrasco Mar=C3=ADn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Ingenier=C3=ADa para la Innovaci=C3=B3n i2TI=
C, S.L.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Tlf:=C2=A0 +34 911 12 32 84 Ext: 223<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.i2tic.com" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">www.i2tic.com</a><br>
&gt; _________________________________________<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank" rel=3D"=
noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo=
.cgi/ceph-users-ceph.com</a><br>
</blockquote></div></div></div>

--0000000000003fa9ca0577b49811--

--===============3045593440299278670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3045593440299278670==--
