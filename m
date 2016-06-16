From: Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
	objects in pool
Date: Thu, 16 Jun 2016 14:30:21 +0000
Message-ID: <CA+e22SfR0YrXdyM9+Na4zjCWCi8m8o2osSP1AcyhFEyyYekjag@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<CA+z5Dsz=e1N9RxRoF5Wao8Dogf_S1UstNZaCJ=oj-efj83HBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1959993115=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5Dsz=e1N9RxRoF5Wao8Dogf_S1UstNZaCJ=oj-efj83HBig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1959993115==
Content-Type: multipart/alternative; boundary=001a113947848a161f0535661497

--001a113947848a161f0535661497
Content-Type: text/plain; charset=UTF-8

Blairo,

Thats right, I do see "lots" of READ IO!  If I compare the "bad (330Mil)"
pool, with the new test (good) pool:

iostat while running to the "good" pool shows almost all writes.
iostat while running to the "bad" pool has VERY large read spikes, with
almost no writes.

Sounds like you have an idea about what causes this.  I'm happy to hear it!

slabinfo is below.  Drop caches has no affect.

slabinfo - version: 2.1

# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata
<active_slabs> <num_slabs> <sharedavail>

blk_io_mits         4674   4769   1664   19    8 : tunables    0    0    0
: slabdata    251    251      0

rpc_inode_cache        0      0    640   51    8 : tunables    0    0    0
: slabdata      0      0      0

t10_alua_tg_pt_gp_cache      0      0    408   40    4 : tunables    0    0
  0 : slabdata      0      0      0

t10_pr_reg_cache       0      0    696   47    8 : tunables    0    0    0
: slabdata      0      0      0

se_sess_cache          0      0    896   36    8 : tunables    0    0    0
: slabdata      0      0      0

kvm_vcpu               0      0  16256    2    8 : tunables    0    0    0
: slabdata      0      0      0

kvm_mmu_page_header     48     48    168   48    2 : tunables    0    0    0
: slabdata      1      1      0

xfs_dqtrx              0      0    528   62    8 : tunables    0    0    0
: slabdata      0      0      0

xfs_dquot              0      0    472   69    8 : tunables    0    0    0
: slabdata      0      0      0

xfs_icr                0      0    144   56    2 : tunables    0    0    0
: slabdata      0      0      0

xfs_ili           96974261 97026835    152   53    2 : tunables    0    0
  0 : slabdata 1830695 1830695      0

xfs_inode         97120263 97120263   1088   30    8 : tunables    0    0
  0 : slabdata 3237631 3237631      0

xfs_efd_item        6280   6360    400   40    4 : tunables    0    0    0
: slabdata    159    159      0

xfs_da_state        3264   3264    480   68    8 : tunables    0    0    0
: slabdata     48     48      0

xfs_btree_cur       1872   1872    208   39    2 : tunables    0    0    0
: slabdata     48     48      0

xfs_log_ticket     23980  23980    184   44    2 : tunables    0    0    0
: slabdata    545    545      0

scsi_cmd_cache      4536   4644    448   36    4 : tunables    0    0    0
: slabdata    129    129      0

kcopyd_job             0      0   3312    9    8 : tunables    0    0    0
: slabdata      0      0      0

dm_uevent              0      0   2608   12    8 : tunables    0    0    0
: slabdata      0      0      0

dm_rq_target_io        0      0    136   60    2 : tunables    0    0    0
: slabdata      0      0      0

UDPLITEv6              0      0   1152   28    8 : tunables    0    0    0
: slabdata      0      0      0

UDPv6                980    980   1152   28    8 : tunables    0    0    0
: slabdata     35     35      0

tw_sock_TCPv6          0      0    256   64    4 : tunables    0    0    0
: slabdata      0      0      0

TCPv6                510    510   2112   15    8 : tunables    0    0    0
: slabdata     34     34      0

uhci_urb_priv       6132   6132     56   73    1 : tunables    0    0    0
: slabdata     84     84      0

cfq_queue          64153  97300    232   70    4 : tunables    0    0    0
: slabdata   1390   1390      0

bsg_cmd                0      0    312   52    4 : tunables    0    0    0
: slabdata      0      0      0

mqueue_inode_cache     36     36    896   36    8 : tunables    0    0    0
: slabdata      1      1      0

hugetlbfs_inode_cache    106    106    608   53    8 : tunables    0    0
  0 : slabdata      2      2      0

