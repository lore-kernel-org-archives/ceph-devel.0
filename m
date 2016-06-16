From: Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
	objects in pool
Date: Thu, 16 Jun 2016 10:32:57 -0400
Message-ID: <CA+e22SfWFrN8OHkM09qf8iouwaKOkFzHAJNc0afQXikGTUpLBA@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<CA+z5Dsz=e1N9RxRoF5Wao8Dogf_S1UstNZaCJ=oj-efj83HBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Blairo,

Thats right, I do see "lots" of READ IO!  If I compare the "bad
(330Mil)" pool, with the new test (good) pool:

iostat while running to the "good" pool shows almost all writes.
iostat while running to the "bad" pool has VERY large read spikes,
with almost no writes.

Sounds like you have an idea about what causes this.  I'm happy to hear it!

slabinfo is below.  Drop caches has no affect.

slabinfo - version: 2.1

# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>

blk_io_mits         4674   4769   1664   19    8 : tunables    0    0
  0 : slabdata    251    251      0

rpc_inode_cache        0      0    640   51    8 : tunables    0    0
  0 : slabdata      0      0      0

t10_alua_tg_pt_gp_cache      0      0    408   40    4 : tunables    0
   0    0 : slabdata      0      0      0

t10_pr_reg_cache       0      0    696   47    8 : tunables    0    0
  0 : slabdata      0      0      0

se_sess_cache          0      0    896   36    8 : tunables    0    0
  0 : slabdata      0      0      0

kvm_vcpu               0      0  16256    2    8 : tunables    0    0
  0 : slabdata      0      0      0

kvm_mmu_page_header     48     48    168   48    2 : tunables    0
0    0 : slabdata      1      1      0

xfs_dqtrx              0      0    528   62    8 : tunables    0    0
  0 : slabdata      0      0      0

xfs_dquot              0      0    472   69    8 : tunables    0    0
  0 : slabdata      0      0      0

xfs_icr                0      0    144   56    2 : tunables    0    0
  0 : slabdata      0      0      0

xfs_ili           96974261 97026835    152   53    2 : tunables    0
 0    0 : slabdata 1830695 1830695      0

xfs_inode         97120263 97120263   1088   30    8 : tunables    0
 0    0 : slabdata 3237631 3237631      0

xfs_efd_item        6280   6360    400   40    4 : tunables    0    0
  0 : slabdata    159    159      0

xfs_da_state        3264   3264    480   68    8 : tunables    0    0
  0 : slabdata     48     48      0

xfs_btree_cur       1872   1872    208   39    2 : tunables    0    0
  0 : slabdata     48     48      0

xfs_log_ticket     23980  23980    184   44    2 : tunables    0    0
  0 : slabdata    545    545      0

scsi_cmd_cache      4536   4644    448   36    4 : tunables    0    0
  0 : slabdata    129    129      0

kcopyd_job             0      0   3312    9    8 : tunables    0    0
  0 : slabdata      0      0      0

dm_uevent              0      0   2608   12    8 : tunables    0    0
  0 : slabdata      0      0      0

dm_rq_target_io        0      0    136   60    2 : tunables    0    0
  0 : slabdata      0      0      0

UDPLITEv6              0      0   1152   28    8 : tunables    0    0
  0 : slabdata      0      0      0

UDPv6                980    980   1152   28    8 : tunables    0    0
  0 : slabdata     35     35      0

tw_sock_TCPv6          0      0    256   64    4 : tunables    0    0
  0 : slabdata      0      0      0

TCPv6                510    510   2112   15    8 : tunables    0    0
  0 : slabdata     34     34      0

uhci_urb_priv       6132   6132     56   73    1 : tunables    0    0
  0 : slabdata     84     84      0

cfq_queue          64153  97300    232   70    4 : tunables    0    0
  0 : slabdata   1390   1390      0

bsg_cmd                0      0    312   52    4 : tunables    0    0
  0 : slabdata      0      0      0

mqueue_inode_cache     36     36    896   36    8 : tunables    0    0
   0 : slabdata      1      1      0

hugetlbfs_inode_cache    106    106    608   53    8 : tunables    0
 0    0 : slabdata      2      2      0

