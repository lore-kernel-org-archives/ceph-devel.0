From: Mohamed Pakkeer <mdfakkeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: CephFs - Ceph-fuse Client Read Performance During
	Cache Tier Flushing
Date: Sun, 26 Apr 2015 11:28:24 +0530
Message-ID: <CAN7LZ4GUxgWH+eMZVrxMgxxBVQYAdG3EvUZqOA5VtdttftSvFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1155801442=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1155801442==
Content-Type: multipart/alternative; boundary=047d7b3a7f7e443e7105149a517b

--047d7b3a7f7e443e7105149a517b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

 I was doing some testing on erasure coded based CephFS cluster. cluster is
running with giant 0.87.1 release.



Cluster info

15 * 36 drives node(journal on same osd)

3 * 4 drives SSD cache node( Intel DC3500)

3 * MON/MDS

EC 10 +3

10G Ethernet for private and cluster network



We got approx. 55MB/s read transfer speed using ceph-fuse client, when the
data was available on cache tier( cold storage was empty). When I tried to
add more data, ceph started the flushing the data from cache tier to cold
storage. During flushing, cluster read speed became approx 100 KB/s. But I
got 50 =E2=80=93 55MB/s write transfer speed during flushing from multiple
simultaneous ceph-fuse client( 1G Ethernet). I think there is an issue on
data migration from cold storage to cache tier during ceph-fuse client
read. Am I hitting any known issue/bug or is there any issue with my
cluster?



I used big video files( approx 5 GB to 10 GB) for this testing .



Any help ?

Cheers
K.Mohamed Pakkeer

--047d7b3a7f7e443e7105149a517b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal">Hi </p>

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

<p class=3D"MsoNormal">Any help ?</p><div><br></div><div class=3D"gmail_sig=
nature">Cheers =C2=A0=C2=A0<br><span>K.</span>Mohamed <span>Pakkeer</span><=
br><br><br></div>
</div>

--047d7b3a7f7e443e7105149a517b--

--===============1155801442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1155801442==--
