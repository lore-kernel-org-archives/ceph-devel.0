From: Daniel Carrasco <d.carrasco-RJazjCFaYHwAvxtiuMwx3w@public.gmane.org>
Subject: Re: Don't upgrade to 13.2.2 if you use cephfs
Date: Mon, 8 Oct 2018 05:28:13 +0200
Message-ID: <CAGG0Mq0XB=+y5xhfKQcAdbHtDTEzN64OZ8UjN-g9kQ7BqJ4WBg@mail.gmail.com>
References: <CAAM7YAnkjiujm8dqgeG6uOhPGL+ccC71Q0F15-ez=4Qgj6Fomw@mail.gmail.com>
 <28a7ec84-864a-8f61-a223-b307217919ce@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7514122457854215642=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <28a7ec84-864a-8f61-a223-b307217919ce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============7514122457854215642==
Content-Type: multipart/alternative; boundary="0000000000009a426d0577af37be"

--0000000000009a426d0577af37be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've got several problems on 12.2.8 too. All my standby MDS uses a lot of
memory (while active uses normal memory), and I'm receiving a lot of slow
MDS messages (causing the webpage to freeze and fail until MDS are
restarted)... Finally I had to copy the entire site to DRBD and use NFS to
solve all problems...

El lun., 8 oct. 2018 a las 5:21, Alex Litvak (<alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>)
escribi=C3=B3:

> How is this not an emergency announcement?  Also I wonder if I can
> downgrade at all ?  I am using ceph with docker deployed with
> ceph-ansible.  I wonder if I should push downgrade or basically wait for
> the fix.  I believe, a fix needs to be provided.
>
> Thank you,
>
> On 10/7/2018 9:30 PM, Yan, Zheng wrote:
> > There is a bug in v13.2.2 mds, which causes decoding purge queue to
> > fail. If mds is already in damaged state, please downgrade mds to
> > 13.2.1, then run 'ceph mds repaired fs_name:damaged_rank' .
> >
> > Sorry for all the trouble I caused.
> > Yan, Zheng
> >
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


--=20
_________________________________________

      Daniel Carrasco Mar=C3=ADn
      Ingenier=C3=ADa para la Innovaci=C3=B3n i2TIC, S.L.
      Tlf:  +34 911 12 32 84 Ext: 223
      www.i2tic.com
_________________________________________

--0000000000009a426d0577af37be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve got several problems on 12.2.8 too. All my standb=
y MDS uses a lot of memory (while active uses normal memory), and I&#39;m r=
eceiving a lot of slow MDS messages (causing the webpage to freeze and fail=
 until MDS are restarted)... Finally I had to copy the entire site to DRBD =
and use NFS to solve all problems...</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr">El lun., 8 oct. 2018 a las 5:21, Alex Litvak (&lt;<a href=3D=
"mailto:alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;)=
 escribi=C3=B3:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">How is this not an =
emergency announcement?=C2=A0 Also I wonder if I can <br>
downgrade at all ?=C2=A0 I am using ceph with docker deployed with <br>
ceph-ansible.=C2=A0 I wonder if I should push downgrade or basically wait f=
or <br>
the fix.=C2=A0 I believe, a fix needs to be provided.<br>
<br>
Thank you,<br>
<br>
On 10/7/2018 9:30 PM, Yan, Zheng wrote:<br>
&gt; There is a bug in v13.2.2 mds, which causes decoding purge queue to<br=
>
&gt; fail. If mds is already in damaged state, please downgrade mds to<br>
&gt; 13.2.1, then run &#39;ceph mds repaired fs_name:damaged_rank&#39; .<br=
>
&gt; <br>
&gt; Sorry for all the trouble I caused.<br>
&gt; Yan, Zheng<br>
&gt; <br>
<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><span style=3D"font-size:12.8px">______________________________</span><=
span style=3D"font-size:12.8px">___________</span><br style=3D"font-size:12=
.8px"><font face=3D"Arial" size=3D"2"><br></font><div><font face=3D"Arial" =
size=3D"2">=C2=A0=C2=A0</font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0<=
/font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0Daniel Carrasco Mar=C3=AD=
n</font><font face=3D"Arial" size=3D"2"><br></font><div style=3D"font-size:=
12.8px"><font face=3D"Arial" size=3D"2"></font></div><font face=3D"Arial" s=
ize=3D"2">=C2=A0=C2=A0</font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0</=
font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0</font><font face=3D"Arial=
" size=3D"2">Ingenier=C3=ADa para la Innovaci=C3=B3n i2TIC, S.L.</font><fon=
t face=3D"Arial" size=3D"2"><br></font><font face=3D"Arial" size=3D"2">=C2=
=A0=C2=A0</font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0</font><font fa=
ce=3D"Arial" size=3D"2">=C2=A0 Tlf:=C2=A0=C2=A0+34=C2=A0</font><font face=
=3D"Arial" size=3D"2">911 12 32 84 Ext: 223<br></font><font face=3D"Arial" =
size=3D"2">=C2=A0=C2=A0</font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0<=
/font><font face=3D"Arial" size=3D"2">=C2=A0=C2=A0</font><font face=3D"Aria=
l" size=3D"2"><a href=3D"http://www.i2tic.com/" style=3D"color:rgb(17,85,20=
4)" target=3D"_blank">www.i2tic.com</a></font><br style=3D"font-size:12.8px=
"><span style=3D"font-size:12.8px">______________________________</span><sp=
an style=3D"font-size:12.8px">___________</span><br></div></div></div>

--0000000000009a426d0577af37be--

--===============7514122457854215642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7514122457854215642==--
