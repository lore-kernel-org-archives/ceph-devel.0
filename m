From: Cesar Mello <cmello@gmail.com>
Subject: Re: RadosGW performance and disk space usage
Date: Sun, 27 Jan 2013 21:10:23 -0200
Message-ID: <CAJVE5RVE5_QzvNEYnm86NaKs4GVaAfXDUVUsrdJneXX5GbWgBw@mail.gmail.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
	<CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
	<CALFpzo4u2PspjkvSig3LL821YY_XA2iHBjAh30JxgwWTFGsgcA@mail.gmail.com>
	<CAJVE5RXpqJ3ZcbxAOCSD0f5OwN6Nre_TuhjY1BUveJTb=cga9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:33667 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab3A0XKY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jan 2013 18:10:24 -0500
Received: by mail-vb0-f41.google.com with SMTP id l22so1527564vbn.0
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jan 2013 15:10:23 -0800 (PST)
In-Reply-To: <CAJVE5RXpqJ3ZcbxAOCSD0f5OwN6Nre_TuhjY1BUveJTb=cga9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Just tried rest-bench. This little tool is wonderful, thanks!

I still have to learn lots of things. So please don't spend much time
explaining me, but instead please give me any pointers to
documentation or source code that can be useful. As a curiosity, I'm
pasting the results from my laptop. I'll repeat the same tests using
my desktop as the server.

Notice there is an assert being triggered, so I guess I'm running a
build with debugging code ?!. I compiled using ./configure
--with-radosgw --with-rest-bench followed by make.

Thanks a lot for the attention.

Best regards!
Mello

root@l3:/etc/init.d# rest-bench --api-host=localhost --bucket=test
--access-key=JJABVJ3AWBS1ZOCML7NS
--secret=A+ecBz2+Sdxj4Y8Mo+u3akIewGvJPkwOhwRgPKkX --protocol=http
--uri_style=path write
host=localhost
 Maintaining 16 concurrent writes of 4194304 bytes for at least 60 seconds.
 Object prefix: benchmark_data_l3_4032
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       3         3         0         0         0         -         0
     1      16        16         0         0         0         -         0
     2      16        16         0         0         0         -         0
     3      16        16         0         0         0         -         0
     4      16        16         0         0         0         -         0
     5      16        16         0         0         0         -         0
     6      16        16         0         0         0         -         0
     7      16        16         0         0         0         -         0
     8      16        16         0         0         0         -         0
     9      16        16         0         0         0         -         0
    10      16        16         0         0         0         -         0
    11      16        16         0         0         0         -         0
    12      16        17         1  0.333265  0.333333   11.2761   11.2761
    13      16        18         2  0.615257         4   12.5964   11.9363
    14      16        20         4   1.14262         8   13.1392   12.5365
    15      16        23         7   1.86628        12   14.2273   13.2594
    16      16        27        11   2.74944        16   15.0222   13.8968
    17      16        32        16   3.76394        20   16.2604   14.6301
    18      16        32        16   3.55483         0         -   14.6301
    19      16        34        18    3.7887         4    6.2274   13.7695
2013-01-27 20:49:29.703509min lat: 6.2274 max lat: 16.2604 avg lat: 13.7695
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    20      16        34        18   3.59927         0         -   13.7695
    21      16        34        18   3.42787         0         -   13.7695
    22      16        34        18   3.27205         0         -   13.7695
    23      16        35        19   3.30367         1   9.09053   13.5233
    24      16        36        20   3.33264         4   9.09667    13.302
    25      16        36        20   3.19933         0         -    13.302
    26      16        36        20   3.07628         0         -    13.302
    27      16        37        21   3.11047   1.33333   11.2459    13.204
    28      16        37        21   2.99938         0         -    13.204
    29      16        37        21   2.89595         0         -    13.204
    30      16        37        21   2.79942         0         -    13.204
    31      16        37        21   2.70912         0         -    13.204
    32      16        39        23   2.87441       1.6   14.9981   13.3602
    33      16        39        23    2.7873         0         -   13.3602
    34      16        39        23   2.70533         0         -   13.3602
    35      16        40        24   2.74229   1.33333   21.5365   13.7009
    36      16        40        24   2.66612         0         -   13.7009
    37      16        42        26   2.81023         4   22.6059   14.3855
    38      16        42        26   2.73628         0         -   14.3855
    39      16        45        29   2.97374         6   23.2615   15.3025