configfs_dir_cache     46     46     88   46    1 : tunables    0    0    0
: slabdata      1      1      0

dquot                  0      0    256   64    4 : tunables    0    0    0
: slabdata      0      0      0

kioctx              1512   1512    576   56    8 : tunables    0    0    0
: slabdata     27     27      0

userfaultfd_ctx_cache      0      0    128   64    2 : tunables    0    0
  0 : slabdata      0      0      0

pid_namespace          0      0   2176   15    8 : tunables    0    0    0
: slabdata      0      0      0

user_namespace         0      0    280   58    4 : tunables    0    0    0
: slabdata      0      0      0

posix_timers_cache      0      0    248   66    4 : tunables    0    0    0
: slabdata      0      0      0

UDP-Lite               0      0   1024   32    8 : tunables    0    0    0
: slabdata      0      0      0

RAW                 1972   1972    960   34    8 : tunables    0    0    0
: slabdata     58     58      0

UDP                 1472   1504   1024   32    8 : tunables    0    0    0
: slabdata     47     47      0

tw_sock_TCP         6272   6400    256   64    4 : tunables    0    0    0
: slabdata    100    100      0

TCP                 5236   5457   1920   17    8 : tunables    0    0    0
: slabdata    321    321      0

blkdev_queue         421    465   2088   15    8 : tunables    0    0    0
: slabdata     31     31      0

blkdev_requests   36137670 39504234    384   42    4 : tunables    0    0
  0 : slabdata 940577 940577      0

blkdev_ioc          2106   2106    104   39    1 : tunables    0    0    0
: slabdata     54     54      0

fsnotify_event_holder   8160   8160     24  170    1 : tunables    0    0
  0 : slabdata     48     48      0

fsnotify_event     37128  37128    120   68    2 : tunables    0    0    0
: slabdata    546    546      0

sock_inode_cache   11985  11985    640   51    8 : tunables    0    0    0
: slabdata    235    235      0

net_namespace          0      0   4608    7    8 : tunables    0    0    0
: slabdata      0      0      0

shmem_inode_cache   5040   5040    680   48    8 : tunables    0    0    0
: slabdata    105    105      0

Acpi-ParseExt     116256 116256     72   56    1 : tunables    0    0    0
: slabdata   2076   2076      0

Acpi-Namespace     14586  14586     40  102    1 : tunables    0    0    0
: slabdata    143    143      0

taskstats           2352   2352    328   49    4 : tunables    0    0    0
: slabdata     48     48      0

proc_inode_cache  146512 146706    656   49    8 : tunables    0    0    0
: slabdata   2994   2994      0

sigqueue            2448   2448    160   51    2 : tunables    0    0    0
: slabdata     48     48      0

bdev_cache          1872   1872    832   39    8 : tunables    0    0    0
: slabdata     48     48      0

sysfs_dir_cache   172296 172296    112   36    1 : tunables    0    0    0
: slabdata   4786   4786      0

inode_cache        17550  17820    592   55    8 : tunables    0    0    0
: slabdata    324    324      0

dentry            63799847 86138682    192   42    2 : tunables    0    0
  0 : slabdata 2050921 2050921      0

iint_cache             0      0     80   51    1 : tunables    0    0    0
: slabdata      0      0      0

selinux_inode_security  41920  42636     80   51    1 : tunables    0    0
  0 : slabdata    836    836      0

buffer_head       28851697 32477250    104   39    1 : tunables    0    0
  0 : slabdata 832750 832750      0

vm_area_struct     36548  38665    216   37    2 : tunables    0    0    0
: slabdata   1045   1045      0

mm_struct           1120   1120   1600   20    8 : tunables    0    0    0
: slabdata     56     56      0

files_cache         2703   2703    640   51    8 : tunables    0    0    0
: slabdata     53     53      0

signal_cache        5109   5376   1152   28    8 : tunables    0    0    0
: slabdata    192    192      0

sighand_cache       3241   3345   2112   15    8 : tunables    0    0    0
: slabdata    223    223      0

task_xstate        14118  14937    832   39    8 : tunables    0    0    0
: slabdata    383    383      0

task_struct         9295  10538   2944   11    8 : tunables    0    0    0
: slabdata    958    958      0

anon_vma           30400  30400     64   64    1 : tunables    0    0    0
: slabdata    475    475      0

shared_policy_node   5780   5780     48   85    1 : tunables    0    0    0
: slabdata     68     68      0

