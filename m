From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Thu, 15 Mar 2012 07:34:49 +0000 (UTC)
Message-ID: <loom.20120315T082908-316@post.gmane.org>
References: <loom.20120313T113524-750@post.gmane.org> <4F5FA114.7070806@gmail.com> <loom.20120314T052312-964@post.gmane.org> <Pine.LNX.4.64.1203141052350.11925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58303 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947Ab2COHfF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Mar 2012 03:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S85DB-0008Vx-U6
	for ceph-devel@vger.kernel.org; Thu, 15 Mar 2012 08:35:02 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 08:35:01 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 08:35:01 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> There are a range of reasons why this could be slow, and unfortunately we 
> don't have enough information to tell what is the problem. 
> 
> First, see what the OSD performance looks like.  Output from, say,
> 
>  rados -p rbd bench 60 write
Below is the output for above command
Maintaining 16 concurrent writes of 4194304 bytes for at least 60 seconds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    0       0         0         0         0         0         -         0
    1      16        21         5   19.9977        20  0.812528  0.670245
    2      16        32        16   31.9968        44    1.8945   1.08347
    3      16        36        20   26.6642        16    1.3047   1.20578
    4      16        36        20   19.9983         0         -   1.20578
    5      16        36        20   15.9988         0         -   1.20578
    6      16        36        20   13.3323         0         -   1.20578
    7      16        36        20   11.4277         0         -   1.20578
    8      16        37        21   10.4992       0.8   6.16667   1.44201
    9      16        38        22   9.77707         4    6.2427   1.66023
   10      16        42        26   10.3993        16   7.56009    2.7077
   11      16        50        34   12.3628        32   8.39974   4.29642
   12      16        53        37   12.3324        12     1.484   4.26584
   13      16        56        40   12.3068        12   4.37864    4.2272
   14      16        56        40   11.4277         0         -    4.2272
   15      16        59        43   11.4658         6   3.67994   4.14289
   16      16        61        45   11.2492         8   1.36923   4.02616
   17      16        63        47    11.058         8   6.27617   4.28349
   18      16        68        52   11.5547        20  0.156699   4.38157
   19      16        74        58   12.2096        24   7.59485   4.48972
min lat: 0.126333 max lat: 13.8708 avg lat: 4.48972
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   20      16        74        58   11.5991         0         -   4.48972
   21      16        78        62   11.8087         8   4.28192   4.56687
   22      16        79        63   11.4537         4   10.3042   4.65793
   23      16        80        64   11.1296         4   5.11324   4.66505
   24      16        95        79   13.1657        60  0.507039   4.61964
   25      16       111        95   15.1989        64   1.30604   4.15126
   26      16       122       106   16.3065        44   1.03886   3.80572
   27      16       132       116   17.1839        40   1.29897   3.59711
   28      16       145       129   18.4272        52  0.894609   3.37619
   29      16       156       140   19.3089        44   0.74373   3.22486
   30      16       164       148   19.7319        32   2.20334   3.13232
   31      16       170       154   19.8695        24  0.237399   3.05052
   32      16       173       157   19.6235        12   0.23249   2.99613
   33      16       173       157   19.0289         0         -   2.99613
   34      16       175       159   18.7045         4   5.25468   3.02382
   35      16       177       161   18.3986         8   6.17519    3.0629
   36      16       178       162   17.9987         4  0.536972    3.0473
   37      16       179       163   17.6203         4   7.70179   3.07586
   38      16       180       164   17.2619         4   0.22377   3.05847
   39      16       183       167    17.127        12  0.227409   3.11332
