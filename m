From: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Potential OSD deadlock?
Date: Sun, 4 Oct 2015 18:16:39 +0200
Message-ID: <CAOnYue_X09VQ9gSQDEVWXq1JG=Hz+p8dNkfRd6=vWrkoJdnf3w@mail.gmail.com>
References: <CAANLjFpAXaDWQzumg1hCs=SC_0YvdYDd6vyodz5_ZBNvGWdkSw@mail.gmail.com>
	<CAANLjFob5ZsJzYop0RjQsXw-4UfV4OvdhBjT2sGF-u6gq9NrhQ@mail.gmail.com>
	<CAJ4mKGZ8WhY5JWD2P=5fQ+9EYQazEKETCTg8gU6qcZ03V3jrVw@mail.gmail.com>
	<CAANLjFrcx_M7BxW5UCZxUk_Y7-s3NneBevnP+JHU0PA8pazpAw@mail.gmail.com>
	<CAJ4mKGZLD4QfAfhZEXAe6KSbq9Z6wPXdUes_GJunfgnTf+K0Yg@mail.gmail.com>
	<CAANLjFqn8t+w3hACiCvgi2zpG4TGFYzmAW5ocsa1TOjqueY6QQ@mail.gmail.com>
	<CAJ4mKGY-XcFvbzSCRH4d5qJuwNE1uQ0Kdj7UCq5p0saFyaoiBA@mail.gmail.com>
	<CAANLjFrDqHhAtWPqBV+QEDcFU6xNum37puO6XHZE0zhNp9reSQ@mail.gmail.com>
	<CAJ4mKGYdJJfFERrOrdN7T8SzhdcyKhSDqJ69wOiee2aVj8vpEA@mail.gmail.com>
	<CAANLjFqbt0y-Ri=q6hXuuS06Sgi1S6phRdb1MJTgR6LTyHPtvw@mail.gmail.com>
	<CAN=+7FVo6D2AoufELCP_qeiJ23i0XEOqQs_yYLrFNXwiiQSthw@mail.gmail.com>
	<alpine.DEB.2.00.1509221450490.11876@cobra.newdream.net>
	<CAANLjFoK4O-3GB_1b40xp-5RtbZhdSXJT5+ydUDX+dq=dBHR8w@mail.gmail.com>
	<CAANLjFrrAyhJ=JR0+K3SX6G1ZsdcUyhTqFzUn_A0+bSh0D=bkA@mail.gmail.com>
	<5602F921.3010204@redhat.com>
	<CAANLjFqTW3750rw6zCnNfcD41GjYxer05m--JAWx-YLnaxcg-Q@mail.gmail.com>
	<CAANLjFrw0AtqvHu5ioRPH7yKjV5ZqfnGKou+fKLTZukLTnLbgw@mail.gmail.com>
	<CAANLjFoafHQ1X8U7LUrvhh2h8fu3WgNpUsMDR+QkSWpfW8ad0g@mail.gmail.com>
	<CAOnYue-T061jkAvpe3cwH7Et4xXY_dkW73KyKcbwiefgzgs8cA@mail.gmail.com>
	<CAANLjFosyB_cqk19Ax=5wgXDnSGOOa-_5sY1FuCZyYTx3rS9JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340533483=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFosyB_cqk19Ax=5wgXDnSGOOa-_5sY1FuCZyYTx3rS9JQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1340533483==
Content-Type: multipart/alternative; boundary=f46d044287d2ca28d3052149b818

--f46d044287d2ca28d3052149b818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I would start with defrag the drives, the good part is that you can just
run the defrag with the time parameter and it will take all available xfs
drives.
On 4 Oct 2015 6:13 pm, "Robert LeBlanc" <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> These are Toshiba MG03ACA400 drives.
>
> sd{a,b} are 4TB on 00:1f.2 SATA controller: Intel Corporation C600/X79 se=
ries chipset 6-Port SATA AHCI Controller (rev 05) at 3.0 Gb
> sd{c,d} are 4TB on 00:1f.2 SATA controller: Intel Corporation C600/X79 se=
ries chipset 6-Port SATA AHCI Controller (rev 05) at 6.0 Gb
> sde is SATADOM with OS install
> sd{f..i,l,m} are 4TB on 01:00.0 Serial Attached SCSI controller: LSI Logi=
c / Symbios Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
> sd{j,k} are 240 GB Intel SSDSC2BB240G4 on 01:00.0 Serial Attached SCSI co=
ntroller: LSI Logic / Symbios Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (r=
ev 05)
>
> There is probably some performance optimization that we can do in this ar=
ea, however unless I'm missing something, I don't see anything that should =
cause I/O to take 30-60+ seconds to complete from a disk standpoint.
>
> [root@ceph1 ~]# for i in {{a..d},{f..i},{l,m}}; do echo -n "sd${i}1: "; x=
fs_db -c frag -r /dev/sd${i}1; done
> sda1: actual 924229, ideal 414161, fragmentation factor 55.19%
> sdb1: actual 1703083, ideal 655321, fragmentation factor 61.52%
> sdc1: actual 2161827, ideal 746418, fragmentation factor 65.47%
> sdd1: actual 1807008, ideal 654214, fragmentation factor 63.80%
> sdf1: actual 735471, ideal 311837, fragmentation factor 57.60%
> sdg1: actual 1463859, ideal 507362, fragmentation factor 65.34%
> sdh1: actual 1684905, ideal 556571, fragmentation factor 66.97%
> sdi1: actual 1833980, ideal 608499, fragmentation factor 66.82%
> sdl1: actual 1641128, ideal 554364, fragmentation factor 66.22%
> sdm1: actual 2032644, ideal 697129, fragmentation factor 65.70%
>
>
> [root@ceph1 ~]# iostat -xd 2
> Linux 4.2.1-1.el7.elrepo.x86_64 (ceph1)   10/04/2015      _x86_64_       =
 (16 CPU)
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.09     2.06    9.24   36.18   527.28  1743.71   100.0=
0     8.96  197.32   17.50  243.23   4.07  18.47
> sdb               0.17     3.61   16.70   74.44   949.65  2975.30    86.1=
3     6.74   73.95   23.94   85.16   4.31  39.32
> sdc               0.14     4.67   15.69   87.80   818.02  3860.11    90.4=
1     9.56   92.38   26.73  104.11   4.44  45.91
> sdd               0.17     3.43    7.16   69.13   480.96  2847.42    87.2=
5     4.80   62.89   30.00   66.30   4.33  33.00
> sde               0.01     1.13    0.34    0.99     8.35    12.01    30.6=
2     0.01    7.37    2.64    9.02   1.64   0.22
> sdj               0.00     1.22    0.01  348.22     0.03 11302.65    64.9=
1     0.23    0.66    0.14    0.66   0.15   5.15
> sdk               0.00     1.99    0.01  369.94     0.03 12876.74    69.6=
1     0.26    0.71    0.13    0.71   0.16   5.75
> sdf               0.01     1.79    1.55   31.12    39.64  1431.37    90.0=
6     4.07  124.67   16.25  130.05   3.11  10.17
> sdi               0.22     3.17   23.92   72.90  1386.45  2676.28    83.9=
3     7.75   80.00   24.31   98.27   4.31  41.77
> sdm               0.16     3.10   17.63   72.84   986.29  2767.24    82.9=
8     6.57   72.64   23.67   84.50   4.23  38.30
> sdl               0.11     3.01   12.10   55.14   660.85  2361.40    89.8=
9    17.87  265.80   21.64  319.36   4.08  27.45
> sdg               0.08     2.45    9.75   53.90   489.67  1929.42    76.0=
1    17.27  271.30   20.77  316.61   3.98  25.33
> sdh               0.10     2.76   11.28   60.97   600.10  2114.48    75.1=
4     1.70   23.55   22.92   23.66   4.10  29.60
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    0.50    0.00   146.00     0.00   584.0=
0     0.01   16.00   16.00    0.00  16.00   0.80
> sdb               0.00     0.50    9.00  119.00  2036.00  2578.00    72.0=
9     0.68    5.50    7.06    5.39   2.36  30.25
> sdc               0.00     4.00   34.00  129.00   494.00  6987.75    91.8=
0     1.70   10.44   17.00    8.72   4.44  72.40
> sdd               0.00     1.50    1.50   95.50    74.00  2396.50    50.9=
4     0.85    8.75   23.33    8.52   7.53  73.05
> sde               0.00    37.00   11.00    1.00    46.00   152.00    33.0=
0     0.01    1.00    0.64    5.00   0.54   0.65
> sdj               0.00     0.50    0.00  970.50     0.00 12594.00    25.9=
5     0.09    0.09    0.00    0.09   0.08   8.20
> sdk               0.00     0.00    0.00  977.50     0.00 12016.00    24.5=
9     0.10    0.10    0.00    0.10   0.09   8.90
> sdf               0.00     0.50    0.50   37.50     2.00   230.25    12.2=
2     9.63   10.58    8.00   10.61   1.79   6.80
> sdi               2.00     0.00   10.50    0.00  2528.00     0.00   481.5=
2     0.10    9.33    9.33    0.00   7.76   8.15
> sdm               0.00     0.50   15.00  116.00   546.00   833.25    21.0=
6     0.94    7.17   14.03    6.28   4.13  54.15
> sdl               0.00     0.00    3.00    0.00    26.00     0.00    17.3=
3     0.02    7.50    7.50    0.00   7.50   2.25
> sdg               0.00     3.50    1.00   64.50     4.00  2929.25    89.5=
6     0.40    6.04    9.00    5.99   3.42  22.40
> sdh               0.50     0.50    4.00   64.00   770.00  1105.00    55.1=
5     4.96  189.42   21.25  199.93   4.21  28.60
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    8.50    0.00   110.00     0.00    25.8=
8     0.01    1.59    1.59    0.00   1.53   1.30
> sdb               0.00     4.00    6.50  117.50   494.00  4544.50    81.2=
7     0.87    6.99   11.62    6.73   3.28  40.70
> sdc               0.00     0.50    5.50  202.50   526.00  4123.00    44.7=
0     1.80    8.66   18.73    8.39   2.08  43.30
> sdd               0.00     3.00    2.50  227.00   108.00  6952.00    61.5=
3    46.10  197.44   30.20  199.29   3.86  88.60
> sde               0.00     0.00    0.00    1.50     0.00     6.00     8.0=
0     0.00    2.33    0.00    2.33   1.33   0.20
> sdj               0.00     0.00    0.00  834.00     0.00  9912.00    23.7=
7     0.08    0.09    0.00    0.09   0.08   6.75
> sdk               0.00     0.00    0.00  777.00     0.00 12318.00    31.7=
1     0.12    0.15    0.00    0.15   0.10   7.70
> sdf               0.00     1.00    4.50  117.00   198.00   693.25    14.6=
7    34.86  362.88   84.33  373.60   3.59  43.65
> sdi               0.00     0.00    1.50    0.00     6.00     0.00     8.0=
0     0.01    9.00    9.00    0.00   9.00   1.35
> sdm               0.50     3.00    3.50  143.00  1014.00  4205.25    71.2=
5     0.93    5.95   20.43    5.59   3.08  45.15
> sdl               0.50     0.00    8.00  148.50  1578.00  2128.50    47.3=
7     0.82    5.27    6.44    5.21   3.40  53.20
> sdg               1.50     2.00   10.50  100.50  2540.00  2039.50    82.5=
1     0.77    7.00   14.19    6.25   5.42  60.20
> sdh               0.50     0.00    5.00    0.00  1050.00     0.00   420.0=
0     0.04    7.10    7.10    0.00   7.10   3.55
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    6.00    0.00   604.00     0.00   201.3=
3     0.03    5.58    5.58    0.00   5.58   3.35
> sdb               0.00     6.00    7.00  236.00   132.00  8466.00    70.7=
7    45.48  186.59   31.79  191.18   1.62  39.45
> sdc               2.00     0.00   19.50   46.50  6334.00   686.00   212.7=
3     0.39    5.96    7.97    5.12   3.57  23.55
> sdd               0.00     1.00    3.00   20.00    72.00  1527.25   139.0=
7     0.31   47.67    6.17   53.90   3.11   7.15
> sde               0.00    17.00    0.00    4.50     0.00   184.00    81.7=
8     0.01    2.33    0.00    2.33   2.33   1.05
> sdj               0.00     0.00    0.00  805.50     0.00 12760.00    31.6=
8     0.21    0.27    0.00    0.27   0.09   7.35
> sdk               0.00     0.00    0.00  438.00     0.00 14300.00    65.3=
0     0.24    0.54    0.00    0.54   0.13   5.65
> sdf               0.00     0.00    1.00    0.00     6.00     0.00    12.0=
0     0.00    2.50    2.50    0.00   2.50   0.25
> sdi               0.00     5.50   14.50   27.50   394.00  6459.50   326.3=
6     0.86   20.18   11.00   25.02   7.42  31.15
> sdm               0.00     1.00    9.00  175.00   554.00  3173.25    40.5=
1     1.12    6.38    7.22    6.34   2.41  44.40
> sdl               0.00     2.00    2.50  100.50    26.00  2483.00    48.7=
2     0.77    7.47   11.80    7.36   2.10  21.65
> sdg               0.00     4.50    9.00  214.00   798.00  7417.00    73.6=
8    66.56  298.46   28.83  309.80   3.35  74.70
> sdh               0.00     0.00   16.50    0.00   344.00     0.00    41.7=
0     0.09    5.61    5.61    0.00   4.55   7.50
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               1.00     0.00    9.00    0.00  3162.00     0.00   702.6=
7     0.07    8.06    8.06    0.00   6.06   5.45
> sdb               0.50     0.00   12.50   13.00  1962.00   298.75   177.3=
1     0.63   30.00    4.84   54.19   9.96  25.40
> sdc               0.00     0.50    3.50  131.00    18.00  1632.75    24.5=
5     0.87    6.48   16.86    6.20   3.51  47.25
> sdd               0.00     0.00    4.00    0.00    72.00    16.00    44.0=
0     0.26   10.38   10.38    0.00  23.38   9.35
> sde               0.00     0.00    0.00    0.00     0.00     0.00     0.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdj               0.00     0.00    0.00  843.50     0.00 16334.00    38.7=
3     0.19    0.23    0.00    0.23   0.11   9.10
> sdk               0.00     0.00    0.00  803.00     0.00 10394.00    25.8=
9     0.07    0.08    0.00    0.08   0.08   6.25
> sdf               0.00     4.00   11.00   90.50   150.00  2626.00    54.7=
0     0.59    5.84    3.82    6.08   4.06  41.20
> sdi               0.00     3.50   17.50  130.50  2132.00  6309.50   114.0=
7     1.84   12.55   25.60   10.80   5.76  85.30
> sdm               0.00     4.00    2.00  139.00    44.00  1957.25    28.3=
9     0.89    6.28   14.50    6.17   3.55  50.10
> sdl               0.00     0.50   12.00  101.00   334.00  1449.75    31.5=
7     0.94    8.28   10.17    8.06   2.11  23.85
> sdg               0.00     0.00    2.50    3.00   204.00    17.00    80.3=
6     0.02    5.27    4.60    5.83   3.91   2.15
> sdh               0.00     0.50    9.50   32.50  1810.00   199.50    95.6=
9     0.28    6.69    3.79    7.54   5.12  21.50
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.50     0.50   25.00   24.50  1248.00   394.25    66.3=
5     0.76   15.30   11.62   19.06   5.25  26.00
> sdb               1.50     0.00   13.50   30.00  2628.00   405.25   139.4=
6     0.27    5.94    8.19    4.93   5.31  23.10
> sdc               0.00     6.00    3.00  163.00    60.00  9889.50   119.8=
7     1.66    9.83   28.67    9.48   5.95  98.70
> sdd               0.00    11.00    5.50  353.50    50.00  2182.00    12.4=
3   118.42  329.26   30.27  333.91   2.78  99.90
> sde               0.00     5.50    0.00    1.50     0.00    28.00    37.3=
3     0.00    2.33    0.00    2.33   2.33   0.35
> sdj               0.00     0.00    0.00 1227.50     0.00 22064.00    35.9=
5     0.50    0.41    0.00    0.41   0.10  12.50
> sdk               0.00     0.50    0.00 1073.50     0.00 19248.00    35.8=
6     0.24    0.23    0.00    0.23   0.10  10.40
> sdf               0.00     4.00    0.00  109.00     0.00  4145.00    76.0=
6     0.59    5.44    0.00    5.44   3.63  39.55
> sdi               0.00     1.00    8.50   95.50   218.00  2091.75    44.4=
2     1.06    9.70   18.71    8.90   7.00  72.80
> sdm               0.00     0.00    8.00  177.50    82.00  3173.00    35.0=
9     1.24    6.65   14.31    6.30   3.53  65.40
> sdl               0.00     3.50    3.00  187.50    32.00  2175.25    23.1=
7     1.47    7.68   18.50    7.50   3.85  73.35
> sdg               0.00     0.00    1.00    0.00    12.00     0.00    24.0=
0     0.00    1.50    1.50    0.00   1.50   0.15
> sdh               0.50     1.00   14.00  169.50  2364.00  4568.00    75.5=
5     1.50    8.12   21.25    7.03   4.91  90.10
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     4.00    3.00   60.00   212.00  2542.00    87.4=
3     0.58    8.02   15.50    7.64   7.95  50.10
> sdb               0.00     0.50    2.50   98.00   682.00  1652.00    46.4=
5     0.51    5.13    6.20    5.10   3.05  30.65
> sdc               0.00     2.50    4.00  146.00    16.00  4623.25    61.8=
6     1.07    7.33   13.38    7.17   2.22  33.25
> sdd               0.00     0.50    9.50   30.00   290.00   358.00    32.8=
1     0.84   32.22   49.16   26.85  12.28  48.50
> sde               0.00     0.00    0.00    0.00     0.00     0.00     0.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdj               0.00     0.50    0.00  530.00     0.00  7138.00    26.9=
4     0.06    0.11    0.00    0.11   0.09   4.65
> sdk               0.00     0.00    0.00  625.00     0.00  8254.00    26.4=
1     0.07    0.12    0.00    0.12   0.09   5.75
> sdf               0.00     0.00    0.00    4.00     0.00    18.00     9.0=
0     0.01    3.62    0.00    3.62   3.12   1.25
> sdi               0.00     2.50    8.00   61.00   836.00  2681.50   101.9=
6     0.58    9.25   15.12    8.48   6.71  46.30
> sdm               0.00     4.50   11.00  273.00  2100.00  8562.00    75.0=
8    13.49   47.53   24.95   48.44   1.83  52.00
> sdl               0.00     1.00    0.50   49.00     2.00  1038.00    42.0=
2     0.23    4.83   14.00    4.73   2.45  12.15
> sdg               0.00     0.00    0.00    0.00     0.00     0.00     0.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdh               1.00     1.00    9.00  109.00  2082.00  2626.25    79.8=
0     0.85    7.34    7.83    7.30   3.83  45.20
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     1.50   10.00  177.00   284.00  4857.00    54.9=
8    36.26  194.27   21.85  204.01   3.53  66.00
> sdb               1.00     0.50   39.50  119.50  1808.00  2389.25    52.8=
0     1.58    9.96   12.32    9.18   2.42  38.45
> sdc               0.00     2.00   15.00  200.50   116.00  4951.00    47.0=
3    14.37   66.70   73.87   66.16   2.23  47.95
> sdd               0.00     3.50    6.00   54.50   180.00  2360.50    83.9=
8     0.69   11.36   20.42   10.36   7.99  48.35
> sde               0.00     7.50    0.00   32.50     0.00   160.00     9.8=
5     1.64   50.51    0.00   50.51   1.48   4.80
> sdj               0.00     0.00    0.00  835.00     0.00 10198.00    24.4=
3     0.07    0.09    0.00    0.09   0.08   6.50
> sdk               0.00     0.00    0.00  802.00     0.00 12534.00    31.2=
6     0.23    0.29    0.00    0.29   0.10   8.05
> sdf               0.00     2.50    2.00  133.50    14.00  5272.25    78.0=
3     4.37   32.21    4.50   32.63   1.73  23.40
> sdi               0.00     4.50   17.00  125.50  2676.00  8683.25   159.4=
3     1.86   13.02   27.97   11.00   4.95  70.55
> sdm               0.00     0.00    7.00    0.50   540.00    32.00   152.5=
3     0.05    7.07    7.57    0.00   7.07   5.30
> sdl               0.00     7.00   27.00  276.00  2374.00 11955.50    94.5=
8    25.87   85.36   15.20   92.23   1.84  55.90
> sdg               0.00     0.00   45.00    0.00   828.00     0.00    36.8=
0     0.07    1.62    1.62    0.00   0.68   3.05
> sdh               0.00     0.50    0.50   65.50     2.00  1436.25    43.5=
8     0.51    7.79   16.00    7.73   3.61  23.80
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     8.00   14.50  150.00   122.00   929.25    12.7=
8    20.65   70.61    7.55   76.71   1.46  24.05
> sdb               0.00     5.00    8.00  283.50    86.00  2757.50    19.5=
1    69.43  205.40   51.75  209.73   2.40  69.85
> sdc               0.00     0.00   12.50    1.50   350.00    48.25    56.8=
9     0.25   17.75   17.00   24.00   4.75   6.65
> sdd               0.00     3.50   36.50  141.00   394.00  2338.75    30.7=
9     1.50    8.42   16.16    6.41   4.56  80.95
> sde               0.00     1.50    0.00    1.00     0.00    10.00    20.0=
0     0.00    2.00    0.00    2.00   2.00   0.20
> sdj               0.00     0.00    0.00 1059.00     0.00 18506.00    34.9=
5     0.19    0.18    0.00    0.18   0.10  10.75
> sdk               0.00     0.00    0.00 1103.00     0.00 14220.00    25.7=
8     0.09    0.08    0.00    0.08   0.08   8.35
> sdf               0.00     5.50    2.00   19.50     8.00  5158.75   480.6=
3     0.17    8.05    6.50    8.21   6.95  14.95
> sdi               0.00     5.50   28.00  224.50  2210.00  8971.75    88.5=
7   122.15  328.47   27.43  366.02   3.71  93.70
> sdm               0.00     0.00   13.00    4.00   718.00    16.00    86.3=
5     0.15    3.76    4.23    2.25   3.62   6.15
> sdl               0.00     0.00   16.50    0.00   832.00     0.00   100.8=
5     0.02    1.12    1.12    0.00   1.09   1.80
> sdg               0.00     2.50   17.00   23.50  1032.00  3224.50   210.2=
0     0.25    6.25    2.56    8.91   3.41  13.80
> sdh               0.00    10.50    4.50  241.00    66.00  7252.00    59.6=
2    23.00   91.66    4.22   93.29   2.11  51.85
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.50    3.50   91.00    92.00   552.75    13.6=
5    36.27  479.41   81.57  494.71   5.65  53.35
> sdb               0.00     1.00    6.00  168.00   224.00   962.50    13.6=
4    83.35  533.92   62.00  550.77   5.75 100.00
> sdc               0.00     1.00    3.00  171.00    16.00  1640.00    19.0=
3     1.08    6.18   11.83    6.08   3.15  54.80
> sdd               0.00     5.00    5.00  107.50   132.00  6576.75   119.2=
7     0.79    7.06   18.80    6.51   5.13  57.70
> sde               0.00     0.00    0.00    0.00     0.00     0.00     0.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdj               0.00     0.00    0.00 1111.50     0.00 22346.00    40.2=
1     0.27    0.24    0.00    0.24   0.11  12.10
> sdk               0.00     0.00    0.00 1022.00     0.00 33040.00    64.6=
6     0.68    0.67    0.00    0.67   0.13  13.60
> sdf               0.00     5.50    2.50   91.00    12.00  4977.25   106.7=
2     2.29   24.48   14.40   24.76   2.42  22.60
> sdi               0.00     0.00   10.00   69.50   368.00   858.50    30.8=
6     7.40  586.41    5.50  669.99   4.21  33.50
> sdm               0.00     4.00    8.00  210.00   944.00  5833.50    62.1=
8     1.57    7.62   18.62    7.20   4.57  99.70
> sdl               0.00     0.00    7.50   22.50   104.00   253.25    23.8=
2     0.14    4.82    5.07    4.73   4.03  12.10
> sdg               0.00     4.00    1.00   84.00     4.00  3711.75    87.4=
3     0.58    6.88   12.50    6.81   5.75  48.90
> sdh               0.00     3.50    7.50   44.00    72.00  2954.25   117.5=
2     1.54   39.50   61.73   35.72   6.40  32.95
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    1.00    0.00    20.00     0.00    40.0=
0     0.01   14.50   14.50    0.00  14.50   1.45
> sdb               0.00     7.00   10.50  198.50  2164.00  6014.75    78.2=
7     1.94    9.29   28.90    8.25   4.77  99.75
> sdc               0.00     2.00    4.00   95.50   112.00  5152.25   105.8=
1     0.94    9.46   24.25    8.84   4.68  46.55
> sdd               0.00     1.00    2.00  131.00    10.00  7167.25   107.9=
3     4.55   34.23   83.25   33.48   2.52  33.55
> sde               0.00     0.00    0.00    0.50     0.00     2.00     8.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdj               0.00     0.00    0.00  541.50     0.00  6468.00    23.8=
9     0.05    0.10    0.00    0.10   0.09   5.00
> sdk               0.00     0.00    0.00  509.00     0.00  7704.00    30.2=
7     0.07    0.14    0.00    0.14   0.10   4.85
> sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdi               0.00     0.00    3.50    0.00    90.00     0.00    51.4=
3     0.04   10.14   10.14    0.00  10.14   3.55
> sdm               0.00     2.00    5.00  102.50  1186.00  4583.00   107.3=
3     0.81    7.56   23.20    6.80   2.78  29.85
> sdl               0.00    14.00   10.00  216.00   112.00  3645.50    33.2=
5    73.45  311.05   46.30  323.31   3.51  79.35
> sdg               0.00     1.00    0.00   52.50     0.00   240.00     9.1=
4     0.25    4.76    0.00    4.76   4.48  23.50
> sdh               0.00     0.00    3.50    0.00    18.00     0.00    10.2=
9     0.02    7.00    7.00    0.00   7.00   2.45
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    1.00    0.00     4.00     0.00     8.0=
0     0.01   14.50   14.50    0.00  14.50   1.45
> sdb               0.00     9.00    2.00  292.00   192.00 10925.75    75.6=
3    36.98  100.27   54.75  100.58   2.95  86.60
> sdc               0.00     9.00   10.50  151.00    78.00  6771.25    84.8=
2    36.06   94.60   26.57   99.33   3.77  60.85
> sdd               0.00     0.00    5.00    1.00    74.00    24.00    32.6=
7     0.03    5.00    6.00    0.00   5.00   3.00
> sde               0.00     0.00    0.00    0.00     0.00     0.00     0.0=
0     0.00    0.00    0.00    0.00   0.00   0.00
> sdj               0.00     0.00    0.00  787.50     0.00  9418.00    23.9=
2     0.07    0.10    0.00    0.10   0.09   6.70
> sdk               0.00     0.00    0.00  766.50     0.00  9400.00    24.5=
3     0.08    0.11    0.00    0.11   0.10   7.70
> sdf               0.00     0.00    0.50   41.50     6.00   391.00    18.9=
0     0.24    5.79    9.00    5.75   5.50  23.10
> sdi               0.00    10.00    9.00  268.00    92.00  1618.75    12.3=
5    68.20  150.90   15.50  155.45   2.36  65.30
> sdm               0.00    11.50   10.00  330.50    72.00  3201.25    19.2=
3    68.83  139.38   37.45  142.46   1.84  62.80
> sdl               0.00     2.50    2.50  228.50    14.00  2526.00    21.9=
9    90.42  404.71  242.40  406.49   4.33 100.00
> sdg               0.00     5.50    7.50  298.00    68.00  5275.25    34.9=
8    75.31  174.85   26.73  178.58   2.67  81.60
> sdh               0.00     0.00    2.50    2.00    28.00    24.00    23.1=
1     0.01    2.78    5.00    0.00   2.78   1.25
>
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
> On Sun, Oct 4, 2015 at 12:16 AM, Josef Johansson  wrote:
> Hi,
>
> I don't know what brand those 4TB spindles are, but I know that mine are =
very bad at doing write at the same time as read. Especially small read wri=
te.
>
> This has an absurdly bad effect when doing maintenance on ceph. That bein=
g said we see a lot of difference between dumpling and hammer in performanc=
e on these drives. Most likely due to hammer able to read write degraded PG=
s.
>
> We have run into two different problems along the way, the first was bloc=
ked request where we had to upgrade from 64GB mem on each node to 256GB. We=
 thought that it was the only safe buy make things better.