numa_policy          620    620    264   62    4 : tunables    0    0    0
: slabdata     10     10      0

radix_tree_node   10364872 10364872    584   56    8 : tunables    0    0
  0 : slabdata 185087 185087      0

idr_layer_cache     1185   1185   2112   15    8 : tunables    0    0    0
: slabdata     79     79      0

dma-kmalloc-8192       0      0   8192    4    8 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-4096       0      0   4096    8    8 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-2048       0      0   2048   16    8 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-1024       0      0   1024   32    8 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-512        0      0    512   64    8 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-256        0      0    256   64    4 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-128        0      0    128   64    2 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-64         0      0     64   64    1 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-32         0      0     32  128    1 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-16         0      0     16  256    1 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-8          0      0      8  512    1 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-192        0      0    192   42    2 : tunables    0    0    0
: slabdata      0      0      0

dma-kmalloc-96         0      0     96   42    1 : tunables    0    0    0
: slabdata      0      0      0

kmalloc-8192         588    680   8192    4    8 : tunables    0    0    0
: slabdata    170    170      0

kmalloc-4096        6374   6424   4096    8    8 : tunables    0    0    0
: slabdata    803    803      0

kmalloc-2048       60889  63744   2048   16    8 : tunables    0    0    0
: slabdata   3984   3984      0

kmalloc-1024       27406  32448   1024   32    8 : tunables    0    0    0
: slabdata   1014   1014      0

kmalloc-512       96841607 96891536    512   64    8 : tunables    0    0
  0 : slabdata 1513967 1513967      0

kmalloc-256        73414 108736    256   64    4 : tunables    0    0    0
: slabdata   1699   1699      0

kmalloc-192        32870  33432    192   42    2 : tunables    0    0    0
: slabdata    796    796      0

kmalloc-128        64128  92736    128   64    2 : tunables    0    0    0
: slabdata   1449   1449      0

kmalloc-96          9350   9618     96   42    1 : tunables    0    0    0
: slabdata    229    229      0

kmalloc-64        159325477 194832256     64   64    1 : tunables    0    0
  0 : slabdata 3044254 3044254      0

kmalloc-32         24960  24960     32  128    1 : tunables    0    0    0
: slabdata    195    195      0

kmalloc-16         45312  45312     16  256    1 : tunables    0    0    0
: slabdata    177    177      0

kmalloc-8          51712  51712      8  512    1 : tunables    0    0    0
: slabdata    101    101      0

kmem_cache_node      741    768     64   64    1 : tunables    0    0    0
: slabdata     12     12      0

kmem_cache           640    640    256   64    4 : tunables    0    0    0
: slabdata     10     10      0

On Thu, Jun 16, 2016 at 8:48 AM Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi Wade,
>
> What IO are you seeing on the OSD devices when this happens (see e.g.
> iostat), are there short periods of high read IOPS where (almost) no
> writes occur? What does your memory usage look like (including slab)?
>
> Cheers,
>
> On 16 June 2016 at 22:14, Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi All,
> >
> > I have a repeatable condition when the object count in a pool gets to
> > 320-330 million the object write time dramatically and almost
> > instantly increases as much as 10X, exhibited by fs_apply_latency
> > going from 10ms to 100s of ms.
> >
> > Can someone point me in a direction / have an explanation ?
> >
> > I can add a new pool and it performs normally.
> >
> > Config is generally
> > 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
> > with NVME for journals. Centos 7.2, XFS
> >
> > Jewell is the release; inserting objects with librados via some Python
> > test code.
> >
> > Best Regards
> > Wade
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> ~Blairo
>

--001a113947848a161f0535661497
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Blairo,=C2=A0<div><br></div><div>Thats right, I do see &qu=
ot;lots&quot; of READ IO!=C2=A0 If I compare the &quot;bad (330Mil)&quot; p=
ool, with the new test (good) pool:</div><div><br></div><div>iostat while r=
unning to the &quot;good&quot; pool shows almost all writes.</div><div>iost=
at while running to the &quot;bad&quot; pool has VERY large read spikes, wi=
th almost no writes.</div><div><br></div><div>Sounds like you have an idea =
about what causes this.=C2=A0 I&#39;m happy to hear it!</div><div><br></div=
><div>slabinfo is below.=C2=A0 Drop caches has no affect.</div><div><br></d=
iv><div><div></div>