min lat: 0.126333 max lat: 13.8708 avg lat: 3.18654
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   40      16       185       169   16.8983         8   10.6939   3.18654
   41      16       185       169   16.4862         0         -   3.18654
   42      16       193       177   16.8555        16   13.1432   3.44995
   43      16       196       180   16.7425        12   12.6742   3.53561
   44      16       198       182   16.5438         8   0.31367   3.56882
   45      16       200       184    16.354         8   9.78219   3.60965
   46      16       205       189   16.4332        20   6.45287    3.6977
   47      16       219       203    17.275        56    5.0728   3.65707
   48      16       231       215    17.915        48  0.720143   3.50757
   49      16       237       221   18.0391        24  0.703825   3.44442
   50      16       239       223   17.8383         8  0.233446   3.41695
   51      16       243       227   17.8023        16  0.342869   3.41006
   52      16       244       228   17.5368         4    4.4299   3.41453
   53      16       247       231   17.4323        12   4.64127   3.43726
   54      16       253       237   17.5539        24   5.46034   3.48178
   55      16       260       244   17.7438        28   5.34504   3.47632
   56      16       266       250   17.8555        24   7.08689   3.50108
   57      16       272       256   17.9633        24   2.84547   3.46993
   58      16       282       266   18.3432        40   2.52109   3.41593
   59      16       290       274   18.5746        32   1.92934   3.37696
min lat: 0.126333 max lat: 13.8708 avg lat: 3.28278
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   60      16       305       289   19.2649        60   0.56854   3.28278
Total time run:        60.767218
Total writes made:     306
Write size:            4194304
Bandwidth (MB/sec):    20.142

Average Latency:       3.17418
Max latency:           13.8708
Min latency:           0.126333


>  rados -p rbd bench 60 write -b 4096
Below is the output for above mentioned command

[root@ceph-node-1 tmp]# more bench_60_write_4096.txt
Maintaining 16 concurrent writes of 4096 bytes for at least 60 seconds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    0       0         0         0         0         0         -         0
    1      16        78        62  0.242166  0.242188  0.202912  0.124461
    2      16        78        62  0.121084         0         -  0.124461
    3      16        78        62 0.0807232         0         -  0.124461
    4      16        78        62 0.0605425         0         -  0.124461
    5      16       109        93 0.0726512 0.0302734  0.003603   0.85439
    6      16       204       188  0.122387  0.371094  0.204265  0.496608
    7      16       318       302  0.168515  0.445312  0.054909  0.366443
    8      16       413       397  0.193835  0.371094  0.161807  0.316899
    9      16       509       493  0.213961     0.375  0.113778  0.289189
   10      16       582       566  0.221079  0.285156  0.157507   0.27352
   11      15       599       584  0.207372 0.0703125    1.1949  0.294279
   12      16       665       649  0.211249  0.253906  0.093375  0.273437
   13      16       667       651    0.1956 0.0078125  0.933936  0.275469
   14      16       673       657  0.183302 0.0234375  0.100929  0.280136
   15      16       683       667  0.173686 0.0390625  0.075955  0.317487
   16      16       683       667  0.162831         0         -  0.317487
   17      16       687       671  0.154172 0.0078125  0.101985  0.334214
   18      16       695       679  0.147342   0.03125  0.206219  0.371785
   19      16       695       679  0.139588         0         -  0.371785
min lat: 0.001391 max lat: 7.24938 avg lat: 0.376663
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   20      16       696       680  0.1328030.00195312   3.68887  0.376663
   21      16       721       705  0.131129 0.0976562  0.173381  0.470115
   22      16       734       718  0.127477 0.0507812  0.173739  0.479609
   23      16       746       730  0.123973  0.046875   1.10609  0.493413
   24      16       810       794  0.129223      0.25  0.209269  0.479339
   25      16       845       829  0.129523  0.136719  0.205449   0.47522
   26      16       892       876  0.131602  0.183594  0.205226  0.467846
   27      16       961       945   0.13671  0.269531  0.001928  0.454477
   28      16      1009       993  0.138523    0.1875   0.20625  0.440584
   29      16      1009       993  0.133746         0         -  0.440584
   30      16      1009       993  0.129288         0         -  0.440584
   31      16      1009       993  0.125118         0         -  0.440584
   32      16      1009       993  0.121208         0         -  0.440584
   33      16      1009       993  0.117535         0         -  0.440584
   34      16      1009       993  0.114078         0         -  0.440584
   35      16      1009       993  0.110818         0         -  0.440584
   36      16      1021      1005  0.1090420.00585938   0.05714   0.50878
   37      16      1022      1006  0.1062010.00390625   9.17946  0.517399
   38      16      1024      1008  0.103611 0.0078125   0.06615  0.525953
   39      16      1031      1015  0.101656 0.0273438   3.67783  0.568425
