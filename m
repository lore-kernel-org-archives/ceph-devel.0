From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Ceph benchmark
Date: Tue, 5 May 2015 23:17:18 -0700
Message-ID: <CAKKTCLWj6404BfKNOS3KzcTJz2kf3fj=cz_t4a2TD7RsSL79ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34112 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbEFGRj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 02:17:39 -0400
Received: by obfe9 with SMTP id e9so131760obf.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 23:17:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

I am running ceph bench mark on a 3 node cluster.
I am seeing that the bandwidth is going down and latencies are going
up beyond 16k.
What must be going on ? Is there anything I must check?


Thanks in advance for your help.


Hard disk can handle it.(dd below) and it is a 1Gb network.

vjujjuri@rgulistan-wsl13:~/ceph-cluster$ sudo dd if=/dev/zero
of=/media/data/ddtest bs=8k count=100 oflag=direct
100+0 records in
100+0 records out
819200 bytes (819 kB) copied, 0.00778172 s, 105 MB/s
vjujjuri@rgulistan-wsl13:~/ceph-cluster$ sudo dd if=/dev/zero
of=/media/data/ddtest bs=16k count=100 oflag=direct
100+0 records in
100+0 records out
1638400 bytes (1.6 MB) copied, 0.00819058 s, 200 MB/s
vjujjuri@rgulistan-wsl13:~/ceph-cluster$ sudo dd if=/dev/zero
of=/media/data/ddtest bs=32k count=100 oflag=direct
100+0 records in
100+0 records out
3276800 bytes (3.3 MB) copied, 0.0133412 s, 246 MB/s
vjujjuri@rgulistan-wsl13:~/ceph-cluster$ sudo dd if=/dev/zero
of=/media/data/ddtest bs=64k count=100 oflag=direct
100+0 records in
100+0 records out
6553600 bytes (6.6 MB) copied, 0.0213862 s, 306 MB/s



vjujjuri@rgulistan-wsl13:~/ceph-cluster$ rados bench -p sfdc_ssd -b
8192 10 write --no-cleanup
 Maintaining 16 concurrent writes of 8192 bytes for up to 10 seconds
or 0 objects
 Object prefix: benchmark_data_rgulistan-wsl13_3978
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16      4491      4475   34.9558   34.96090.004625760.00356678
     2      16      8019      8003   31.2573   27.56250.005743870.00399099
     3      15     11550     11535   30.0349   27.59380.003749640.00415737
     4      16     14836     14820   28.9414   25.66410.005634550.00431221
     5      15     17328     17313   27.0481   19.47660.007941170.00461614
     6      16     20654     20638   26.8692   25.97660.003703640.00464857
     7      16     24144     24128   26.9253   27.26560.004056120.00463968
     8      16     27647     27631   26.9803   27.36720.002609330.00463053
     9      15     31049     31034   26.9361   26.58590.005216640.00463805
    10      16     34482     34466   26.9235   26.81250.009889080.00464022
 Total time run:         10.006237
Total writes made:      34482
Write size:             8192
Bandwidth (MB/sec):     26.922

Stddev Bandwidth:       8.84853
Max bandwidth (MB/sec): 34.9609
Min bandwidth (MB/sec): 0
Average Latency:        0.00464095
Stddev Latency:         0.00186824
Max latency:            0.035694
Min latency:            0.00191166
vjujjuri@rgulistan-wsl13:~/ceph-cluster$ rados bench -p sfdc_ssd -b
16384 10 write --no-cleanup
 Maintaining 16 concurrent writes of 16384 bytes for up to 10 seconds
or 0 objects
 Object prefix: benchmark_data_rgulistan-wsl13_3999
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16      3416      3400   53.1168    53.1250.005582130.00468952
     2      16      6804      6788   53.0233   52.93750.004283230.00470578
     3      16     10310     10294   53.6069   54.78120.004640170.00465615
     4      16     13598     13582   53.0482    51.3750.005829570.00470762
     5      16     16159     16143   50.4404   40.01560.00569706 0.0049528
     6      16     19616     19600   51.0352   54.01560.005133240.00489462
     7      16     22904     22888   51.0828    51.3750.00464216 0.0048904
     8      15     26388     26373   51.5034   54.45310.00280325 0.0048512
     9      16     29098     29082   50.4835   42.32810.004756190.00494863
    10      16     32401     32385   50.5954   51.6094 0.00410140.00493792
 Total time run:         10.007195
Total writes made:      32401
Write size:             16384
Bandwidth (MB/sec):     50.590

Stddev Bandwidth:       16.0195
Max bandwidth (MB/sec): 54.7812
Min bandwidth (MB/sec): 0
Average Latency:        0.00493992
Stddev Latency:         0.00167482
Max latency:            0.0296512
Min latency:            0.00211289
vjujjuri@rgulistan-wsl13:~/ceph-cluster$ rados bench -p sfdc_ssd -b
32768 10 write --no-cleanup
 Maintaining 16 concurrent writes of 32768 bytes for up to 10 seconds
or 0 objects
 Object prefix: benchmark_data_rgulistan-wsl13_4175
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16      1224      1208   37.7451     37.750.005912320.00995742
     2      16      2145      2129   33.2615   28.7812 0.0100326  0.014982
     3      16      3707      3691   38.4427   48.8125   0.01267 0.0128672
     4      16      4880      4864   37.9949   36.65620.00840912 0.0131463
     5      16      6292      6276   39.2197    44.125 0.0107234 0.0123698
     6      16      7392      7376   38.4115    34.375 0.0052234 0.0130013
     7      16      8941      8925   39.8385   48.40620.00581271 0.0125307
     8      16     10395     10379   40.5378   45.43750.00430514 0.0123214
     9      16     11257     11241   39.0263   26.9375  0.011219 0.0127994
    10      16     12757     12741   39.8106    46.8750.00634619 0.0125532
 Total time run:         10.251305
Total writes made:      12758
Write size:             32768
Bandwidth (MB/sec):     38.891

Stddev Bandwidth:       14.2386
Max bandwidth (MB/sec): 48.8125
Min bandwidth (MB/sec): 0
Average Latency:        0.0128327
Stddev Latency:         0.0231052
Max latency:            0.259471
Min latency:            0.00291666



-- 
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
