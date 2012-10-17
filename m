From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Poor performance with rbd volumes
Date: Wed, 17 Oct 2012 07:44:40 +0200 (CEST)
Message-ID: <dc8a4b14-5449-4cb7-ae56-e1f1ae76f3ad@mailpro>
References: <CAGqxmDPs2TWb0-XpXSWtT3HHCOGPu9NkcP264XK702FeYuiuaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58647 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab2JQFpL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 01:45:11 -0400
In-Reply-To: <CAGqxmDPs2TWb0-XpXSWtT3HHCOGPu9NkcP264XK702FeYuiuaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maciej =?utf-8?Q?Ga=C5=82kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

Hi,I think you should really put your journal on ssd, or tmpfs for test=
ing.


----- Mail original -----=20

De: "Maciej Ga=C5=82kiewicz" <maciejgalkiewicz@ragnarson.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 16 Octobre 2012 16:27:08=20
Objet: Poor performance with rbd volumes=20

Hello=20

I have two ceph clusters configured this way:=20

production:=20
# cat /etc/ceph/ceph.conf=20
[global]=20
auth supported =3D cephx=20
keyring =3D /srv/ceph/keyring.admin=20

[mon]=20
mon data =3D /srv/ceph/mon=20
mon clock drift allowed =3D 0.5=20

[mon.n11c1]=20
host =3D n11c1=20
mon addr =3D 1.1.1.49:6789=20
[mon.cc2]=20
host =3D cc2=20
mon addr =3D 1.1.1.48:6789=20
[mon.n13c1]=20
host =3D n13c1=20
mon addr =3D 1.1.1.51:6789=20

[mds]=20
debug mds =3D 1=20
keyring =3D /srv/ceph/ceph-stage2/keyring.$name=20

[mds.n11c1]=20
host =3D n11c1=20

[osd]=20
osd data =3D /srv/ceph/$name=20
osd journal =3D /srv/ceph/$name.journal=20
osd journal size =3D 1000=20
keyring =3D /srv/ceph/ceph-stage2/keyring.$name=20
debug osd =3D 1=20

[osd.2]=20
host =3D n14c1=20
[osd.0]=20
host =3D n11c1=20
[osd.3]=20
host =3D n13c1=20
[osd.1]=20
host =3D n12c1=20

staging:=20
# cat /etc/ceph/ceph.conf=20
[global]=20
auth supported =3D cephx=20
keyring =3D /srv/ceph/keyring.admin=20

[mon]=20
mon data =3D /srv/ceph/mon=20
mon clock drift allowed =3D 0.5=20

[mon.cc]=20
host =3D cc=20
mon addr =3D 1.1.1.35:6789=20
[mon.n3cc]=20
host =3D n3cc=20
mon addr =3D 1.1.1.34:6789=20

[mds]=20
debug mds =3D 1=20
keyring =3D /srv/ceph/ceph-stage2/keyring.$name=20

[mds.cc]=20
host =3D cc=20
[mds.n3cc]=20
host =3D n3cc=20
mds standby replay =3D true=20
mds standby for name =3D cc=20

[osd]=20
osd data =3D /srv/ceph/$name=20
osd journal =3D /srv/ceph/$name.journal=20
osd journal size =3D 1000=20
keyring =3D /srv/ceph/ceph-stage2/keyring.$name=20
debug osd =3D 1=20

[osd.0]=20
host =3D cc=20
[osd.1]=20
host =3D n3cc=20

I am using RBD volumes mapped on virtual machines which run postgresql=20
and mongodb databases. Right now there are 15 clients with postgresql=20
and 10 with mongodb. All clients generate at most 0.4 IOPS (both read=20
and write). Here are the graphs (writes per second) for nodes with=20
osds from last week:=20
https://www.dropbox.com/s/djnpcxb6a9ktzv8/ceph_stats1.png=20
https://www.dropbox.com/s/ak7npkhm776jarp/ceph_stats2.png=20
https://www.dropbox.com/s/3lzfaku1nourmle/ceph_stats3.png=20

