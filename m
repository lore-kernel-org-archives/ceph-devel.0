From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 15:39:52 +0200
Message-ID: <4FC4D1A8.1080001@univ-nantes.fr>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [193.52.103.110] ([193.52.103.110]:50889 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752347Ab2E2NkN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 May 2012 09:40:13 -0400
In-Reply-To: <4FC49B12.8020004@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On 29/05/2012 11:46, Stefan Priebe - Profihost AG wrote:
> It would be really nice if somebody from inktank can comment this who=
le
> sitation.
>
Hello.
I think I have the same bug :

My setup is with 8 OSD nodes, 3 MDS (1 active) & 3 MON.
All my machines are debian, using a custom 3.4.0 kernel. Ceph is=20
0.47.2-1~bpo60+1 (debian package)

root@label5:~#  rados -p data bench 20 write -t 16
Maintaining 16 concurrent writes of 4194304 bytes for at least 20 secon=
ds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1      16        99        83     331.9       332  0.059756 0.0946=
512
     2      16       141       125   249.946       168  0.049822  0.212=
338
     3      16       166       150   199.963       100  0.057352  0.257=
179
     4      16       227       211   210.965       244  0.043592  0.265=
005
     5      16       257       241   192.767       120  0.040883  0.276=
718
     6      16       260       244   162.641        12   1.59593  0.293=
439
     7      16       319       303   173.118       236  0.056913  0.357=
856
     8      16       348       332   165.976       116  0.052954  0.332=
424
     9      16       348       332   147.535         0         -  0.332=
424
    10      16       472       456   182.374       248  0.038543  0.343=
745
    11      16       485       469   170.522        52  0.040475  0.347=
328
    12      16       485       469   156.312         0         -  0.347=
328
    13      16       517       501   154.133        64  0.047759  0.378=
595
    14      16       562       546    155.98       180  0.042814  0.395=
036
    15      16       563       547   145.847         4  0.045834  0.394=
398
    16      16       563       547   136.732         0         -  0.394=
398
    17      16       563       547   128.689         0         -  0.394=
398
    18      16       667       651   144.648   138.667   0.06501  0.440=
847
    19      16       703       687   144.613       144  0.040772  0.421=
935
min lat: 0.030505 max lat: 5.05834 avg lat: 0.421935
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
    20      16       703       687   137.382         0         -  0.421=
935
    21      16       704       688   131.031         2   2.65675  0.425=
184
    22      14       704       690   125.439         8   3.26857  0.433=
417
Total time run:        22.042041
Total writes made:     704
Write size:            4194304
Bandwidth (MB/sec):    127.756

Average Latency:       0.498932
Max latency:           5.05834
Min latency:           0.030505


What puzzle me is if I test with pool rbd instead :


root@label5:~#  rados -p rbd bench 20 write -t 16
Maintaining 16 concurrent writes of 4194304 bytes for at least 20 secon=
ds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1      16       191       175   699.782       700  0.236737 0.0841=
979
     2      16       397       381   761.837       824  0.065643 0.0813=
094
     3      16       602       586   781.193       820   0.07921 0.0808=
584
     4      16       815       799    798.88       852  0.066597 0.0785=
906
     5      16      1026      1010   807.885       844   0.10364 0.0785=
475
     6      16      1249      1233   821.886       892  0.069324 0.0773=
951
     7      16      1461      1445   825.608       848  0.053176 0.0770=
628
     8      16      1680      1664   831.895       876   0.09612 0.0765=
263
     9      16      1897      1881   835.891       868  0.100736 0.0761=
617
    10      16      2105      2089   835.491       832  0.114913 0.0761=
897
    11      16      2329      2313   840.983       896  0.042009 0.0758=
589
    12      16      2553      2537   845.559       896   0.07017 0.0754=
364
    13      16      2786      2770   852.203       932  0.066365 0.0749=
136
    14      16      3009      2993   855.041       892   0.06491 0.0746=
046
    15      16      3228      3212   856.431       876   0.05698 0.0745=
573
    16      16      3437      3421   855.148       836  0.062162 0.0746=
339
    17      16      3652      3636   855.428       860  0.140451  0.074=
534
    18      16      3878      3862   858.121       904  0.081505 0.0743=
125
    19      16      4106      4090   860.952       912  0.079922 0.0742=
146
min lat: 0.032342 max lat: 0.63151 avg lat: 0.0741575
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
    20      16      4324      4308   861.495       872   0.06199 0.0741=
575
Total time run:        20.102264
Total writes made:     4325
Write size:            4194304
Bandwidth (MB/sec):    860.600

Average Latency:       0.0743131
Max latency:           0.63151
Min latency:           0.032342


As you can see, much more stable bandwith with this pool.

I understand data & rbd pool probably don't use the same internals, but=
=20
is this difference expected ?

disclaimer: By no mean I'm a ceph expert, I'm just experimenting with=20
it, and still don't understand all the internals.


Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