<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">slabinfo - versi=
on: 2.1</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1"># name<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>&lt;active_objs&gt; &lt;num_objs&gt; &lt;objsize&gt; &lt;objp=
erslab&gt; &lt;pagesperslab&gt; : tunables &lt;limit&gt; &lt;batchcount&gt;=
 &lt;sharedfactor&gt; : slabdata &lt;active_slabs&gt; &lt;num_slabs&gt; &lt=
;sharedavail&gt;</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">blk_io_mits <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>4674 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
4769 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1664 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>19<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>251<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>251<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">rpc_inode_cache<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>640 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>51<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">t10_alua_tg_pt_g=
p_cache<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>408 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>40<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">t10_pr_reg_cache=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>696 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>47=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">se_sess_cache<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>896 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 </span>36<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kvm_vcpu <span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 </span>16256<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>2<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kvm_mmu_page_hea=
der <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
48 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4=
8<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>168=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>48<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunables=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabda=
ta<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </=
span>1<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>1<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_dqtrx<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>528 <span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 </span>62<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_dquot<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>472 <span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 </span>69<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_icr<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 </span>144 <span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 </span>56<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>2 : tunables<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-convert=
ed-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_ili <span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>96974261 97026835<span class=3D"inbox-inbox-Apple-converted-spac=
e">=C2=A0 =C2=A0 </span>152 <span class=3D"inbox-inbox-Apple-converted-spac=
e">=C2=A0 </span>53<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>2 : tunables<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata 1830695 1830695<span class=3D"inbox-inbox-Ap=
ple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_inode <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>97120263 97120263 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 </span>1088 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>30<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </sp=
an>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>0 : slabdata 3237631 3237631<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_efd_item<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>6280 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
6360<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
400 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>40<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>159<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
159<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_da_state<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>3264 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
3264<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
480 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>68<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>48 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>48<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_btree_cur <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>1872 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1872<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>208 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>39<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunables<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>48 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>48<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">xfs_log_ticket <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>23980=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>23980<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>184 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>44<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>545<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>545<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<=
/span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">scsi_cmd_cache<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>4536 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>4644<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>448 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>36<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4 : tunables<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>129<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>129<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kcopyd_job <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 </span>3312<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>9<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dm_uevent<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 </span>2608 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>12<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dm_rq_target_io<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>136 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>60<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>2 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">UDPLITEv6<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 </span>1152 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>28<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">UDPv6<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>980<span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>980 <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 </span>1152 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>28<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>35 <span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>35<span class=3D"inbox-inbox-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">tw_sock_TCPv6<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>256 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 </span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">TCPv6<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>510<span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>510 <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 </span>2112 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>15<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>34 <span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>34<span class=3D"inbox-inbox-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">uhci_urb_priv <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>6132 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>6132 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>56 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>73<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunables<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>84 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>84<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">cfq_queue<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>64153<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>97300<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>232 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>7=
0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4 :=
 tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
 : slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span=
>1390 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1390<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </spa=
n>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">bsg_cmd<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 </span>312 <span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 </span>52<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>4 : tunables<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-convert=
ed-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">mqueue_inode_cac=
he <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>3=
6 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>36=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>896 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>36<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdat=
a<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>1<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>1<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">hugetlbfs_inode_=
cache<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>106<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
106<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>6=
08 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>53<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunabl=
es<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slab=
data<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
</span>2<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>2<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">configfs_dir_cac=
he <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4=
6 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>46=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>88 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>46<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunables<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdat=
a<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>1<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>1<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dquot<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conver=
ted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-co=
nverted-space">=C2=A0 =C2=A0 </span>256 <span class=3D"inbox-inbox-Apple-co=
nverted-space">=C2=A0 </span>64<span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>4 : tunables<span class=3D"inbox-inbox-Apple-con=
verted-space">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conver=
ted-space">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kioctx<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>1512 <span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 </span>1512<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>576 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 </span>56<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>27 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>27<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">userfaultfd_ctx_=
cache<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>128 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </s=
pan>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>2 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">pid_namespace<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 </span>2176 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>15<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </sp=
an>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">user_namespace <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>280 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>58<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">posix_timers_cac=
he<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </=
span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>248 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span=
>66<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4=
 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
