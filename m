From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 15:21:09 +0200
Message-ID: <4FC77045.6050907@univ-nantes.fr>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:35845 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757948Ab2EaNVS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 09:21:18 -0400
In-Reply-To: <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Stefan Majer <stefan.majer@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On 31/05/2012 09:30, Yehuda Sadeh wrote:
> On Thu, May 31, 2012 at 12:10 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hi Marc, Hi Stefan,
>>

Hello, back today

Today, I upgraded my 2 last osd nodes with big storage, so now all my=20
nodes are equivalent.

Using 3.4.0 kernel, I still have good results with rbd pool, but jumpin=
g=20
values with data.


>> first thanks for all your help and time.
>>
>> I found the commit which results in this problem and it is TCP relat=
ed
>> but i'm still wondering if the expected behaviour of this commit is
>> expected?
>

=2E...

>>
> Yeah, this might have affected the tcp performance. Looking at the
> current linus tree this function looks more like it looked beforehand=
,
> so it was probable reverted this way or another!
>
> Yehuda

Well, I saw you probably found the culprit.

So tried the latest (this morning) git kernel.

Now data gives good results :

root@label5:~#  rados -p data bench 20 write -t 16
Maintaining 16 concurrent writes of 4194304 bytes for at least 20 secon=
ds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1      16       215       199   795.765       796  0.073769 0.0745=
517
     2      16       430       414   827.833       860  0.060165 0.0753=
952
     3      16       632       616   821.207       808  0.072241 0.0772=
463
     4      16       838       822   821.883       824  0.129571 0.0768=
741
     5      16      1039      1023   818.271       804  0.056867  0.077=
637
     6      16      1254      1238   825.209       860  0.078801 0.0771=
122
     7      16      1474      1458   833.023       880  0.062886 0.0764=
071
     8      16      1669      1653   826.389       780   0.09632 0.0767=
323
     9      16      1877      1861   827.003       832  0.083765 0.0770=
398
    10      16      2087      2071   828.294       840  0.051437  0.076=
937
    11      16      2309      2293   833.714       888  0.080584 0.0764=
829
    12      16      2535      2519   839.563       904  0.078095 0.0759=
574
    13      16      2762      2746   844.816       908  0.081323 0.0754=
571
    14      16      2984      2968   847.889       888  0.076973 0.0752=
921
    15      16      3203      3187   849.754       876  0.069877 0.0750=
613
    16      16      3437      3421   855.138       936  0.046845 0.0746=
941
    17      16      3655      3639   856.126       872  0.052258 0.0745=
157
    18      16      3862      3846   854.559       828  0.061542 0.0746=
875
    19      16      4085      4069   856.525       892  0.053889 0.0745=
582
min lat: 0.033007 max lat: 0.462951 avg lat: 0.0743988
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
    20      15      4308      4293   858.492       896  0.054176 0.0743=
988
Total time run:        20.103415
Total writes made:     4309
Write size:            4194304
Bandwidth (MB/sec):    857.367

Average Latency:       0.0746302
Max latency:           0.462951
Min latency:           0.033007



But very strangely it's now rbd that isn't stable ?!

root@label5:~#  rados -p rbd bench 20 write -t 16
Maintaining 16 concurrent writes of 4194304 bytes for at least 20 secon=
ds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1      16       155       139    555.87       556  0.046232  0.109=
021
     2      16       250       234   467.923       380  0.046793 0.0985=
316
     3      16       250       234   311.955         0         - 0.0985=
316
     4      16       250       234   233.965         0         - 0.0985=
316
     5      16       250       234   187.173         0         - 0.0985=
316
     6      16       266       250   166.645        16  0.038083  0.175=
697
     7      16       266       250   142.839         0         -  0.175=
697
     8      16       441       425   212.475       350   0.05512  0.298=
391
     9      16       476       460   204.422       140   0.04372  0.280=
483
    10      16       531       515   205.976       220  0.125076  0.309=
449
    11      16       734       718    261.06       812  0.127582  0.244=
134
    12      16       795       779   259.637       244  0.065158  0.234=
156
    13      16       818       802   246.742        92  0.054514  0.241=
704
    14      16       830       814   232.546        48  0.044386  0.239=
006
    15      16       837       821   218.909        28   3.41523  0.267=
521
    16      16      1043      1027   256.721       824   0.04898  0.248=
212
    17      16      1147      1131   266.088       416  0.048591  0.232=
725
    18      16      1147      1131   251.305         0         -  0.232=
725
    19      16      1202      1186   249.657       110  0.081777   0.25=
501
min lat: 0.033773 max lat: 5.92059 avg lat: 0.245711
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
    20      16      1296      1280    255.97       376  0.053797  0.245=
711
    21       9      1297      1288   245.305        32  0.708133  0.248=
248
    22       9      1297      1288   234.155         0         -  0.248=
248
    23       9      1297      1288   223.975         0         -  0.248=
248
    24       9      1297      1288   214.643         0         -  0.248=
248
    25       9      1297      1288   206.057         0         -  0.248=
248
    26       9      1297      1288   198.131         0         -  0.248=
248
Total time run:        26.829870
Total writes made:     1297
Write size:            4194304
Bandwidth (MB/sec):    193.367

Average Latency:       0.295922
Max latency:           7.36701
Min latency:           0.033773


Strange. I'm wondering if this has something to do with cache (that is,=
=20
operation I could have done before on nodes, as all my nodes are just=20
freshly rebooted).

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