2013-01-27 20:49:49.707740min lat: 6.2274 max lat: 23.4496 avg lat: 16.1307
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    40      16        51        35   3.49927        24   21.0123   16.1307
    41      16        51        35   3.41392         0         -   16.1307
    42      16        52        36   3.42786         2   19.0243    16.211
    43      16        52        36   3.34814         0         -    16.211
    44      16        52        36   3.27204         0         -    16.211
    45      16        52        36   3.19933         0         -    16.211
    46      16        53        37   3.21672         1   11.0793   16.0723
    47      16        53        37   3.14828         0         -   16.0723
    48      16        53        37   3.08269         0         -   16.0723
    49      16        53        37   3.01978         0         -   16.0723
    50      16        55        39   3.11935         2   23.4253   16.5245
    51      16        55        39   3.05819         0         -   16.5245
    52      16        58        42    3.2301         6   13.3052   16.2945
    53      16        58        42   3.16915         0         -   16.2945
    54      16        60        44   3.25858         4   14.2116   16.1999
    55      16        60        44   3.19933         0         -   16.1999
    56      16        63        47   3.35644         6   15.6276   16.3393
    57      16        63        47   3.29756         0         -   16.3393
    58      16        66        50   3.44755         6   18.0547   16.5454
    59      16        66        50   3.38912         0         -   16.5454
2013-01-27 20:50:09.712027min lat: 6.2274 max lat: 26.3519 avg lat: 16.5454
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    60      16        66        50   3.33263         0         -   16.5454
    61      16        66        50     3.278         0         -   16.5454
    62      16        66        50   3.22513         0         -   16.5454
    63      16        67        51   3.23741       0.8   10.9553   16.4358
    64      16        67        51   3.18683         0         -   16.4358
    65      16        67        51    3.1378         0         -   16.4358
    66      16        67        51   3.09025         0         -   16.4358
    67      16        67        51   3.04413         0         -   16.4358
    68      16        67        51   2.99937         0         -   16.4358
    69      16        67        51    2.9559         0         -   16.4358
    70      16        67        51   2.91367         0         -   16.4358
    71      14        67        53   2.98528         1   15.1841   16.2524
    72       9        67        58   3.22154        20   26.2114   16.6243
 Total time run:         72.403588
Total writes made:      67
Write size:             4194304
Bandwidth (MB/sec):     3.701

Stddev Bandwidth:       4.92554
Max bandwidth (MB/sec): 24
Min bandwidth (MB/sec): 0
Average Latency:        17.1886
Stddev Latency:         5.48181
Max latency:            32.7038
Min latency:            6.2274
common/WorkQueue.cc: In function 'virtual ThreadPool::~ThreadPool()'
thread 7f1211401780 time 2013-01-27 20:51:01.196525
common/WorkQueue.cc: 59: FAILED assert(_threads.empty())
 ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
 1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
 2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
 3: (main()+0x75b) [0x42521b]
 4: (__libc_start_main()+0xed) [0x7f120f37576d]
 5: rest-bench() [0x426079]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
2013-01-27 20:51:01.197253 7f1211401780 -1 common/WorkQueue.cc: In
function 'virtual ThreadPool::~ThreadPool()' thread 7f1211401780 time
2013-01-27 20:51:01.196525
common/WorkQueue.cc: 59: FAILED assert(_threads.empty())

 ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
 1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
 2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
 3: (main()+0x75b) [0x42521b]
 4: (__libc_start_main()+0xed) [0x7f120f37576d]
 5: rest-bench() [0x426079]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
   -11> 2013-01-27 20:49:09.292227 7f1211401780  5 asok(0x29dc270)
register_command perfcounters_dump hook 0x29dc440
   -10> 2013-01-27 20:49:09.292259 7f1211401780  5 asok(0x29dc270)