>
> I believe it worked because more reads were cached so we had less mixed r=
ead write on the nodes, thus giving the spindles more room to breath. Now t=
his was a shot in the dark then, but the price is not that high even to jus=
t try it out.. compared to 6 people working on it. I believe the IO on disk=
 was not huge either, but what kills the disk is high latency. How much ban=
dwidth are the disk using? We had very low.. 3-5MB/s.
>
> The second problem was defragmentations hitting 70%, lowering that to 6% =
made a lot of difference. Depending on IO pattern this increases different.
>
> TL;DR read kills the 4TB spindles.
>
> Hope you guys clear out of the woods.
> /Josef
>
> On 3 Oct 2015 10:10 pm, "Robert LeBlanc"  wrote:
> - -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> We are still struggling with this and have tried a lot of different
> things. Unfortunately, Inktank (now Red Hat) no longer provides
> consulting services for non-Red Hat systems. If there are some
> certified Ceph consultants in the US that we can do both remote and
> on-site engagements, please let us know.
>
> This certainly seems to be network related, but somewhere in the
> kernel. We have tried increasing the network and TCP buffers, number
> of TCP sockets, reduced the FIN_WAIT2 state. There is about 25% idle
> on the boxes, the disks are busy, but not constantly at 100% (they
> cycle from <10% up to 100%, but not 100% for more than a few seconds
> at a time). There seems to be no reasonable explanation why I/O is
> blocked pretty frequently longer than 30 seconds. We have verified
> Jumbo frames by pinging from/to each node with 9000 byte packets. The
> network admins have verified that packets are not being dropped in the
> switches for these nodes. We have tried different kernels including
> the recent Google patch to cubic. This is showing up on three cluster
> (two Ethernet and one IPoIB). I booted one cluster into Debian Jessie
> (from CentOS 7.1) with similar results.
>
> The messages seem slightly different:
> 2015-10-03 14:38:23.193082 osd.134 10.208.16.25:6800/1425 439 :
> cluster [WRN] 14 slow requests, 1 included below; oldest blocked for >
> 100.087155 secs
> 2015-10-03 14:38:23.193090 osd.134 10.208.16.25:6800/1425 440 :
> cluster [WRN] slow request 30.041999 seconds old, received at
> 2015-10-03 14:37:53.151014: osd_op(client.1328605.0:7082862
> rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~4096]
> 11.6d19c36f ack+read+known_if_redirected e10249) currently no flag
> points reached
>
> I don't know what "no flag points reached" means.
>
> The problem is most pronounced when we have to reboot an OSD node (1
> of 13), we will have hundreds of I/O blocked for some times up to 300
> seconds. It takes a good 15 minutes for things to settle down. The
> production cluster is very busy doing normally 8,000 I/O and peaking
> at 15,000. This is all 4TB spindles with SSD journals and the disks
> are between 25-50% full. We are currently splitting PGs to distribute
> the load better across the disks, but we are having to do this 10 PGs
> at a time as we get blocked I/O. We have max_backfills and
> max_recovery set to 1, client op priority is set higher than recovery
> priority. We tried increasing the number of op threads but this didn't
> seem to help. It seems as soon as PGs are finished being checked, they
> become active and could be the cause for slow I/O while the other PGs
> are being checked.
>
> What I don't understand is that the messages are delayed. As soon as
> the message is received by Ceph OSD process, it is very quickly
> committed to the journal and a response is sent back to the primary
> OSD which is received very quickly as well. I've adjust
> min_free_kbytes and it seems to keep the OSDs from crashing, but
> doesn't solve the main problem. We don't have swap and there is 64 GB
> of RAM per nodes for 10 OSDs.
>
> Is there something that could cause the kernel to get a packet but not
> be able to dispatch it to Ceph such that it could be explaining why we
> are seeing these blocked I/O for 30+ seconds. Is there some pointers
> to tracing Ceph messages from the network buffer through the kernel to
> the Ceph process?
>
> We can really use some pointers no matter how outrageous. We've have
> over 6 people looking into this for weeks now and just can't think of
> anything else.
>
> Thanks,
> - -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.1.0
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzStar
> NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN6F1
> prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvrqP6
> K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfCFe2
> h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+nxm
> iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahzkGF
> Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyidWyY
> Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZIoHb
> JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYEoYT
> 8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlYrGm
> lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYhheg
> 4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdNDpk
> l7OF
> =3DOI++
> - -----END PGP SIGNATURE-----
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc  wrote:
> > We dropped the replication on our cluster from 4 to 3 and it looks
> > like all the blocked I/O has stopped (no entries in the log for the
> > last 12 hours). This makes me believe that there is some issue with
> > the number of sockets or some other TCP issue. We have not messed with
> > Ephemeral ports and TIME_WAIT at this point. There are 130 OSDs, 8 KVM
> > hosts hosting about 150 VMs. Open files is set at 32K for the OSD
> > processes and 16K system wide.
> >
> > Does this seem like the right spot to be looking? What are some
> > configuration items we should be looking at?
> >
> > Thanks,
> > ----------------
> > Robert LeBlanc
> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >
> >
> > On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc  wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA256
> >>
> >> We were able to only get ~17Gb out of the XL710 (heavily tweaked)
> >> until we went to the 4.x kernel where we got ~36Gb (no tweaking). It
> >> seems that there were some major reworks in the network handling in
> >> the kernel to efficiently handle that network rate. If I remember
> >> right we also saw a drop in CPU utilization. I'm starting to think
> >> that we did see packet loss while congesting our ISLs in our initial
> >> testing, but we could not tell where the dropping was happening. We
> >> saw some on the switches, but it didn't seem to be bad if we weren't
> >> trying to congest things. We probably already saw this issue, just
> >> didn't know it.
> >> - ----------------
> >> Robert LeBlanc
> >> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>
> >>
> >> On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson  wrote:
> >>> FWIW, we've got some 40GbE Intel cards in the community performance c=
luster
> >>> on a Mellanox 40GbE switch that appear (knock on wood) to be running =
fine
> >>> with 3.10.0-229.7.2.el7.x86_64.  We did get feedback from Intel that =
older
> >>> drivers might cause problems though.
> >>>
> >>> Here's ifconfig from one of the nodes:
> >>>
> >>> ens513f1: flags=3D4163  mtu 1500
> >>>         inet 10.0.10.101  netmask 255.255.255.0  broadcast 10.0.10.25=
5
> >>>         inet6 fe80::6a05:caff:fe2b:7ea1  prefixlen 64  scopeid 0x20
> >>>         ether 68:05:ca:2b:7e:a1  txqueuelen 1000  (Ethernet)
> >>>         RX packets 169232242875  bytes 229346261232279 (208.5 TiB)
> >>>         RX errors 0  dropped 0  overruns 0  frame 0
> >>>         TX packets 153491686361  bytes 203976410836881 (185.5 TiB)
> >>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >>>
> >>> Mark
> >>>
> >>>
> >>> On 09/23/2015 01:48 PM, Robert LeBlanc wrote:
> >>>>
> >>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>> Hash: SHA256
> >>>>
> >>>> OK, here is the update on the saga...
> >>>>
> >>>> I traced some more of blocked I/Os and it seems that communication
> >>>> between two hosts seemed worse than others. I did a two way ping flo=
od
> >>>> between the two hosts using max packet sizes (1500). After 1.5M
> >>>> packets, no lost pings. Then then had the ping flood running while I
> >>>> put Ceph load on the cluster and the dropped pings started increasin=
g
> >>>> after stopping the Ceph workload the pings stopped dropping.
> >>>>
> >>>> I then ran iperf between all the nodes with the same results, so tha=
t
> >>>> ruled out Ceph to a large degree. I then booted in the the
> >>>> 3.10.0-229.14.1.el7.x86_64 kernel and with an hour test so far there
> >>>> hasn't been any dropped pings or blocked I/O. Our 40 Gb NICs really
> >>>> need the network enhancements in the 4.x series to work well.
> >>>>
> >>>> Does this sound familiar to anyone? I'll probably start bisecting th=
e
> >>>> kernel to see where this issue in introduced. Both of the clusters
> >>>> with this issue are running 4.x, other than that, they are pretty
> >>>> differing hardware and network configs.
> >>>>
> >>>> Thanks,
> >>>> -----BEGIN PGP SIGNATURE-----
> >>>> Version: Mailvelope v1.1.0
> >>>> Comment: https://www.mailvelope.com
> >>>>
> >>>> wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP/1xmCtW++G11qcE8y/sr
> >>>> RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZpc6t4+m5nzE3LkA1rl2l
> >>>> AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl0594eInEn7eI7crz8R543V
> >>>> 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLINK0Yb9XRVBlFip+Slt+j
> >>>> cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0MOzBkFQM1FHfOipbo/LYv
> >>>> F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/Zxvor2gOi/J6d2XS9ckW
> >>>> byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLsu/6YzeDNI6kmtGURajdE
> >>>> /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEODGAt6byoaoQEGN6dlFGe
> >>>> LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uXm0l1CHcp22RWBDvRinok
> >>>> UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdxGL29iFta4THzJgUGrp98
> >>>> sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkdHX+x1EXpJUtocSeI44LX
> >>>> KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1ULrFX0ILNx5Mo0Rp944X
> >>>> 4OEo
> >>>> =3DP33I
> >>>> -----END PGP SIGNATURE-----
> >>>> ----------------
> >>>> Robert LeBlanc
> >>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>>>
> >>>>
> >>>> On Tue, Sep 22, 2015 at 4:15 PM, Robert LeBlanc
> >>>> wrote:
> >>>>>
> >>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>> Hash: SHA256
> >>>>>
> >>>>> This is IPoIB and we have the MTU set to 64K. There was some issues
> >>>>> pinging hosts with "No buffer space available" (hosts are currently
> >>>>> configured for 4GB to test SSD caching rather than page cache). I
> >>>>> found that MTU under 32K worked reliable for ping, but still had th=
e
> >>>>> blocked I/O.
> >>>>>
> >>>>> I reduced the MTU to 1500 and checked pings (OK), but I'm still see=
ing
> >>>>> the blocked I/O.
> >>>>> - ----------------
> >>>>> Robert LeBlanc
> >>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>>>>
> >>>>>
> >>>>> On Tue, Sep 22, 2015 at 3:52 PM, Sage Weil  wrote:
> >>>>>>
> >>>>>> On Tue, 22 Sep 2015, Samuel Just wrote:
> >>>>>>>
> >>>>>>> I looked at the logs, it looks like there was a 53 second delay
> >>>>>>> between when osd.17 started sending the osd_repop message and whe=
n
> >>>>>>> osd.13 started reading it, which is pretty weird.  Sage, didn't w=
e
> >>>>>>> once see a kernel issue which caused some messages to be mysterio=
usly
> >>>>>>> delayed for many 10s of seconds?
> >>>>>>
> >>>>>>
> >>>>>> Every time we have seen this behavior and diagnosed it in the wild=
 it
