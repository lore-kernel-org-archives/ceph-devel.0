From: Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: using cache-tier with writeback mode,
 raods bench result degrade
Date: Fri, 08 Jan 2016 16:13:36 +0000
Message-ID: <CA+e22Ser8H0YDQDDVEwO0Mk7H0eDzzYonUbDyko-FGD1-LvnUg@mail.gmail.com>
References: <op.yaxfgsdp6jkj1f@zhoulindemacbook-pro.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1280796221=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <op.yaxfgsdp6jkj1f-Azv1iiBWqJVWD3n+koEi8Ve7Yu2RT3cRrNQQ6b5fDX0@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: hnuzhoulin <hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1280796221==
Content-Type: multipart/alternative; boundary=001a113fe5b624e57e0528d4dfaa

--001a113fe5b624e57e0528d4dfaa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

My experience is performance degrades dramatically when dirty objects are
flushed.

Best Regards,
Wade


On Fri, Jan 8, 2016 at 11:08 AM hnuzhoulin <hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi,guyes
> Recentlly,I am testing  cache-tier using writeback mode.but I found a
> strange things.
> the performance  using rados bench degrade.Is it correct?
> If so,how to explain.following some info about my test:
>
> storage node:4 machine,two INTEL SSDSC2BB120G4(one for systaem,the other
> one used as OSD),four sata as OSD.
>
> before using cache-tier:
> root@ceph1:~# rados bench -p coldstorage 300 write --no-cleanup
> ----------------------------------------------------------------
> Total time run:         301.236355
> Total writes made:      6041
> Write size:             4194304
> Bandwidth (MB/sec):     80.216
>
> Stddev Bandwidth:       10.5358
> Max bandwidth (MB/sec): 104
> Min bandwidth (MB/sec): 0
> Average Latency:        0.797838
> Stddev Latency:         0.619098
> Max latency:            4.89823
> Min latency:            0.158543
>
> root@ceph1:/root/cluster# rados bench -p coldstorage  300 seq
> Total time run:        133.563980
> Total reads made:     6041
> Read size:            4194304
> Bandwidth (MB/sec):    180.917
>
> Average Latency:       0.353559
> Max latency:           1.83356
> Min latency:           0.027878
>
> after configure cache-tier:
> root@ubuntu:~/benchmarkcollect/Monitor# ceph osd tier add coldstorage
> hotstorage
> pool 'hotstorage' is now (or already was) a tier of 'coldstorage'
>
> root@ubuntu:~/benchmarkcollect/Monitor# ceph osd tier cache-mode
> hotstorage writeback
> set cache-mode for pool 'hotstorage' to writeback
>
> root@ubuntu:~/benchmarkcollect/Monitor# ceph osd tier set-overlay
> coldstorage hotstorage
> overlay for 'coldstorage' is now (or already was) 'hotstorage'
>
> oot@ubuntu:~# ceph osd dump|grep storage
> pool 6 'coldstorage' replicated size 3 min_size 1 crush_ruleset 0
> object_hash rjenkins pg_num 512 pgp_num 512 last_change 216 lfor 216 flag=
s
> hashpspool tiers 7 read_tier 7 write_tier 7 stripe_width 0
> pool 7 'hotstorage' replicated size 3 min_size 1 crush_ruleset 1
> object_hash rjenkins pg_num 128 pgp_num 128 last_change 228 flags
> hashpspool,incomplete_clones tier_of 6 cache_mode writeback target_bytes
> 100000000000 hit_set bloom{false_positive_probability: 0.05, target_size:
> 0, seed: 0} 3600s x6 stripe_width 0
> -------------------------------------------------------------
> rados bench -p coldstorage 300 write --no-cleanup
> Total time run: 302.207573
> Total writes made: 4315
> Write size: 4194304
> Bandwidth (MB/sec): 57.113
>
> Stddev Bandwidth: 23.9375
> Max bandwidth (MB/sec): 104
> Min bandwidth (MB/sec): 0
> Average Latency: 1.1204
> Stddev Latency: 0.717092
> Max latency: 6.97288
> Min latency: 0.158371
>
> root@ubuntu:/# rados bench -p coldstorage 300 seq
> Total time run: 153.869741
> Total reads made: 4315
> Read size: 4194304
> Bandwidth (MB/sec): 112.173
>
> Average Latency: 0.570487
> Max latency: 1.75137
> Min latency: 0.039635
>
>
> ceph.conf:
> --------------------------------------------
> [global]
> fsid =3D 4ec1eb64-226c-4d90-8c5c-b6b6644be831
> mon_initial_members =3D ceph2, ceph3, ceph4
> mon_host =3D 10.**.**.241,10.**.**.242,10.**.**.243
> auth_cluster_required =3D cephx
> auth_service_required =3D cephx
> auth_client_required =3D cephx
> filestore_xattr_use_omap =3D true
> osd_pool_default_size =3D 3
> osd_pool_default_min_size =3D 1
> auth_supported =3D cephx
> osd_journal_size =3D 10240
> osd_mkfs_type =3D xfs
> osd crush update on start =3D false
>
> [client]
> rbd_cache =3D true
> rbd_cache_writethrough_until_flush =3D false
> rbd_cache_size =3D 33554432
> rbd_cache_max_dirty =3D 25165824
> rbd_cache_target_dirty =3D 16777216
> rbd_cache_max_dirty_age =3D 1
> rbd_cache_block_writes_upfront =3D false
> [osd]
> filestore_omap_header_cache_size =3D 40000
> filestore_fd_cache_size =3D 40000
> filestore_fiemap =3D true
> client_readahead_min =3D 2097152
> client_readahead_max_bytes =3D 0
> client_readahead_max_periods =3D 4
> filestore_journal_writeahead =3D false
> filestore_max_sync_interval =3D 10
> filestore_queue_max_ops =3D 500
> filestore_queue_max_bytes =3D 1048576000
> filestore_queue_committing_max_ops =3D 5000
> filestore_queue_committing_max_bytes =3D 1048576000
> keyvaluestore_queue_max_ops =3D 500
> keyvaluestore_queue_max_bytes =3D 1048576000
> journal_queue_max_ops =3D 30000
> journal_queue_max_bytes =3D 3355443200
> osd_op_threads =3D 20
> osd_disk_threads =3D 8
> filestore_op_threads =3D 4
> osd_mount_options_xfs =3D rw,noatime,nobarrier,inode64,logbsize=3D256k,de=
laylog
>
> [mon]
> mon_osd_allow_primary_affinity=3Dtrue
>
> --
> =E4=BD=BF=E7=94=A8Opera=E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=
=AE=A2=E6=88=B7=E7=AB=AF=EF=BC=9Ahttp://www.opera.com/mail/
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113fe5b624e57e0528d4dfaa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">My experience is performance degrades dramatically when di=
rty objects are flushed.=C2=A0<div><br></div><div>Best Regards,</div><div>W=
ade</div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r">On Fri, Jan 8, 2016 at 11:08 AM hnuzhoulin &lt;<a href=3D"mailto:hnuzhou=
lin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">Hi,guyes<br>
Recentlly,I am testing=C2=A0 cache-tier using writeback mode.but I found a<=
br>
strange things.<br>
the performance=C2=A0 using rados bench degrade.Is it correct?<br>
If so,how to explain.following some info about my test:<br>
<br>
storage node:4 machine,two INTEL SSDSC2BB120G4(one for systaem,the other<br=
>
one used as OSD),four sata as OSD.<br>
<br>
before using cache-tier:<br>
root@ceph1:~# rados bench -p coldstorage 300 write --no-cleanup<br>
----------------------------------------------------------------<br>
Total time run:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0301.236355<br>
Total writes made:=C2=A0 =C2=A0 =C2=A0 6041<br>
Write size:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04194304<br>
Bandwidth (MB/sec):=C2=A0 =C2=A0 =C2=A080.216<br>
<br>
Stddev Bandwidth:=C2=A0 =C2=A0 =C2=A0 =C2=A010.5358<br>
Max bandwidth (MB/sec): 104<br>
Min bandwidth (MB/sec): 0<br>
Average Latency:=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.797838<br>
Stddev Latency:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.619098<br>
Max latency:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4.89823<br>
Min latency:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.158543<br>
<br>
root@ceph1:/root/cluster# rados bench -p coldstorage=C2=A0 300 seq<br>
Total time run:=C2=A0 =C2=A0 =C2=A0 =C2=A0 133.563980<br>
Total reads made:=C2=A0 =C2=A0 =C2=A06041<br>
Read size:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4194304<br>
Bandwidth (MB/sec):=C2=A0 =C2=A0 180.917<br>
<br>
Average Latency:=C2=A0 =C2=A0 =C2=A0 =C2=A00.353559<br>
Max latency:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.83356<br>
Min latency:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.027878<br>
<br>
after configure cache-tier:<br>
root@ubuntu:~/benchmarkcollect/Monitor# ceph osd tier add coldstorage<br>
hotstorage<br>
pool &#39;hotstorage&#39; is now (or already was) a tier of &#39;coldstorag=
e&#39;<br>
<br>
root@ubuntu:~/benchmarkcollect/Monitor# ceph osd tier cache-mode<br>
hotstorage writeback<br>
set cache-mode for pool &#39;hotstorage&#39; to writeback<br>
<br>
root@ubuntu:~/benchmarkcollect/Monitor# ceph osd tier set-overlay<br>
coldstorage hotstorage<br>
overlay for &#39;coldstorage&#39; is now (or already was) &#39;hotstorage&#=
39;<br>
<br>
oot@ubuntu:~# ceph osd dump|grep storage<br>
pool 6 &#39;coldstorage&#39; replicated size 3 min_size 1 crush_ruleset 0<b=
r>
object_hash rjenkins pg_num 512 pgp_num 512 last_change 216 lfor 216 flags<=
br>
hashpspool tiers 7 read_tier 7 write_tier 7 stripe_width 0<br>
pool 7 &#39;hotstorage&#39; replicated size 3 min_size 1 crush_ruleset 1<br=
>
object_hash rjenkins pg_num 128 pgp_num 128 last_change 228 flags<br>
hashpspool,incomplete_clones tier_of 6 cache_mode writeback target_bytes<br=
>
100000000000 hit_set bloom{false_positive_probability: 0.05, target_size:<b=
r>
0, seed: 0} 3600s x6 stripe_width 0<br>
-------------------------------------------------------------<br>
rados bench -p coldstorage 300 write --no-cleanup<br>
Total time run: 302.207573<br>
Total writes made: 4315<br>
Write size: 4194304<br>
Bandwidth (MB/sec): 57.113<br>
<br>
Stddev Bandwidth: 23.9375<br>
Max bandwidth (MB/sec): 104<br>
Min bandwidth (MB/sec): 0<br>
Average Latency: 1.1204<br>
Stddev Latency: 0.717092<br>
Max latency: 6.97288<br>
Min latency: 0.158371<br>
<br>
root@ubuntu:/# rados bench -p coldstorage 300 seq<br>
Total time run: 153.869741<br>
Total reads made: 4315<br>
Read size: 4194304<br>
Bandwidth (MB/sec): 112.173<br>
<br>
Average Latency: 0.570487<br>
Max latency: 1.75137<br>
Min latency: 0.039635<br>
<br>
<br>
ceph.conf:<br>
--------------------------------------------<br>
[global]<br>
fsid =3D 4ec1eb64-226c-4d90-8c5c-b6b6644be831<br>
mon_initial_members =3D ceph2, ceph3, ceph4<br>
mon_host =3D 10.**.**.241,10.**.**.242,10.**.**.243<br>
auth_cluster_required =3D cephx<br>
auth_service_required =3D cephx<br>
auth_client_required =3D cephx<br>
filestore_xattr_use_omap =3D true<br>
osd_pool_default_size =3D 3<br>
osd_pool_default_min_size =3D 1<br>
auth_supported =3D cephx<br>
osd_journal_size =3D 10240<br>
osd_mkfs_type =3D xfs<br>
osd crush update on start =3D false<br>
<br>
[client]<br>
rbd_cache =3D true<br>
rbd_cache_writethrough_until_flush =3D false<br>
rbd_cache_size =3D 33554432<br>
rbd_cache_max_dirty =3D 25165824<br>
rbd_cache_target_dirty =3D 16777216<br>
rbd_cache_max_dirty_age =3D 1<br>
rbd_cache_block_writes_upfront =3D false<br>
[osd]<br>
filestore_omap_header_cache_size =3D 40000<br>
filestore_fd_cache_size =3D 40000<br>
filestore_fiemap =3D true<br>
client_readahead_min =3D 2097152<br>
client_readahead_max_bytes =3D 0<br>
client_readahead_max_periods =3D 4<br>
filestore_journal_writeahead =3D false<br>
filestore_max_sync_interval =3D 10<br>
filestore_queue_max_ops =3D 500<br>
filestore_queue_max_bytes =3D 1048576000<br>
filestore_queue_committing_max_ops =3D 5000<br>
filestore_queue_committing_max_bytes =3D 1048576000<br>
keyvaluestore_queue_max_ops =3D 500<br>
keyvaluestore_queue_max_bytes =3D 1048576000<br>
journal_queue_max_ops =3D 30000<br>
journal_queue_max_bytes =3D 3355443200<br>
osd_op_threads =3D 20<br>
osd_disk_threads =3D 8<br>
filestore_op_threads =3D 4<br>
osd_mount_options_xfs =3D rw,noatime,nobarrier,inode64,logbsize=3D256k,dela=
ylog<br>
<br>
[mon]<br>
mon_osd_allow_primary_affinity=3Dtrue<br>
<br>
--<br>
=E4=BD=BF=E7=94=A8Opera=E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=AE=
=A2=E6=88=B7=E7=AB=AF=EF=BC=9A<a href=3D"http://www.opera.com/mail/" rel=3D=
"noreferrer" target=3D"_blank">http://www.opera.com/mail/</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--001a113fe5b624e57e0528d4dfaa--

--===============1280796221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1280796221==--