register_command 1 hook 0x29dc440
    -9> 2013-01-27 20:49:09.292262 7f1211401780  5 asok(0x29dc270)
register_command perf dump hook 0x29dc440
    -8> 2013-01-27 20:49:09.292271 7f1211401780  5 asok(0x29dc270)
register_command perfcounters_schema hook 0x29dc440
    -7> 2013-01-27 20:49:09.292275 7f1211401780  5 asok(0x29dc270)
register_command 2 hook 0x29dc440
    -6> 2013-01-27 20:49:09.292278 7f1211401780  5 asok(0x29dc270)
register_command perf schema hook 0x29dc440
    -5> 2013-01-27 20:49:09.292285 7f1211401780  5 asok(0x29dc270)
register_command config show hook 0x29dc440
    -4> 2013-01-27 20:49:09.292290 7f1211401780  5 asok(0x29dc270)
register_command config set hook 0x29dc440
    -3> 2013-01-27 20:49:09.292292 7f1211401780  5 asok(0x29dc270)
register_command log flush hook 0x29dc440
    -2> 2013-01-27 20:49:09.292296 7f1211401780  5 asok(0x29dc270)
register_command log dump hook 0x29dc440
    -1> 2013-01-27 20:49:09.292300 7f1211401780  5 asok(0x29dc270)
register_command log reopen hook 0x29dc440
     0> 2013-01-27 20:51:01.197253 7f1211401780 -1
common/WorkQueue.cc: In function 'virtual ThreadPool::~ThreadPool()'
thread 7f1211401780 time 2013-01-27 20:51:01.196525
common/WorkQueue.cc: 59: FAILED assert(_threads.empty())

 ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
 1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
 2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
 3: (main()+0x75b) [0x42521b]
 4: (__libc_start_main()+0xed) [0x7f120f37576d]
 5: rest-bench() [0x426079]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -2/-2 (syslog threshold)
  99/99 (stderr threshold)
  max_recent    100000
  max_new         1000
  log_file
--- end dump of recent events ---
terminate called after throwing an instance of 'ceph::FailedAssertion'
*** Caught signal (Aborted) **
 in thread 7f1211401780
 ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
 1: rest-bench() [0x436b40]
 2: (()+0xfcb0) [0x7f1210ffccb0]
 3: (gsignal()+0x35) [0x7f120f38a425]
 4: (abort()+0x17b) [0x7f120f38db8b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f120fc85e2d]
 6: (()+0x5ef26) [0x7f120fc83f26]
 7: (()+0x5ef53) [0x7f120fc83f53]
 8: (()+0x5f17e) [0x7f120fc8417e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x43d) [0x43eced]
 10: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
 11: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
 12: (main()+0x75b) [0x42521b]
 13: (__libc_start_main()+0xed) [0x7f120f37576d]
 14: rest-bench() [0x426079]
2013-01-27 20:51:01.200578 7f1211401780 -1 *** Caught signal (Aborted) **
 in thread 7f1211401780

 ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
 1: rest-bench() [0x436b40]
 2: (()+0xfcb0) [0x7f1210ffccb0]
 3: (gsignal()+0x35) [0x7f120f38a425]
 4: (abort()+0x17b) [0x7f120f38db8b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f120fc85e2d]
 6: (()+0x5ef26) [0x7f120fc83f26]
 7: (()+0x5ef53) [0x7f120fc83f53]
 8: (()+0x5f17e) [0x7f120fc8417e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x43d) [0x43eced]
 10: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
 11: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
 12: (main()+0x75b) [0x42521b]
 13: (__libc_start_main()+0xed) [0x7f120f37576d]
 14: rest-bench() [0x426079]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
     0> 2013-01-27 20:51:01.200578 7f1211401780 -1 *** Caught signal