configfs_dir_cache     46     46     88   46    1 : tunables    0    0
   0 : slabdata      1      1      0

dquot                  0      0    256   64    4 : tunables    0    0
  0 : slabdata      0      0      0

kioctx              1512   1512    576   56    8 : tunables    0    0
  0 : slabdata     27     27      0

userfaultfd_ctx_cache      0      0    128   64    2 : tunables    0
 0    0 : slabdata      0      0      0

pid_namespace          0      0   2176   15    8 : tunables    0    0
  0 : slabdata      0      0      0

user_namespace         0      0    280   58    4 : tunables    0    0
  0 : slabdata      0      0      0

posix_timers_cache      0      0    248   66    4 : tunables    0    0
   0 : slabdata      0      0      0

UDP-Lite               0      0   1024   32    8 : tunables    0    0
  0 : slabdata      0      0      0

RAW                 1972   1972    960   34    8 : tunables    0    0
  0 : slabdata     58     58      0

UDP                 1472   1504   1024   32    8 : tunables    0    0
  0 : slabdata     47     47      0

tw_sock_TCP         6272   6400    256   64    4 : tunables    0    0
  0 : slabdata    100    100      0

TCP                 5236   5457   1920   17    8 : tunables    0    0
  0 : slabdata    321    321      0

blkdev_queue         421    465   2088   15    8 : tunables    0    0
  0 : slabdata     31     31      0

blkdev_requests   36137670 39504234    384   42    4 : tunables    0
 0    0 : slabdata 940577 940577      0

blkdev_ioc          2106   2106    104   39    1 : tunables    0    0
  0 : slabdata     54     54      0

fsnotify_event_holder   8160   8160     24  170    1 : tunables    0
 0    0 : slabdata     48     48      0

fsnotify_event     37128  37128    120   68    2 : tunables    0    0
  0 : slabdata    546    546      0

sock_inode_cache   11985  11985    640   51    8 : tunables    0    0
  0 : slabdata    235    235      0

net_namespace          0      0   4608    7    8 : tunables    0    0
  0 : slabdata      0      0      0

shmem_inode_cache   5040   5040    680   48    8 : tunables    0    0
  0 : slabdata    105    105      0

Acpi-ParseExt     116256 116256     72   56    1 : tunables    0    0
  0 : slabdata   2076   2076      0

Acpi-Namespace     14586  14586     40  102    1 : tunables    0    0
  0 : slabdata    143    143      0

taskstats           2352   2352    328   49    4 : tunables    0    0
  0 : slabdata     48     48      0

proc_inode_cache  146512 146706    656   49    8 : tunables    0    0
  0 : slabdata   2994   2994      0

sigqueue            2448   2448    160   51    2 : tunables    0    0
  0 : slabdata     48     48      0

bdev_cache          1872   1872    832   39    8 : tunables    0    0
  0 : slabdata     48     48      0

sysfs_dir_cache   172296 172296    112   36    1 : tunables    0    0
  0 : slabdata   4786   4786      0

inode_cache        17550  17820    592   55    8 : tunables    0    0
  0 : slabdata    324    324      0

dentry            63799847 86138682    192   42    2 : tunables    0
 0    0 : slabdata 2050921 2050921      0

iint_cache             0      0     80   51    1 : tunables    0    0
  0 : slabdata      0      0      0

selinux_inode_security  41920  42636     80   51    1 : tunables    0
  0    0 : slabdata    836    836      0

buffer_head       28851697 32477250    104   39    1 : tunables    0
 0    0 : slabdata 832750 832750      0

vm_area_struct     36548  38665    216   37    2 : tunables    0    0
  0 : slabdata   1045   1045      0

mm_struct           1120   1120   1600   20    8 : tunables    0    0
  0 : slabdata     56     56      0

files_cache         2703   2703    640   51    8 : tunables    0    0
  0 : slabdata     53     53      0

signal_cache        5109   5376   1152   28    8 : tunables    0    0
  0 : slabdata    192    192      0

sighand_cache       3241   3345   2112   15    8 : tunables    0    0
  0 : slabdata    223    223      0

