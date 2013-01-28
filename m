From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: RadosGW performance and disk space usage
Date: Mon, 28 Jan 2013 14:28:57 +0000
Message-ID: <51068B29.2060809@inktank.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com> <CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com> <CALFpzo4u2PspjkvSig3LL821YY_XA2iHBjAh30JxgwWTFGsgcA@mail.gmail.com> <CAJVE5RXpqJ3ZcbxAOCSD0f5OwN6Nre_TuhjY1BUveJTb=cga9A@mail.gmail.com> <CAJVE5RVE5_QzvNEYnm86NaKs4GVaAfXDUVUsrdJneXX5GbWgBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47169 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab3A1O3S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 09:29:18 -0500
Received: by mail-lb0-f179.google.com with SMTP id j14so3896705lbo.24
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 06:29:16 -0800 (PST)
In-Reply-To: <CAJVE5RVE5_QzvNEYnm86NaKs4GVaAfXDUVUsrdJneXX5GbWgBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, yehuda@inktank.com

On 01/27/2013 11:10 PM, Cesar Mello wrote:
> Hi,
>
> Just tried rest-bench. This little tool is wonderful, thanks!
>
> I still have to learn lots of things. So please don't spend much time
> explaining me, but instead please give me any pointers to
> documentation or source code that can be useful. As a curiosity, I'm
> pasting the results from my laptop. I'll repeat the same tests using
> my desktop as the server.
>
> Notice there is an assert being triggered, so I guess I'm running a
> build with debugging code ?!. I compiled using ./configure
> --with-radosgw --with-rest-bench followed by make.

asserts are usually used to mark invariants on the code logic, and are 
always built, regardless debugging being enabled or disabled.  Given you 
are hitting one, it probably means something is not quite right (might 
be a bug, or some invariant was broken for some reason).

> common/WorkQueue.cc: In function 'virtual ThreadPool::~ThreadPool()'
> thread 7f1211401780 time 2013-01-27 20:51:01.196525
> common/WorkQueue.cc: 59: FAILED assert(_threads.empty())
>   ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>   1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>   2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>   3: (main()+0x75b) [0x42521b]
>   4: (__libc_start_main()+0xed) [0x7f120f37576d]
>   5: rest-bench() [0x426079]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.

Looks like http://tracker.newdream.net/issues/3896