</span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">UDP-Lite <span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 </span>1024 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>32<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">RAW <span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>1972 <span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 </span>1972<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>960 <span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 </span>34<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>58 <span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>58<span class=3D"inbox-inbox-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">UDP <span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>1472 <span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 </span>1504 <span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 </span>1024 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 </span>32<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-spac=
e">=C2=A0 =C2=A0 </span>47 <span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>47<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">tw_sock_TCP <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>6272 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
6400<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
256 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>64<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>100<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
100<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">TCP <span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>5236 <span class=3D"inbox-inbox-Apple-converted=
-space">=C2=A0 </span>5457 <span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 </span>1920 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 </span>17<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>321<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>321<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">blkdev_queue <sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
</span>421<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>465 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2=
088 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>15<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>31 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>31<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">blkdev_requests =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>36137670 39=
504234<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>384 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>42<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4 : tun=
ables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : s=
labdata 940577 940577<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">blkdev_ioc<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>2106 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>2106<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>104 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>39=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
</span>54 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>54<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">fsnotify_event_h=
older <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>8160 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>8160 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>24<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>170<span class=3D"i=
nbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunables<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D=
"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>48 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>48<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</sp=
an></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">fsnotify_event <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>37128=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>37128<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>120 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>68<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>546<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>546<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<=
/span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">sock_inode_cache=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>11985<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>11985<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>640 <span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>51<span class=3D"inbox=
-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D=
"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D"in=
box-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>235<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>235<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span>=
</p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">net_namespace<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 </span>4608<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>7<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">shmem_inode_cach=
e <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>5040 <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>5040<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>680 <span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>48<span class=3D"inbox=
-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D=
"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D"in=
box-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>105<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>105<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span>=
</p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">Acpi-ParseExt <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>116256=
 116256 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>72 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>56<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tu=
nables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : =
slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>20=
76 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2076<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0=
</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">Acpi-Namespace <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>14586=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>14586 <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>40<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>102<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>143<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>143<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<=
/span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">taskstats <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>2352 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>2352<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>328 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>49=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
</span>48 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>48<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">proc_inode_cache=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>146512 1467=
06<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>65=
6 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>49<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunable=
s<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabd=
ata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2994 <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2994<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</spa=
n></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">sigqueue<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>2448 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>2448<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>160 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>51<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>2 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>48 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>48<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">bdev_cache<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>1872 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>1872<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>832 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>39=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
</span>48 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>48<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">sysfs_dir_cache =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>172296 1722=
96<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>11=
2 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>36<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunable=
s<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabd=
ata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>4786 <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>4786<span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</spa=
n></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">inode_cache<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>17550<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1=
7820<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
592 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>55<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>324<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
324<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dentry<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>63799847 86138682<span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 =C2=A0 </span>192 <span class=3D"inbox-inbox-Apple-converted-s=
pace">=C2=A0 </span>42<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>2 : tunables<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0 : slabdata 2050921 2050921<span class=3D"inbox-inbox=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">iint_cache <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space=
">=C2=A0 =C2=A0 </span>80 <span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 </span>51<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">selinux_inode_se=
curity<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>41920=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>42636 <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>80 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>51<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>836<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>836<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<=
/span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">buffer_head <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>2=
8851697 32477250<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>104 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>39<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata 832750 832750<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">vm_area_struct <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>36548=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>38665<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>216 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>37<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1045 <span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1045<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">mm_struct <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>1120 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>1120 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1=
600 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>20<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>56 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>56<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">files_cache <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>2703 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
2703<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
640 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>51<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>53 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>53<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">signal_cache<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>5109 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
5376 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1152 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>28<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>192<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>192<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">sighand_cache <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>3241 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>3345 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2112 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>15<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>223<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>223<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0<=
/span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">task_xstate<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>14118<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1=
4937<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
832 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>39<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>383<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
383<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">task_struct <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>9295<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1=
0538 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2944 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>11<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>958<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>958<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">anon_vma <span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>30400<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>30400 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
</span>64 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>6=
4<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 :=
 tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
</span>475<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>475<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">shared_policy_no=
de <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>5780 <sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>5780 <span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>48 <span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>85<span class=3D"inbo=
x-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunables<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D=
"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D"in=
box-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata <span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>68 <span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>68<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span>=
</p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">numa_policy<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>620<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>620<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>264 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>62<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>10 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>10<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">radix_tree_node =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>10364872 10=
364872<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>584 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>56<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tun=
ables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : s=
labdata 185087 185087<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">idr_layer_cache =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1185=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1185 <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2112 <span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>15<span class=3D"inbox=
-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D=
"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=3D"in=
box-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata <span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>79 <span cla=
ss=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>79<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span>=
</p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-8192=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>8=
192<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-4096=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>4=
096<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-2048=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2=
048 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>16<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-1024=
 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1=