Is it normal that ceph generates so much writes? In staging cluster=20
there are no clients connected and still there are about 40 writes/s.=20
I have also checked admin socket and dumped ops_in_flight. There were=20
0 ops.=20
The situation on production is also weird for me. There are a lot of=20
writes which do not reflect volume usage on clients. Looks like ceph=20
have a big overhead or more likely something is wrong with the=20
cluster.=20

Benchmarks from both clusters:=20

root@n12c1[production]:/srv/ceph# rados -p todo-list bench 60 write -b=20
4096 -t 16=20
Maintaining 16 concurrent writes of 4096 bytes for at least 60 seconds.=
=20
Object prefix: benchmark_data_n12c1_2638=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
0 0 0 0 0 0 - 0=20
1 16 20 4 0.0156214 0.015625 0.798329 0.696832=20
2 16 20 40.00781079 0 - 0.696832=20
3 16 20 40.00520727 0 - 0.696832=20
4 16 20 40.00390549 0 - 0.696832=20
5 16 20 40.00312442 0 - 0.696832=20
6 16 20 40.00260369 0 - 0.696832=20
7 16 20 40.00223175 0 - 0.696832=20
8 16 20 40.00195278 0 - 0.696832=20
9 16 20 40.00173581 0 - 0.696832=20
10 16 20 40.00156223 0 - 0.696832=20
11 16 20 40.00142021 0 - 0.696832=20
12 16 20 40.00130186 0 - 0.696832=20
13 16 20 40.00120171 0 - 0.696832=20
14 16 20 40.00111588 0 - 0.696832=20
15 16 20 40.00104149 0 - 0.696832=20
16 16 20 40.000976395 0 - 0.696832=20
17 16 20 40.000918959 0 - 0.696832=20
18 16 20 40.000867905 0 - 0.696832=20
19 16 24 80.001644450.000868056 18.9809 9.83857=20
2012-10-16 16:10:18.553915min lat: 0.391531 max lat: 18.9809 avg lat: 9=
=2E83857=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
20 16 24 80.00156223 0 - 9.83857=20
21 16 25 90.001673810.00195312 20.6347 11.0381=20
22 16 36 200.00355051 0.0429688 0.259829 14.4342=20
23 16 36 200.00339614 0 - 14.4342=20
24 16 36 200.00325464 0 - 14.4342=20
25 16 37 210.003280680.00130208 23.8748 14.8838=20
26 16 37 21 0.0031545 0 - 14.8838=20
27 16 37 210.00303766 0 - 14.8838=20
28 16 37 210.00292918 0 - 14.8838=20
29 16 37 210.00282817 0 - 14.8838=20
30 16 37 21 0.0027339 0 - 14.8838=20
31 16 37 210.00264571 0 - 14.8838=20
32 16 37 210.00256303 0 - 14.8838=20
33 16 37 210.00248537 0 - 14.8838=20
34 16 37 210.00241227 0 - 14.8838=20
35 16 37 210.00234335 0 - 14.8838=20
36 16 37 210.00227825 0 - 14.8838=20
37 16 37 210.00221668 0 - 14.8838=20
38 16 37 210.00215834 0 - 14.8838=20
39 16 37 21 0.002103 0 - 14.8838=20
2012-10-16 16:10:38.557419min lat: 0.258984 max lat: 23.8748 avg lat: 1=
4.8838=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
40 16 37 210.00205043 0 - 14.8838=20
41 16 37 210.00200041 0 - 14.8838=20
42 16 37 210.00195279 0 - 14.8838=20
43 16 37 210.00190737 0 - 14.8838=20
44 16 37 210.00186402 0 - 14.8838=20
45 16 37 21 0.0018226 0 - 14.8838=20
46 16 37 210.00178298 0 - 14.8838=20
47 16 37 210.00174504 0 - 14.8838=20
48 16 37 210.00170869 0 - 14.8838=20
49 16 37 210.00167382 0 - 14.8838=20
50 16 37 210.00164034 0 - 14.8838=20
51 16 37 210.00160818 0 - 14.8838=20
52 16 37 210.00157725 0 - 14.8838=20
53 16 37 210.00154749 0 - 14.8838=20
54 16 37 210.00151884 0 - 14.8838=20
55 16 37 210.00149122 0 - 14.8838=20
56 16 37 210.00146459 0 - 14.8838=20
57 16 37 21 0.0014389 0 - 14.8838=20
58 16 37 210.00141409 0 - 14.8838=20
59 16 37 210.00139012 0 - 14.8838=20
2012-10-16 16:10:58.560825min lat: 0.258984 max lat: 23.8748 avg lat: 1=
4.8838=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
60 16 37 210.00136695 0 - 14.8838=20
61 16 37 210.00134454 0 - 14.8838=20
62 16 37 210.00132286 0 - 14.8838=20
63 16 37 210.00130186 0 - 14.8838=20
64 16 37 210.00128152 0 - 14.8838=20
65 16 37 21 0.0012618 0 - 14.8838=20
66 6 38 320.001893610.00104802 44.154 25.6537=20
67 6 38 320.00186535 0 - 25.6537=20
Total time run: 67.779471=20
Total writes made: 38=20
Write size: 4096=20
Bandwidth (MB/sec): 0.002=20