Am not sure who should be made aware of this issue though. Maybe Yehuda 
(cc'ing)?

   -Joao


> 2013-01-27 20:51:01.197253 7f1211401780 -1 common/WorkQueue.cc: In
> function 'virtual ThreadPool::~ThreadPool()' thread 7f1211401780 time
> 2013-01-27 20:51:01.196525
> common/WorkQueue.cc: 59: FAILED assert(_threads.empty())
>
>   ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>   1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>   2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>   3: (main()+0x75b) [0x42521b]
>   4: (__libc_start_main()+0xed) [0x7f120f37576d]
>   5: rest-bench() [0x426079]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- begin dump of recent events ---
>     -11> 2013-01-27 20:49:09.292227 7f1211401780  5 asok(0x29dc270)
> register_command perfcounters_dump hook 0x29dc440
>     -10> 2013-01-27 20:49:09.292259 7f1211401780  5 asok(0x29dc270)
> register_command 1 hook 0x29dc440
>      -9> 2013-01-27 20:49:09.292262 7f1211401780  5 asok(0x29dc270)
> register_command perf dump hook 0x29dc440
>      -8> 2013-01-27 20:49:09.292271 7f1211401780  5 asok(0x29dc270)
> register_command perfcounters_schema hook 0x29dc440
>      -7> 2013-01-27 20:49:09.292275 7f1211401780  5 asok(0x29dc270)
> register_command 2 hook 0x29dc440
>      -6> 2013-01-27 20:49:09.292278 7f1211401780  5 asok(0x29dc270)
> register_command perf schema hook 0x29dc440
>      -5> 2013-01-27 20:49:09.292285 7f1211401780  5 asok(0x29dc270)
> register_command config show hook 0x29dc440
>      -4> 2013-01-27 20:49:09.292290 7f1211401780  5 asok(0x29dc270)
> register_command config set hook 0x29dc440
>      -3> 2013-01-27 20:49:09.292292 7f1211401780  5 asok(0x29dc270)
> register_command log flush hook 0x29dc440
>      -2> 2013-01-27 20:49:09.292296 7f1211401780  5 asok(0x29dc270)
> register_command log dump hook 0x29dc440
>      -1> 2013-01-27 20:49:09.292300 7f1211401780  5 asok(0x29dc270)
> register_command log reopen hook 0x29dc440
>       0> 2013-01-27 20:51:01.197253 7f1211401780 -1
> common/WorkQueue.cc: In function 'virtual ThreadPool::~ThreadPool()'
> thread 7f1211401780 time 2013-01-27 20:51:01.196525
> common/WorkQueue.cc: 59: FAILED assert(_threads.empty())
>
>   ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>   1: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>   2: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>   3: (main()+0x75b) [0x42521b]
>   4: (__libc_start_main()+0xed) [0x7f120f37576d]
>   5: rest-bench() [0x426079]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 1 lockdep
>     0/ 1 context
>     1/ 1 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 1 buffer
>     0/ 1 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 5 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 5 osd
>     0/ 5 optracker
>     0/ 5 objclass
>     1/ 3 filestore
>     1/ 3 journal
>     0/ 5 ms
>     1/ 5 mon
>     0/10 monc
>     0/ 5 paxos
>     0/ 5 tp
>     1/ 5 auth
>     1/ 5 crypto
>     1/ 1 finisher
>     1/ 5 heartbeatmap
>     1/ 5 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     1/ 5 asok
>     1/ 1 throttle
>    -2/-2 (syslog threshold)
>    99/99 (stderr threshold)
>    max_recent    100000
>    max_new         1000
>    log_file
> --- end dump of recent events ---
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> *** Caught signal (Aborted) **
>   in thread 7f1211401780
>   ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>   1: rest-bench() [0x436b40]
>   2: (()+0xfcb0) [0x7f1210ffccb0]
>   3: (gsignal()+0x35) [0x7f120f38a425]
>   4: (abort()+0x17b) [0x7f120f38db8b]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f120fc85e2d]
>   6: (()+0x5ef26) [0x7f120fc83f26]
>   7: (()+0x5ef53) [0x7f120fc83f53]
>   8: (()+0x5f17e) [0x7f120fc8417e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x43d) [0x43eced]
>   10: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>   11: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>   12: (main()+0x75b) [0x42521b]
>   13: (__libc_start_main()+0xed) [0x7f120f37576d]
>   14: rest-bench() [0x426079]
> 2013-01-27 20:51:01.200578 7f1211401780 -1 *** Caught signal (Aborted) **
>   in thread 7f1211401780
>
>   ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>   1: rest-bench() [0x436b40]
>   2: (()+0xfcb0) [0x7f1210ffccb0]
>   3: (gsignal()+0x35) [0x7f120f38a425]
>   4: (abort()+0x17b) [0x7f120f38db8b]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f120fc85e2d]
>   6: (()+0x5ef26) [0x7f120fc83f26]
>   7: (()+0x5ef53) [0x7f120fc83f53]
>   8: (()+0x5f17e) [0x7f120fc8417e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x43d) [0x43eced]
>   10: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>   11: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>   12: (main()+0x75b) [0x42521b]
>   13: (__libc_start_main()+0xed) [0x7f120f37576d]
>   14: rest-bench() [0x426079]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- begin dump of recent events ---
>       0> 2013-01-27 20:51:01.200578 7f1211401780 -1 *** Caught signal
> (Aborted) **
>   in thread 7f1211401780
>
>   ceph version 0.56-464-gfa421cf (fa421cf5f52ca16fa1328dbea2f4bda85c56cd3f)
>   1: rest-bench() [0x436b40]
>   2: (()+0xfcb0) [0x7f1210ffccb0]
>   3: (gsignal()+0x35) [0x7f120f38a425]
>   4: (abort()+0x17b) [0x7f120f38db8b]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f120fc85e2d]
>   6: (()+0x5ef26) [0x7f120fc83f26]
>   7: (()+0x5ef53) [0x7f120fc83f53]
>   8: (()+0x5f17e) [0x7f120fc8417e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x43d) [0x43eced]
>   10: (ThreadPool::~ThreadPool()+0x10c) [0x43bf9c]
>   11: (RESTDispatcher::~RESTDispatcher()+0xf1) [0x42a021]
>   12: (main()+0x75b) [0x42521b]
>   13: (__libc_start_main()+0xed) [0x7f120f37576d]
>   14: rest-bench() [0x426079]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 1 lockdep
>     0/ 1 context
>     1/ 1 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 1 buffer
>     0/ 1 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 5 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 5 osd
>     0/ 5 optracker
>     0/ 5 objclass
>     1/ 3 filestore
>     1/ 3 journal
>     0/ 5 ms
>     1/ 5 mon
>     0/10 monc
>     0/ 5 paxos
>     0/ 5 tp
>     1/ 5 auth
>     1/ 5 crypto
>     1/ 1 finisher
>     1/ 5 heartbeatmap
>     1/ 5 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     1/ 5 asok
>     1/ 1 throttle
>    -2/-2 (syslog threshold)
>    99/99 (stderr threshold)
>    max_recent    100000
>    max_new         1000
>    log_file
> --- end dump of recent events ---
> Aborted (core dumped)
> root@l3:/etc/init.d#
>
> On Sat, Jan 26, 2013 at 12:20 PM, Cesar Mello <cmello@gmail.com> wrote:
>> Dear Sam, Dan and Marcus,
>>
>> Thank you a lot for the replies. I'll do more tests today.
>>
>> The length of each object used in my test is just 20 bytes. I'm glad
>> you got 400 objects/s! Iif I get that with a length of 8 KB using a
>> 2-node cluster, then ceph with rados will be already faster than my
>> current solution. And then I will be able to present it to my boss.
>> :-)
>>
>> I'll try rest-bench later. Thanks for the help!
>>
>> Best regards
>> Mello
>>
>> On Sat, Jan 26, 2013 at 3:43 AM, Marcus Sorensen <shadowsor@gmail.com> wrote:
>>> Have you tried rest-bench on localhost at the rados gateway? I was playing
>>> with the rados gateway in a VM the other day, and was getting up to 400/s on
>>> 4k objects. Above that I was getting connection failures, but I think it was
>>> just due to a default max connections setting somewhere or something. My VM
>>> is on SSD though. I was just thinking it may help isolate the issue.
>>>
>>>
>>> On Fri, Jan 25, 2013 at 4:14 PM, Sam Lang <sam.lang@inktank.com> wrote:
>>>>
>>>> On Thu, Jan 24, 2013 at 9:27 AM, Cesar Mello <cmello@gmail.com> wrote:
>>>>> Hi!
>>>>>
>>>>> I have successfully prototyped read/write access to ceph from Windows
>>>>> using the S3 API, thanks so much for the help.
>>>>>
>>>>> Now I would like to do some prototypes targeting performance
>>>>> evaluation. My scenario typically requires parallel storage of data
>>>>> from tens of thousands of loggers, but scalability to hundreds of
>>>>> thousands is the main reason for investigating ceph.
>>>>>
>>>>> My tests using a single laptop running ceph with 2 local OSDs and
>>>>> local radosgw allows writing in average 2.5 small objects per second
>>>>> (100 objects in 40 seconds). Is this the expected performance? It
>>>>> seems to be I/O bound because the HDD led keeps on during the
>>>>> PutObject requests. Any suggestion or documentation pointers for
>>>>> profiling are very appreciated.
>>>>
>>>> Hi Mello,
>>>>
>>>> 2.5 objects/sec seems terribly slow, even on your laptop.  How "small"
>>>> are these objects?  You might try to benchmark without the disk as a
>>>> potential bottleneck, by putting your osd data and journals in /tmp
>>>> (for benchmarking only of course) or create/mount a tmpfs and point
>>>> your osd backends there.
>>>>
>>>>>
>>>>> I am afraid the S3 API is not good for my scenario, because there is
>>>>> no way to append data to existing objects (so I won't be able to model
>>>>> a single object for each data collector). If this is the case, then I
>>>>> would need to store billions of small objects. I would like to know
>>>>> how much disk space each object instance requires other than the
>>>>> object content length.
>>>>>
>>>>> If the S3 API is not well suited to my scenario, then my effort should
>>>>> be better directed to porting or writing a native ceph client for
>>>>> Windows. I just need an API to read and write/append blocks to files.
>>>>> Any comments are really appreciated.
>>>>
>>>> Hopefully someone with more windows experience will give you better
>>>> info/advice than I can.
>>>>
>>>> You could try to port the rados API to windows.  Its purely userspace,
>>>> but does rely on pthreads and other libc/gcc specifics.  With
>>>> something like cygwin a port might not be too hard though.  If you
>>>> decide to go that route, let us know how you progress!
>>>>
>>>> -sam
>>>>
>>>>
>>>>>
>>>>> Thank you a lot for the attention!
>>>>>
>>>>> Best regards
>>>>> Mello
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