024 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>32<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-512<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>512 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-256<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>256 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-128<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>128 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>2 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-64 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>64 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 <=
/span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-32 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>32<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>128<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-16 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>16<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>256<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-8<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>8<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>512<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-192<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>192 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>42<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>2 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">dma-kmalloc-96 <=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 =C2=A0 </span>0 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>96 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 <=
/span>42<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-8192 <sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
</span>588<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>680 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>8=
192<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>4=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>170<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>170<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-4096<spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>6374 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>=
6424 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>4096<s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>803<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
803<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-2048 <sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>=
60889<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>63744 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2048 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>16<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>3984 <span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>3984<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-1024 <sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>=
27406<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>32448 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1024 <span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>32<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>8 : tunables<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span clas=
s=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<span class=
=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : slabdata <s=
pan class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1014 <span cl=
ass=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1014<span class=3D"=
inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-512 <spa=
n class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>9=
6841607 96891536<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>512 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>8 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata 1513967 1513967<span class=3D"inbox-inbox-Apple-conver=
ted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-256<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>73414 108736<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>256 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 </span>1699 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>1699<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-192<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>32870<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>3=
3432<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
192 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>42<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>796<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
796<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-128<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>64128<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>9=
2736<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
128 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>64<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>2 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1449 =
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>1449<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</s=
pan></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-96<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>9350 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>9618 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>96 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>42=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : =
tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </s=
pan>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 =
: slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>229<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>229<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-64<span =
class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>159325477 194832256 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>64 <span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 </span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=
=C2=A0 =C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>0 : slabdata 3044254 3044254<span class=3D"inbox-inbox-Ap=
ple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-32 <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>24960<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>2=
4960 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>32<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>128<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>195<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
195<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-16 <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </=
span>45312<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>4=
5312 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>16<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>256<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>177<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>=
177<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmalloc-8<span c=
lass=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>51712<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </=
span>51712<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>8<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </s=
pan>512<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </sp=
an>1 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>0 : slabdata<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>101<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>101<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 </span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmem_cache_node<=
span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </spa=
n>741<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>768 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>64 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 </span>64<span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>1 : tunab=
les<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0=
<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0<sp=
an class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span>0 : sla=
bdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </spa=
n>12 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </span=
>12<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 <=
/span>0</span></p>
<p class=3D"inbox-inbox-p1"><span class=3D"inbox-inbox-s1">kmem_cache <span=
 class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>640<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>640<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>256 <span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
</span>64<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0 </=
span>4 : tunables<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =
=C2=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=
=A0 </span>0<span class=3D"inbox-inbox-Apple-converted-space">=C2=A0 =C2=A0=
 </span>0 : slabdata <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>10 <span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 </span>10<span class=3D"inbox-inbox-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>0</span></p><br><div class=3D"gmail_quote"><div di=
r=3D"ltr">On Thu, Jun 16, 2016 at 8:48 AM Blair Bethwaite &lt;<a href=3D"ma=
ilto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Hi Wade,<br>
<br>
What IO are you seeing on the OSD devices when this happens (see e.g.<br>
iostat), are there short periods of high read IOPS where (almost) no<br>
writes occur? What does your memory usage look like (including slab)?<br>
<br>
Cheers,<br>
<br>
On 16 June 2016 at 22:14, Wade Holler &lt;<a href=3D"mailto:wade.holler@gma=
il.com" target=3D"_blank">wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; I have a repeatable condition when the object count in a pool gets to<=
br>
&gt; 320-330 million the object write time dramatically and almost<br>
&gt; instantly increases as much as 10X, exhibited by fs_apply_latency<br>
&gt; going from 10ms to 100s of ms.<br>
&gt;<br>
&gt; Can someone point me in a direction / have an explanation ?<br>
&gt;<br>
&gt; I can add a new pool and it performs normally.<br>
&gt;<br>
&gt; Config is generally<br>
&gt; 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD=
<br>
&gt; with NVME for journals. Centos 7.2, XFS<br>
&gt;<br>
&gt; Jewell is the release; inserting objects with librados via some Python=
<br>
&gt; test code.<br>
&gt;<br>
&gt; Best Regards<br>
&gt; Wade<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/m=
ajordomo-info.html</a><br>
<br>
<br>
<br>
--<br>
Cheers,<br>
~Blairo<br>
</blockquote></div></div></div>

--001a113947848a161f0535661497--

--===============1959993115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1959993115==--