> >>>>>> has
> >>>>>> been a network misconfiguration.  Usually related to jumbo frames.
> >>>>>>
> >>>>>> sage
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> What kernel are you running?
> >>>>>>> -Sam
> >>>>>>>
> >>>>>>> On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlanc  wrote:
> >>>>>>>>
> >>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>>>> Hash: SHA256
> >>>>>>>>
> >>>>>>>> OK, looping in ceph-devel to see if I can get some more eyes. I'=
ve
> >>>>>>>> extracted what I think are important entries from the logs for t=
he
> >>>>>>>> first blocked request. NTP is running all the servers so the log=
s
> >>>>>>>> should be close in terms of time. Logs for 12:50 to 13:00 are
> >>>>>>>> available at http://162.144.87.113/files/ceph_block_io.logs.tar.=
xz
> >>>>>>>>
> >>>>>>>> 2015-09-22 12:55:06.500374 - osd.17 gets I/O from client
> >>>>>>>> 2015-09-22 12:55:06.557160 - osd.17 submits I/O to osd.13
> >>>>>>>> 2015-09-22 12:55:06.557305 - osd.17 submits I/O to osd.16
> >>>>>>>> 2015-09-22 12:55:06.573711 - osd.16 gets I/O from osd.17
> >>>>>>>> 2015-09-22 12:55:06.595716 - osd.17 gets ondisk result=3D0 from =
osd.16
> >>>>>>>> 2015-09-22 12:55:06.640631 - osd.16 reports to osd.17 ondisk res=
ult=3D0
> >>>>>>>> 2015-09-22 12:55:36.926691 - osd.17 reports slow I/O > 30.439150=
 sec
> >>>>>>>> 2015-09-22 12:55:59.790591 - osd.13 gets I/O from osd.17
> >>>>>>>> 2015-09-22 12:55:59.812405 - osd.17 gets ondisk result=3D0 from =
osd.13
> >>>>>>>> 2015-09-22 12:56:02.941602 - osd.13 reports to osd.17 ondisk res=
ult=3D0
> >>>>>>>>
> >>>>>>>> In the logs I can see that osd.17 dispatches the I/O to osd.13 a=
nd
> >>>>>>>> osd.16 almost silmutaniously. osd.16 seems to get the I/O right =
away,
> >>>>>>>> but for some reason osd.13 doesn't get the message until 53 seco=
nds
> >>>>>>>> later. osd.17 seems happy to just wait and doesn't resend the da=
ta
> >>>>>>>> (well, I'm not 100% sure how to tell which entries are the actua=
l data
> >>>>>>>> transfer).
> >>>>>>>>
> >>>>>>>> It looks like osd.17 is receiving responses to start the communi=
cation
> >>>>>>>> with osd.13, but the op is not acknowledged until almost a minut=
e
> >>>>>>>> later. To me it seems that the message is getting received but n=
ot
> >>>>>>>> passed to another thread right away or something. This test was =
done
> >>>>>>>> with an idle cluster, a single fio client (rbd engine) with a si=
ngle
> >>>>>>>> thread.
> >>>>>>>>
> >>>>>>>> The OSD servers are almost 100% idle during these blocked I/O
> >>>>>>>> requests. I think I'm at the end of my troubleshooting, so I can=
 use
> >>>>>>>> some help.
> >>>>>>>>
> >>>>>>>> Single Test started about
> >>>>>>>> 2015-09-22 12:52:36
> >>>>>>>>
> >>>>>>>> 2015-09-22 12:55:36.926680 osd.17 192.168.55.14:6800/16726 56 :
> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked =
for >
> >>>>>>>> 30.439150 secs
> >>>>>>>> 2015-09-22 12:55:36.926699 osd.17 192.168.55.14:6800/16726 57 :
> >>>>>>>> cluster [WRN] slow request 30.439150 seconds old, received at
> >>>>>>>> 2015-09-22 12:55:06.487451:
> >>>>>>>>   osd_op(client.250874.0:1388 rbd_data.3380e2ae8944a.00000000000=
00545
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.bbf3e8ff ack+ondisk+write+known_if_redirected e5678=
5)
> >>>>>>>>   currently waiting for subops from 13,16
> >>>>>>>> 2015-09-22 12:55:36.697904 osd.16 192.168.55.13:6800/29410 7 : c=
luster
> >>>>>>>> [WRN] 2 slow requests, 2 included below; oldest blocked for >
> >>>>>>>> 30.379680 secs
> >>>>>>>> 2015-09-22 12:55:36.697918 osd.16 192.168.55.13:6800/29410 8 : c=
luster
> >>>>>>>> [WRN] slow request 30.291520 seconds old, received at 2015-09-22
> >>>>>>>> 12:55:06.406303:
> >>>>>>>>   osd_op(client.250874.0:1384 rbd_data.3380e2ae8944a.00000000000=
00541
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.5fb2123f ack+ondisk+write+known_if_redirected e5678=
5)
> >>>>>>>>   currently waiting for subops from 13,17
> >>>>>>>> 2015-09-22 12:55:36.697927 osd.16 192.168.55.13:6800/29410 9 : c=
luster
> >>>>>>>> [WRN] slow request 30.379680 seconds old, received at 2015-09-22
> >>>>>>>> 12:55:06.318144:
> >>>>>>>>   osd_op(client.250874.0:1382 rbd_data.3380e2ae8944a.00000000000=
0053f
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.312e69ca ack+ondisk+write+known_if_redirected e5678=
5)
> >>>>>>>>   currently waiting for subops from 13,14
> >>>>>>>> 2015-09-22 12:58:03.998275 osd.13 192.168.55.12:6804/4574 130 :
> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked =
for >
> >>>>>>>> 30.954212 secs
> >>>>>>>> 2015-09-22 12:58:03.998286 osd.13 192.168.55.12:6804/4574 131 :
> >>>>>>>> cluster [WRN] slow request 30.954212 seconds old, received at
> >>>>>>>> 2015-09-22 12:57:33.044003:
> >>>>>>>>   osd_op(client.250874.0:1873 rbd_data.3380e2ae8944a.00000000000=
0070d
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.e69870d4 ack+ondisk+write+known_if_redirected e5678=
5)
> >>>>>>>>   currently waiting for subops from 16,17
> >>>>>>>> 2015-09-22 12:58:03.759826 osd.16 192.168.55.13:6800/29410 10 :
> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked =
for >
> >>>>>>>> 30.704367 secs
> >>>>>>>> 2015-09-22 12:58:03.759840 osd.16 192.168.55.13:6800/29410 11 :
> >>>>>>>> cluster [WRN] slow request 30.704367 seconds old, received at
> >>>>>>>> 2015-09-22 12:57:33.055404:
> >>>>>>>>   osd_op(client.250874.0:1874 rbd_data.3380e2ae8944a.00000000000=
0070e
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.f7635819 ack+ondisk+write+known_if_redirected e5678=
5)
> >>>>>>>>   currently waiting for subops from 13,17
> >>>>>>>>
> >>>>>>>> Server   IP addr              OSD
> >>>>>>>> nodev  - 192.168.55.11 - 12
> >>>>>>>> nodew  - 192.168.55.12 - 13
> >>>>>>>> nodex  - 192.168.55.13 - 16
> >>>>>>>> nodey  - 192.168.55.14 - 17
> >>>>>>>> nodez  - 192.168.55.15 - 14
> >>>>>>>> nodezz - 192.168.55.16 - 15
> >>>>>>>>
> >>>>>>>> fio job:
> >>>>>>>> [rbd-test]
> >>>>>>>> readwrite=3Dwrite
> >>>>>>>> blocksize=3D4M
> >>>>>>>> #runtime=3D60
> >>>>>>>> name=3Drbd-test
> >>>>>>>> #readwrite=3Drandwrite
> >>>>>>>> #bssplit=3D4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1
> >>>>>>>> #rwmixread=3D72
> >>>>>>>> #norandommap
> >>>>>>>> #size=3D1T
> >>>>>>>> #blocksize=3D4k
> >>>>>>>> ioengine=3Drbd
> >>>>>>>> rbdname=3Dtest2
> >>>>>>>> pool=3Drbd
> >>>>>>>> clientname=3Dadmin
> >>>>>>>> iodepth=3D8
> >>>>>>>> #numjobs=3D4
> >>>>>>>> #thread
> >>>>>>>> #group_reporting
> >>>>>>>> #time_based
> >>>>>>>> #direct=3D1
> >>>>>>>> #ramp_time=3D60
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> -----BEGIN PGP SIGNATURE-----
> >>>>>>>> Version: Mailvelope v1.1.0
> >>>>>>>> Comment: https://www.mailvelope.com
> >>>>>>>>
> >>>>>>>> wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAKBnS94fwuw0OqpPU3/z
> >>>>>>>> tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQmmqGuvEMn68spmasWu
> >>>>>>>> h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5jpGc8kZCvNS+ocDgFOl
> >>>>>>>> 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHMOwQK0bw8wWiCJEvqVB
> >>>>>>>> sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ5AMpeYPvEHu/LAr1N7
> >>>>>>>> FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlzszlEHm3iif98QtsxbF
> >>>>>>>> pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PCm59b4LBNAg6iPNH1AI
> >>>>>>>> 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg///vhxDsHWmcwClLEn
> >>>>>>>> B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+7V1oIzIYvWHyl2QpBq
> >>>>>>>> 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCjoCXJc8ajywR9Dy+6lL
> >>>>>>>> o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNEpde89qW32S9CZlrJDO
> >>>>>>>> gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV9vhzYoM7p5YWHghBKB
> >>>>>>>> J3hS
> >>>>>>>> =3D0J7F
> >>>>>>>> -----END PGP SIGNATURE-----
> >>>>>>>> ----------------
> >>>>>>>> Robert LeBlanc
> >>>>>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9=
F1
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On Tue, Sep 22, 2015 at 8:31 AM, Gregory Farnum  wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Sep 22, 2015 at 7:24 AM, Robert LeBlanc  wrote:
> >>>>>>>>>>
> >>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>>>>>> Hash: SHA256
> >>>>>>>>>>
> >>>>>>>>>> Is there some way to tell in the logs that this is happening?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> You can search for the (mangled) name _split_collection
> >>>>>>>>>>
> >>>>>>>>>> I'm not
> >>>>>>>>>> seeing much I/O, CPU usage during these times. Is there some w=
ay to
> >>>>>>>>>> prevent the splitting? Is there a negative side effect to doin=
g so?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Bump up the split and merge thresholds. You can search the list=
 for
> >>>>>>>>> this, it was discussed not too long ago.
> >>>>>>>>>
> >>>>>>>>>> We've had I/O block for over 900 seconds and as soon as the se=
ssions
> >>>>>>>>>> are aborted, they are reestablished and complete immediately.
> >>>>>>>>>>
> >>>>>>>>>> The fio test is just a seq write, starting it over (rewriting =
from
> >>>>>>>>>> the
> >>>>>>>>>> beginning) is still causing the issue. I was suspect that it i=
s not
> >>>>>>>>>> having to create new file and therefore split collections. Thi=
s is
> >>>>>>>>>> on
> >>>>>>>>>> my test cluster with no other load.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Hmm, that does make it seem less likely if you're really not cr=
eating
> >>>>>>>>> new objects, if you're actually running fio in such a way that =
it's
> >>>>>>>>> not allocating new FS blocks (this is probably hard to set up?)=
.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I'll be doing a lot of testing today. Which log options and de=
pths
> >>>>>>>>>> would be the most helpful for tracking this issue down?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> If you want to go log diving "debug osd =3D 20", "debug filesto=
re =3D
> >>>>>>>>> 20",
> >>>>>>>>> "debug ms =3D 1" are what the OSD guys like to see. That should=
 spit