min lat: 0.001391 max lat: 11.0367 avg lat: 0.568425
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   40      16      1031      1015 0.0990946         0         -  0.568425
   41      16      1035      1019 0.0970591 0.0078125  0.107579  0.572232
   42      16      1035      1019 0.0947486         0         -  0.572232
   43      16      1035      1019 0.0925456         0         -  0.572232
   44      16      1035      1019 0.0904426         0         -  0.572232
   45      16      1035      1019 0.0884332         0         -  0.572232
   46      16      1037      1021 0.0866808 0.0015625  0.230719  0.580969
   47      16      1064      1048 0.0870804  0.105469   0.13313  0.711481
   48      16      1067      1051 0.0855106 0.0117188  0.534748  0.710977
   49      16      1082      1066 0.0849613 0.0585938   2.28933  0.726275
   50      16      1103      1087 0.0849025 0.0820312  0.148827  0.725101
   51      16      1107      1091 0.0835444  0.015625  0.084552  0.727337
   52      16      1126      1110 0.0833649 0.0742188  0.192315   0.74344
   53      16      1144      1128 0.0831186 0.0703125   0.59475  0.745803
   54      16      1190      1174 0.0849064  0.179688  0.002427  0.733341
   55      16      1201      1185  0.084144 0.0429688   1.03461  0.735925
   56      16      1305      1289 0.0898946   0.40625  0.001528  0.692833
   57      16      1500      1484  0.101678  0.761719  0.002309  0.613436
   58      16      1762      1746  0.117567   1.02344  0.060972  0.531532
   59      16      1924      1908  0.126298  0.632812  0.052236  0.493528
min lat: 0.001359 max lat: 19.2606 avg lat: 0.485451
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
   60      16      1969      1953  0.127123  0.175781  0.089677  0.485451
   61      16      1969      1953  0.125039         0         -  0.485451
   62      16      1969      1953  0.123023         0         -  0.485451
   63      16      1969      1953   0.12107         0         -  0.485451
   64      16      1969      1953  0.119179         0         -  0.485451
   65      16      1969      1953  0.117345         0         -  0.485451
   66      16      1969      1953  0.115568         0         -  0.485451
Total time run:        66.614723
Total writes made:     1970
Write size:            4096
Bandwidth (MB/sec):    0.116

Average Latency:       0.541031
Max latency:           19.2606
Min latency:           0.00135
> 
> will give us a sense of what the object store performance looks like.
> 
> The other big question is which client you're using.. since you have 
> ceph-fuse problems, I assume you're using the kernel client?  Which kernel 
> version, etc.  If it's MDS performance the way to diagnose would probably 
> be to gather a message log initially ('debug ms = 1' on the [mds] section 
> of ceph.conf) to see what the client/mds interaction looks like.  MDS 
> performance isn't something we have very much time to spend on right now, 
> though, since our focus in primarily RADOS and RBD stability currently 
> (unless you want to talk to the professional services side of things, 
> info <at> ceph.com).
> 
> The first step, though, is to figure out if this is an OSD or MDS 
> performance issue...
> 
> sage
I have debug ms = 1 set in my ceph.conf file. Below is a tail of mds log