task_xstate        14118  14937    832   39    8 : tunables    0    0
  0 : slabdata    383    383      0

task_struct         9295  10538   2944   11    8 : tunables    0    0
  0 : slabdata    958    958      0

anon_vma           30400  30400     64   64    1 : tunables    0    0
  0 : slabdata    475    475      0

shared_policy_node   5780   5780     48   85    1 : tunables    0    0
   0 : slabdata     68     68      0

numa_policy          620    620    264   62    4 : tunables    0    0
  0 : slabdata     10     10      0

radix_tree_node   10364872 10364872    584   56    8 : tunables    0
 0    0 : slabdata 185087 185087      0

idr_layer_cache     1185   1185   2112   15    8 : tunables    0    0
  0 : slabdata     79     79      0

dma-kmalloc-8192       0      0   8192    4    8 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-4096       0      0   4096    8    8 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-2048       0      0   2048   16    8 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-1024       0      0   1024   32    8 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-512        0      0    512   64    8 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-256        0      0    256   64    4 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-128        0      0    128   64    2 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-64         0      0     64   64    1 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-32         0      0     32  128    1 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-16         0      0     16  256    1 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-8          0      0      8  512    1 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-192        0      0    192   42    2 : tunables    0    0
  0 : slabdata      0      0      0

dma-kmalloc-96         0      0     96   42    1 : tunables    0    0
  0 : slabdata      0      0      0

kmalloc-8192         588    680   8192    4    8 : tunables    0    0
  0 : slabdata    170    170      0

kmalloc-4096        6374   6424   4096    8    8 : tunables    0    0
  0 : slabdata    803    803      0

kmalloc-2048       60889  63744   2048   16    8 : tunables    0    0
  0 : slabdata   3984   3984      0

kmalloc-1024       27406  32448   1024   32    8 : tunables    0    0
  0 : slabdata   1014   1014      0

kmalloc-512       96841607 96891536    512   64    8 : tunables    0
 0    0 : slabdata 1513967 1513967      0

kmalloc-256        73414 108736    256   64    4 : tunables    0    0
  0 : slabdata   1699   1699      0

kmalloc-192        32870  33432    192   42    2 : tunables    0    0
  0 : slabdata    796    796      0

kmalloc-128        64128  92736    128   64    2 : tunables    0    0
  0 : slabdata   1449   1449      0

kmalloc-96          9350   9618     96   42    1 : tunables    0    0
  0 : slabdata    229    229      0

kmalloc-64        159325477 194832256     64   64    1 : tunables    0
   0    0 : slabdata 3044254 3044254      0

kmalloc-32         24960  24960     32  128    1 : tunables    0    0
  0 : slabdata    195    195      0

kmalloc-16         45312  45312     16  256    1 : tunables    0    0
  0 : slabdata    177    177      0

kmalloc-8          51712  51712      8  512    1 : tunables    0    0
  0 : slabdata    101    101      0

kmem_cache_node      741    768     64   64    1 : tunables    0    0
  0 : slabdata     12     12      0

kmem_cache           640    640    256   64    4 : tunables    0    0
  0 : slabdata     10     10      0


On Thu, Jun 16, 2016 at 8:48 AM, Blair Bethwaite
<blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Wade,
>
> What IO are you seeing on the OSD devices when this happens (see e.g.
> iostat), are there short periods of high read IOPS where (almost) no
> writes occur? What does your memory usage look like (including slab)?
>
> Cheers,
>
> On 16 June 2016 at 22:14, Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi All,
>>
>> I have a repeatable condition when the object count in a pool gets to
>> 320-330 million the object write time dramatically and almost
>> instantly increases as much as 10X, exhibited by fs_apply_latency
>> going from 10ms to 100s of ms.
>>
>> Can someone point me in a direction / have an explanation ?
>>
>> I can add a new pool and it performs normally.
>>
>> Config is generally
>> 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
>> with NVME for journals. Centos 7.2, XFS
>>
>> Jewell is the release; inserting objects with librados via some Python
>> test code.
>>
>> Best Regards
>> Wade
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> ~Blairo