> >>>>>>>>> out
> >>>>>>>>> everything you need to track exactly what each Op is doing.
> >>>>>>>>> -Greg
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
> >>>>>>>> in
> >>>>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>
> >>>>> -----BEGIN PGP SIGNATURE-----
> >>>>> Version: Mailvelope v1.1.0
> >>>>> Comment: https://www.mailvelope.com
> >>>>>
> >>>>> wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAAoEgP/AqpH7i1BLpoz6fTlfWG
> >>>>> a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMmhWpJ6utEr1XPW0MPFgzvNIsf
> >>>>> a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr6It9v4Nv+biqZHkiY8x/rRtV
> >>>>> s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwzSsP3omupZgNyaKkCgdkil9Vc
> >>>>> iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3AWXSN4yEn286KyMDjFrsDY5B
> >>>>> izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJTikmGoNW6oQBjFq/z/zindTz
> >>>>> caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkTq+eTOb5pBhQbp+42Pkkqh7jj
> >>>>> efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuHyKbkwVs8x3JMPEiCl6PBvJbx
> >>>>> GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19RZPrAUhpDW0/DbUvuoKSR8m7
> >>>>> glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai9RpzQ+mWmp3xi7becYmL482H
> >>>>> +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmihAIn9dVTJ1O2RlapCLqL3YAJg
> >>>>> pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LELNS/UpyuYurbPcyPKUQ0uPjp
> >>>>> gcZm
> >>>>> =3DCjwB
> >>>>> -----END PGP SIGNATURE-----
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>
> >>
> >> -----BEGIN PGP SIGNATURE-----
> >> Version: Mailvelope v1.1.0
> >> Comment: https://www.mailvelope.com
> >>
> >> wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zjl606aMdkmQG7
> >> S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0JLDDqrbsqre2
> >> lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHlP59Hu7VpxC5l
> >> 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoyUwCM+eL7sotl
> >> JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKzs9IZadOI8Ce0
> >> dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVkxQGPYlpbpckf
> >> nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh9z7o6qHs3Kvp
> >> krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7QZ13Zau/qhDu
> >> FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1fovEtJVeGAfE
> >> tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96VtqAR5GQCkYE
> >> hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1mrI3j80mZ4VTj
> >> BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nmh5IyY+WO8hPo
> >> ae22
> >> =3DAX+L
> >> -----END PGP SIGNATURE-----
> _______________________________________________
> ceph-users mailing listceph-users-idqoXFIVOFIuzjOF24JIZ5en40jlLrCI@public.gmane.org://lists.ceph.com/lis=
tinfo.cgi/ceph-users-ceph.com
>
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.1.0
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWEVA5CRDmVDuy+mK58QAAY4EP/2jTEGPrbR3KDOC1d6FU
> 7TkVeFtow7UCe9/TwArLtcEVTr8rdaXNWRi7gat99zbL5pw+96Sj6bGqpKVz
> ZBSHcBlLIl42Hj10Ju7Svpwn7Q9RnSGOvjEdghEKsTxnf37gZD/KjvMbidJu
> jlPGEfnGEdYbQ+vDYoCoUIuvUNPbCvWQTjJpnTXrMZfhhEBoOepMzF9s6L6B
> AWR9WUrtz4HtGSMT42U1gd3LDOUh/5Ioy6FuhJe04piaf3ikRg+pjX47/WBd
> mQupmKJOblaULCswOrMLTS9R2+p6yaWj0zlUb3OAOErO7JR8OWZ2H7tYjkQN
> rGPsIRNv4yKw2Z5vJdHLksVdYhBQY1I4N1GO3+hf+j/yotPC9Ay4BYLZrQwf
> 3L+uhqSEu80erZjsJF4lilmw0l9nbDSoXc0MqRoXrpUIqyVtmaCBynv5Xq7s
> L5idaH6iVPBwy4Y6qzVuQpP0LaHp48ojIRx7likQJt0MSeDzqnslnp5B/9nb
> Ppu3peRUKf5GEKISRQ6gOI3C4gTSSX6aBatWdtpm01Et0T6ysoxAP/VoO3Nb
> 0PDsuYYT0U1MYqi0USouiNc4yRWNb9hkkBHEJrwjtP52moL1WYdYleL6w+FS
> Y1YQ1DU8YsEtVniBmZc4TBQJRRIS6SaQjH108JCjUcy9oVNwRtOqbcT1aiI6
> EP/Q
> =3Defx7
> -----END PGP SIGNATURE-----
>
>

--f46d044287d2ca28d3052149b818
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I would start with defrag the drives, the good part is that =
you can just run the defrag with the time parameter and it will take all av=
ailable xfs drives.</p>
<div class=3D"gmail_quote">On 4 Oct 2015 6:13 pm, &quot;Robert LeBlanc&quot=
; &lt;<a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; =
wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"l=
tr"><pre>-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

These are Toshiba=C2=A0MG03ACA400 drives.

sd{a,b} are 4TB on=C2=A000:1f.2 SATA controller: Intel Corporation C600/X79=
 series chipset 6-Port SATA AHCI Controller (rev 05) at 3.0 Gb
sd{c,d} are 4TB on=C2=A000:1f.2 SATA controller: Intel Corporation C600/X79=
 series chipset 6-Port SATA AHCI Controller (rev 05) at 6.0 Gb
sde is SATADOM with OS install
sd{f..i,l,m} are 4TB on=C2=A001:00.0 Serial Attached SCSI controller: LSI L=
ogic / Symbios Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
sd{j,k} are 240 GB Intel=C2=A0SSDSC2BB240G4 on=C2=A001:00.0 Serial Attached=
 SCSI controller: LSI Logic / Symbios Logic SAS2308 PCI-Express Fusion-MPT =
SAS-2 (rev 05)

There is probably some performance optimization that we can do in this area=
, however unless I&#39;m missing something, I don&#39;t see anything that s=
hould cause I/O to take 30-60+ seconds to complete from a disk standpoint.

[root@ceph1 ~]# for i in {{a..d},{f..i},{l,m}}; do echo -n &quot;sd${i}1: &=
quot;; xfs_db -c frag -r /dev/sd${i}1; done =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
sda1: actual 924229, ideal 414161, fragmentation factor 55.19%
sdb1: actual 1703083, ideal 655321, fragmentation factor 61.52%
sdc1: actual 2161827, ideal 746418, fragmentation factor 65.47%
sdd1: actual 1807008, ideal 654214, fragmentation factor 63.80%
sdf1: actual 735471, ideal 311837, fragmentation factor 57.60%
sdg1: actual 1463859, ideal 507362, fragmentation factor 65.34%
sdh1: actual 1684905, ideal 556571, fragmentation factor 66.97%
sdi1: actual 1833980, ideal 608499, fragmentation factor 66.82%
sdl1: actual 1641128, ideal 554364, fragmentation factor 66.22%
sdm1: actual 2032644, ideal 697129, fragmentation factor 65.70%


[root@ceph1 ~]# iostat -xd 2
Linux 4.2.1-1.el7.elrepo.x86_64 (ceph1) =C2=A0 10/04/2015 =C2=A0 =C2=A0 =C2=
=A0_x86_64_ =C2=A0 =C2=A0 =C2=A0 =C2=A0(16 CPU)

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.09 =C2=A0 =C2=A0 2.0=
6 =C2=A0 =C2=A09.24 =C2=A0 36.18 =C2=A0 527.28 =C2=A01743.71 =C2=A0 100.00 =
=C2=A0 =C2=A0 8.96 =C2=A0197.32 =C2=A0 17.50 =C2=A0243.23 =C2=A0 4.07 =C2=
=A018.47
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17 =C2=A0 =C2=A0 3.6=
1 =C2=A0 16.70 =C2=A0 74.44 =C2=A0 949.65 =C2=A02975.30 =C2=A0 =C2=A086.13 =
=C2=A0 =C2=A0 6.74 =C2=A0 73.95 =C2=A0 23.94 =C2=A0 85.16 =C2=A0 4.31 =C2=
=A039.32
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14 =C2=A0 =C2=A0 4.6=
7 =C2=A0 15.69 =C2=A0 87.80 =C2=A0 818.02 =C2=A03860.11 =C2=A0 =C2=A090.41 =
=C2=A0 =C2=A0 9.56 =C2=A0 92.38 =C2=A0 26.73 =C2=A0104.11 =C2=A0 4.44 =C2=
=A045.91
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17 =C2=A0 =C2=A0 3.4=
3 =C2=A0 =C2=A07.16 =C2=A0 69.13 =C2=A0 480.96 =C2=A02847.42 =C2=A0 =C2=A08=
7.25 =C2=A0 =C2=A0 4.80 =C2=A0 62.89 =C2=A0 30.00 =C2=A0 66.30 =C2=A0 4.33 =
=C2=A033.00
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A0 1.1=
3 =C2=A0 =C2=A00.34 =C2=A0 =C2=A00.99 =C2=A0 =C2=A0 8.35 =C2=A0 =C2=A012.01=
 =C2=A0 =C2=A030.62 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A07.37 =C2=A0 =C2=A02.64 =
