From: Mohamed Pakkeer <mdfakkeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CephFs - Ceph-fuse Client Read Performance During
	Cache Tier Flushing
Date: Mon, 27 Apr 2015 21:04:27 +0530
Message-ID: <CAN7LZ4FpViaQyBJBBpLvmdVZpAmgrRc-JmpX-UCtt-LDrYdCUw@mail.gmail.com>
References: <CAN7LZ4GUxgWH+eMZVrxMgxxBVQYAdG3EvUZqOA5VtdttftSvFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0837866726=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN7LZ4GUxgWH+eMZVrxMgxxBVQYAdG3EvUZqOA5VtdttftSvFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0837866726==
Content-Type: multipart/alternative; boundary=001a1137947a3b21380514b67b2d

--001a1137947a3b21380514b67b2d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all

The issue is resolved after upgrading Ceph from Giant to Hammer(0.94.1)

cheers
K.Mohamed Pakkeer

On Sun, Apr 26, 2015 at 11:28 AM, Mohamed Pakkeer <mdfakkeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi
>
>  I was doing some testing on erasure coded based CephFS cluster. cluster
> is running with giant 0.87.1 release.
>
>
>
> Cluster info
>
> 15 * 36 drives node(journal on same osd)
>
> 3 * 4 drives SSD cache node( Intel DC3500)
>
> 3 * MON/MDS
>
> EC 10 +3
>
> 10G Ethernet for private and cluster network
>
>
>
> We got approx. 55MB/s read transfer speed using ceph-fuse client, when th=
e
> data was available on cache tier( cold storage was empty). When I tried t=
o
> add more data, ceph started the flushing the data from cache tier to cold
> storage. During flushing, cluster read speed became approx 100 KB/s. But =
I
> got 50 =E2=80=93 55MB/s write transfer speed during flushing from multipl=
e
> simultaneous ceph-fuse client( 1G Ethernet). I think there is an issue on
> data migration from cold storage to cache tier during ceph-fuse client
> read. Am I hitting any known issue/bug or is there any issue with my
> cluster?
>
>
>
> I used big video files( approx 5 GB to 10 GB) for this testing .
>
>
>
> Any help ?
>
> Cheers
> K.Mohamed Pakkeer
>
>
>


--=20
Thanks & Regards
K.Mohamed Pakkeer
Mobile- 0091-8754410114

--001a1137947a3b21380514b67b2d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all<div><br></div><div>The issue is resolved after upgr=
ading Ceph from Giant to Hammer(0.94.1)</div><div><br></div><div>cheers</di=
v><div>K.Mohamed Pakkeer</div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Sun, Apr 26, 2015 at 11:28 AM, Mohamed Pakkeer <span =
dir=3D"ltr">&lt;<a href=3D"mailto:mdfakkeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">md=
fakkeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div dir=3D"ltr"><p class=3D"MsoNormal">Hi </p>

<p class=3D"MsoNormal">=C2=A0I was doing some testing
on erasure coded based CephFS cluster. cluster is running with giant 0.87.1
release. </p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">Cluster info</p>

<p class=3D"MsoNormal">15 * 36 drives node(journal on same osd)</p>

<p class=3D"MsoNormal">3 * 4 drives SSD cache node( Intel DC3500)</p>

<p class=3D"MsoNormal">3 * MON/MDS</p>

<p class=3D"MsoNormal">EC 10 +3</p><p class=3D"MsoNormal">10G Ethernet for =
private and cluster network</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">We got approx. 55MB/s read transfer speed using ceph=
-fuse
client, when the data was available on cache tier( cold storage was empty).=
 When
I tried to add more data, ceph started the flushing the data from cache tie=
r to
cold storage. During flushing, cluster read speed became approx 100 KB/s. B=
ut I
got 50 =E2=80=93 55MB/s write transfer speed during flushing from multiple =
simultaneous
ceph-fuse client( 1G Ethernet). I think there is an issue on data migration=
 from
cold storage to cache tier during ceph-fuse client read. Am I hitting any k=
nown
issue/bug or is there any issue with my cluster?</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">I used big video files( approx 5 GB to 10 GB) for th=
is
testing .</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">Any help ?</p><div><br></div><div>Cheers =C2=A0=C2=
=A0<br><span>K.</span>Mohamed <span>Pakkeer</span><br><br><br></div>
</div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Thanks &amp; Regards=C2=A0 =C2=A0 <br><span>K.</span>M=
ohamed <span>Pakkeer</span><br>Mobile- 0091-8754410114<br><br></div>
</div>

--001a1137947a3b21380514b67b2d--

--===============0837866726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0837866726==--
