From: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: hardware heterogeneous in same pool
Date: Thu, 4 Oct 2018 09:50:02 +0200
Message-ID: <CAA6-MF8qKOeJRzBm0rsieFK_aWbWS1PMWUhTDMGgVx1iSc88wQ@mail.gmail.com>
References: <CAL040-j2xziD6WGd7yqJc08sQfO0g5Qru0f-7maCxbqAq4EayQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0649420126875437524=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAL040-j2xziD6WGd7yqJc08sQfO0g5Qru0f-7maCxbqAq4EayQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0649420126875437524==
Content-Type: multipart/alternative; boundary="000000000000b8a142057762672c"

--000000000000b8a142057762672c
Content-Type: text/plain; charset="UTF-8"

Den tors 4 okt. 2018 kl 00:09 skrev Bruno Carvalho <brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> Hi Cephers, I would like to know how you are growing the cluster.
> Using dissimilar hardware in the same pool or creating a pool for each
> different hardware group.
> What problem would I have many problems using different hardware (CPU,
> memory, disk) in the same pool?


I don't think CPU and RAM (and other hw related things like HBA controller
card brand) matters
a lot, more is always nicer, but as long as you don't add worse machines
like Jonathan wrote you
should not see any degradation.

What you might want to look out for is if the new disks are very uneven
compared to the old
setup, so if you used to have servers with 10x2TB drives and suddenly add
one with 2x10TB,
things might become very unbalanced, since those differences will not be
handled seamlessly
by the crush map.

Apart from that, the only issues for us is "add drives, quickly set crush
reweight to 0.0 before
all existing OSD hosts shoot massive amounts of I/O on them, then script a
slower raise of
crush weight upto what they should end up at", to lessen the impact for our
24/7 operations.

If you have weekends where noone accesses the cluster or night-time low-IO
usage patterns,
just upping the weight at the right hour might suffice.

Lastly, for ssd/nvme setups with good networking, this is almost moot, they
converge so fast
its almost unfair. A real joy working with expanding flash-only
pools/clusters.

-- 
May the most significant bit of your life be positive.

--000000000000b8a142057762672c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">Den to=
rs 4 okt. 2018 kl 00:09 skrev Bruno Carvalho &lt;<a href=3D"mailto:brunowcs=
@gmail.com">brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br></div><blockquote class=3D"gmail=
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
><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signatu=
re">May the most significant bit of your life be positive.<br></div></div><=
/div>

--000000000000b8a142057762672c--

--===============0649420126875437524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0649420126875437524==--
