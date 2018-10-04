From: Brett Chancellor <bchancellor-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
Subject: Re: hardware heterogeneous in same pool
Date: Thu, 4 Oct 2018 13:18:59 -0400
Message-ID: <CADuVtVBB9g8Gye-sV1FvoEXtH8v3rN-y6qqo7d15ycduSrdKmg@mail.gmail.com>
References: <CAL040-j2xziD6WGd7yqJc08sQfO0g5Qru0f-7maCxbqAq4EayQ@mail.gmail.com>
 <CAA6-MF8qKOeJRzBm0rsieFK_aWbWS1PMWUhTDMGgVx1iSc88wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6664672969733160748=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAA6-MF8qKOeJRzBm0rsieFK_aWbWS1PMWUhTDMGgVx1iSc88wQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============6664672969733160748==
Content-Type: multipart/alternative; boundary="0000000000006c8bde05776a5a26"

--0000000000006c8bde05776a5a26
Content-Type: text/plain; charset="UTF-8"

You could also set *osd_crush_initial_weight = 0 . *New OSDs will
automatically come up with a 0 weight and you won't have to race the clock.

-Brett

On Thu, Oct 4, 2018 at 3:50 AM Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>
>
> Den tors 4 okt. 2018 kl 00:09 skrev Bruno Carvalho <brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
>> Hi Cephers, I would like to know how you are growing the cluster.
>> Using dissimilar hardware in the same pool or creating a pool for each
>> different hardware group.
>> What problem would I have many problems using different hardware (CPU,
>> memory, disk) in the same pool?
>
>
> I don't think CPU and RAM (and other hw related things like HBA controller
> card brand) matters
> a lot, more is always nicer, but as long as you don't add worse machines
> like Jonathan wrote you
> should not see any degradation.
>
> What you might want to look out for is if the new disks are very uneven
> compared to the old
> setup, so if you used to have servers with 10x2TB drives and suddenly add
> one with 2x10TB,
> things might become very unbalanced, since those differences will not be
> handled seamlessly
> by the crush map.
>
> Apart from that, the only issues for us is "add drives, quickly set crush
> reweight to 0.0 before
> all existing OSD hosts shoot massive amounts of I/O on them, then script a
> slower raise of
> crush weight upto what they should end up at", to lessen the impact for
> our 24/7 operations.
>
> If you have weekends where noone accesses the cluster or night-time low-IO
> usage patterns,
> just upping the weight at the right hour might suffice.
>
> Lastly, for ssd/nvme setups with good networking, this is almost moot,
> they converge so fast
> its almost unfair. A real joy working with expanding flash-only
> pools/clusters.
>
> --
> May the most significant bit of your life be positive.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000006c8bde05776a5a26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You could also set=C2=A0<i style=3D"color:rgb(0,0,0);white=
-space:pre-wrap">osd_crush_initial_weight =3D 0 . </i><span style=3D"color:=
rgb(0,0,0);white-space:pre-wrap">New OSDs will automatically come up with a=
 0 weight and you won&#39;t have to race the clock.</span><div><span style=
=3D"color:rgb(0,0,0);white-space:pre-wrap"><br></span></div><div><span styl=
e=3D"color:rgb(0,0,0);white-space:pre-wrap">-Brett</span></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Oct 4, 2018 at 3:50 AM Ja=
nne Johansson &lt;<a href=3D"mailto:icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">icepic.dz-Re5JQEeQqe8@public.gmane.org=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><=
br><br><div class=3D"gmail_quote"><div dir=3D"ltr">Den tors 4 okt. 2018 kl =
00:09 skrev Bruno Carvalho &lt;<a href=3D"mailto:brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">Hi Cephers, I would like to know how you are growing the cluster.<br>
Using dissimilar hardware in the same pool or creating a pool for each<br>
different hardware group.<br>
What problem would I have many problems using different hardware (CPU,<br>
memory, disk) in the same pool?</blockquote><div>=C2=A0</div><div>I don&#39=
;t think CPU and RAM (and other hw related things like HBA controller card =
brand) matters</div><div>a lot, more is always nicer, but as long as you do=
n&#39;t add worse machines like Jonathan wrote you</div><div>should not see=
 any degradation.</div><div><br></div><div>What you might want to look out =
for is if the new disks are very uneven compared to the old</div><div>setup=
, so if you used to have servers with 10x2TB drives and suddenly add one wi=
th 2x10TB,</div><div>things might become very unbalanced, since those diffe=
rences will not be handled seamlessly</div><div>by the crush map.</div></di=
v><div><br></div>Apart from that, the only issues for us is &quot;add drive=
s, quickly set crush reweight to 0.0 before<div>all existing OSD hosts shoo=
t massive amounts of I/O on them, then script a slower raise of</div><div>c=
rush weight upto what they should end up at&quot;, to lessen the impact for=
 our 24/7 operations.</div><div><br></div><div>If you have weekends where n=
oone accesses the cluster or night-time low-IO usage patterns,</div><div>ju=
st upping the weight at the right hour might suffice.<br clear=3D"all"><div=
><br></div><div>Lastly, for ssd/nvme setups with good networking, this is a=
lmost moot, they converge so fast</div><div>its almost unfair. A real joy w=
orking with expanding flash-only pools/clusters.</div><div><br></div>-- <br=
><div dir=3D"ltr" class=3D"m_3259247718011509024gmail_signature" data-smart=
mail=3D"gmail_signature">May the most significant bit of your life be posit=
ive.<br></div></div></div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--0000000000006c8bde05776a5a26--

--===============6664672969733160748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6664672969733160748==--
