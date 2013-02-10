From: Ugis <ugis22@gmail.com>
Subject: Re: how to recover from full osd and possible bug?
Date: Mon, 11 Feb 2013 00:53:13 +0200
Message-ID: <CAE63xUNdVKGqFdusjdG6EE8=AKWSjuMKAaRkv2niLPctvBU06g@mail.gmail.com>
References: <CAE63xUMs2NNseYFF6M_jTfFVjwQ9bbm8kk2m51_L5Mz2HA3VuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:50364 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab3BJWxO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 17:53:14 -0500
Received: by mail-ia0-f181.google.com with SMTP id l29so2222731iag.40
        for <ceph-devel@vger.kernel.org>; Sun, 10 Feb 2013 14:53:13 -0800 (PST)
In-Reply-To: <CAE63xUMs2NNseYFF6M_jTfFVjwQ9bbm8kk2m51_L5Mz2HA3VuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Guys, any advices/comments on this? How to start osd with full
filesystem or that was never intended? If this is possible, I could:
1. change crushmap, reducing weight of the full osd,
2. start the full osd and let cluster rebalance.

Now, the full osd is down anyway, reballancing is going on filling
next osds. It seems that only option is to just reformat full one and
rejoin to get it up&in again. This seems to be the hard way for
cluster which leads to 2 thoughts:
1)can you actually overweight osds manually which leads to full
filesystem? OSD should not allow to set weights higher than underlying
size of filesystem. At least not in terms of size. That would help in
cases when people want to squeeze out any last GB of usable storage
and overweight exactly the same couple GB by looking at Size "df -h".
2)if happens that osd hit full filesystem for any reason, better it
would stay "up"&"out" and let admin to do something about weights
rather than just die off and not start at all, because in latter case
it actually is the same as fatal HW crash when you do not hope to
recover the data from osd.


Ugis