=C2=A0 =C2=A09.02 =C2=A0 1.64 =C2=A0 0.22
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.2=
2 =C2=A0 =C2=A00.01 =C2=A0348.22 =C2=A0 =C2=A0 0.03 11302.65 =C2=A0 =C2=A06=
4.91 =C2=A0 =C2=A0 0.23 =C2=A0 =C2=A00.66 =C2=A0 =C2=A00.14 =C2=A0 =C2=A00.=
66 =C2=A0 0.15 =C2=A0 5.15
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.9=
9 =C2=A0 =C2=A00.01 =C2=A0369.94 =C2=A0 =C2=A0 0.03 12876.74 =C2=A0 =C2=A06=
9.61 =C2=A0 =C2=A0 0.26 =C2=A0 =C2=A00.71 =C2=A0 =C2=A00.13 =C2=A0 =C2=A00.=
71 =C2=A0 0.16 =C2=A0 5.75
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A0 1.7=
9 =C2=A0 =C2=A01.55 =C2=A0 31.12 =C2=A0 =C2=A039.64 =C2=A01431.37 =C2=A0 =
=C2=A090.06 =C2=A0 =C2=A0 4.07 =C2=A0124.67 =C2=A0 16.25 =C2=A0130.05 =C2=
=A0 3.11 =C2=A010.17
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.22 =C2=A0 =C2=A0 3.1=
7 =C2=A0 23.92 =C2=A0 72.90 =C2=A01386.45 =C2=A02676.28 =C2=A0 =C2=A083.93 =
=C2=A0 =C2=A0 7.75 =C2=A0 80.00 =C2=A0 24.31 =C2=A0 98.27 =C2=A0 4.31 =C2=
=A041.77
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.16 =C2=A0 =C2=A0 3.1=
0 =C2=A0 17.63 =C2=A0 72.84 =C2=A0 986.29 =C2=A02767.24 =C2=A0 =C2=A082.98 =
=C2=A0 =C2=A0 6.57 =C2=A0 72.64 =C2=A0 23.67 =C2=A0 84.50 =C2=A0 4.23 =C2=
=A038.30
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.11 =C2=A0 =C2=A0 3.0=
1 =C2=A0 12.10 =C2=A0 55.14 =C2=A0 660.85 =C2=A02361.40 =C2=A0 =C2=A089.89 =
=C2=A0 =C2=A017.87 =C2=A0265.80 =C2=A0 21.64 =C2=A0319.36 =C2=A0 4.08 =C2=
=A027.45
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.08 =C2=A0 =C2=A0 2.4=
5 =C2=A0 =C2=A09.75 =C2=A0 53.90 =C2=A0 489.67 =C2=A01929.42 =C2=A0 =C2=A07=
6.01 =C2=A0 =C2=A017.27 =C2=A0271.30 =C2=A0 20.77 =C2=A0316.61 =C2=A0 3.98 =
=C2=A025.33
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.10 =C2=A0 =C2=A0 2.7=
6 =C2=A0 11.28 =C2=A0 60.97 =C2=A0 600.10 =C2=A02114.48 =C2=A0 =C2=A075.14 =
=C2=A0 =C2=A0 1.70 =C2=A0 23.55 =C2=A0 22.92 =C2=A0 23.66 =C2=A0 4.10 =C2=
=A029.60

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.50 =C2=A0 =C2=A00.00 =C2=A0 146.00 =C2=A0 =C2=A0 0.00 =C2=
=A0 584.00 =C2=A0 =C2=A0 0.01 =C2=A0 16.00 =C2=A0 16.00 =C2=A0 =C2=A00.00 =
=C2=A016.00 =C2=A0 0.80
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A09.00 =C2=A0119.00 =C2=A02036.00 =C2=A02578.00 =C2=A0 =C2=A07=
2.09 =C2=A0 =C2=A0 0.68 =C2=A0 =C2=A05.50 =C2=A0 =C2=A07.06 =C2=A0 =C2=A05.=
39 =C2=A0 2.36 =C2=A030.25
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 34.00 =C2=A0129.00 =C2=A0 494.00 =C2=A06987.75 =C2=A0 =C2=A091.80 =
=C2=A0 =C2=A0 1.70 =C2=A0 10.44 =C2=A0 17.00 =C2=A0 =C2=A08.72 =C2=A0 4.44 =
=C2=A072.40
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.5=
0 =C2=A0 =C2=A01.50 =C2=A0 95.50 =C2=A0 =C2=A074.00 =C2=A02396.50 =C2=A0 =
=C2=A050.94 =C2=A0 =C2=A0 0.85 =C2=A0 =C2=A08.75 =C2=A0 23.33 =C2=A0 =C2=A0=
8.52 =C2=A0 7.53 =C2=A073.05
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A037.0=
0 =C2=A0 11.00 =C2=A0 =C2=A01.00 =C2=A0 =C2=A046.00 =C2=A0 152.00 =C2=A0 =
=C2=A033.00 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A01.00 =C2=A0 =C2=A00.64 =C2=A0 =
=C2=A05.00 =C2=A0 0.54 =C2=A0 0.65
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A00.00 =C2=A0970.50 =C2=A0 =C2=A0 0.00 12594.00 =C2=A0 =C2=A02=
5.95 =C2=A0 =C2=A0 0.09 =C2=A0 =C2=A00.09 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
09 =C2=A0 0.08 =C2=A0 8.20
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0977.50 =C2=A0 =C2=A0 0.00 12016.00 =C2=A0 =C2=A02=
4.59 =C2=A0 =C2=A0 0.10 =C2=A0 =C2=A00.10 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
10 =C2=A0 0.09 =C2=A0 8.90
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A00.50 =C2=A0 37.50 =C2=A0 =C2=A0 2.00 =C2=A0 230.25 =C2=A0 =
=C2=A012.22 =C2=A0 =C2=A0 9.63 =C2=A0 10.58 =C2=A0 =C2=A08.00 =C2=A0 10.61 =
=C2=A0 1.79 =C2=A0 6.80
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 10.50 =C2=A0 =C2=A00.00 =C2=A02528.00 =C2=A0 =C2=A0 0.00 =C2=A0 48=
1.52 =C2=A0 =C2=A0 0.10 =C2=A0 =C2=A09.33 =C2=A0 =C2=A09.33 =C2=A0 =C2=A00.=
00 =C2=A0 7.76 =C2=A0 8.15
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 15.00 =C2=A0116.00 =C2=A0 546.00 =C2=A0 833.25 =C2=A0 =C2=A021.06 =
=C2=A0 =C2=A0 0.94 =C2=A0 =C2=A07.17 =C2=A0 14.03 =C2=A0 =C2=A06.28 =C2=A0 =
4.13 =C2=A054.15
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A03.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A026.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A017.33 =C2=A0 =C2=A0 0.02 =C2=A0 =C2=A07.50 =C2=A0 =C2=A07.50 =
=C2=A0 =C2=A00.00 =C2=A0 7.50 =C2=A0 2.25
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.5=
0 =C2=A0 =C2=A01.00 =C2=A0 64.50 =C2=A0 =C2=A0 4.00 =C2=A02929.25 =C2=A0 =
=C2=A089.56 =C2=A0 =C2=A0 0.40 =C2=A0 =C2=A06.04 =C2=A0 =C2=A09.00 =C2=A0 =
=C2=A05.99 =C2=A0 3.42 =C2=A022.40
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A04.00 =C2=A0 64.00 =C2=A0 770.00 =C2=A01105.00 =C2=A0 =C2=A05=
5.15 =C2=A0 =C2=A0 4.96 =C2=A0189.42 =C2=A0 21.25 =C2=A0199.93 =C2=A0 4.21 =
=C2=A028.60

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A08.50 =C2=A0 =C2=A00.00 =C2=A0 110.00 =C2=A0 =C2=A0 0.00 =C2=
=A0 =C2=A025.88 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A01.59 =C2=A0 =C2=A01.59 =C2=
=A0 =C2=A00.00 =C2=A0 1.53 =C2=A0 1.30
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 =C2=A06.50 =C2=A0117.50 =C2=A0 494.00 =C2=A04544.50 =C2=A0 =C2=A08=
1.27 =C2=A0 =C2=A0 0.87 =C2=A0 =C2=A06.99 =C2=A0 11.62 =C2=A0 =C2=A06.73 =
=C2=A0 3.28 =C2=A040.70
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A05.50 =C2=A0202.50 =C2=A0 526.00 =C2=A04123.00 =C2=A0 =C2=A04=
4.70 =C2=A0 =C2=A0 1.80 =C2=A0 =C2=A08.66 =C2=A0 18.73 =C2=A0 =C2=A08.39 =
=C2=A0 2.08 =C2=A043.30
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.0=
0 =C2=A0 =C2=A02.50 =C2=A0227.00 =C2=A0 108.00 =C2=A06952.00 =C2=A0 =C2=A06=
1.53 =C2=A0 =C2=A046.10 =C2=A0197.44 =C2=A0 30.20 =C2=A0199.29 =C2=A0 3.86 =
=C2=A088.60
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A01.50 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 6.00=
 =C2=A0 =C2=A0 8.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A02.33 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A02.33 =C2=A0 1.33 =C2=A0 0.20
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0834.00 =C2=A0 =C2=A0 0.00 =C2=A09912.00 =C2=A0 =
=C2=A023.77 =C2=A0 =C2=A0 0.08 =C2=A0 =C2=A00.09 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.09 =C2=A0 0.08 =C2=A0 6.75
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0777.00 =C2=A0 =C2=A0 0.00 12318.00 =C2=A0 =C2=A03=
1.71 =C2=A0 =C2=A0 0.12 =C2=A0 =C2=A00.15 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
15 =C2=A0 0.10 =C2=A0 7.70
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A04.50 =C2=A0117.00 =C2=A0 198.00 =C2=A0 693.25 =C2=A0 =C2=A01=
4.67 =C2=A0 =C2=A034.86 =C2=A0362.88 =C2=A0 84.33 =C2=A0373.60 =C2=A0 3.59 =
=C2=A043.65
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A01.50 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 6.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 8.00 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A09.00 =C2=A0 =C2=A09.00 =
=C2=A0 =C2=A00.00 =C2=A0 9.00 =C2=A0 1.35
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 3.0=
0 =C2=A0 =C2=A03.50 =C2=A0143.00 =C2=A01014.00 =C2=A04205.25 =C2=A0 =C2=A07=
1.25 =C2=A0 =C2=A0 0.93 =C2=A0 =C2=A05.95 =C2=A0 20.43 =C2=A0 =C2=A05.59 =
=C2=A0 3.08 =C2=A045.15
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A08.00 =C2=A0148.50 =C2=A01578.00 =C2=A02128.50 =C2=A0 =C2=A04=
7.37 =C2=A0 =C2=A0 0.82 =C2=A0 =C2=A05.27 =C2=A0 =C2=A06.44 =C2=A0 =C2=A05.=
21 =C2=A0 3.40 =C2=A053.20
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.50 =C2=A0 =C2=A0 2.0=
0 =C2=A0 10.50 =C2=A0100.50 =C2=A02540.00 =C2=A02039.50 =C2=A0 =C2=A082.51 =
=C2=A0 =C2=A0 0.77 =C2=A0 =C2=A07.00 =C2=A0 14.19 =C2=A0 =C2=A06.25 =C2=A0 =
5.42 =C2=A060.20
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A05.00 =C2=A0 =C2=A00.00 =C2=A01050.00 =C2=A0 =C2=A0 0.00 =C2=
=A0 420.00 =C2=A0 =C2=A0 0.04 =C2=A0 =C2=A07.10 =C2=A0 =C2=A07.10 =C2=A0 =
=C2=A00.00 =C2=A0 7.10 =C2=A0 3.55

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A06.00 =C2=A0 =C2=A00.00 =C2=A0 604.00 =C2=A0 =C2=A0 0.00 =C2=
=A0 201.33 =C2=A0 =C2=A0 0.03 =C2=A0 =C2=A05.58 =C2=A0 =C2=A05.58 =C2=A0 =
=C2=A00.00 =C2=A0 5.58 =C2=A0 3.35
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 6.0=
0 =C2=A0 =C2=A07.00 =C2=A0236.00 =C2=A0 132.00 =C2=A08466.00 =C2=A0 =C2=A07=
0.77 =C2=A0 =C2=A045.48 =C2=A0186.59 =C2=A0 31.79 =C2=A0191.18 =C2=A0 1.62 =
=C2=A039.45
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 19.50 =C2=A0 46.50 =C2=A06334.00 =C2=A0 686.00 =C2=A0 212.73 =C2=
=A0 =C2=A0 0.39 =C2=A0 =C2=A05.96 =C2=A0 =C2=A07.97 =C2=A0 =C2=A05.12 =C2=
=A0 3.57 =C2=A023.55
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A03.00 =C2=A0 20.00 =C2=A0 =C2=A072.00 =C2=A01527.25 =C2=A0 13=
9.07 =C2=A0 =C2=A0 0.31 =C2=A0 47.67 =C2=A0 =C2=A06.17 =C2=A0 53.90 =C2=A0 =
3.11 =C2=A0 7.15
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A017.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A04.50 =C2=A0 =C2=A0 0.00 =C2=A0 184.00 =C2=
=A0 =C2=A081.78 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A02.33 =C2=A0 =C2=A00.00 =C2=
=A0 =C2=A02.33 =C2=A0 2.33 =C2=A0 1.05
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0805.50 =C2=A0 =C2=A0 0.00 12760.00 =C2=A0 =C2=A03=
1.68 =C2=A0 =C2=A0 0.21 =C2=A0 =C2=A00.27 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
27 =C2=A0 0.09 =C2=A0 7.35
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0438.00 =C2=A0 =C2=A0 0.00 14300.00 =C2=A0 =C2=A06=
5.30 =C2=A0 =C2=A0 0.24 =C2=A0 =C2=A00.54 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
54 =C2=A0 0.13 =C2=A0 5.65
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A01.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 6.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A012.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A02.50 =C2=A0 =C2=A02.50 =
=C2=A0 =C2=A00.00 =C2=A0 2.50 =C2=A0 0.25
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.5=
0 =C2=A0 14.50 =C2=A0 27.50 =C2=A0 394.00 =C2=A06459.50 =C2=A0 326.36 =C2=
=A0 =C2=A0 0.86 =C2=A0 20.18 =C2=A0 11.00 =C2=A0 25.02 =C2=A0 7.42 =C2=A031=
.15
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A09.00 =C2=A0175.00 =C2=A0 554.00 =C2=A03173.25 =C2=A0 =C2=A04=
0.51 =C2=A0 =C2=A0 1.12 =C2=A0 =C2=A06.38 =C2=A0 =C2=A07.22 =C2=A0 =C2=A06.=
34 =C2=A0 2.41 =C2=A044.40
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.0=
0 =C2=A0 =C2=A02.50 =C2=A0100.50 =C2=A0 =C2=A026.00 =C2=A02483.00 =C2=A0 =
=C2=A048.72 =C2=A0 =C2=A0 0.77 =C2=A0 =C2=A07.47 =C2=A0 11.80 =C2=A0 =C2=A0=
7.36 =C2=A0 2.10 =C2=A021.65
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.5=
0 =C2=A0 =C2=A09.00 =C2=A0214.00 =C2=A0 798.00 =C2=A07417.00 =C2=A0 =C2=A07=
3.68 =C2=A0 =C2=A066.56 =C2=A0298.46 =C2=A0 28.83 =C2=A0309.80 =C2=A0 3.35 =
=C2=A074.70
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 16.50 =C2=A0 =C2=A00.00 =C2=A0 344.00 =C2=A0 =C2=A0 0.00 =C2=A0 =
=C2=A041.70 =C2=A0 =C2=A0 0.09 =C2=A0 =C2=A05.61 =C2=A0 =C2=A05.61 =C2=A0 =
=C2=A00.00 =C2=A0 4.55 =C2=A0 7.50

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A09.00 =C2=A0 =C2=A00.00 =C2=A03162.00 =C2=A0 =C2=A0 0.00 =C2=
=A0 702.67 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A08.06 =C2=A0 =C2=A08.06 =C2=A0 =
=C2=A00.00 =C2=A0 6.06 =C2=A0 5.45
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 0.0=
0 =C2=A0 12.50 =C2=A0 13.00 =C2=A01962.00 =C2=A0 298.75 =C2=A0 177.31 =C2=
=A0 =C2=A0 0.63 =C2=A0 30.00 =C2=A0 =C2=A04.84 =C2=A0 54.19 =C2=A0 9.96 =C2=
=A025.40
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A03.50 =C2=A0131.00 =C2=A0 =C2=A018.00 =C2=A01632.75 =C2=A0 =
=C2=A024.55 =C2=A0 =C2=A0 0.87 =C2=A0 =C2=A06.48 =C2=A0 16.86 =C2=A0 =C2=A0=
6.20 =C2=A0 3.51 =C2=A047.25
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A04.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A072.00 =C2=A0 =C2=A016.00=
 =C2=A0 =C2=A044.00 =C2=A0 =C2=A0 0.26 =C2=A0 10.38 =C2=A0 10.38 =C2=A0 =C2=