Stddev Bandwidth: 0.00555568=20
Max bandwidth (MB/sec): 0.0429688=20
Min bandwidth (MB/sec): 0=20
Average Latency: 27.8774=20
Stddev Latency: 17.9306=20
Max latency: 64.4662=20
Min latency: 0.258984=20

root@cc[staging]:/var/images# rados -p todo-list-test bench 60 write=20
-b 4096 -t 16=20
Maintaining 16 concurrent writes of 4096 bytes for at least 60 seconds.=
=20
Object prefix: benchmark_data_cc_20637=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
0 0 0 0 0 0 - 0=20
1 16 129 113 0.441308 0.441406 0.089088 0.130034=20
2 16 228 212 0.413976 0.386719 0.170227 0.144586=20
3 16 324 308 0.400965 0.375 0.17551 0.149879=20
4 16 481 465 0.454019 0.613281 0.081618 0.136798=20
5 16 628 612 0.478042 0.574219 0.080181 0.124768=20
6 16 641 625 0.406831 0.0507812 0.707781 0.136926=20
7 16 641 625 0.348713 0 - 0.136926=20
8 16 659 643 0.313911 0.0351562 0.281386 0.193741=20
9 16 739 723 0.313749 0.3125 0.177852 0.196558=20
10 16 865 849 0.331585 0.492188 0.142906 0.18791=20
11 16 1009 993 0.352569 0.5625 0.089554 0.176182=20
12 16 1059 1043 0.339462 0.195312 0.132217 0.174339=20
13 16 1075 1059 0.318157 0.0625 1.57543 0.195923=20
14 16 1075 1059 0.295431 0 - 0.195923=20
15 16 1076 1060 0.2759960.00195312 2.07952 0.1977=20
16 16 1156 1140 0.278275 0.3125 0.158087 0.22184=20
17 16 1204 1188 0.272933 0.1875 0.08167 0.223639=20
18 16 1221 1205 0.261459 0.0664062 0.714995 0.236254=20
19 16 1222 1206 0.2479040.00390625 0.293113 0.236301=20
2012-10-16 16:14:21.879463min lat: 0.066844 max lat: 2.96921 avg lat: 0=
=2E247091=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
20 16 1302 1286 0.251131 0.3125 0.19978 0.247091=20
21 16 1317 1301 0.241961 0.0585938 0.203456 0.246584=20
22 16 1399 1383 0.24552 0.320312 0.158703 0.253264=20
23 16 1511 1495 0.253864 0.4375 0.164127 0.245372=20
24 16 1654 1638 0.266557 0.558594 0.086673 0.234202=20
25 16 1718 1702 0.265894 0.25 0.27639 0.230337=20
26 16 1720 1704 0.255967 0.0078125 1.58549 0.231933=20
27 16 1785 1769 0.255889 0.253906 0.140973 0.238474=20
28 16 1816 1800 0.251075 0.121094 0.179986 0.247877=20
29 16 1913 1897 0.25548 0.378906 0.103972 0.243542=20
30 16 2057 2041 0.265712 0.5625 0.071993 0.234536=20
31 16 2233 2217 0.279314 0.6875 0.090504 0.223128=20
32 16 2264 2248 0.274369 0.121094 0.11962 0.221455=20
33 16 2281 2265 0.268067 0.0664062 0.22729 0.232648=20
34 16 2281 2265 0.260183 0 - 0.232648=20
35 16 2298 2282 0.254646 0.0332031 0.227998 0.244199=20
36 16 2425 2409 0.261351 0.496094 0.116612 0.238956=20
37 16 2553 2537 0.267798 0.5 0.126228 0.232921=20
38 16 2652 2636 0.270926 0.386719 0.12253 0.229696=20
39 16 2665 2649 0.265281 0.0507812 0.205365 0.229567=20
2012-10-16 16:14:41.882716min lat: 0.066844 max lat: 2.96921 avg lat: 0=
=2E234852=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
40 16 2730 2714 0.264996 0.253906 0.116825 0.234852=20
41 16 2730 2714 0.258532 0 - 0.234852=20
42 16 2747 2731 0.253958 0.0332031 0.155447 0.245442=20
43 16 2844 2828 0.256862 0.378906 0.159537 0.242571=20
44 16 2892 2876 0.255285 0.1875 0.548109 0.242033=20
45 16 2955 2939 0.25508 0.246094 0.245377 0.243047=20
46 16 2957 2941 0.249705 0.0078125 1.33743 0.243768=20
47 16 3021 3005 0.24971 0.25 0.226326 0.249331=20
48 16 3021 3005 0.244508 0 - 0.249331=20
49 16 3067 3051 0.243184 0.0898438 0.218276 0.255766=20
50 16 3068 3052 0.2383990.00390625 1.28465 0.256103=20
51 16 3068 3052 0.233724 0 - 0.256103=20
52 16 3085 3069 0.230506 0.0332031 0.78895 0.26712=20
53 16 3181 3165 0.233232 0.375 0.128619 0.267592=20
54 16 3244 3228 0.233469 0.246094 0.162226 0.265363=20
55 16 3245 3229 0.2292950.00390625 1.23061 0.265662=20
56 16 3326 3310 0.23085 0.316406 0.130218 0.270394=20
57 16 3421 3405 0.233309 0.371094 0.271192 0.26772=20
58 16 3422 3406 0.2293540.00390625 0.243273 0.267713=20
59 16 3472 3456 0.228777 0.195312 0.172423 0.272543=20
2012-10-16 16:15:01.885897min lat: 0.066844 max lat: 2.96921 avg lat: 0=
=2E271267=20
sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
60 16 3536 3520 0.22913 0.25 0.245948 0.271267=20
61 16 3536 3520 0.225373 0 - 0.271267=20
Total time run: 61.778350=20
Total writes made: 3537=20
Write size: 4096=20
Bandwidth (MB/sec): 0.224=20

Stddev Bandwidth: 0.199931=20
Max bandwidth (MB/sec): 0.6875=20
Min bandwidth (MB/sec): 0=20
Average Latency: 0.278853=20
Stddev Latency: 0.441319=20
Max latency: 2.96921=20
Min latency: 0.066844=20

The biggest problem in my clusters is poor performance. Simple insert=20
to the database on the client often takes seconds. It is unacceptable=20
and I am trying to find the bottleneck. Could you please help me with=20
it?=20

Replica count is set to 2. Kernel 3.2.23, ceph 0.52, osd data are=20
stored on the same partition (two 7200rpm disks in raid0) as journal=20
files, filesystem btrfs. Filesystem on n11c1 is 4 months old, n12c1=20
and n14c1 are around 1.5 month old, cc and n3cc is around 3 months=20
old. Both clusters are healthy. Production have around 544 pgs and 46=20
pools, staging 232 and 8 pools.=20

--=20
Regards=20
Maciej Galkiewicz=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