[root@ceph-node-1 tmp]# tail -50 /var/log/ceph/mds.ceph-node-1.log
2012-03-08 08:17:53.288234 42804940 mds.0.locker eval_gather (ixattr excl->sync) 
on [inode 100000317c4 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e2_diff_vmi
d/src/Handler_EL1.s auth v20 ap=1+0 s=11583 n(v0 b11583 1=1+0) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d34140]
2012-03-08 08:17:53.288239 42804940 mds.0.locker  next state is sync 
issued/allows loner s/s xlocker /s other /s
2012-03-08 08:17:53.288249 42804940 mds.0.locker eval_gather finished gather on 
(ixattr excl->sync) on [inode 100000317c4 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e2_diff_vmi
d/src/Handler_EL1.s auth v20 ap=1+0 s=11583 n(v0 b11583 1=1+0) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d34140]
2012-03-08 08:17:53.288259 42804940 mds.0.cache.ino(100000317c4) auth_unpin by 
0x28d348c0 on [inode 100000317c4 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e2_diff_vmi
d/src/Handler_EL1.s auth v20 s=11583 n(v0 b11583 1=1+0) (ifile excl) (iversion 
lock) cr={4129=0-4194304@1} caps={4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps 
0x28d34140] now 0+0
2012-03-08 08:17:53.288263 42804940 mds.0.locker   trying to drop loner
2012-03-08 08:17:53.288274 42804940 mds.0.locker simple_eval (ixattr sync) on 
[inode 100000317c4 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e2_diff_vmi
d/src/Handler_EL1.s auth v20 s=11583 n(v0 b11583 1=1+0) (ifile excl) (iversion 
lock) cr={4129=0-4194304@1} caps={4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps 
0x28d34140]
2012-03-08 08:17:53.288278 42804940 mds.0.locker   trying to drop loner
2012-03-08 08:17:53.288291 42804940 mds.0.locker issue_caps loner client.4129 
allowed=pAsLsXsFsxcrwbl, xlocker allowed=pAsLsXsFsxcrwbl, others allowed=pAsLsXs 
on [inode 100000317c4 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e2_diff_vmi
d/src/Handler_EL1.s auth v20 s=11583 n(v0 b11583 1=1+0) (ifile excl) (iversion 
lock) cr={4129=0-4194304@1} caps={4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps 
0x28d34140]
2012-03-08 08:17:53.288302 42804940 mds.0.locker eval done
2012-03-08 08:17:53.288316 42804940 -- 10.25.12.121:6800/7135 <== client.4129 
10.25.12.129:0/2116640037 1055377 ==== client_caps(update ino 100000317df 202723 
seq 2 caps=pAsLsXsFsxcrwb dirty=- wanted=Fc follows 0 size 3483/3483 mtime 2011-
11-25 21:47:08.000000 tws 2) ==== 176+0+0 (67143743 0 0) 0x4b3c700 con 0xbcadc0
2012-03-08 08:17:53.288321 42804940 mds.0.locker handle_client_caps on 
100000317df follows 0 op update
2012-03-08 08:17:53.288334 42804940 mds.0.cache pick_inode_snap follows 0 on 
[inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/pAsxLsXsxFsxcrwb/Fc@2},l=4129(-1) | caps authpin 
0x28d42360]
2012-03-08 08:17:53.288339 42804940  mds.0.cache.snaprealm(1 seq 1 0xb99200) 
get_snaps  (seq 1 cached_seq 1)
2012-03-08 08:17:53.288352 42804940 mds.0.cache  realm snaprealm(1 seq 1 lc 0 cr 
0 cps 1 snaps={} 0xb99200) [inode 1 [...2,head] / auth v19623 ap=4+0 
snaprealm=0xb99200 f(v0 m2012-03-08 07:33:55.280591 2=0+2) n(v432 rc2012-03-08 
08:17:52.024031 b12919461397 209889=183699+26190)/n(v0 1=0+1) (inest lock dirty) 
(iversion lock) caps={4129=pAsLsXsFs/-@234} | dirtyscattered dirfrag caps dirty 
authpin 0xbfc000]
2012-03-08 08:17:53.288356 42804940 mds.0.cache  snaps
2012-03-08 08:17:53.288367 42804940 mds.0.locker   cap inode [inode 100000317df 
[2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/pAsxLsXsxFsxcrwb/Fc@2},l=4129(-1) | caps authpin 
0x28d42360]
2012-03-08 08:17:53.288381 42804940 mds.0.locker  follows 0 retains 
pAsLsXsFsxcrwb dirty pAsLsXsFsxcrwb on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288393 42804940 mds.0.locker _do_cap_update dirty - issued 
pAsLsXsFsxcrwb wanted Fc on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288405 42804940 mds.0.locker eval 2496 [inode 100000317df 
[2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288409 42804940 mds.0.locker eval doesn't want loner
2012-03-08 08:17:53.288481 42804940 mds.0.locker file_eval wanted=c 
loner_wanted=c other_wanted=  filelock=(ifile excl) on [inode 100000317df 
[2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288495 42804940 mds.0.locker eval_gather (iauth excl->sync) 
on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288508 42804940 mds.0.locker  next state is sync 
issued/allows loner s/s xlocker /s other /s
2012-03-08 08:17:53.288519 42804940 mds.0.locker eval_gather finished gather on 
(iauth excl->sync) on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=2+0 s=3483 n(v0 b3483 1=1+0) (iauth excl->sync) 
(ifile excl) (ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288531 42804940 mds.0.cache.ino(100000317df) auth_unpin by 
0x28d42a30 on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=1+0 s=3483 n(v0 b3483 1=1+0) (ifile excl) (ixattr 
excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360] now 1+0
2012-03-08 08:17:53.288534 42804940 mds.0.locker   trying to drop loner
2012-03-08 08:17:53.288552 42804940 mds.0.locker simple_eval (iauth sync) on 
[inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=1+0 s=3483 n(v0 b3483 1=1+0) (ifile excl) (ixattr 
excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288565 42804940 mds.0.locker simple_eval (ilink sync) on 
[inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=1+0 s=3483 n(v0 b3483 1=1+0) (ifile excl) (ixattr 
excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288576 42804940 mds.0.locker eval_gather (ixattr excl->sync) 
on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=1+0 s=3483 n(v0 b3483 1=1+0) (ifile excl) (ixattr 
excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288581 42804940 mds.0.locker  next state is sync 
issued/allows loner s/s xlocker /s other /s
2012-03-08 08:17:53.288592 42804940 mds.0.locker eval_gather finished gather on 
(ixattr excl->sync) on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 ap=1+0 s=3483 n(v0 b3483 1=1+0) (ifile excl) (ixattr 
excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d42360]
2012-03-08 08:17:53.288602 42804940 mds.0.cache.ino(100000317df) auth_unpin by 
0x28d42ae0 on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 s=3483 n(v0 b3483 1=1+0) (ifile excl) (iversion lock) 
cr={4129=0-4194304@1} caps={4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps 
0x28d42360] now 0+0
2012-03-08 08:17:53.288606 42804940 mds.0.locker   trying to drop loner
2012-03-08 08:17:53.288617 42804940 mds.0.locker simple_eval (ixattr sync) on 
[inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 s=3483 n(v0 b3483 1=1+0) (ifile excl) (iversion lock) 
cr={4129=0-4194304@1} caps={4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps 
0x28d42360]2012-03-08 08:17:53.288621 42804940 mds.0.locker   trying to drop 
loner
2012-03-08 08:17:53.288634 42804940 mds.0.locker issue_caps loner client.4129 
allowed=pAsLsXsFsxcrwbl, xlocker allowed=pAsLsXsFsxcrwbl, others allowed=pAsLsXs 
on [inode 100000317df [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_el2_mmuoff/
src/Handler_EL1.s auth v16 s=3483 n(v0 b3483 1=1+0) (ifile excl) (iversion lock) 
cr={4129=0-4194304@1} caps={4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps 
0x28d42360]
2012-03-08 08:17:53.288648 42804940 mds.0.locker eval done
2012-03-08 08:17:53.288663 42804940 -- 10.25.12.121:6800/7135 <== client.4129 
10.25.12.129:0/2116640037 1055378 ==== client_caps(update ino 100000317d0 202708 
seq 2 caps=pAsLsXsFsxcrwb dirty=- wanted=Fc follows 0 size 229/229 mtime 2011-
12-29 12:44:32.000000 tws 2) ==== 176+0+0 (3797387133 0 0) 0x442d880 con 
0xbcadc0
2012-03-08 08:17:53.288668 42804940 mds.0.locker handle_client_caps on 
100000317d0 follows 0 op update
2012-03-08 08:17:53.288682 42804940 mds.0.cache pick_inode_snap follows 0 on 
[inode 100000317d0 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/pAsxLsXsxFsxcrwb/Fc@2},l=4129(-1) | caps authpin 
0x28d3a5c0]
2012-03-08 08:17:53.288686 42804940  mds.0.cache.snaprealm(1 seq 1 0xb99200) 
get_snaps  (seq 1 cached_seq 1)
2012-03-08 08:17:53.288699 42804940 mds.0.cache  realm snaprealm(1 seq 1 lc 0 cr 
0 cps 1 snaps={} 0xb99200) [inode 1 [...2,head] / auth v19623 ap=4+0 
snaprealm=0xb99200 f(v0 m2012-03-08 07:33:55.280591 2=0+2) n(v432 rc2012-03-08 
08:17:52.024031 b12919461397 209889=183699+26190)/n(v0 1=0+1) (inest lock dirty) 
(iversion lock) caps={4129=pAsLsXsFs/-@234} | dirtyscattered dirfrag caps dirty 
authpin 0xbfc000]
2012-03-08 08:17:53.288703 42804940 mds.0.cache  snaps
2012-03-08 08:17:53.288715 42804940 mds.0.locker   cap inode [inode 100000317d0 
[2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/pAsxLsXsxFsxcrwb/Fc@2},l=4129(-1) | caps authpin 
0x28d3a5c0]
2012-03-08 08:17:53.288728 42804940 mds.0.locker  follows 0 retains 
pAsLsXsFsxcrwb dirty pAsLsXsFsxcrwb on [inode 100000317d0 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d3a5c0]
2012-03-08 08:17:53.288740 42804940 mds.0.locker _do_cap_update dirty - issued 
pAsLsXsFsxcrwb wanted Fc on [inode 100000317d0 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d3a5c0]
2012-03-08 08:17:53.288751 42804940 mds.0.locker eval 2496 [inode 100000317d0 
[2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d3a5c0]
2012-03-08 08:17:53.288755 42804940 mds.0.locker eval doesn't want loner
2012-03-08 08:17:53.288766 42804940 mds.0.locker file_eval wanted=c 
loner_wanted=c other_wanted=  filelock=(ifile excl) on [inode 100000317d0 
[2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps=
{4129=pAsLsXsFsxcrwb/Fc@2},l=4129(-1) | caps authpin 0x28d3a5c0]
2012-03-08 08:17:53.288778 42804940 mds.0.locker eval_gather (iauth excl->sync) 
on [inode 100000317d0 [2,head] 
/test_build/validation/ARCH64/MEM/V8MEM_VZ/tests/v8mem_vz_tlbi_alle1_e3/src/sour
ce.lst auth v20 ap=2+0 s=229 n(v0 b229 1=1+0) (iauth excl->sync) (ifile excl) 
(ixattr excl->sync) (iversion lock) cr={4129=0-4194304@1} caps={4129=pAs