=A00.00 =C2=A023.38 =C2=A0 9.35
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0843.50 =C2=A0 =C2=A0 0.00 16334.00 =C2=A0 =C2=A03=
8.73 =C2=A0 =C2=A0 0.19 =C2=A0 =C2=A00.23 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
23 =C2=A0 0.11 =C2=A0 9.10
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0803.00 =C2=A0 =C2=A0 0.00 10394.00 =C2=A0 =C2=A02=
5.89 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A00.08 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
08 =C2=A0 0.08 =C2=A0 6.25
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 11.00 =C2=A0 90.50 =C2=A0 150.00 =C2=A02626.00 =C2=A0 =C2=A054.70 =
=C2=A0 =C2=A0 0.59 =C2=A0 =C2=A05.84 =C2=A0 =C2=A03.82 =C2=A0 =C2=A06.08 =
=C2=A0 4.06 =C2=A041.20
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.5=
0 =C2=A0 17.50 =C2=A0130.50 =C2=A02132.00 =C2=A06309.50 =C2=A0 114.07 =C2=
=A0 =C2=A0 1.84 =C2=A0 12.55 =C2=A0 25.60 =C2=A0 10.80 =C2=A0 5.76 =C2=A085=
.30
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 =C2=A02.00 =C2=A0139.00 =C2=A0 =C2=A044.00 =C2=A01957.25 =C2=A0 =
=C2=A028.39 =C2=A0 =C2=A0 0.89 =C2=A0 =C2=A06.28 =C2=A0 14.50 =C2=A0 =C2=A0=
6.17 =C2=A0 3.55 =C2=A050.10
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 12.00 =C2=A0101.00 =C2=A0 334.00 =C2=A01449.75 =C2=A0 =C2=A031.57 =
=C2=A0 =C2=A0 0.94 =C2=A0 =C2=A08.28 =C2=A0 10.17 =C2=A0 =C2=A08.06 =C2=A0 =
2.11 =C2=A023.85
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A02.50 =C2=A0 =C2=A03.00 =C2=A0 204.00 =C2=A0 =C2=A017.00 =C2=
=A0 =C2=A080.36 =C2=A0 =C2=A0 0.02 =C2=A0 =C2=A05.27 =C2=A0 =C2=A04.60 =C2=
=A0 =C2=A05.83 =C2=A0 3.91 =C2=A0 2.15
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A09.50 =C2=A0 32.50 =C2=A01810.00 =C2=A0 199.50 =C2=A0 =C2=A09=
5.69 =C2=A0 =C2=A0 0.28 =C2=A0 =C2=A06.69 =C2=A0 =C2=A03.79 =C2=A0 =C2=A07.=
54 =C2=A0 5.12 =C2=A021.50

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 0.5=
0 =C2=A0 25.00 =C2=A0 24.50 =C2=A01248.00 =C2=A0 394.25 =C2=A0 =C2=A066.35 =
=C2=A0 =C2=A0 0.76 =C2=A0 15.30 =C2=A0 11.62 =C2=A0 19.06 =C2=A0 5.25 =C2=
=A026.00
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.50 =C2=A0 =C2=A0 0.0=
0 =C2=A0 13.50 =C2=A0 30.00 =C2=A02628.00 =C2=A0 405.25 =C2=A0 139.46 =C2=
=A0 =C2=A0 0.27 =C2=A0 =C2=A05.94 =C2=A0 =C2=A08.19 =C2=A0 =C2=A04.93 =C2=
=A0 5.31 =C2=A023.10
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 6.0=
0 =C2=A0 =C2=A03.00 =C2=A0163.00 =C2=A0 =C2=A060.00 =C2=A09889.50 =C2=A0 11=
9.87 =C2=A0 =C2=A0 1.66 =C2=A0 =C2=A09.83 =C2=A0 28.67 =C2=A0 =C2=A09.48 =
=C2=A0 5.95 =C2=A098.70
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A011.0=
0 =C2=A0 =C2=A05.50 =C2=A0353.50 =C2=A0 =C2=A050.00 =C2=A02182.00 =C2=A0 =
=C2=A012.43 =C2=A0 118.42 =C2=A0329.26 =C2=A0 30.27 =C2=A0333.91 =C2=A0 2.7=
8 =C2=A099.90
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.5=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A01.50 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A028.00=
 =C2=A0 =C2=A037.33 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A02.33 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A02.33 =C2=A0 2.33 =C2=A0 0.35
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 1227.50 =C2=A0 =C2=A0 0.00 22064.00 =C2=A0 =C2=A035.95 =
=C2=A0 =C2=A0 0.50 =C2=A0 =C2=A00.41 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.41 =
=C2=A0 0.10 =C2=A012.50
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A00.00 1073.50 =C2=A0 =C2=A0 0.00 19248.00 =C2=A0 =C2=A035.86 =
=C2=A0 =C2=A0 0.24 =C2=A0 =C2=A00.23 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.23 =
=C2=A0 0.10 =C2=A010.40
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 =C2=A00.00 =C2=A0109.00 =C2=A0 =C2=A0 0.00 =C2=A04145.00 =C2=A0 =
=C2=A076.06 =C2=A0 =C2=A0 0.59 =C2=A0 =C2=A05.44 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A05.44 =C2=A0 3.63 =C2=A039.55
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A08.50 =C2=A0 95.50 =C2=A0 218.00 =C2=A02091.75 =C2=A0 =C2=A04=
4.42 =C2=A0 =C2=A0 1.06 =C2=A0 =C2=A09.70 =C2=A0 18.71 =C2=A0 =C2=A08.90 =
=C2=A0 7.00 =C2=A072.80
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A08.00 =C2=A0177.50 =C2=A0 =C2=A082.00 =C2=A03173.00 =C2=A0 =
=C2=A035.09 =C2=A0 =C2=A0 1.24 =C2=A0 =C2=A06.65 =C2=A0 14.31 =C2=A0 =C2=A0=
6.30 =C2=A0 3.53 =C2=A065.40
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.5=
0 =C2=A0 =C2=A03.00 =C2=A0187.50 =C2=A0 =C2=A032.00 =C2=A02175.25 =C2=A0 =
=C2=A023.17 =C2=A0 =C2=A0 1.47 =C2=A0 =C2=A07.68 =C2=A0 18.50 =C2=A0 =C2=A0=
7.50 =C2=A0 3.85 =C2=A073.35
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A01.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A012.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A024.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A01.50 =C2=A0 =C2=A01.50 =
=C2=A0 =C2=A00.00 =C2=A0 1.50 =C2=A0 0.15
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.50 =C2=A0 =C2=A0 1.0=
0 =C2=A0 14.00 =C2=A0169.50 =C2=A02364.00 =C2=A04568.00 =C2=A0 =C2=A075.55 =
=C2=A0 =C2=A0 1.50 =C2=A0 =C2=A08.12 =C2=A0 21.25 =C2=A0 =C2=A07.03 =C2=A0 =
4.91 =C2=A090.10

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 =C2=A03.00 =C2=A0 60.00 =C2=A0 212.00 =C2=A02542.00 =C2=A0 =C2=A08=
7.43 =C2=A0 =C2=A0 0.58 =C2=A0 =C2=A08.02 =C2=A0 15.50 =C2=A0 =C2=A07.64 =
=C2=A0 7.95 =C2=A050.10
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A02.50 =C2=A0 98.00 =C2=A0 682.00 =C2=A01652.00 =C2=A0 =C2=A04=
6.45 =C2=A0 =C2=A0 0.51 =C2=A0 =C2=A05.13 =C2=A0 =C2=A06.20 =C2=A0 =C2=A05.=
10 =C2=A0 3.05 =C2=A030.65
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.5=
0 =C2=A0 =C2=A04.00 =C2=A0146.00 =C2=A0 =C2=A016.00 =C2=A04623.25 =C2=A0 =
=C2=A061.86 =C2=A0 =C2=A0 1.07 =C2=A0 =C2=A07.33 =C2=A0 13.38 =C2=A0 =C2=A0=
7.17 =C2=A0 2.22 =C2=A033.25
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A09.50 =C2=A0 30.00 =C2=A0 290.00 =C2=A0 358.00 =C2=A0 =C2=A03=
2.81 =C2=A0 =C2=A0 0.84 =C2=A0 32.22 =C2=A0 49.16 =C2=A0 26.85 =C2=A012.28 =
=C2=A048.50
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A00.00 =C2=A0530.00 =C2=A0 =C2=A0 0.00 =C2=A07138.00 =C2=A0 =
=C2=A026.94 =C2=A0 =C2=A0 0.06 =C2=A0 =C2=A00.11 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.11 =C2=A0 0.09 =C2=A0 4.65
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0625.00 =C2=A0 =C2=A0 0.00 =C2=A08254.00 =C2=A0 =
=C2=A026.41 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A00.12 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.12 =C2=A0 0.09 =C2=A0 5.75
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A04.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A018.00=
 =C2=A0 =C2=A0 9.00 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A03.62 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A03.62 =C2=A0 3.12 =C2=A0 1.25
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.5=
0 =C2=A0 =C2=A08.00 =C2=A0 61.00 =C2=A0 836.00 =C2=A02681.50 =C2=A0 101.96 =
=C2=A0 =C2=A0 0.58 =C2=A0 =C2=A09.25 =C2=A0 15.12 =C2=A0 =C2=A08.48 =C2=A0 =
6.71 =C2=A046.30
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.5=
0 =C2=A0 11.00 =C2=A0273.00 =C2=A02100.00 =C2=A08562.00 =C2=A0 =C2=A075.08 =
=C2=A0 =C2=A013.49 =C2=A0 47.53 =C2=A0 24.95 =C2=A0 48.44 =C2=A0 1.83 =C2=
=A052.00
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A00.50 =C2=A0 49.00 =C2=A0 =C2=A0 2.00 =C2=A01038.00 =C2=A0 =
=C2=A042.02 =C2=A0 =C2=A0 0.23 =C2=A0 =C2=A04.83 =C2=A0 14.00 =C2=A0 =C2=A0=
4.73 =C2=A0 2.45 =C2=A012.15
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A09.00 =C2=A0109.00 =C2=A02082.00 =C2=A02626.25 =C2=A0 =C2=A07=
9.80 =C2=A0 =C2=A0 0.85 =C2=A0 =C2=A07.34 =C2=A0 =C2=A07.83 =C2=A0 =C2=A07.=
30 =C2=A0 3.83 =C2=A045.20

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.5=
0 =C2=A0 10.00 =C2=A0177.00 =C2=A0 284.00 =C2=A04857.00 =C2=A0 =C2=A054.98 =
=C2=A0 =C2=A036.26 =C2=A0194.27 =C2=A0 21.85 =C2=A0204.01 =C2=A0 3.53 =C2=
=A066.00
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 39.50 =C2=A0119.50 =C2=A01808.00 =C2=A02389.25 =C2=A0 =C2=A052.80 =
=C2=A0 =C2=A0 1.58 =C2=A0 =C2=A09.96 =C2=A0 12.32 =C2=A0 =C2=A09.18 =C2=A0 =
2.42 =C2=A038.45
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.0=
0 =C2=A0 15.00 =C2=A0200.50 =C2=A0 116.00 =C2=A04951.00 =C2=A0 =C2=A047.03 =
=C2=A0 =C2=A014.37 =C2=A0 66.70 =C2=A0 73.87 =C2=A0 66.16 =C2=A0 2.23 =C2=
=A047.95
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.5=
0 =C2=A0 =C2=A06.00 =C2=A0 54.50 =C2=A0 180.00 =C2=A02360.50 =C2=A0 =C2=A08=
3.98 =C2=A0 =C2=A0 0.69 =C2=A0 11.36 =C2=A0 20.42 =C2=A0 10.36 =C2=A0 7.99 =
=C2=A048.35
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 7.5=
0 =C2=A0 =C2=A00.00 =C2=A0 32.50 =C2=A0 =C2=A0 0.00 =C2=A0 160.00 =C2=A0 =
=C2=A0 9.85 =C2=A0 =C2=A0 1.64 =C2=A0 50.51 =C2=A0 =C2=A00.00 =C2=A0 50.51 =
=C2=A0 1.48 =C2=A0 4.80
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0835.00 =C2=A0 =C2=A0 0.00 10198.00 =C2=A0 =C2=A02=
4.43 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A00.09 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
09 =C2=A0 0.08 =C2=A0 6.50
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0802.00 =C2=A0 =C2=A0 0.00 12534.00 =C2=A0 =C2=A03=
1.26 =C2=A0 =C2=A0 0.23 =C2=A0 =C2=A00.29 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.=
29 =C2=A0 0.10 =C2=A0 8.05
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.5=
0 =C2=A0 =C2=A02.00 =C2=A0133.50 =C2=A0 =C2=A014.00 =C2=A05272.25 =C2=A0 =
=C2=A078.03 =C2=A0 =C2=A0 4.37 =C2=A0 32.21 =C2=A0 =C2=A04.50 =C2=A0 32.63 =
=C2=A0 1.73 =C2=A023.40
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.5=
0 =C2=A0 17.00 =C2=A0125.50 =C2=A02676.00 =C2=A08683.25 =C2=A0 159.43 =C2=
=A0 =C2=A0 1.86 =C2=A0 13.02 =C2=A0 27.97 =C2=A0 11.00 =C2=A0 4.95 =C2=A070=
.55
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A07.00 =C2=A0 =C2=A00.50 =C2=A0 540.00 =C2=A0 =C2=A032.00 =C2=
=A0 152.53 =C2=A0 =C2=A0 0.05 =C2=A0 =C2=A07.07 =C2=A0 =C2=A07.57 =C2=A0 =
=C2=A00.00 =C2=A0 7.07 =C2=A0 5.30
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 7.0=
0 =C2=A0 27.00 =C2=A0276.00 =C2=A02374.00 11955.50 =C2=A0 =C2=A094.58 =C2=
=A0 =C2=A025.87 =C2=A0 85.36 =C2=A0 15.20 =C2=A0 92.23 =C2=A0 1.84 =C2=A055=
.90
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 45.00 =C2=A0 =C2=A00.00 =C2=A0 828.00 =C2=A0 =C2=A0 0.00 =C2=A0 =
=C2=A036.80 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A01.62 =C2=A0 =C2=A01.62 =C2=A0 =
=C2=A00.00 =C2=A0 0.68 =C2=A0 3.05
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A00.50 =C2=A0 65.50 =C2=A0 =C2=A0 2.00 =C2=A01436.25 =C2=A0 =
=C2=A043.58 =C2=A0 =C2=A0 0.51 =C2=A0 =C2=A07.79 =C2=A0 16.00 =C2=A0 =C2=A0=
7.73 =C2=A0 3.61 =C2=A023.80

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 8.0=
0 =C2=A0 14.50 =C2=A0150.00 =C2=A0 122.00 =C2=A0 929.25 =C2=A0 =C2=A012.78 =
=C2=A0 =C2=A020.65 =C2=A0 70.61 =C2=A0 =C2=A07.55 =C2=A0 76.71 =C2=A0 1.46 =
=C2=A024.05
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.0=
0 =C2=A0 =C2=A08.00 =C2=A0283.50 =C2=A0 =C2=A086.00 =C2=A02757.50 =C2=A0 =
=C2=A019.51 =C2=A0 =C2=A069.43 =C2=A0205.40 =C2=A0 51.75 =C2=A0209.73 =C2=
=A0 2.40 =C2=A069.85
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 12.50 =C2=A0 =C2=A01.50 =C2=A0 350.00 =C2=A0 =C2=A048.25 =C2=A0 =
=C2=A056.89 =C2=A0 =C2=A0 0.25 =C2=A0 17.75 =C2=A0 17.00 =C2=A0 24.00 =C2=
=A0 4.75 =C2=A0 6.65
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.5=
0 =C2=A0 36.50 =C2=A0141.00 =C2=A0 394.00 =C2=A02338.75 =C2=A0 =C2=A030.79 =
=C2=A0 =C2=A0 1.50 =C2=A0 =C2=A08.42 =C2=A0 16.16 =C2=A0 =C2=A06.41 =C2=A0 =
4.56 =C2=A080.95
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.5=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A01.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A010.00=
 =C2=A0 =C2=A020.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A02.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A02.00 =C2=A0 2.00 =C2=A0 0.20
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 1059.00 =C2=A0 =C2=A0 0.00 18506.00 =C2=A0 =C2=A034.95 =
=C2=A0 =C2=A0 0.19 =C2=A0 =C2=A00.18 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.18 =
=C2=A0 0.10 =C2=A010.75
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 1103.00 =C2=A0 =C2=A0 0.00 14220.00 =C2=A0 =C2=A025.78 =
=C2=A0 =C2=A0 0.09 =C2=A0 =C2=A00.08 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.08 =
=C2=A0 0.08 =C2=A0 8.35
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.5=
0 =C2=A0 =C2=A02.00 =C2=A0 19.50 =C2=A0 =C2=A0 8.00 =C2=A05158.75 =C2=A0 48=
0.63 =C2=A0 =C2=A0 0.17 =C2=A0 =C2=A08.05 =C2=A0 =C2=A06.50 =C2=A0 =C2=A08.=
21 =C2=A0 6.95 =C2=A014.95
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.5=
0 =C2=A0 28.00 =C2=A0224.50 =C2=A02210.00 =C2=A08971.75 =C2=A0 =C2=A088.57 =
=C2=A0 122.15 =C2=A0328.47 =C2=A0 27.43 =C2=A0366.02 =C2=A0 3.71 =C2=A093.7=
0
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 13.00 =C2=A0 =C2=A04.00 =C2=A0 718.00 =C2=A0 =C2=A016.00 =C2=A0 =
=C2=A086.35 =C2=A0 =C2=A0 0.15 =C2=A0 =C2=A03.76 =C2=A0 =C2=A04.23 =C2=A0 =
=C2=A02.25 =C2=A0 3.62 =C2=A0 6.15
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 16.50 =C2=A0 =C2=A00.00 =C2=A0 832.00 =C2=A0 =C2=A0 0.00 =C2=A0 10=
0.85 =C2=A0 =C2=A0 0.02 =C2=A0 =C2=A01.12 =C2=A0 =C2=A01.12 =C2=A0 =C2=A00.=
00 =C2=A0 1.09 =C2=A0 1.80
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.5=
0 =C2=A0 17.00 =C2=A0 23.50 =C2=A01032.00 =C2=A03224.50 =C2=A0 210.20 =C2=
=A0 =C2=A0 0.25 =C2=A0 =C2=A06.25 =C2=A0 =C2=A02.56 =C2=A0 =C2=A08.91 =C2=
=A0 3.41 =C2=A013.80
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A010.5=
0 =C2=A0 =C2=A04.50 =C2=A0241.00 =C2=A0 =C2=A066.00 =C2=A07252.00 =C2=A0 =
=C2=A059.62 =C2=A0 =C2=A023.00 =C2=A0 91.66 =C2=A0 =C2=A04.22 =C2=A0 93.29 =
=C2=A0 2.11 =C2=A051.85

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.5=
0 =C2=A0 =C2=A03.50 =C2=A0 91.00 =C2=A0 =C2=A092.00 =C2=A0 552.75 =C2=A0 =
=C2=A013.65 =C2=A0 =C2=A036.27 =C2=A0479.41 =C2=A0 81.57 =C2=A0494.71 =C2=
=A0 5.65 =C2=A053.35
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A06.00 =C2=A0168.00 =C2=A0 224.00 =C2=A0 962.50 =C2=A0 =C2=A01=
3.64 =C2=A0 =C2=A083.35 =C2=A0533.92 =C2=A0 62.00 =C2=A0550.77 =C2=A0 5.75 =
100.00
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A03.00 =C2=A0171.00 =C2=A0 =C2=A016.00 =C2=A01640.00 =C2=A0 =
=C2=A019.03 =C2=A0 =C2=A0 1.08 =C2=A0 =C2=A06.18 =C2=A0 11.83 =C2=A0 =C2=A0=
6.08 =C2=A0 3.15 =C2=A054.80
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.0=
0 =C2=A0 =C2=A05.00 =C2=A0107.50 =C2=A0 132.00 =C2=A06576.75 =C2=A0 119.27 =
=C2=A0 =C2=A0 0.79 =C2=A0 =C2=A07.06 =C2=A0 18.80 =C2=A0 =C2=A06.51 =C2=A0 =
5.13 =C2=A057.70
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 1111.50 =C2=A0 =C2=A0 0.00 22346.00 =C2=A0 =C2=A040.21 =
=C2=A0 =C2=A0 0.27 =C2=A0 =C2=A00.24 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.24 =
=C2=A0 0.11 =C2=A012.10
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 1022.00 =C2=A0 =C2=A0 0.00 33040.00 =C2=A0 =C2=A064.66 =
=C2=A0 =C2=A0 0.68 =C2=A0 =C2=A00.67 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.67 =
=C2=A0 0.13 =C2=A013.60
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.5=
0 =C2=A0 =C2=A02.50 =C2=A0 91.00 =C2=A0 =C2=A012.00 =C2=A04977.25 =C2=A0 10=
6.72 =C2=A0 =C2=A0 2.29 =C2=A0 24.48 =C2=A0 14.40 =C2=A0 24.76 =C2=A0 2.42 =
=C2=A022.60
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 10.00 =C2=A0 69.50 =C2=A0 368.00 =C2=A0 858.50 =C2=A0 =C2=A030.86 =
=C2=A0 =C2=A0 7.40 =C2=A0586.41 =C2=A0 =C2=A05.50 =C2=A0669.99 =C2=A0 4.21 =
=C2=A033.50
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 =C2=A08.00 =C2=A0210.00 =C2=A0 944.00 =C2=A05833.50 =C2=A0 =C2=A06=
2.18 =C2=A0 =C2=A0 1.57 =C2=A0 =C2=A07.62 =C2=A0 18.62 =C2=A0 =C2=A07.20 =
=C2=A0 4.57 =C2=A099.70
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A07.50 =C2=A0 22.50 =C2=A0 104.00 =C2=A0 253.25 =C2=A0 =C2=A02=
3.82 =C2=A0 =C2=A0 0.14 =C2=A0 =C2=A04.82 =C2=A0 =C2=A05.07 =C2=A0 =C2=A04.=
73 =C2=A0 4.03 =C2=A012.10
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 4.0=
0 =C2=A0 =C2=A01.00 =C2=A0 84.00 =C2=A0 =C2=A0 4.00 =C2=A03711.75 =C2=A0 =
=C2=A087.43 =C2=A0 =C2=A0 0.58 =C2=A0 =C2=A06.88 =C2=A0 12.50 =C2=A0 =C2=A0=
6.81 =C2=A0 5.75 =C2=A048.90
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 3.5=
0 =C2=A0 =C2=A07.50 =C2=A0 44.00 =C2=A0 =C2=A072.00 =C2=A02954.25 =C2=A0 11=
7.52 =C2=A0 =C2=A0 1.54 =C2=A0 39.50 =C2=A0 61.73 =C2=A0 35.72 =C2=A0 6.40 =
=C2=A032.95

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A01.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A020.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A040.00 =C2=A0 =C2=A0 0.01 =C2=A0 14.50 =C2=A0 14.50 =C2=A0 =C2=
=A00.00 =C2=A014.50 =C2=A0 1.45
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 7.0=
0 =C2=A0 10.50 =C2=A0198.50 =C2=A02164.00 =C2=A06014.75 =C2=A0 =C2=A078.27 =
=C2=A0 =C2=A0 1.94 =C2=A0 =C2=A09.29 =C2=A0 28.90 =C2=A0 =C2=A08.25 =C2=A0 =
4.77 =C2=A099.75
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.0=
0 =C2=A0 =C2=A04.00 =C2=A0 95.50 =C2=A0 112.00 =C2=A05152.25 =C2=A0 105.81 =
=C2=A0 =C2=A0 0.94 =C2=A0 =C2=A09.46 =C2=A0 24.25 =C2=A0 =C2=A08.84 =C2=A0 =
4.68 =C2=A046.55
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A02.00 =C2=A0131.00 =C2=A0 =C2=A010.00 =C2=A07167.25 =C2=A0 10=
7.93 =C2=A0 =C2=A0 4.55 =C2=A0 34.23 =C2=A0 83.25 =C2=A0 33.48 =C2=A0 2.52 =
=C2=A033.55
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.50 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.00=
 =C2=A0 =C2=A0 8.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0541.50 =C2=A0 =C2=A0 0.00 =C2=A06468.00 =C2=A0 =
