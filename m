From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Bug while creating new cluster
Date: Thu, 09 Jun 2011 20:17:15 -0500
Message-ID: <0a039c525aee33b4199342fb05256aa8@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:43398 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab1FJBRP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jun 2011 21:17:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

 Hi All,

 Just tripped over this bug:

 *** Caught signal (Segmentation fault) **
  in thread 0xb6fff6d0
  ceph version 0.28.2-310-gb6e5c08 
 (commit:b6e5c080a273dfbc679a2db2772f8b58f72bc517)
  1: (ceph::BackTrace::BackTrace(int)+0x24) [0x83033c4]
  2: /usr/bin/cmon() [0x83320f5]
  3: [0xb786f400]
  4: (Monitor::Monitor(std::string, MonitorStore*, Messenger*, 
 MonMap*)+0xc) [0x81ef61e]
  5: (main()+0x57e) [0x81dec66]
  6: (__libc_start_main()+0xe2) [0xb7016cc2]
  7: /usr/bin/cmon() [0x81de4a1]
 /usr/sbin/mkcephfs: line 257:   673 Segmentation fault      (core 
 dumped) $BINDIR/cmon -c $conf --mkfs -i $id --monmap $dir/monmap 
 --osdmap $dir/osdmap -k $dir/keyring.mon
 failed: 'ssh ceph4 /usr/sbin/mkcephfs -d /tmp/mkfs.ceph.707 
 --init-daemon mon.4'


 (gdb) bt
 #0  0xb786f424 in __kernel_vsyscall ()
 #1  0xb7862e10 in raise (sig=11) at 
 ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
 #2  0x08331fad in reraise_fatal (signum=11) at common/signal.cc:61
 #3  0x08332173 in handle_fatal_signal (signum=11) at 
 common/signal.cc:108
 #4  <signal handler called>
 #5  0x081ef61e in Monitor::Monitor (this=0xbfed27f0, nm=..., 
 s=0xbfed2e70, m=0x0, map=0xbfed2d14) at mon/Monitor.cc:104
 #6  0x081dec66 in main (argc=12, argv=0xbfed3064) at cmon.cc:112


 (gdb) p this
 $1 = (Monitor * const) 0xbfed27f0
 (gdb) p nm
 $2 = {static npos = <optimized out>, _M_dataplus = 
 {<std::allocator<char>> = {<__gnu_cxx::new_allocator<char>> = {<No data 
 fields>}, <No data fields>},
     _M_p = 0xbfed2ec0 "\354K\360\tLNA\b"}}
 (gdb) p s
 $3 = (MonitorStore *) 0xbfed2e70
 (gdb) p map
 $4 = (MonMap *) 0xbfed2d14
 (gdb) p *map
 $5 = {epoch = 1, fsid = {fsid = 
 "=\000\346\331\021t\221\351y\335[\252\343\227\330\304"}, mon_addr = 
 {_M_t = {
       _M_impl = 
 {<std::allocator<std::_Rb_tree_node<std::pair<std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> > const, entity_addr_t> > 
 >> = 
 {<__gnu_cxx::new_allocator<std::_Rb_tree_node<std::pair<std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> > const, entity_addr_t> > 
 >> = {<No data fields>}, <No data fields>},
         _M_key_compare = {<std::binary_function<std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> >, std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> >, bool>> = {<No data 
 fields>}, <No data fields>}, _M_header = {_M_color = std::_S_red, 
 _M_parent = 0x9f05088,
           _M_left = 0x9f05088, _M_right = 0x9f05088}, _M_node_count = 
 1}}}, last_changed = {tv = {tv_sec = 1307667829, tv_nsec = 465852000}}, 
 created = {
     tv = {tv_sec = 1307667829, tv_nsec = 465852000}},
   rank_name = {<std::_Vector_base<std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> >, 
 std::allocator<std::basic_string<char, std::char_traits<char>, 
 std::allocator<char> > > >> = {
       _M_impl = {<std::allocator<std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> > >> = 
 {<__gnu_cxx::new_allocator<std::basic_string<char, 
 std::char_traits<char>, std::allocator<char> > >> = {<No data fields>}, 
 <No data fields>}, _M_start = 0x9f05128, _M_finish = 0x9f0512c,
         _M_end_of_storage = 0x9f0512c}}, <No data fields>}, rank_addr = 
 {<std::_Vector_base<entity_addr_t, std::allocator<entity_addr_t> >> = {
       _M_impl = {<std::allocator<entity_addr_t>> = 
 {<__gnu_cxx::new_allocator<entity_addr_t>> = {<No data fields>}, <No 
 data fields>},
         _M_start = 0x9f05138, _M_finish = 0x9f051c0, _M_end_of_storage 
 = 0x9f051c0}}, <No data fields>}}




 Thanks,
 Dyweni