2013/2/8 Ugis <ugis22@gmail.com>:
> Hi,
>
> While trying to balance cluster over night I have hit "osd full"
> treshold on one osd.
> Now I actually cannot start it, because ir says xfs file system is full.
>
> # df -h /dev/sdb1
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdb1       373G  373G  100K 100% /var/lib/ceph/osd/ceph-0
>
> How to recover from this? Full osd sure is the situation to escape(red
> flags in doc for that), whilst it should not mean lost osd, right?
> And some debugging output follows, probably situation is not handled
> best way by binary?
>
>
> from /var/log/ceph/ceph-osd.0.log when starting osd.0
>
> 2013-02-08 15:07:09.430192 7f4366d55780 -1
> filestore(/var/lib/ceph/osd/ceph-0) _test_fiemap failed to write to
> /var/lib/ceph/osd/ceph-0/fiemap_test: (28) No space left on device
> 2013-02-08 15:07:09.435356 7f4366d55780 -1 common/config.cc: In
> function 'void md_config_t::remove_observer(md_config_obs_t*)' thread
> 7f4366d55780 time 2013-02-08 15:07:09.430779
> common/config.cc: 174: FAILED assert(found_obs)
>
>  ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
>  1: (md_config_t::remove_observer(md_config_obs_t*)+0x1e2) [0x83c892]
>  2: (FileStore::umount()+0xfb) [0x6ef3ab]
>  3: (OSD::do_convertfs(ObjectStore*)+0x928) [0x5f2268]
>  4: (OSD::convertfs(std::string const&, std::string const&)+0x47) [0x5f23c7]
>  5: (main()+0x2141) [0x5668a1]
>  6: (__libc_start_main()+0xed) [0x7f4364b9a76d]
>  7: /usr/bin/ceph-osd() [0x568ef9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- begin dump of recent events ---
>    -24> 2013-02-08 15:07:09.064409 7f4366d55780  5 asok(0x14e6000)
> register_command perfcounters_dump hook 0x14d9010
>    -23> 2013-02-08 15:07:09.064458 7f4366d55780  5 asok(0x14e6000)
> register_command 1 hook 0x14d9010
>    -22> 2013-02-08 15:07:09.064464 7f4366d55780  5 asok(0x14e6000)
> register_command perf dump hook 0x14d9010
>    -21> 2013-02-08 15:07:09.064482 7f4366d55780  5 asok(0x14e6000)
> register_command perfcounters_schema hook 0x14d9010
>    -20> 2013-02-08 15:07:09.064489 7f4366d55780  5 asok(0x14e6000)
> register_command 2 hook 0x14d9010
>    -19> 2013-02-08 15:07:09.064493 7f4366d55780  5 asok(0x14e6000)
> register_command perf schema hook 0x14d9010
>    -18> 2013-02-08 15:07:09.064502 7f4366d55780  5 asok(0x14e6000)
> register_command config show hook 0x14d9010
>    -17> 2013-02-08 15:07:09.064509 7f4366d55780  5 asok(0x14e6000)
> register_command config set hook 0x14d9010
>    -16> 2013-02-08 15:07:09.064514 7f4366d55780  5 asok(0x14e6000)
> register_command log flush hook 0x14d9010
>    -15> 2013-02-08 15:07:09.064521 7f4366d55780  5 asok(0x14e6000)
> register_command log dump hook 0x14d9010
>    -14> 2013-02-08 15:07:09.064526 7f4366d55780  5 asok(0x14e6000)
> register_command log reopen hook 0x14d9010
>    -13> 2013-02-08 15:07:09.066961 7f4366d55780  0 ceph version 0.56.2
> (586538e22afba85c59beda49789ec42024e7a061), process ceph-osd, pid
> 13903
>    -12> 2013-02-08 15:07:09.083752 7f4366d55780  1
> accepter.accepter.bind my_inst.addr is 0.0.0.0:6801/13903 need_addr=1
>    -11> 2013-02-08 15:07:09.083803 7f4366d55780  1
> accepter.accepter.bind my_inst.addr is 0.0.0.0:6802/13903 need_addr=1
>    -10> 2013-02-08 15:07:09.083820 7f4366d55780  1
> accepter.accepter.bind my_inst.addr is 0.0.0.0:6803/13903 need_addr=1
>     -9> 2013-02-08 15:07:09.084621 7f4366d55780  1 finished
> global_init_daemonize
>     -8> 2013-02-08 15:07:09.090620 7f4366d55780  5 asok(0x14e6000)
> init /var/run/ceph/ceph-osd.0.asok
>     -7> 2013-02-08 15:07:09.090667 7f4366d55780  5 asok(0x14e6000)
> bind_and_listen /var/run/ceph/ceph-osd.0.asok
>     -6> 2013-02-08 15:07:09.090730 7f4366d55780  5 asok(0x14e6000)
> register_command 0 hook 0x14d80b0
>     -5> 2013-02-08 15:07:09.090742 7f4366d55780  5 asok(0x14e6000)
> register_command version hook 0x14d80b0
>     -4> 2013-02-08 15:07:09.090754 7f4366d55780  5 asok(0x14e6000)
> register_command git_version hook 0x14d80b0
>     -3> 2013-02-08 15:07:09.090765 7f4366d55780  5 asok(0x14e6000)
> register_command help hook 0x14d90c0
>     -2> 2013-02-08 15:07:09.090821 7f4362be8700  5 asok(0x14e6000) entry start
>     -1> 2013-02-08 15:07:09.430192 7f4366d55780 -1
> filestore(/var/lib/ceph/osd/ceph-0) _test_fiemap failed to write to
> /var/lib/ceph/osd/ceph-0/fiemap_test: (28) No space left on device
>      0> 2013-02-08 15:07:09.435356 7f4366d55780 -1 common/config.cc:
> In function 'void md_config_t::remove_observer(md_config_obs_t*)'
> thread 7f4366d55780 time 2013-02-08 15:07:09.430779
> common/config.cc: 174: FAILED assert(found_obs)
>
>  ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
>  1: (md_config_t::remove_observer(md_config_obs_t*)+0x1e2) [0x83c892]
>  2: (FileStore::umount()+0xfb) [0x6ef3ab]
>  3: (OSD::do_convertfs(ObjectStore*)+0x928) [0x5f2268]
>  4: (OSD::convertfs(std::string const&, std::string const&)+0x47) [0x5f23c7]
>  5: (main()+0x2141) [0x5668a1]
>  6: (__libc_start_main()+0xed) [0x7f4364b9a76d]
>  7: /usr/bin/ceph-osd() [0x568ef9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>    0/ 5 none
>    0/ 1 lockdep
>    0/ 1 context
>    1/ 1 crush
>    1/ 5 mds
>    1/ 5 mds_balancer
>    1/ 5 mds_locker
>    1/ 5 mds_log
>    1/ 5 mds_log_expire
>    1/ 5 mds_migrator
>    0/ 1 buffer
>    0/ 1 timer
>    0/ 1 filer
>    0/ 1 striper
>    0/ 1 objecter
>    0/ 5 rados
>    0/ 5 rbd
>    0/ 5 journaler
>    0/ 5 objectcacher
>    0/ 5 client
>    0/ 5 osd
>    0/ 5 optracker
>    0/ 5 objclass
>    1/ 3 filestore
>    1/ 3 journal
>    0/ 5 ms
>    1/ 5 mon
>    0/10 monc
>    0/ 5 paxos
>    0/ 5 tp
>    1/ 5 auth
>    1/ 5 crypto
>    1/ 1 finisher
>    1/ 5 heartbeatmap
>    1/ 5 perfcounter
>    1/ 5 rgw
>    1/ 5 hadoop
>    1/ 5 javaclient
>    1/ 5 asok
>    1/ 1 throttle
>   -2/-2 (syslog threshold)
>   -1/-1 (stderr threshold)
>   max_recent    100000
>   max_new         1000
>   log_file /var/log/ceph/ceph-osd.0.log
> --- end dump of recent events ---
> 2013-02-08 15:07:09.440211 7f4366d55780 -1 *** Caught signal (Aborted) **
>  in thread 7f4366d55780
>
>  ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
>  1: /usr/bin/ceph-osd() [0x7828da]
>  2: (()+0xfcb0) [0x7f43661f0cb0]
>  3: (gsignal()+0x35) [0x7f4364baf425]
>  4: (abort()+0x17b) [0x7f4364bb2b8b]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f436550169d]
>  6: (()+0xb5846) [0x7f43654ff846]
>  7: (()+0xb5873) [0x7f43654ff873]
>  8: (()+0xb596e) [0x7f43654ff96e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x1df) [0x82ce7f]
>  10: (md_config_t::remove_observer(md_config_obs_t*)+0x1e2) [0x83c892]
>  11: (FileStore::umount()+0xfb) [0x6ef3ab]
>  12: (OSD::do_convertfs(ObjectStore*)+0x928) [0x5f2268]
>  13: (OSD::convertfs(std::string const&, std::string const&)+0x47) [0x5f23c7]
>  14: (main()+0x2141) [0x5668a1]
>  15: (__libc_start_main()+0xed) [0x7f4364b9a76d]
>  16: /usr/bin/ceph-osd() [0x568ef9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- begin dump of recent events ---
>      0> 2013-02-08 15:07:09.440211 7f4366d55780 -1 *** Caught signal
> (Aborted) **
>  in thread 7f4366d55780
>
>  ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
>  1: /usr/bin/ceph-osd() [0x7828da]
>  2: (()+0xfcb0) [0x7f43661f0cb0]
>  3: (gsignal()+0x35) [0x7f4364baf425]
>  4: (abort()+0x17b) [0x7f4364bb2b8b]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f436550169d]
>  6: (()+0xb5846) [0x7f43654ff846]
>  7: (()+0xb5873) [0x7f43654ff873]
>  8: (()+0xb596e) [0x7f43654ff96e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x1df) [0x82ce7f]
>  10: (md_config_t::remove_observer(md_config_obs_t*)+0x1e2) [0x83c892]
>  11: (FileStore::umount()+0xfb) [0x6ef3ab]
>  12: (OSD::do_convertfs(ObjectStore*)+0x928) [0x5f2268]
>  13: (OSD::convertfs(std::string const&, std::string const&)+0x47) [0x5f23c7]
>  14: (main()+0x2141) [0x5668a1]
>  15: (__libc_start_main()+0xed) [0x7f4364b9a76d]
>  16: /usr/bin/ceph-osd() [0x568ef9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>    0/ 5 none
>    0/ 1 lockdep
>    0/ 1 context
>    1/ 1 crush
>    1/ 5 mds
>    1/ 5 mds_balancer
>    1/ 5 mds_locker
>    1/ 5 mds_log
>    1/ 5 mds_log_expire
>    1/ 5 mds_migrator
>    0/ 1 buffer
>    0/ 1 timer
>    0/ 1 filer
>    0/ 1 striper
>    0/ 1 objecter
>    0/ 5 rados
>    0/ 5 rbd
>    0/ 5 journaler
>    0/ 5 objectcacher
>    0/ 5 client
>    0/ 5 osd
>    0/ 5 optracker
>    0/ 5 objclass
>    1/ 3 filestore
>    1/ 3 journal
>    0/ 5 ms
>    1/ 5 mon
>    0/10 monc
>    0/ 5 paxos
>    0/ 5 tp
>    1/ 5 auth
>    1/ 5 crypto
>    1/ 1 finisher
>    1/ 5 heartbeatmap
>    1/ 5 perfcounter
>    1/ 5 rgw
>    1/ 5 hadoop
>    1/ 5 javaclient
>    1/ 5 asok
>    1/ 1 throttle
>   -2/-2 (syslog threshold)
>   -1/-1 (stderr threshold)
>   max_recent    100000
>   max_new         1000
>   log_file /var/log/ceph/ceph-osd.0.log
> --- end dump of recent events ---
>
>
> Ugis