=C2=A023.89 =C2=A0 =C2=A0 0.05 =C2=A0 =C2=A00.10 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.10 =C2=A0 0.09 =C2=A0 5.00
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0509.00 =C2=A0 =C2=A0 0.00 =C2=A07704.00 =C2=A0 =
=C2=A030.27 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A00.14 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.14 =C2=A0 0.10 =C2=A0 4.85
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A03.50 =C2=A0 =C2=A00.00 =C2=A0 =C2=A090.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A051.43 =C2=A0 =C2=A0 0.04 =C2=A0 10.14 =C2=A0 10.14 =C2=A0 =C2=
=A00.00 =C2=A010.14 =C2=A0 3.55
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.0=
0 =C2=A0 =C2=A05.00 =C2=A0102.50 =C2=A01186.00 =C2=A04583.00 =C2=A0 107.33 =
=C2=A0 =C2=A0 0.81 =C2=A0 =C2=A07.56 =C2=A0 23.20 =C2=A0 =C2=A06.80 =C2=A0 =
2.78 =C2=A029.85
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A014.0=
0 =C2=A0 10.00 =C2=A0216.00 =C2=A0 112.00 =C2=A03645.50 =C2=A0 =C2=A033.25 =
=C2=A0 =C2=A073.45 =C2=A0311.05 =C2=A0 46.30 =C2=A0323.31 =C2=A0 3.51 =C2=
=A079.35
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 1.0=
0 =C2=A0 =C2=A00.00 =C2=A0 52.50 =C2=A0 =C2=A0 0.00 =C2=A0 240.00 =C2=A0 =
=C2=A0 9.14 =C2=A0 =C2=A0 0.25 =C2=A0 =C2=A04.76 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A04.76 =C2=A0 4.48 =C2=A023.50
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A03.50 =C2=A0 =C2=A00.00 =C2=A0 =C2=A018.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A010.29 =C2=A0 =C2=A0 0.02 =C2=A0 =C2=A07.00 =C2=A0 =C2=A07.00 =
=C2=A0 =C2=A00.00 =C2=A0 7.00 =C2=A0 2.45

Device: =C2=A0 =C2=A0 =C2=A0 =C2=A0 rrqm/s =C2=A0 wrqm/s =C2=A0 =C2=A0 r/s =
=C2=A0 =C2=A0 w/s =C2=A0 =C2=A0rkB/s =C2=A0 =C2=A0wkB/s avgrq-sz avgqu-sz =
=C2=A0 await r_await w_await =C2=A0svctm =C2=A0%util
sda =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A01.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 4.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 8.00 =C2=A0 =C2=A0 0.01 =C2=A0 14.50 =C2=A0 14.50 =C2=A0 =C2=
=A00.00 =C2=A014.50 =C2=A0 1.45
sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 9.0=
0 =C2=A0 =C2=A02.00 =C2=A0292.00 =C2=A0 192.00 10925.75 =C2=A0 =C2=A075.63 =
=C2=A0 =C2=A036.98 =C2=A0100.27 =C2=A0 54.75 =C2=A0100.58 =C2=A0 2.95 =C2=
=A086.60
sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 9.0=
0 =C2=A0 10.50 =C2=A0151.00 =C2=A0 =C2=A078.00 =C2=A06771.25 =C2=A0 =C2=A08=
4.82 =C2=A0 =C2=A036.06 =C2=A0 94.60 =C2=A0 26.57 =C2=A0 99.33 =C2=A0 3.77 =
=C2=A060.85
sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A05.00 =C2=A0 =C2=A01.00 =C2=A0 =C2=A074.00 =C2=A0 =C2=A024.00=
 =C2=A0 =C2=A032.67 =C2=A0 =C2=A0 0.03 =C2=A0 =C2=A05.00 =C2=A0 =C2=A06.00 =
=C2=A0 =C2=A00.00 =C2=A0 5.00 =C2=A0 3.00
sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00=
 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A00.00 =C2=A0 =C2=A00.00 =
=C2=A0 =C2=A00.00 =C2=A0 0.00 =C2=A0 0.00
sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0787.50 =C2=A0 =C2=A0 0.00 =C2=A09418.00 =C2=A0 =
=C2=A023.92 =C2=A0 =C2=A0 0.07 =C2=A0 =C2=A00.10 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.10 =C2=A0 0.09 =C2=A0 6.70
sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.00 =C2=A0766.50 =C2=A0 =C2=A0 0.00 =C2=A09400.00 =C2=A0 =
=C2=A024.53 =C2=A0 =C2=A0 0.08 =C2=A0 =C2=A00.11 =C2=A0 =C2=A00.00 =C2=A0 =
=C2=A00.11 =C2=A0 0.10 =C2=A0 7.70
sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A00.50 =C2=A0 41.50 =C2=A0 =C2=A0 6.00 =C2=A0 391.00 =C2=A0 =
=C2=A018.90 =C2=A0 =C2=A0 0.24 =C2=A0 =C2=A05.79 =C2=A0 =C2=A09.00 =C2=A0 =
=C2=A05.75 =C2=A0 5.50 =C2=A023.10
sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A010.0=
0 =C2=A0 =C2=A09.00 =C2=A0268.00 =C2=A0 =C2=A092.00 =C2=A01618.75 =C2=A0 =
=C2=A012.35 =C2=A0 =C2=A068.20 =C2=A0150.90 =C2=A0 15.50 =C2=A0155.45 =C2=
=A0 2.36 =C2=A065.30
sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A011.5=
0 =C2=A0 10.00 =C2=A0330.50 =C2=A0 =C2=A072.00 =C2=A03201.25 =C2=A0 =C2=A01=
9.23 =C2=A0 =C2=A068.83 =C2=A0139.38 =C2=A0 37.45 =C2=A0142.46 =C2=A0 1.84 =
=C2=A062.80
sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 2.5=
0 =C2=A0 =C2=A02.50 =C2=A0228.50 =C2=A0 =C2=A014.00 =C2=A02526.00 =C2=A0 =
=C2=A021.99 =C2=A0 =C2=A090.42 =C2=A0404.71 =C2=A0242.40 =C2=A0406.49 =C2=
=A0 4.33 100.00
sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 5.5=
0 =C2=A0 =C2=A07.50 =C2=A0298.00 =C2=A0 =C2=A068.00 =C2=A05275.25 =C2=A0 =
=C2=A034.98 =C2=A0 =C2=A075.31 =C2=A0174.85 =C2=A0 26.73 =C2=A0178.58 =C2=
=A0 2.67 =C2=A081.60
sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00 =C2=A0 =C2=A0 0.0=
0 =C2=A0 =C2=A02.50 =C2=A0 =C2=A02.00 =C2=A0 =C2=A028.00 =C2=A0 =C2=A024.00=
 =C2=A0 =C2=A023.11 =C2=A0 =C2=A0 0.01 =C2=A0 =C2=A02.78 =C2=A0 =C2=A05.00 =
=C2=A0 =C2=A00.00 =C2=A0 2.78 =C2=A0 1.25

- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904 =C2=A0C70E E654 3BB2 FA62 B9F1

On Sun, Oct 4, 2015 at 12:16 AM, Josef Johansson  wrote:
Hi,

I don&#39;t know what brand those 4TB spindles are, but I know that mine ar=
e very bad at doing write at the same time as read. Especially small read w=
rite.

This has an absurdly bad effect when doing maintenance on ceph. That being =
said we see a lot of difference between dumpling and hammer in performance =
on these drives. Most likely due to hammer able to read write degraded PGs.

We have run into two different problems along the way, the first was blocke=
d request where we had to upgrade from 64GB mem on each node to 256GB. We t=
hought that it was the only safe buy make things better.

I believe it worked because more reads were cached so we had less mixed rea=
d write on the nodes, thus giving the spindles more room to breath. Now thi=
s was a shot in the dark then, but the price is not that high even to just =
try it out.. compared to 6 people working on it. I believe the IO on disk w=
as not huge either, but what kills the disk is high latency. How much bandw=
idth are the disk using? We had very low.. 3-5MB/s.

The second problem was defragmentations hitting 70%, lowering that to 6% ma=
de a lot of difference. Depending on IO pattern this increases different.

TL;DR read kills the 4TB spindles.

Hope you guys clear out of the woods.
/Josef

On 3 Oct 2015 10:10 pm, &quot;Robert LeBlanc&quot;  wrote:
- -----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

We are still struggling with this and have tried a lot of different
things. Unfortunately, Inktank (now Red Hat) no longer provides
consulting services for non-Red Hat systems. If there are some
certified Ceph consultants in the US that we can do both remote and
on-site engagements, please let us know.

This certainly seems to be network related, but somewhere in the
kernel. We have tried increasing the network and TCP buffers, number
of TCP sockets, reduced the FIN_WAIT2 state. There is about 25% idle
on the boxes, the disks are busy, but not constantly at 100% (they
cycle from &lt;10% up to 100%, but not 100% for more than a few seconds
at a time). There seems to be no reasonable explanation why I/O is
blocked pretty frequently longer than 30 seconds. We have verified
Jumbo frames by pinging from/to each node with 9000 byte packets. The
network admins have verified that packets are not being dropped in the
switches for these nodes. We have tried different kernels including
the recent Google patch to cubic. This is showing up on three cluster
(two Ethernet and one IPoIB). I booted one cluster into Debian Jessie
(from CentOS 7.1) with similar results.

The messages seem slightly different:
2015-10-03 14:38:23.193082 osd.134 <a href=3D"http://10.208.16.25:6800/1425=
" target=3D"_blank">10.208.16.25:6800/1425</a> 439 :
cluster [WRN] 14 slow requests, 1 included below; oldest blocked for &gt;
100.087155 secs
2015-10-03 14:38:23.193090 osd.134 <a href=3D"http://10.208.16.25:6800/1425=
" target=3D"_blank">10.208.16.25:6800/1425</a> 440 :
cluster [WRN] slow request 30.041999 seconds old, received at
2015-10-03 14:37:53.151014: osd_op(client.1328605.0:7082862
rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~4096]
11.6d19c36f ack+read+known_if_redirected e10249) currently no flag
points reached

I don&#39;t know what &quot;no flag points reached&quot; means.

The problem is most pronounced when we have to reboot an OSD node (1
of 13), we will have hundreds of I/O blocked for some times up to 300
seconds. It takes a good 15 minutes for things to settle down. The
production cluster is very busy doing normally 8,000 I/O and peaking
at 15,000. This is all 4TB spindles with SSD journals and the disks
are between 25-50% full. We are currently splitting PGs to distribute
the load better across the disks, but we are having to do this 10 PGs
at a time as we get blocked I/O. We have max_backfills and
max_recovery set to 1, client op priority is set higher than recovery
priority. We tried increasing the number of op threads but this didn&#39;t
seem to help. It seems as soon as PGs are finished being checked, they
become active and could be the cause for slow I/O while the other PGs
are being checked.

What I don&#39;t understand is that the messages are delayed. As soon as
the message is received by Ceph OSD process, it is very quickly
committed to the journal and a response is sent back to the primary
OSD which is received very quickly as well. I&#39;ve adjust
min_free_kbytes and it seems to keep the OSDs from crashing, but
doesn&#39;t solve the main problem. We don&#39;t have swap and there is 64 =
GB
of RAM per nodes for 10 OSDs.

Is there something that could cause the kernel to get a packet but not
be able to dispatch it to Ceph such that it could be explaining why we
are seeing these blocked I/O for 30+ seconds. Is there some pointers
to tracing Ceph messages from the network buffer through the kernel to
the Ceph process?

We can really use some pointers no matter how outrageous. We&#39;ve have
over 6 people looking into this for weeks now and just can&#39;t think of
anything else.

Thanks,
- -----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.1.0
Comment: <a href=3D"https://www.mailvelope.com" target=3D"_blank">https://w=
ww.mailvelope.com</a>

wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzStar
NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN6F1
prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvrqP6
K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfCFe2
h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+nxm
iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahzkGF
Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyidWyY
Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZIoHb
JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYEoYT
8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlYrGm
lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYhheg
4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdNDpk
l7OF
=3DOI++
- -----END PGP SIGNATURE-----
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F1


On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc  wrote:
&gt; We dropped the replication on our cluster from 4 to 3 and it looks
&gt; like all the blocked I/O has stopped (no entries in the log for the
&gt; last 12 hours). This makes me believe that there is some issue with
&gt; the number of sockets or some other TCP issue. We have not messed with
&gt; Ephemeral ports and TIME_WAIT at this point. There are 130 OSDs, 8 KVM
&gt; hosts hosting about 150 VMs. Open files is set at 32K for the OSD
&gt; processes and 16K system wide.
&gt;
&gt; Does this seem like the right spot to be looking? What are some
&gt; configuration items we should be looking at?
&gt;
&gt; Thanks,
&gt; ----------------
&gt; Robert LeBlanc
&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F=
1
&gt;
&gt;
&gt; On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc  wrote:
&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----
&gt;&gt; Hash: SHA256
&gt;&gt;
&gt;&gt; We were able to only get ~17Gb out of the XL710 (heavily tweaked)
&gt;&gt; until we went to the 4.x kernel where we got ~36Gb (no tweaking). =
It
&gt;&gt; seems that there were some major reworks in the network handling i=
n
&gt;&gt; the kernel to efficiently handle that network rate. If I remember
&gt;&gt; right we also saw a drop in CPU utilization. I&#39;m starting to t=
hink
&gt;&gt; that we did see packet loss while congesting our ISLs in our initi=
al
&gt;&gt; testing, but we could not tell where the dropping was happening. W=
e
&gt;&gt; saw some on the switches, but it didn&#39;t seem to be bad if we w=
eren&#39;t
&gt;&gt; trying to congest things. We probably already saw this issue, just
&gt;&gt; didn&#39;t know it.
&gt;&gt; - ----------------
&gt;&gt; Robert LeBlanc
&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62=
 B9F1
&gt;&gt;
&gt;&gt;
&gt;&gt; On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson=C2=A0 wrote:
&gt;&gt;&gt; FWIW, we&#39;ve got some 40GbE Intel cards in the community pe=
rformance cluster
&gt;&gt;&gt; on a Mellanox 40GbE switch that appear (knock on wood) to be r=
unning fine
&gt;&gt;&gt; with 3.10.0-229.7.2.el7.x86_64.=C2=A0 We did get feedback from=
 Intel that older
&gt;&gt;&gt; drivers might cause problems though.
&gt;&gt;&gt;
&gt;&gt;&gt; Here&#39;s ifconfig from one of the nodes:
&gt;&gt;&gt;
&gt;&gt;&gt; ens513f1: flags=3D4163=C2=A0 mtu 1500
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet 10.0.10.101=C2=A0 netmas=
k 255.255.255.0=C2=A0 broadcast 10.0.10.255
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet6 fe80::6a05:caff:fe2b:7e=
a1=C2=A0 prefixlen 64=C2=A0 scopeid 0x20
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ether 68:05:ca:2b:7e:a1=C2=A0=
 txqueuelen 1000=C2=A0 (Ethernet)
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets 169232242875=C2=A0=
 bytes 229346261232279 (208.5 TiB)
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX errors 0=C2=A0 dropped 0=
=C2=A0 overruns 0=C2=A0 frame 0
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets 153491686361=C2=A0=
 bytes 203976410836881 (185.5 TiB)
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX errors 0=C2=A0 dropped 0 o=
verruns 0=C2=A0 carrier 0=C2=A0 collisions 0
&gt;&gt;&gt;
&gt;&gt;&gt; Mark
&gt;&gt;&gt;
&gt;&gt;&gt;
&gt;&gt;&gt; On 09/23/2015 01:48 PM, Robert LeBlanc wrote:
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----
&gt;&gt;&gt;&gt; Hash: SHA256
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; OK, here is the update on the saga...
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; I traced some more of blocked I/Os and it seems that commu=
nication
&gt;&gt;&gt;&gt; between two hosts seemed worse than others. I did a two wa=
y ping flood
&gt;&gt;&gt;&gt; between the two hosts using max packet sizes (1500). After=
 1.5M
&gt;&gt;&gt;&gt; packets, no lost pings. Then then had the ping flood runni=
ng while I
&gt;&gt;&gt;&gt; put Ceph load on the cluster and the dropped pings started=
 increasing
&gt;&gt;&gt;&gt; after stopping the Ceph workload the pings stopped droppin=
g.
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; I then ran iperf between all the nodes with the same resul=
ts, so that
&gt;&gt;&gt;&gt; ruled out Ceph to a large degree. I then booted in the the
&gt;&gt;&gt;&gt; 3.10.0-229.14.1.el7.x86_64 kernel and with an hour test so=
 far there
&gt;&gt;&gt;&gt; hasn&#39;t been any dropped pings or blocked I/O. Our 40 G=
b NICs really
&gt;&gt;&gt;&gt; need the network enhancements in the 4.x series to work we=
ll.
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; Does this sound familiar to anyone? I&#39;ll probably star=
t bisecting the
&gt;&gt;&gt;&gt; kernel to see where this issue in introduced. Both of the =
clusters
&gt;&gt;&gt;&gt; with this issue are running 4.x, other than that, they are=
 pretty