(Aborted) **
 in thread 7f1211401780

 ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
 1: rest-bench() [0x436b40]
 2: (()+0xfcb0) [0x7f1210ffccb0]
 3: (gsignal()+0x35) [0x7f120f38a425]
 4: (abort()+0x17b) [0x7f120f38db8b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f120fc85e2d]
 6: (()+0x5ef26) [0x7f120fc83f26]
 7: (()+0x5ef53) [0x7f120fc83f53]
 8: (()+0x5f17e) [0x7f120fc8417e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x43d) [0x43eced]
 10: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
 11: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
 12: (main()+0x75b) [0x42521b]
 13: (__libc_start_main()+0xed) [0x7f120f37576d]
 14: rest-bench() [0x426079]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -2/-2 (syslog threshold)
  99/99 (stderr threshold)
  max_recent    100000
  max_new         1000
  log_file
--- end dump of recent events ---
Aborted (core dumped)
root@l3:/etc/init.d#

On Sat, Jan 26, 2013 at 12:20 PM, Cesar Mello <cmello@gmail.com> wrote:
> Dear Sam, Dan and Marcus,
>
> Thank you a lot for the replies. I'll do more tests today.
>
> The length of each object used in my test is just 20 bytes. I'm glad
> you got 400 objects/s! Iif I get that with a length of 8 KB using a
> 2-node cluster, then ceph with rados will be already faster than my
> current solution. And then I will be able to present it to my boss.
> :-)
>
> I'll try rest-bench later. Thanks for the help!
>
> Best regards
> Mello
>
> On Sat, Jan 26, 2013 at 3:43 AM, Marcus Sorensen <shadowsor@gmail.com> wrote:
>> Have you tried rest-bench on localhost at the rados gateway? I was playing
>> with the rados gateway in a VM the other day, and was getting up to 400/s on
>> 4k objects. Above that I was getting connection failures, but I think it was
>> just due to a default max connections setting somewhere or something. My VM
>> is on SSD though. I was just thinking it may help isolate the issue.
>>
>>
>> On Fri, Jan 25, 2013 at 4:14 PM, Sam Lang <sam.lang@inktank.com> wrote:
>>>
>>> On Thu, Jan 24, 2013 at 9:27 AM, Cesar Mello <cmello@gmail.com> wrote:
>>> > Hi!
>>> >
>>> > I have successfully prototyped read/write access to ceph from Windows
>>> > using the S3 API, thanks so much for the help.
>>> >
>>> > Now I would like to do some prototypes targeting performance
>>> > evaluation. My scenario typically requires parallel storage of data
>>> > from tens of thousands of loggers, but scalability to hundreds of
>>> > thousands is the main reason for investigating ceph.
>>> >
>>> > My tests using a single laptop running ceph with 2 local OSDs and
>>> > local radosgw allows writing in average 2.5 small objects per second
>>> > (100 objects in 40 seconds). Is this the expected performance? It
>>> > seems to be I/O bound because the HDD led keeps on during the
>>> > PutObject requests. Any suggestion or documentation pointers for
>>> > profiling are very appreciated.
>>>
>>> Hi Mello,
>>>
>>> 2.5 objects/sec seems terribly slow, even on your laptop.  How "small"
>>> are these objects?  You might try to benchmark without the disk as a
>>> potential bottleneck, by putting your osd data and journals in /tmp
>>> (for benchmarking only of course) or create/mount a tmpfs and point
>>> your osd backends there.
>>>
>>> >
>>> > I am afraid the S3 API is not good for my scenario, because there is
>>> > no way to append data to existing objects (so I won't be able to model
>>> > a single object for each data collector). If this is the case, then I
>>> > would need to store billions of small objects. I would like to know
>>> > how much disk space each object instance requires other than the
>>> > object content length.
>>> >
>>> > If the S3 API is not well suited to my scenario, then my effort should
>>> > be better directed to porting or writing a native ceph client for
>>> > Windows. I just need an API to read and write/append blocks to files.
>>> > Any comments are really appreciated.
>>>
>>> Hopefully someone with more windows experience will give you better
>>> info/advice than I can.
>>>
>>> You could try to port the rados API to windows.  Its purely userspace,
>>> but does rely on pthreads and other libc/gcc specifics.  With
>>> something like cygwin a port might not be too hard though.  If you
>>> decide to go that route, let us know how you progress!
>>>
>>> -sam
>>>
>>>
>>> >
>>> > Thank you a lot for the attention!
>>> >
>>> > Best regards
>>> > Mello
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
