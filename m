From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: Bug while creating new cluster
Date: Thu, 09 Jun 2011 20:52:34 -0500
Message-ID: <36f4fd9d974e0982b5832fa21aa8d914@pl1.haspere.com>
References: <0a039c525aee33b4199342fb05256aa8@pl1.haspere.com>
 <BANLkTimt4O47H4Lmwh55pbEcLtiPuWqGDw@mail.gmail.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:51287 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1FJBwf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jun 2011 21:52:35 -0400
In-Reply-To: <BANLkTimt4O47H4Lmwh55pbEcLtiPuWqGDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

 Hi Colin/All,

 I was on b6e5c080a273dfbc679a2db2772f8b58f72bc517.

 I am building dadf2a3fa22fefe78615cebcd98c98993f1eaf94 now.  (It was 
 the latest as of a few minutes ago).


 I like to help the development effort. :)



 Thanks,
 Dyweni



 On Thu, 9 Jun 2011 18:46:30 -0700, Colin McCabe wrote:

> Hi Dyweni,
>
> This looks like a bug that cropped up in master earlier today but
> should be fixed now. You can try updating to the latest in master, or
> switching to the stable branch, which is more-- er-- stable.
>
> sincerely,
> Colin
>
> On Thu, Jun 9, 2011 at 6:17 PM, Dyweni - Ceph-Devel
> wrote:
>> Hi All, Just tripped over this bug: *** Caught signal (Segmentation
>> fault) ** in thread 0xb6fff6d0 ceph version 0.28.2-310-gb6e5c08
>> (commit:b6e5c080a273dfbc679a2db2772f8b58f72bc517) 1:
>> (ceph::BackTrace::BackTrace(int)+0x24) [0x83033c4] 2: 
>> /usr/bin/cmon()
>> [0x83320f5] 3: [0xb786f400] 4: (Monitor::Monitor(std::string,
>> MonitorStore*, Messenger*, MonMap*)+0xc) [0x81ef61e] 5: 
>> (main()+0x57e)
>> [0x81dec66] 6: (__libc_start_main()+0xe2) [0xb7016cc2] 7:
>> /usr/bin/cmon() [0x81de4a1] /usr/sbin/mkcephfs: line 257: 673
>> Segmentation fault (core dumped) $BINDIR/cmon -c $conf --mkfs -i $id
>> --monmap $dir/monmap --osdmap $dir/osdmap -k $dir/keyring.mon 
>> failed:
>> 'ssh ceph4 /usr/sbin/mkcephfs -d /tmp/mkfs.ceph.707 --init-daemon
>> mon.4' (gdb) bt #0 0xb786f424 in __kernel_vsyscall () #1 0xb7862e10 
>> in
>> raise (sig=11) at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42 #2
>> 0x08331fad in reraise_fatal (signum=11) at common/signal.cc:61 #3
>> 0x08332173 in handle_fatal_signal (signum=11) at 
>> common/signal.cc:108
>> #4 #5 0x081ef61e in Monitor::Monitor (this=0xbfed27f0, nm=...,
>> s=0xbfed2e70, m=0x0, map=0xbfed2d14) at mon/Monitor.cc:104 #6
>> 0x081dec66 in main (argc=12, argv=0xbfed3064) at cmon.cc:112 (gdb) p
>> this = (Monitor * const) 0xbfed27f0 (gdb) p nm = {static npos = ,
>> _M_dataplus = {> = { = {}, }, _M_p = 0xbfed2ec0 "354K360tLNAb"}} 
>> (gdb)
>> p s = (MonitorStore *) 0xbfed2e70 (gdb) p map = (MonMap *)
>> 0xbfed2d14 (gdb) p *map = {epoch = 1, fsid = {fsid =
>> "=0034633121t221351y335[252343227330304"}, mon_addr = {_M_t = { 
>> _M_impl
>> = {, std::allocator > const, entity_addr_t> > >> = { const,
>> entity_addr_t> > >> = {}, }, _M_key_compare = {, std::allocator >,
>> std::basic_string, std::allocator >, bool>> = {}, }, _M_header =
>> {_M_color = std::_S_red, _M_parent = 0x9f05088, _M_left = 0x9f05088,
>> _M_right = 0x9f05088}, _M_node_count = 1}}}, last_changed = {tv =
>> {tv_sec = 1307667829, tv_nsec = 465852000}}, created = { tv = 
>> {tv_sec =
>> 1307667829, tv_nsec = 465852000}}, rank_name = {, std::allocator >,
>> std::allocator, std::allocator > > >> = { _M_impl = {, 
>> std::allocator >
>>>> = { >> = {}, }, _M_start = 0x9f05128, _M_finish = 0x9f0512c,
>> _M_end_of_storage = 0x9f0512c}}, }, rank_addr = { >> = { _M_impl = 
>> {> =
>> { = {}, }, _M_start = 0x9f05138, _M_finish = 0x9f051c0,
>> _M_end_of_storage = 0x9f051c0}}, }} Thanks, Dyweni -- To unsubscribe
>> from this list: send the line "unsubscribe ceph-devel" in the body 
>> of a
>> message to majordomo@vger.kernel.org [1] More majordomo info at
>> http://vger.kernel.org/majordomo-info.html [2]
> -- To unsubscribe from this list: send the line "unsubscribe 
> ceph-devel"
> in the body of a message to majordomo@vger.kernel.org [4] More 
> majordomo
> info at http://vger.kernel.org/majordomo-info.html [5]


 Links:
 ------
 [1] mailto:majordomo@vger.kernel.org
 [2] http://vger.kernel.org/majordomo-info.html
 [3] mailto:YS3fpFE2ykfB@dyweni.com
 [4] mailto:majordomo@vger.kernel.org
 [5] http://vger.kernel.org/majordomo-info.html