&gt;&gt;&gt;&gt; differing hardware and network configs.
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; Thanks,
&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----
&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0
&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" target=3D"=
_blank">https://www.mailvelope.com</a>
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP/1xmCtW++G11qcE8y/=
sr
&gt;&gt;&gt;&gt; RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZpc6t4+m5nzE3LkA1rl=
2l
&gt;&gt;&gt;&gt; AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl0594eInEn7eI7crz8R54=
3V
&gt;&gt;&gt;&gt; 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLINK0Yb9XRVBlFip+Slt=
+j
&gt;&gt;&gt;&gt; cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0MOzBkFQM1FHfOipbo/L=
Yv
&gt;&gt;&gt;&gt; F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/Zxvor2gOi/J6d2XS9c=
kW
&gt;&gt;&gt;&gt; byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLsu/6YzeDNI6kmtGURaj=
dE
&gt;&gt;&gt;&gt; /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEODGAt6byoaoQEGN6dlF=
Ge
&gt;&gt;&gt;&gt; LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uXm0l1CHcp22RWBDvRin=
ok
&gt;&gt;&gt;&gt; UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdxGL29iFta4THzJgUGrp=
98
&gt;&gt;&gt;&gt; sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkdHX+x1EXpJUtocSeI44=
LX
&gt;&gt;&gt;&gt; KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1ULrFX0ILNx5Mo0Rp94=
4X
&gt;&gt;&gt;&gt; 4OEo
&gt;&gt;&gt;&gt; =3DP33I
&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----
&gt;&gt;&gt;&gt; ----------------
&gt;&gt;&gt;&gt; Robert LeBlanc
&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3=
BB2 FA62 B9F1
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 4:15 PM, Robert LeBlanc
&gt;&gt;&gt;&gt; wrote:
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----
&gt;&gt;&gt;&gt;&gt; Hash: SHA256
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt; This is IPoIB and we have the MTU set to 64K. There wa=
s some issues
&gt;&gt;&gt;&gt;&gt; pinging hosts with &quot;No buffer space available&quo=
t; (hosts are currently
&gt;&gt;&gt;&gt;&gt; configured for 4GB to test SSD caching rather than pag=
e cache). I
&gt;&gt;&gt;&gt;&gt; found that MTU under 32K worked reliable for ping, but=
 still had the
&gt;&gt;&gt;&gt;&gt; blocked I/O.
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt; I reduced the MTU to 1500 and checked pings (OK), but =
I&#39;m still seeing
&gt;&gt;&gt;&gt;&gt; the blocked I/O.
&gt;&gt;&gt;&gt;&gt; - ----------------
&gt;&gt;&gt;&gt;&gt; Robert LeBlanc
&gt;&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E6=
54 3BB2 FA62 B9F1
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 3:52 PM, Sage Weil=C2=A0 wrote=
:
&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 22 Sep 2015, Samuel Just wrote:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I looked at the logs, it looks like there was =
a 53 second delay
&gt;&gt;&gt;&gt;&gt;&gt;&gt; between when osd.17 started sending the osd_re=
pop message and when
&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd.13 started reading it, which is pretty wei=
rd.=C2=A0 Sage, didn&#39;t we
&gt;&gt;&gt;&gt;&gt;&gt;&gt; once see a kernel issue which caused some mess=
ages to be mysteriously
&gt;&gt;&gt;&gt;&gt;&gt;&gt; delayed for many 10s of seconds?
&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt; Every time we have seen this behavior and diagnose=
d it in the wild it
&gt;&gt;&gt;&gt;&gt;&gt; has
&gt;&gt;&gt;&gt;&gt;&gt; been a network misconfiguration.=C2=A0 Usually rel=
ated to jumbo frames.
&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt; sage
&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt; What kernel are you running?
&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Sam
&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlan=
c=C2=A0 wrote:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hash: SHA256
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; OK, looping in ceph-devel to see if I can =
get some more eyes. I&#39;ve
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; extracted what I think are important entri=
es from the logs for the
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; first blocked request. NTP is running all =
the servers so the logs
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; should be close in terms of time. Logs for=
 12:50 to 13:00 are
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; available at <a href=3D"http://162.144.87.=
113/files/ceph_block_io.logs.tar.xz" target=3D"_blank">http://162.144.87.11=
3/files/ceph_block_io.logs.tar.xz</a>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.500374 - osd.17 gets I=
/O from client
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.557160 - osd.17 submit=
s I/O to osd.13
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.557305 - osd.17 submit=
s I/O to osd.16
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.573711 - osd.16 gets I=
/O from osd.17
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.595716 - osd.17 gets o=
ndisk result=3D0 from osd.16
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.640631 - osd.16 report=
s to osd.17 ondisk result=3D0
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.926691 - osd.17 report=
s slow I/O &gt; 30.439150 sec
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:59.790591 - osd.13 gets I=
/O from osd.17
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:59.812405 - osd.17 gets o=
ndisk result=3D0 from osd.13
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:56:02.941602 - osd.13 report=
s to osd.17 ondisk result=3D0
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In the logs I can see that osd.17 dispatch=
es the I/O to osd.13 and
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd.16 almost silmutaniously. osd.16 seems=
 to get the I/O right away,
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; but for some reason osd.13 doesn&#39;t get=
 the message until 53 seconds
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; later. osd.17 seems happy to just wait and=
 doesn&#39;t resend the data
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (well, I&#39;m not 100% sure how to tell w=
hich entries are the actual data
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; transfer).
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; It looks like osd.17 is receiving response=
s to start the communication
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; with osd.13, but the op is not acknowledge=
d until almost a minute
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; later. To me it seems that the message is =
getting received but not
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; passed to another thread right away or som=
ething. This test was done
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; with an idle cluster, a single fio client =
(rbd engine) with a single
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; thread.
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The OSD servers are almost 100% idle durin=
g these blocked I/O
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; requests. I think I&#39;m at the end of my=
 troubleshooting, so I can use
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; some help.
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Single Test started about
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:52:36
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.926680 osd.17 <a href=
=3D"http://192.168.55.14:6800/16726" target=3D"_blank">192.168.55.14:6800/1=
6726</a> 56 :
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow requests, 1 included =
below; oldest blocked for &gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.439150 secs
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.926699 osd.17 <a href=
=3D"http://192.168.55.14:6800/16726" target=3D"_blank">192.168.55.14:6800/1=
6726</a> 57 :
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow request 30.439150 secon=
ds old, received at
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.487451:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1388 rb=
d_data.3380e2ae8944a.0000000000000545
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.bbf3e8ff ack+ondisk+write+kno=
wn_if_redirected e56785)
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,16
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.697904 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" target=3D"_blank">192.168.55.13:6800/2=
9410</a> 7 : cluster
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] 2 slow requests, 2 included below; o=
ldest blocked for &gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.379680 secs
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.697918 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" target=3D"_blank">192.168.55.13:6800/2=
9410</a> 8 : cluster
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] slow request 30.291520 seconds old, =
received at 2015-09-22
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 12:55:06.406303:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1384 rb=
d_data.3380e2ae8944a.0000000000000541
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.5fb2123f ack+ondisk+write+kno=
wn_if_redirected e56785)
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,17
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.697927 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" target=3D"_blank">192.168.55.13:6800/2=
9410</a> 9 : cluster
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] slow request 30.379680 seconds old, =
received at 2015-09-22
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 12:55:06.318144:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1382 rb=
d_data.3380e2ae8944a.000000000000053f
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.312e69ca ack+ondisk+write+kno=
wn_if_redirected e56785)
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,14
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.998275 osd.13 <a href=
=3D"http://192.168.55.12:6804/4574" target=3D"_blank">192.168.55.12:6804/45=
74</a> 130 :
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow requests, 1 included =
below; oldest blocked for &gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.954212 secs
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.998286 osd.13 <a href=
=3D"http://192.168.55.12:6804/4574" target=3D"_blank">192.168.55.12:6804/45=
74</a> 131 :
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow request 30.954212 secon=
ds old, received at
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:57:33.044003:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1873 rb=
d_data.3380e2ae8944a.000000000000070d
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.e69870d4 ack+ondisk+write+kno=
wn_if_redirected e56785)
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 16,17
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.759826 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" target=3D"_blank">192.168.55.13:6800/2=
9410</a> 10 :
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow requests, 1 included =
below; oldest blocked for &gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.704367 secs
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.759840 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" target=3D"_blank">192.168.55.13:6800/2=
9410</a> 11 :
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow request 30.704367 secon=
ds old, received at
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:57:33.055404:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1874 rb=
d_data.3380e2ae8944a.000000000000070e
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.f7635819 ack+ondisk+write+kno=
wn_if_redirected e56785)
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,17
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Server=C2=A0 =C2=A0IP addr=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSD
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodev=C2=A0 - 192.168.55.11 - 12
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodew=C2=A0 - 192.168.55.12 - 13
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodex=C2=A0 - 192.168.55.13 - 16
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodey=C2=A0 - 192.168.55.14 - 17
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodez=C2=A0 - 192.168.55.15 - 14
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodezz - 192.168.55.16 - 15
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; fio job:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [rbd-test]
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; readwrite=3Dwrite
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; blocksize=3D4M
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #runtime=3D60
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; name=3Drbd-test
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #readwrite=3Drandwrite
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #bssplit=3D4k/85:32k/11:512/3:1m/1,4k/89:3=
2k/10:512k/1
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #rwmixread=3D72
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #norandommap
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #size=3D1T
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #blocksize=3D4k
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ioengine=3Drbd
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; rbdname=3Dtest2
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pool=3Drbd
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; clientname=3Dadmin
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; iodepth=3D8
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #numjobs=3D4
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #thread
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #group_reporting
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #time_based
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #direct=3D1
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #ramp_time=3D60
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope=
.com" target=3D"_blank">https://www.mailvelope.com</a>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAK=
BnS94fwuw0OqpPU3/z
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQ=
mmqGuvEMn68spmasWu
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5j=
pGc8kZCvNS+ocDgFOl
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHM=
OwQK0bw8wWiCJEvqVB
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ=
5AMpeYPvEHu/LAr1N7
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlz=
szlEHm3iif98QtsxbF
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PC=
m59b4LBNAg6iPNH1AI
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg=
///vhxDsHWmcwClLEn
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+=
7V1oIzIYvWHyl2QpBq
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCj=
oCXJc8ajywR9Dy+6lL
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNE=
pde89qW32S9CZlrJDO
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV=
9vhzYoM7p5YWHghBKB
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; J3hS
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =3D0J7F
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----------------
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Robert LeBlanc
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=
=C2=A0 C70E E654 3BB2 FA62 B9F1
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 8:31 AM, Gregory F=
arnum=C2=A0 wrote:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 7:24 AM, Rober=
t LeBlanc=C2=A0 wrote:
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hash: SHA256
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is there some way to tell in the l=
ogs that this is happening?
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; You can search for the (mangled) name =
_split_collection
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m not
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; seeing much I/O, CPU usage during =
these times. Is there some way to
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; prevent the splitting? Is there a =
negative side effect to doing so?
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Bump up the split and merge thresholds=
. You can search the list for
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; this, it was discussed not too long ag=
o.
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; We&#39;ve had I/O block for over 9=
00 seconds and as soon as the sessions
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; are aborted, they are reestablishe=
d and complete immediately.
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The fio test is just a seq write, =
starting it over (rewriting from
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; beginning) is still causing the is=
sue. I was suspect that it is not
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; having to create new file and ther=
efore split collections. This is
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; on
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; my test cluster with no other load=
.
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hmm, that does make it seem less likel=
y if you&#39;re really not creating
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; new objects, if you&#39;re actually ru=
nning fio in such a way that it&#39;s
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; not allocating new FS blocks (this is =
probably hard to set up?).
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;ll be doing a lot of testing=
 today. Which log options and depths
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; would be the most helpful for trac=
king this issue down?
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If you want to go log diving &quot;deb=
ug osd =3D 20&quot;, &quot;debug filestore =3D
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 20&quot;,
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;debug ms =3D 1&quot; are what th=
e OSD guys like to see. That should spit
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; out
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; everything you need to track exactly w=
hat each Op is doing.
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Greg
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To unsubscribe from this list: send the li=
ne &quot;unsubscribe ceph-devel&quot;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; in
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the body of a message to <a href=3D"mailto=
:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"ht=
tp://vger.kernel.org/majordomo-info.html" target=3D"_blank">http://vger.ker=
nel.org/majordomo-info.html</a>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----
&gt;&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0
&gt;&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" target=
=3D"_blank">https://www.mailvelope.com</a>
&gt;&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAAoEgP/AqpH7i1BLpoz6=
fTlfWG
&gt;&gt;&gt;&gt;&gt; a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMmhWpJ6utEr1XPW0MPFg=
zvNIsf
&gt;&gt;&gt;&gt;&gt; a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr6It9v4Nv+biqZHkiY8=
x/rRtV
&gt;&gt;&gt;&gt;&gt; s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwzSsP3omupZgNyaKkCgd=
kil9Vc
&gt;&gt;&gt;&gt;&gt; iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3AWXSN4yEn286KyMDjF=
rsDY5B
&gt;&gt;&gt;&gt;&gt; izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJTikmGoNW6oQBjFq/z/=
zindTz
&gt;&gt;&gt;&gt;&gt; caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkTq+eTOb5pBhQbp+42Pk=
kqh7jj
&gt;&gt;&gt;&gt;&gt; efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuHyKbkwVs8x3JMPEiCl6=
PBvJbx
&gt;&gt;&gt;&gt;&gt; GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19RZPrAUhpDW0/DbUvuo=
KSR8m7
&gt;&gt;&gt;&gt;&gt; glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai9RpzQ+mWmp3xi7becY=
mL482H
&gt;&gt;&gt;&gt;&gt; +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmihAIn9dVTJ1O2RlapCLq=
L3YAJg
&gt;&gt;&gt;&gt;&gt; pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LELNS/UpyuYurbPcyPKU=
Q0uPjp
&gt;&gt;&gt;&gt;&gt; gcZm
&gt;&gt;&gt;&gt;&gt; =3DCjwB
&gt;&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;&gt; --
&gt;&gt;&gt;&gt; To unsubscribe from this list: send the line &quot;unsubsc=
ribe ceph-devel&quot; in
&gt;&gt;&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.=
kernel.org" target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
&gt;&gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel=
.org/majordomo-info.html" target=3D"_blank">http://vger.kernel.org/majordom=
o-info.html</a>
&gt;&gt;&gt;&gt;
&gt;&gt;&gt;
&gt;&gt;
&gt;&gt; -----BEGIN PGP SIGNATURE-----
&gt;&gt; Version: Mailvelope v1.1.0
&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" target=3D"_blank">=
https://www.mailvelope.com</a>
&gt;&gt;
&gt;&gt; wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zjl606aMdkmQG7
&gt;&gt; S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0JLDDqrbsqre2
&gt;&gt; lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHlP59Hu7VpxC5l
&gt;&gt; 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoyUwCM+eL7sotl
&gt;&gt; JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKzs9IZadOI8Ce0
&gt;&gt; dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVkxQGPYlpbpckf
&gt;&gt; nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh9z7o6qHs3Kvp
&gt;&gt; krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7QZ13Zau/qhDu
&gt;&gt; FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1fovEtJVeGAfE
&gt;&gt; tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96VtqAR5GQCkYE
&gt;&gt; hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1mrI3j80mZ4VTj
&gt;&gt; BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nmh5IyY+WO8hPo
&gt;&gt; ae22
&gt;&gt; =3DAX+L
&gt;&gt; -----END PGP SIGNATURE-----
_______________________________________________
ceph-users mailing list
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.1.0
Comment: <a href=3D"https://www.mailvelope.com" target=3D"_blank">https://w=
ww.mailvelope.com</a>

wsFcBAEBCAAQBQJWEVA5CRDmVDuy+mK58QAAY4EP/2jTEGPrbR3KDOC1d6FU
7TkVeFtow7UCe9/TwArLtcEVTr8rdaXNWRi7gat99zbL5pw+96Sj6bGqpKVz
ZBSHcBlLIl42Hj10Ju7Svpwn7Q9RnSGOvjEdghEKsTxnf37gZD/KjvMbidJu
jlPGEfnGEdYbQ+vDYoCoUIuvUNPbCvWQTjJpnTXrMZfhhEBoOepMzF9s6L6B
AWR9WUrtz4HtGSMT42U1gd3LDOUh/5Ioy6FuhJe04piaf3ikRg+pjX47/WBd
mQupmKJOblaULCswOrMLTS9R2+p6yaWj0zlUb3OAOErO7JR8OWZ2H7tYjkQN
rGPsIRNv4yKw2Z5vJdHLksVdYhBQY1I4N1GO3+hf+j/yotPC9Ay4BYLZrQwf
3L+uhqSEu80erZjsJF4lilmw0l9nbDSoXc0MqRoXrpUIqyVtmaCBynv5Xq7s
L5idaH6iVPBwy4Y6qzVuQpP0LaHp48ojIRx7likQJt0MSeDzqnslnp5B/9nb
Ppu3peRUKf5GEKISRQ6gOI3C4gTSSX6aBatWdtpm01Et0T6ysoxAP/VoO3Nb
0PDsuYYT0U1MYqi0USouiNc4yRWNb9hkkBHEJrwjtP52moL1WYdYleL6w+FS
Y1YQ1DU8YsEtVniBmZc4TBQJRRIS6SaQjH108JCjUcy9oVNwRtOqbcT1aiI6
EP/Q
=3Defx7
-----END PGP SIGNATURE-----
<pre></pre></pre></div>
</blockquote></div>

--f46d044287d2ca28d3052149b818--

--===============1340533483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1340533483==--
