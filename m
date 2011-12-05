From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Mon, 05 Dec 2011 11:05:16 -0800
Message-ID: <4EDD15EC.1000900@cs.ucsc.edu>
References: <4EDC0ECF.60805@cs.ucsc.edu> <4EDC1853.5080405@cs.ucsc.edu> <Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net> <4EDD1437.4030608@cs.ucsc.edu> <CAORUGqCZy+j3MUry7ut=E7YXNiPHLGSqRw5qyqaOKR2=12mjhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:46088 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1LETFU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 14:05:20 -0500
In-Reply-To: <CAORUGqCZy+j3MUry7ut=E7YXNiPHLGSqRw5qyqaOKR2=12mjhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 12/05/2011 11:03 AM, Tommi Virtanen wrote:
> Can we get a "sudo lsof -n -p 1394" too? That would tell a little bit
> more about what the sockets are actually for..
>    
root@issdm-23:~# lsof -n -p 1394
COMMAND   PID USER   FD   TYPE             DEVICE SIZE/OFF    NODE NAME
ceph-mds 1394 root  cwd    DIR                8,1     4096       2 /
ceph-mds 1394 root  rtd    DIR                8,1     4096       2 /
ceph-mds 1394 root  txt    REG                8,1  4577640 7097096 
/usr/bin/ceph-mds
ceph-mds 1394 root  mem    REG                8,1    42856 7096319 
/usr/lib/libunwind.so.7.0.0
ceph-mds 1394 root  mem    REG                8,1  1572232 9178738 
/lib/libc-2.12.1.so
ceph-mds 1394 root  mem    REG                8,1    88384 9175100 
/lib/libgcc_s.so.1
ceph-mds 1394 root  mem    REG                8,1   534832 9178742 
/lib/libm-2.12.1.so
ceph-mds 1394 root  mem    REG                8,1   986888 7082428 
/usr/lib/libstdc++.so.6.0.14
ceph-mds 1394 root  mem    REG                8,1   249080 7096323 
/usr/lib/libtcmalloc.so.0.0.0
ceph-mds 1394 root  mem    REG                8,1    31744 9178754 
/lib/librt-2.12.1.so
ceph-mds 1394 root  mem    REG                8,1    19008 9175163 
/lib/libuuid.so.1.3.0
ceph-mds 1394 root  mem    REG                8,1  4946936 7096152 
/usr/lib/libcrypto++.so.8.0.0
ceph-mds 1394 root  mem    REG                8,1   136067 9178752 
/lib/libpthread-2.12.1.so
ceph-mds 1394 root  mem    REG                8,1   141072 9178735 
/lib/ld-2.12.1.so
ceph-mds 1394 root    0r   CHR                1,3      0t0    4372 /dev/null
ceph-mds 1394 root    1r   CHR                1,3      0t0    4372 /dev/null
ceph-mds 1394 root    2r   CHR                1,3      0t0    4372 /dev/null
ceph-mds 1394 root    3w   REG                8,1 14761050 6034073 
/var/log/ceph/mds.a.log
ceph-mds 1394 root    4u  IPv4               7837      0t0     TCP 
*:6800 (LISTEN)
ceph-mds 1394 root    5r  FIFO                0,8      0t0    7841 pipe
ceph-mds 1394 root    6w  FIFO                0,8      0t0    7841 pipe
ceph-mds 1394 root    7u  unix 0xffff88021a623a80      0t0    7842 
/var/run/ceph/mds.a.asok
ceph-mds 1394 root    8u  IPv4               7850      0t0     TCP 
192.168.141.123:38046->192.168.141.123:6789 (ESTABLISHED)
ceph-mds 1394 root    9u  IPv4              41245      0t0     TCP 
192.168.141.123:58242->192.168.141.135:6800 (ESTABLISHED)
ceph-mds 1394 root   10u  IPv4              41249      0t0     TCP 
192.168.141.123:39475->192.168.141.128:6800 (ESTABLISHED)
ceph-mds 1394 root   11u  IPv4              40004      0t0     TCP 
192.168.141.123:53885->192.168.141.124:6800 (ESTABLISHED)
ceph-mds 1394 root   12u  sock                0,6      0t0   11560 can't 
identify protocol
ceph-mds 1394 root   13u  IPv4              41246      0t0     TCP 
192.168.141.123:51006->192.168.141.132:6800 (ESTABLISHED)
ceph-mds 1394 root   14u  IPv4              40005      0t0     TCP 
192.168.141.123:34639->192.168.141.138:6800 (ESTABLISHED)
ceph-mds 1394 root   15u  IPv4              41247      0t0     TCP 
192.168.141.123:43558->192.168.141.125:6800 (ESTABLISHED)
ceph-mds 1394 root   16u  IPv4              41241      0t0     TCP 
192.168.141.123:52571->192.168.141.127:6800 (ESTABLISHED)
ceph-mds 1394 root   17u  sock                0,6      0t0   12488 can't 
identify protocol
ceph-mds 1394 root   18u  sock                0,6      0t0   10214 can't 
identify protocol
ceph-mds 1394 root   19u  IPv4              10656      0t0     TCP 
192.168.141.123:6800->192.168.141.123:46078 (ESTABLISHED)
ceph-mds 1394 root   20u  IPv4              10847      0t0     TCP 
192.168.141.123:6800->192.168.141.130:37586 (ESTABLISHED)
ceph-mds 1394 root   21u  IPv4              10849      0t0     TCP 
192.168.141.123:6800->192.168.141.135:44058 (ESTABLISHED)
ceph-mds 1394 root   22u  IPv4              10856      0t0     TCP 
192.168.141.123:6800->192.168.141.129:34711 (ESTABLISHED)
ceph-mds 1394 root   23u  IPv4              10858      0t0     TCP 
192.168.141.123:6800->192.168.141.137:35032 (ESTABLISHED)
ceph-mds 1394 root   24u  IPv4              10863      0t0     TCP 
192.168.141.123:6800->192.168.141.131:34520 (ESTABLISHED)
ceph-mds 1394 root   25u  IPv4              10872      0t0     TCP 
192.168.141.123:6800->192.168.141.122:44304 (ESTABLISHED)
ceph-mds 1394 root   26u  IPv4              10873      0t0     TCP 
192.168.141.123:6800->192.168.141.128:51902 (ESTABLISHED)
ceph-mds 1394 root   27u  IPv4              10874      0t0     TCP 
192.168.141.123:6800->192.168.141.125:60607 (ESTABLISHED)
ceph-mds 1394 root   28u  IPv4              10876      0t0     TCP 
192.168.141.123:6800->192.168.141.124:39850 (ESTABLISHED)
ceph-mds 1394 root   29u  IPv4              10878      0t0     TCP 
192.168.141.123:6800->192.168.141.127:43072 (ESTABLISHED)
ceph-mds 1394 root   30u  IPv4              10892      0t0     TCP 
192.168.141.123:6800->192.168.141.132:41561 (ESTABLISHED)
ceph-mds 1394 root   31u  IPv4              10919      0t0     TCP 
192.168.141.123:6800->192.168.141.138:36645 (ESTABLISHED)
ceph-mds 1394 root   32u  IPv4              41242      0t0     TCP 
192.168.141.123:56058->192.168.141.137:6800 (ESTABLISHED)
ceph-mds 1394 root   33u  sock                0,6      0t0   11572 can't 
identify protocol
ceph-mds 1394 root   34u  sock                0,6      0t0   12540 can't 
identify protocol
ceph-mds 1394 root   35u  sock                0,6      0t0   20392 can't 
identify protocol
ceph-mds 1394 root   36u  IPv4              41244      0t0     TCP 
192.168.141.123:47859->192.168.141.122:6800 (ESTABLISHED)
ceph-mds 1394 root   37u  sock                0,6      0t0   11612 can't 
identify protocol
ceph-mds 1394 root   38u  sock                0,6      0t0   11629 can't 
identify protocol
ceph-mds 1394 root   39u  sock                0,6      0t0   11689 can't 
identify protocol
ceph-mds 1394 root   40u  sock                0,6      0t0   11716 can't 
identify protocol
ceph-mds 1394 root   41u  sock                0,6      0t0   11727 can't 
identify protocol
ceph-mds 1394 root   42u  sock                0,6      0t0   11748 can't 
identify protocol
ceph-mds 1394 root   43u  sock                0,6      0t0   11761 can't 
identify protocol
ceph-mds 1394 root   44u  sock                0,6      0t0   11778 can't 
identify protocol
ceph-mds 1394 root   45u  sock                0,6      0t0   11780 can't 
identify protocol
ceph-mds 1394 root   46u  sock                0,6      0t0   11787 can't 
identify protocol
ceph-mds 1394 root   47u  IPv4              41248      0t0     TCP 
192.168.141.123:54637->192.168.141.131:6800 (ESTABLISHED)
ceph-mds 1394 root   48u  IPv4              41243      0t0     TCP 
192.168.141.123:48293->192.168.141.130:6800 (ESTABLISHED)
ceph-mds 1394 root   49u  sock                0,6      0t0   12551 can't 
identify protocol
ceph-mds 1394 root   50u  sock                0,6      0t0   12605 can't 
identify protocol
ceph-mds 1394 root   51u  sock                0,6      0t0   12618 can't 
identify protocol
ceph-mds 1394 root   52u  sock                0,6      0t0   12630 can't 
identify protocol
ceph-mds 1394 root   53u  sock                0,6      0t0   12632 can't 
identify protocol
ceph-mds 1394 root   54u  sock                0,6      0t0   12634 can't 
identify protocol
ceph-mds 1394 root   55u  sock                0,6      0t0   12636 can't 
identify protocol
ceph-mds 1394 root   56u  sock                0,6      0t0   12639 can't 
identify protocol
ceph-mds 1394 root   57u  sock                0,6      0t0   12640 can't 
identify protocol
ceph-mds 1394 root   58u  sock                0,6      0t0   12642 can't 
identify protocol
ceph-mds 1394 root   59u  sock                0,6      0t0   12644 can't 
identify protocol
ceph-mds 1394 root   60u  sock                0,6      0t0   12646 can't 
identify protocol
ceph-mds 1394 root   61u  sock                0,6      0t0   12648 can't 
identify protocol
ceph-mds 1394 root   62u  sock                0,6      0t0   12651 can't 
identify protocol
ceph-mds 1394 root   63u  sock                0,6      0t0   12652 can't 
identify protocol
ceph-mds 1394 root   64u  sock                0,6      0t0   12654 can't 
identify protocol
ceph-mds 1394 root   65u  sock                0,6      0t0   12656 can't 
identify protocol
ceph-mds 1394 root   66u  sock                0,6      0t0   12659 can't 
identify protocol
ceph-mds 1394 root   67u  sock                0,6      0t0   12660 can't 
identify protocol
ceph-mds 1394 root   68u  sock                0,6      0t0   12662 can't 
identify protocol
ceph-mds 1394 root   69u  sock                0,6      0t0   12664 can't 
identify protocol
ceph-mds 1394 root   70u  sock                0,6      0t0   12666 can't 
identify protocol
ceph-mds 1394 root   71u  sock                0,6      0t0   12674 can't 
identify protocol
ceph-mds 1394 root   72u  sock                0,6      0t0   12675 can't 
identify protocol
ceph-mds 1394 root   73u  sock                0,6      0t0   12682 can't 
identify protocol
ceph-mds 1394 root   74u  sock                0,6      0t0   12684 can't 
identify protocol
ceph-mds 1394 root   75u  sock                0,6      0t0   12687 can't 
identify protocol
ceph-mds 1394 root   76u  sock                0,6      0t0   12688 can't 
identify protocol
ceph-mds 1394 root   77u  sock                0,6      0t0   12691 can't 
identify protocol
ceph-mds 1394 root   78u  sock                0,6      0t0   12692 can't 
identify protocol
ceph-mds 1394 root   79u  sock                0,6      0t0   12694 can't 
identify protocol
ceph-mds 1394 root   80u  sock                0,6      0t0   12696 can't 
identify protocol
ceph-mds 1394 root   81u  sock                0,6      0t0   12698 can't 
identify protocol
ceph-mds 1394 root   82u  sock                0,6      0t0   12700 can't 
identify protocol
ceph-mds 1394 root   83u  sock                0,6      0t0   12702 can't 
identify protocol
ceph-mds 1394 root   84u  sock                0,6      0t0   12704 can't 
identify protocol
ceph-mds 1394 root   85u  sock                0,6      0t0   12706 can't 
identify protocol
ceph-mds 1394 root   86u  sock                0,6      0t0   12708 can't 
identify protocol
ceph-mds 1394 root   87u  sock                0,6      0t0   12732 can't 
identify protocol
ceph-mds 1394 root   88u  sock                0,6      0t0   12734 can't 
identify protocol
ceph-mds 1394 root   89u  sock                0,6      0t0   12746 can't 
identify protocol
ceph-mds 1394 root   90u  sock                0,6      0t0   12748 can't 
identify protocol
ceph-mds 1394 root   91u  sock                0,6      0t0   12750 can't 
identify protocol
ceph-mds 1394 root   92u  sock                0,6      0t0   12752 can't 
identify protocol
ceph-mds 1394 root   93u  sock                0,6      0t0   12754 can't 
identify protocol
ceph-mds 1394 root   94u  sock                0,6      0t0   12756 can't 
identify protocol
ceph-mds 1394 root   95u  sock                0,6      0t0   12758 can't 
identify protocol
ceph-mds 1394 root   96u  sock                0,6      0t0   12760 can't 
identify protocol
ceph-mds 1394 root   97u  sock                0,6      0t0   12762 can't 
identify protocol
ceph-mds 1394 root   98u  sock                0,6      0t0   12764 can't 
identify protocol
ceph-mds 1394 root   99u  sock                0,6      0t0   12766 can't 
identify protocol
ceph-mds 1394 root  100u  sock                0,6      0t0   12769 can't 
identify protocol
ceph-mds 1394 root  101u  sock                0,6      0t0   12770 can't 
identify protocol
ceph-mds 1394 root  102u  sock                0,6      0t0   12773 can't 
identify protocol
ceph-mds 1394 root  103u  sock                0,6      0t0   12774 can't 
identify protocol
ceph-mds 1394 root  104u  sock                0,6      0t0   12776 can't 
identify protocol
ceph-mds 1394 root  105u  sock                0,6      0t0   12786 can't 
identify protocol
ceph-mds 1394 root  106u  sock                0,6      0t0   12787 can't 
identify protocol
ceph-mds 1394 root  107u  sock                0,6      0t0   12788 can't 
identify protocol
ceph-mds 1394 root  108u  sock                0,6      0t0   12789 can't 
identify protocol
ceph-mds 1394 root  109u  sock                0,6      0t0   12790 can't 
identify protocol
ceph-mds 1394 root  110u  sock                0,6      0t0   12803 can't 
identify protocol
ceph-mds 1394 root  111u  sock                0,6      0t0   12804 can't 
identify protocol
ceph-mds 1394 root  112u  sock                0,6      0t0   12816 can't 
identify protocol
ceph-mds 1394 root  113u  sock                0,6      0t0   12818 can't 
identify protocol
ceph-mds 1394 root  114u  sock                0,6      0t0   12831 can't 
identify protocol
ceph-mds 1394 root  115u  sock                0,6      0t0   12832 can't 
identify protocol
ceph-mds 1394 root  116u  sock                0,6      0t0   12834 can't 
identify protocol
ceph-mds 1394 root  117u  sock                0,6      0t0   12836 can't 
identify protocol
ceph-mds 1394 root  118u  sock                0,6      0t0   12838 can't 
identify protocol
ceph-mds 1394 root  119u  sock                0,6      0t0   12840 can't 
identify protocol
ceph-mds 1394 root  120u  sock                0,6      0t0   12842 can't 
identify protocol
ceph-mds 1394 root  121u  sock                0,6      0t0   12844 can't 
identify protocol
ceph-mds 1394 root  122u  sock                0,6      0t0   12846 can't 
identify protocol
ceph-mds 1394 root  123u  sock                0,6      0t0   12848 can't 
identify protocol
ceph-mds 1394 root  124u  sock                0,6      0t0   12851 can't 
identify protocol
ceph-mds 1394 root  125u  sock                0,6      0t0   12852 can't 
identify protocol
ceph-mds 1394 root  126u  sock                0,6      0t0   12854 can't 
identify protocol
ceph-mds 1394 root  127u  sock                0,6      0t0   12856 can't 
identify protocol
ceph-mds 1394 root  128u  sock                0,6      0t0   12858 can't 
identify protocol
ceph-mds 1394 root  129u  sock                0,6      0t0   12860 can't 
identify protocol
ceph-mds 1394 root  130u  sock                0,6      0t0   12862 can't 
identify protocol
ceph-mds 1394 root  131u  sock                0,6      0t0   12864 can't 
identify protocol
ceph-mds 1394 root  132u  sock                0,6      0t0   12866 can't 
identify protocol
ceph-mds 1394 root  133u  sock                0,6      0t0   12873 can't 
identify protocol
ceph-mds 1394 root  134u  sock                0,6      0t0   12880 can't 
identify protocol
ceph-mds 1394 root  135u  sock                0,6      0t0   12882 can't 
identify protocol
ceph-mds 1394 root  136u  sock                0,6      0t0   12894 can't 
identify protocol
ceph-mds 1394 root  137u  sock                0,6      0t0   12896 can't 
identify protocol
ceph-mds 1394 root  138u  sock                0,6      0t0   12908 can't 
identify protocol
ceph-mds 1394 root  139u  sock                0,6      0t0   12910 can't 
identify protocol
ceph-mds 1394 root  140u  sock                0,6      0t0   14170 can't 
identify protocol
ceph-mds 1394 root  141u  sock                0,6      0t0   12915 can't 
identify protocol
ceph-mds 1394 root  142u  sock                0,6      0t0   12916 can't 
identify protocol
ceph-mds 1394 root  143u  sock                0,6      0t0   12918 can't 
identify protocol
ceph-mds 1394 root  144u  sock                0,6      0t0   12920 can't 
identify protocol
ceph-mds 1394 root  145u  sock                0,6      0t0   12927 can't 
identify protocol
ceph-mds 1394 root  146u  sock                0,6      0t0   12944 can't 
identify protocol
ceph-mds 1394 root  147u  sock                0,6      0t0   12956 can't 
identify protocol
ceph-mds 1394 root  148u  sock                0,6      0t0   12958 can't 
identify protocol
ceph-mds 1394 root  149u  sock                0,6      0t0   12980 can't 
identify protocol
ceph-mds 1394 root  150u  sock                0,6      0t0   14222 can't 
identify protocol
ceph-mds 1394 root  151u  sock                0,6      0t0   14259 can't 
identify protocol
ceph-mds 1394 root  152u  sock                0,6      0t0   14302 can't 
identify protocol
ceph-mds 1394 root  153u  sock                0,6      0t0   14313 can't 
identify protocol
ceph-mds 1394 root  154u  sock                0,6      0t0   14321 can't 
identify protocol
ceph-mds 1394 root  155u  sock                0,6      0t0   14334 can't 
identify protocol
ceph-mds 1394 root  156u  sock                0,6      0t0   14346 can't 
identify protocol
ceph-mds 1394 root  157u  sock                0,6      0t0   14348 can't 
identify protocol
ceph-mds 1394 root  158u  sock                0,6      0t0   14350 can't 
identify protocol
ceph-mds 1394 root  159u  sock                0,6      0t0   15519 can't 
identify protocol
ceph-mds 1394 root  160u  sock                0,6      0t0   15668 can't 
identify protocol
ceph-mds 1394 root  161u  sock                0,6      0t0   15679 can't 
identify protocol
ceph-mds 1394 root  162u  sock                0,6      0t0   15727 can't 
identify protocol
ceph-mds 1394 root  163u  sock                0,6      0t0   15740 can't 
identify protocol
ceph-mds 1394 root  164u  sock                0,6      0t0   15757 can't 
identify protocol
ceph-mds 1394 root  165u  sock                0,6      0t0   15759 can't 
identify protocol
ceph-mds 1394 root  166u  sock                0,6      0t0   15761 can't 
identify protocol
ceph-mds 1394 root  167u  sock                0,6      0t0   15763 can't 
identify protocol
ceph-mds 1394 root  168u  sock                0,6      0t0   15765 can't 
identify protocol
ceph-mds 1394 root  169u  sock                0,6      0t0   15767 can't 
identify protocol
ceph-mds 1394 root  170u  sock                0,6      0t0   15769 can't 
identify protocol
ceph-mds 1394 root  171u  sock                0,6      0t0   15771 can't 
identify protocol
ceph-mds 1394 root  172u  sock                0,6      0t0   15773 can't 
identify protocol
ceph-mds 1394 root  173u  sock                0,6      0t0   15775 can't 
identify protocol
ceph-mds 1394 root  174u  sock                0,6      0t0   15777 can't 
identify protocol
ceph-mds 1394 root  175u  sock                0,6      0t0   15779 can't 
identify protocol
ceph-mds 1394 root  176u  sock                0,6      0t0   15781 can't 
identify protocol
ceph-mds 1394 root  177u  sock                0,6      0t0   15783 can't 
identify protocol
ceph-mds 1394 root  178u  sock                0,6      0t0   15785 can't 
identify protocol
ceph-mds 1394 root  179u  sock                0,6      0t0   15795 can't 
identify protocol
ceph-mds 1394 root  180u  sock                0,6      0t0   15796 can't 
identify protocol
ceph-mds 1394 root  181u  sock                0,6      0t0   15797 can't 
identify protocol
ceph-mds 1394 root  182u  sock                0,6      0t0   15798 can't 
identify protocol
ceph-mds 1394 root  183u  sock                0,6      0t0   15800 can't 
identify protocol
ceph-mds 1394 root  184u  sock                0,6      0t0   15802 can't 
identify protocol
ceph-mds 1394 root  185u  sock                0,6      0t0   15804 can't 
identify protocol
ceph-mds 1394 root  186u  sock                0,6      0t0   15806 can't 
identify protocol
ceph-mds 1394 root  187u  sock                0,6      0t0   15809 can't 
identify protocol
ceph-mds 1394 root  188u  sock                0,6      0t0   15810 can't 
identify protocol
ceph-mds 1394 root  189u  sock                0,6      0t0   15812 can't 
identify protocol
ceph-mds 1394 root  190u  sock                0,6      0t0   15814 can't 
identify protocol
ceph-mds 1394 root  191u  sock                0,6      0t0   15816 can't 
identify protocol
ceph-mds 1394 root  192u  sock                0,6      0t0   15818 can't 
identify protocol
ceph-mds 1394 root  193u  sock                0,6      0t0   15821 can't 
identify protocol
ceph-mds 1394 root  194u  sock                0,6      0t0   15822 can't 
identify protocol
ceph-mds 1394 root  195u  sock                0,6      0t0   15824 can't 
identify protocol
ceph-mds 1394 root  196u  sock                0,6      0t0   15826 can't 
identify protocol
ceph-mds 1394 root  197u  sock                0,6      0t0   15828 can't 
identify protocol
ceph-mds 1394 root  198u  sock                0,6      0t0   15830 can't 
identify protocol
ceph-mds 1394 root  199u  sock                0,6      0t0   15852 can't 
identify protocol
ceph-mds 1394 root  200u  sock                0,6      0t0   15854 can't 
identify protocol
ceph-mds 1394 root  201u  sock                0,6      0t0   15856 can't 
identify protocol
ceph-mds 1394 root  202u  sock                0,6      0t0   15858 can't 
identify protocol
ceph-mds 1394 root  203u  sock                0,6      0t0   15860 can't 
identify protocol
ceph-mds 1394 root  204u  sock                0,6      0t0   15866 can't 
identify protocol
ceph-mds 1394 root  205u  sock                0,6      0t0   15873 can't 
identify protocol
ceph-mds 1394 root  206u  sock                0,6      0t0   15875 can't 
identify protocol
ceph-mds 1394 root  207u  sock                0,6      0t0   15877 can't 
identify protocol
ceph-mds 1394 root  208u  sock                0,6      0t0   15879 can't 
identify protocol
ceph-mds 1394 root  209u  sock                0,6      0t0   15881 can't 
identify protocol
ceph-mds 1394 root  210u  sock                0,6      0t0   15895 can't 
identify protocol
ceph-mds 1394 root  211u  sock                0,6      0t0   15896 can't 
identify protocol
ceph-mds 1394 root  212u  sock                0,6      0t0   15897 can't 
identify protocol
ceph-mds 1394 root  213u  sock                0,6      0t0   15898 can't 
identify protocol
ceph-mds 1394 root  214u  sock                0,6      0t0   15899 can't 
identify protocol
ceph-mds 1394 root  215u  sock                0,6      0t0   15900 can't 
identify protocol
ceph-mds 1394 root  216u  sock                0,6      0t0   15901 can't 
identify protocol
ceph-mds 1394 root  217u  sock                0,6      0t0   15902 can't 
identify protocol
ceph-mds 1394 root  218u  sock                0,6      0t0   15904 can't 
identify protocol
ceph-mds 1394 root  219u  sock                0,6      0t0   15906 can't 
identify protocol
ceph-mds 1394 root  220u  sock                0,6      0t0   15908 can't 
identify protocol
ceph-mds 1394 root  221u  sock                0,6      0t0   15910 can't 
identify protocol
ceph-mds 1394 root  222u  sock                0,6      0t0   15912 can't 
identify protocol
ceph-mds 1394 root  223u  sock                0,6      0t0   15914 can't 
identify protocol
ceph-mds 1394 root  224u  sock                0,6      0t0   15926 can't 
identify protocol
ceph-mds 1394 root  225u  sock                0,6      0t0   15928 can't 
identify protocol
ceph-mds 1394 root  226u  sock                0,6      0t0   15930 can't 
identify protocol
ceph-mds 1394 root  227u  sock                0,6      0t0   15932 can't 
identify protocol
ceph-mds 1394 root  228u  sock                0,6      0t0   15934 can't 
identify protocol
ceph-mds 1394 root  229u  sock                0,6      0t0   15936 can't 
identify protocol
ceph-mds 1394 root  230u  sock                0,6      0t0   15943 can't 
identify protocol
ceph-mds 1394 root  231u  sock                0,6      0t0   15945 can't 
identify protocol
ceph-mds 1394 root  232u  sock                0,6      0t0   15947 can't 
identify protocol
ceph-mds 1394 root  233u  sock                0,6      0t0   15960 can't 
identify protocol
ceph-mds 1394 root  234u  sock                0,6      0t0   15961 can't 
identify protocol
ceph-mds 1394 root  235u  sock                0,6      0t0   15962 can't 
identify protocol
ceph-mds 1394 root  236u  sock                0,6      0t0   15963 can't 
identify protocol
ceph-mds 1394 root  237u  sock                0,6      0t0   15964 can't 
identify protocol
ceph-mds 1394 root  238u  sock                0,6      0t0   15965 can't 
identify protocol
ceph-mds 1394 root  239u  sock                0,6      0t0   15966 can't 
identify protocol
ceph-mds 1394 root  240u  sock                0,6      0t0   15968 can't 
identify protocol
ceph-mds 1394 root  241u  sock                0,6      0t0   15970 can't 
identify protocol
ceph-mds 1394 root  242u  sock                0,6      0t0   15973 can't 
identify protocol
ceph-mds 1394 root  243u  sock                0,6      0t0   15974 can't 
identify protocol
ceph-mds 1394 root  244u  sock                0,6      0t0   15976 can't 
identify protocol
ceph-mds 1394 root  245u  sock                0,6      0t0   15984 can't 
identify protocol
ceph-mds 1394 root  246u  sock                0,6      0t0   15985 can't 
identify protocol
ceph-mds 1394 root  247u  sock                0,6      0t0   16002 can't 
identify protocol
ceph-mds 1394 root  248u  sock                0,6      0t0   16004 can't 
identify protocol
ceph-mds 1394 root  249u  sock                0,6      0t0   16006 can't 
identify protocol
ceph-mds 1394 root  250u  sock                0,6      0t0   16008 can't 
identify protocol
ceph-mds 1394 root  251u  sock                0,6      0t0   16015 can't 
identify protocol
ceph-mds 1394 root  252u  sock                0,6      0t0   16017 can't 
identify protocol
ceph-mds 1394 root  253u  sock                0,6      0t0   16019 can't 
identify protocol
ceph-mds 1394 root  254u  sock                0,6      0t0   16021 can't 
identify protocol
ceph-mds 1394 root  255u  sock                0,6      0t0   16023 can't 
identify protocol
ceph-mds 1394 root  256u  sock                0,6      0t0   16035 can't 
identify protocol
ceph-mds 1394 root  257u  sock                0,6      0t0   16036 can't 
identify protocol
ceph-mds 1394 root  258u  sock                0,6      0t0   16037 can't 
identify protocol
ceph-mds 1394 root  259u  sock                0,6      0t0   16038 can't 
identify protocol
ceph-mds 1394 root  260u  sock                0,6      0t0   16039 can't 
identify protocol
ceph-mds 1394 root  261u  sock                0,6      0t0   16040 can't 
identify protocol
ceph-mds 1394 root  262u  sock                0,6      0t0   16042 can't 
identify protocol
ceph-mds 1394 root  263u  sock                0,6      0t0   16044 can't 
identify protocol
ceph-mds 1394 root  264u  sock                0,6      0t0   16046 can't 
identify protocol
ceph-mds 1394 root  265u  sock                0,6      0t0   16048 can't 
identify protocol
ceph-mds 1394 root  266u  sock                0,6      0t0   16050 can't 
identify protocol
ceph-mds 1394 root  267u  sock                0,6      0t0   16057 can't 
identify protocol
ceph-mds 1394 root  268u  sock                0,6      0t0   16081 can't 
identify protocol
ceph-mds 1394 root  269u  sock                0,6      0t0   16083 can't 
identify protocol
ceph-mds 1394 root  270u  sock                0,6      0t0   16095 can't 
identify protocol
ceph-mds 1394 root  271u  sock                0,6      0t0   16097 can't 
identify protocol
ceph-mds 1394 root  272u  sock                0,6      0t0   16099 can't 
identify protocol
ceph-mds 1394 root  273u  sock                0,6      0t0   16106 can't 
identify protocol
ceph-mds 1394 root  274u  sock                0,6      0t0   16108 can't 
identify protocol
ceph-mds 1394 root  275u  sock                0,6      0t0   16115 can't 
identify protocol
ceph-mds 1394 root  276u  sock                0,6      0t0   16117 can't 
identify protocol
ceph-mds 1394 root  277u  sock                0,6      0t0   16120 can't 
identify protocol
ceph-mds 1394 root  278u  sock                0,6      0t0   16121 can't 
identify protocol
ceph-mds 1394 root  279u  sock                0,6      0t0   16123 can't 
identify protocol
ceph-mds 1394 root  280u  sock                0,6      0t0   16125 can't 
identify protocol
ceph-mds 1394 root  281u  sock                0,6      0t0   16128 can't 
identify protocol
ceph-mds 1394 root  282u  sock                0,6      0t0   16130 can't 
identify protocol
ceph-mds 1394 root  283u  sock                0,6      0t0   16131 can't 
identify protocol
ceph-mds 1394 root  284u  sock                0,6      0t0   16133 can't 
identify protocol
ceph-mds 1394 root  285u  sock                0,6      0t0   16135 can't 
identify protocol
ceph-mds 1394 root  286u  sock                0,6      0t0   16137 can't 
identify protocol
ceph-mds 1394 root  287u  sock                0,6      0t0   16149 can't 
identify protocol
ceph-mds 1394 root  288u  sock                0,6      0t0   16151 can't 
identify protocol
ceph-mds 1394 root  289u  sock                0,6      0t0   16153 can't 
identify protocol
ceph-mds 1394 root  290u  sock                0,6      0t0   16161 can't 
identify protocol
ceph-mds 1394 root  291u  sock                0,6      0t0   16162 can't 
identify protocol
ceph-mds 1394 root  292u  sock                0,6      0t0   16174 can't 
identify protocol
ceph-mds 1394 root  293u  sock                0,6      0t0   16176 can't 
identify protocol
ceph-mds 1394 root  294u  sock                0,6      0t0   16183 can't 
identify protocol
ceph-mds 1394 root  295u  sock                0,6      0t0   16185 can't 
identify protocol
ceph-mds 1394 root  296u  sock                0,6      0t0   16187 can't 
identify protocol
ceph-mds 1394 root  297u  sock                0,6      0t0   16196 can't 
identify protocol
ceph-mds 1394 root  298u  sock                0,6      0t0   16197 can't 
identify protocol
ceph-mds 1394 root  299u  sock                0,6      0t0   16199 can't 
identify protocol
ceph-mds 1394 root  300u  sock                0,6      0t0   16200 can't 
identify protocol
ceph-mds 1394 root  301u  sock                0,6      0t0   16202 can't 
identify protocol
ceph-mds 1394 root  302u  sock                0,6      0t0   16204 can't 
identify protocol
ceph-mds 1394 root  303u  sock                0,6      0t0   16206 can't 
identify protocol
ceph-mds 1394 root  304u  sock                0,6      0t0   16213 can't 
identify protocol
ceph-mds 1394 root  305u  sock                0,6      0t0   16214 can't 
identify protocol
ceph-mds 1394 root  306u  sock                0,6      0t0   16216 can't 
identify protocol
ceph-mds 1394 root  307u  sock                0,6      0t0   16223 can't 
identify protocol
ceph-mds 1394 root  308u  sock                0,6      0t0   16225 can't 
identify protocol
ceph-mds 1394 root  309u  sock                0,6      0t0   16227 can't 
identify protocol
ceph-mds 1394 root  310u  sock                0,6      0t0   16229 can't 
identify protocol
ceph-mds 1394 root  311u  sock                0,6      0t0   16231 can't 
identify protocol
ceph-mds 1394 root  312u  sock                0,6      0t0   16239 can't 
identify protocol
ceph-mds 1394 root  313u  sock                0,6      0t0   16240 can't 
identify protocol
ceph-mds 1394 root  314u  sock                0,6      0t0   16252 can't 
identify protocol
ceph-mds 1394 root  315u  sock                0,6      0t0   16265 can't 
identify protocol
ceph-mds 1394 root  316u  sock                0,6      0t0   16266 can't 
identify protocol
ceph-mds 1394 root  317u  sock                0,6      0t0   16273 can't 
identify protocol
ceph-mds 1394 root  318u  sock                0,6      0t0   16275 can't 
identify protocol
ceph-mds 1394 root  319u  sock                0,6      0t0   16282 can't 
identify protocol
ceph-mds 1394 root  320u  sock                0,6      0t0   16284 can't 
identify protocol
ceph-mds 1394 root  321u  sock                0,6      0t0   16286 can't 
identify protocol
ceph-mds 1394 root  322u  sock                0,6      0t0   16288 can't 
identify protocol
ceph-mds 1394 root  323u  sock                0,6      0t0   16290 can't 
identify protocol
ceph-mds 1394 root  324u  sock                0,6      0t0   16297 can't 
identify protocol
ceph-mds 1394 root  325u  sock                0,6      0t0   16299 can't 
identify protocol
ceph-mds 1394 root  326u  sock                0,6      0t0   16301 can't 
identify protocol
ceph-mds 1394 root  327u  sock                0,6      0t0   16303 can't 
identify protocol
ceph-mds 1394 root  328u  sock                0,6      0t0   16305 can't 
identify protocol
ceph-mds 1394 root  329u  sock                0,6      0t0   16307 can't 
identify protocol
ceph-mds 1394 root  330u  sock                0,6      0t0   16310 can't 
identify protocol
ceph-mds 1394 root  331u  sock                0,6      0t0   16311 can't 
identify protocol
ceph-mds 1394 root  332u  sock                0,6      0t0   16313 can't 
identify protocol
ceph-mds 1394 root  333u  sock                0,6      0t0   16315 can't 
identify protocol
ceph-mds 1394 root  334u  sock                0,6      0t0   16317 can't 
identify protocol
ceph-mds 1394 root  335u  sock                0,6      0t0   18794 can't 
identify protocol
ceph-mds 1394 root  336u  sock                0,6      0t0   16346 can't 
identify protocol
ceph-mds 1394 root  337u  sock                0,6      0t0   16358 can't 
identify protocol
ceph-mds 1394 root  338u  sock                0,6      0t0   16360 can't 
identify protocol
ceph-mds 1394 root  339u  sock                0,6      0t0   16362 can't 
identify protocol
ceph-mds 1394 root  340u  sock                0,6      0t0   16370 can't 
identify protocol
ceph-mds 1394 root  341u  sock                0,6      0t0   16377 can't 
identify protocol
ceph-mds 1394 root  342u  sock                0,6      0t0   19386 can't 
identify protocol
ceph-mds 1394 root  343u  sock                0,6      0t0   19398 can't 
identify protocol
ceph-mds 1394 root  344u  sock                0,6      0t0   19435 can't 
identify protocol
ceph-mds 1394 root  345u  sock                0,6      0t0   19441 can't 
identify protocol
ceph-mds 1394 root  346u  sock                0,6      0t0   19489 can't 
identify protocol
ceph-mds 1394 root  347u  sock                0,6      0t0   19502 can't 
identify protocol
ceph-mds 1394 root  348u  sock                0,6      0t0   19519 can't 
identify protocol
ceph-mds 1394 root  349u  sock                0,6      0t0   19521 can't 
identify protocol
ceph-mds 1394 root  350u  sock                0,6      0t0   19523 can't 
identify protocol
ceph-mds 1394 root  351u  sock                0,6      0t0   19525 can't 
identify protocol
ceph-mds 1394 root  352u  sock                0,6      0t0   19527 can't 
identify protocol
ceph-mds 1394 root  353u  sock                0,6      0t0   19529 can't 
identify protocol
ceph-mds 1394 root  354u  sock                0,6      0t0   19531 can't 
identify protocol
ceph-mds 1394 root  355u  sock                0,6      0t0   19533 can't 
identify protocol
ceph-mds 1394 root  356u  sock                0,6      0t0   19535 can't 
identify protocol
ceph-mds 1394 root  357u  sock                0,6      0t0   19537 can't 
identify protocol
ceph-mds 1394 root  358u  sock                0,6      0t0   19539 can't 
identify protocol
ceph-mds 1394 root  359u  sock                0,6      0t0   19541 can't 
identify protocol
ceph-mds 1394 root  360u  sock                0,6      0t0   19543 can't 
identify protocol
ceph-mds 1394 root  361u  sock                0,6      0t0   19545 can't 
identify protocol
ceph-mds 1394 root  362u  sock                0,6      0t0   19547 can't 
identify protocol
ceph-mds 1394 root  363u  sock                0,6      0t0   19549 can't 
identify protocol
ceph-mds 1394 root  364u  sock                0,6      0t0   19551 can't 
identify protocol
ceph-mds 1394 root  365u  sock                0,6      0t0   19554 can't 
identify protocol
ceph-mds 1394 root  366u  sock                0,6      0t0   19555 can't 
identify protocol
ceph-mds 1394 root  367u  sock                0,6      0t0   19557 can't 
identify protocol
ceph-mds 1394 root  368u  sock                0,6      0t0   19559 can't 
identify protocol
ceph-mds 1394 root  369u  sock                0,6      0t0   19567 can't 
identify protocol
ceph-mds 1394 root  370u  sock                0,6      0t0   19568 can't 
identify protocol
ceph-mds 1394 root  371u  sock                0,6      0t0   19571 can't 
identify protocol
ceph-mds 1394 root  372u  sock                0,6      0t0   19572 can't 
identify protocol
ceph-mds 1394 root  373u  sock                0,6      0t0   19575 can't 
identify protocol
ceph-mds 1394 root  374u  sock                0,6      0t0   19576 can't 
identify protocol
ceph-mds 1394 root  375u  sock                0,6      0t0   19578 can't 
identify protocol
ceph-mds 1394 root  376u  sock                0,6      0t0   19580 can't 
identify protocol
ceph-mds 1394 root  377u  sock                0,6      0t0   19583 can't 
identify protocol
ceph-mds 1394 root  378u  sock                0,6      0t0   19584 can't 
identify protocol
ceph-mds 1394 root  379u  sock                0,6      0t0   19586 can't 
identify protocol
ceph-mds 1394 root  380u  sock                0,6      0t0   19588 can't 
identify protocol
ceph-mds 1394 root  381u  sock                0,6      0t0   19590 can't 
identify protocol
ceph-mds 1394 root  382u  sock                0,6      0t0   19592 can't 
identify protocol
ceph-mds 1394 root  383u  sock                0,6      0t0   19605 can't 
identify protocol
ceph-mds 1394 root  384u  sock                0,6      0t0   19607 can't 
identify protocol
ceph-mds 1394 root  385u  sock                0,6      0t0   19609 can't 
identify protocol
ceph-mds 1394 root  386u  sock                0,6      0t0   19611 can't 
identify protocol
ceph-mds 1394 root  387u  sock                0,6      0t0   19618 can't 
identify protocol
ceph-mds 1394 root  388u  sock                0,6      0t0   19620 can't 
identify protocol
ceph-mds 1394 root  389u  sock                0,6      0t0   19622 can't 
identify protocol
ceph-mds 1394 root  390u  sock                0,6      0t0   19624 can't 
identify protocol
ceph-mds 1394 root  391u  sock                0,6      0t0   19626 can't 
identify protocol
ceph-mds 1394 root  392u  sock                0,6      0t0   19628 can't 
identify protocol
ceph-mds 1394 root  393u  sock                0,6      0t0   19630 can't 
identify protocol
ceph-mds 1394 root  394u  sock                0,6      0t0   19632 can't 
identify protocol
ceph-mds 1394 root  395u  sock                0,6      0t0   19641 can't 
identify protocol
ceph-mds 1394 root  396u  sock                0,6      0t0   19642 can't 
identify protocol
ceph-mds 1394 root  397u  sock                0,6      0t0   19643 can't 
identify protocol
ceph-mds 1394 root  398u  sock                0,6      0t0   19645 can't 
identify protocol
ceph-mds 1394 root  399u  sock                0,6      0t0   19647 can't 
identify protocol
ceph-mds 1394 root  400u  sock                0,6      0t0   19649 can't 
identify protocol
ceph-mds 1394 root  401u  sock                0,6      0t0   19651 can't 
identify protocol
ceph-mds 1394 root  402u  sock                0,6      0t0   19653 can't 
identify protocol
ceph-mds 1394 root  403u  sock                0,6      0t0   19666 can't 
identify protocol
ceph-mds 1394 root  404u  sock                0,6      0t0   19667 can't 
identify protocol
ceph-mds 1394 root  405u  sock                0,6      0t0   19668 can't 
identify protocol
ceph-mds 1394 root  406u  sock                0,6      0t0   19675 can't 
identify protocol
ceph-mds 1394 root  407u  sock                0,6      0t0   19677 can't 
identify protocol
ceph-mds 1394 root  408u  sock                0,6      0t0   19679 can't 
identify protocol
ceph-mds 1394 root  409u  sock                0,6      0t0   19681 can't 
identify protocol
ceph-mds 1394 root  410u  sock                0,6      0t0   19683 can't 
identify protocol
ceph-mds 1394 root  411u  sock                0,6      0t0   19685 can't 
identify protocol
ceph-mds 1394 root  412u  sock                0,6      0t0   19687 can't 
identify protocol
ceph-mds 1394 root  413u  sock                0,6      0t0   19689 can't 
identify protocol
ceph-mds 1394 root  414u  sock                0,6      0t0   19691 can't 
identify protocol
ceph-mds 1394 root  415u  sock                0,6      0t0   19693 can't 
identify protocol
ceph-mds 1394 root  416u  sock                0,6      0t0   19695 can't 
identify protocol
ceph-mds 1394 root  417u  sock                0,6      0t0   19697 can't 
identify protocol
ceph-mds 1394 root  418u  sock                0,6      0t0   19699 can't 
identify protocol
ceph-mds 1394 root  419u  sock                0,6      0t0   19701 can't 
identify protocol
ceph-mds 1394 root  420u  sock                0,6      0t0   19704 can't 
identify protocol
ceph-mds 1394 root  421u  sock                0,6      0t0   19705 can't 
identify protocol
ceph-mds 1394 root  422u  sock                0,6      0t0   19716 can't 
identify protocol
ceph-mds 1394 root  423u  sock                0,6      0t0   19718 can't 
identify protocol
ceph-mds 1394 root  424u  sock                0,6      0t0   19707 can't 
identify protocol
ceph-mds 1394 root  425u  sock                0,6      0t0   19709 can't 
identify protocol
ceph-mds 1394 root  426u  sock                0,6      0t0   19720 can't 
identify protocol
ceph-mds 1394 root  427u  sock                0,6      0t0   19727 can't 
identify protocol
ceph-mds 1394 root  428u  sock                0,6      0t0   19735 can't 
identify protocol
ceph-mds 1394 root  429u  sock                0,6      0t0   19736 can't 
identify protocol
ceph-mds 1394 root  430u  sock                0,6      0t0   19738 can't 
identify protocol
ceph-mds 1394 root  431u  sock                0,6      0t0   19740 can't 
identify protocol
ceph-mds 1394 root  432u  sock                0,6      0t0   19742 can't 
identify protocol
ceph-mds 1394 root  433u  sock                0,6      0t0   19744 can't 
identify protocol
ceph-mds 1394 root  434u  sock                0,6      0t0   19746 can't 
identify protocol
ceph-mds 1394 root  435u  sock                0,6      0t0   19748 can't 
identify protocol
ceph-mds 1394 root  436u  sock                0,6      0t0   19750 can't 
identify protocol
ceph-mds 1394 root  437u  sock                0,6      0t0   19752 can't 
identify protocol
ceph-mds 1394 root  438u  sock                0,6      0t0   19754 can't 
identify protocol
ceph-mds 1394 root  439u  sock                0,6      0t0   19756 can't 
identify protocol
ceph-mds 1394 root  440u  sock                0,6      0t0   19765 can't 
identify protocol
ceph-mds 1394 root  441u  sock                0,6      0t0   19766 can't 
identify protocol
ceph-mds 1394 root  442u  sock                0,6      0t0   19767 can't 
identify protocol
ceph-mds 1394 root  443u  sock                0,6      0t0   19769 can't 
identify protocol
ceph-mds 1394 root  444u  sock                0,6      0t0   19771 can't 
identify protocol
ceph-mds 1394 root  445u  sock                0,6      0t0   19773 can't 
identify protocol
ceph-mds 1394 root  446u  sock                0,6      0t0   19775 can't 
identify protocol
ceph-mds 1394 root  447u  sock                0,6      0t0   19777 can't 
identify protocol
ceph-mds 1394 root  448u  sock                0,6      0t0   19784 can't 
identify protocol
ceph-mds 1394 root  449u  sock                0,6      0t0   19786 can't 
identify protocol
ceph-mds 1394 root  450u  sock                0,6      0t0   19788 can't 
identify protocol
ceph-mds 1394 root  451u  sock                0,6      0t0   19795 can't 
identify protocol
ceph-mds 1394 root  452u  sock                0,6      0t0   19797 can't 
identify protocol
ceph-mds 1394 root  453u  sock                0,6      0t0   19799 can't 
identify protocol
ceph-mds 1394 root  454u  sock                0,6      0t0   19801 can't 
identify protocol
ceph-mds 1394 root  455u  sock                0,6      0t0   19803 can't 
identify protocol
ceph-mds 1394 root  456u  sock                0,6      0t0   19811 can't 
identify protocol
ceph-mds 1394 root  457u  sock                0,6      0t0   19812 can't 
identify protocol
ceph-mds 1394 root  458u  sock                0,6      0t0   19814 can't 
identify protocol
ceph-mds 1394 root  459u  sock                0,6      0t0   19816 can't 
identify protocol
ceph-mds 1394 root  460u  sock                0,6      0t0   19819 can't 
identify protocol
ceph-mds 1394 root  461u  sock                0,6      0t0   19820 can't 
identify protocol
ceph-mds 1394 root  462u  sock                0,6      0t0   19830 can't 
identify protocol
ceph-mds 1394 root  463u  sock                0,6      0t0   19831 can't 
identify protocol
ceph-mds 1394 root  464u  sock                0,6      0t0   19832 can't 
identify protocol
ceph-mds 1394 root  465u  sock                0,6      0t0   19833 can't 
identify protocol
ceph-mds 1394 root  466u  sock                0,6      0t0   19835 can't 
identify protocol
ceph-mds 1394 root  467u  sock                0,6      0t0   19837 can't 
identify protocol
ceph-mds 1394 root  468u  sock                0,6      0t0   19848 can't 
identify protocol
ceph-mds 1394 root  469u  sock                0,6      0t0   19849 can't 
identify protocol
ceph-mds 1394 root  470u  sock                0,6      0t0   19850 can't 
identify protocol
ceph-mds 1394 root  471u  sock                0,6      0t0   19851 can't 
identify protocol
ceph-mds 1394 root  472u  sock                0,6      0t0   19852 can't 
identify protocol
ceph-mds 1394 root  473u  sock                0,6      0t0   19854 can't 
identify protocol
ceph-mds 1394 root  474u  sock                0,6      0t0   19856 can't 
identify protocol
ceph-mds 1394 root  475u  sock                0,6      0t0   19863 can't 
identify protocol
ceph-mds 1394 root  476u  sock                0,6      0t0   19865 can't 
identify protocol
ceph-mds 1394 root  477u  sock                0,6      0t0   19867 can't 
identify protocol
ceph-mds 1394 root  478u  sock                0,6      0t0   19869 can't 
identify protocol
ceph-mds 1394 root  479u  sock                0,6      0t0   19871 can't 
identify protocol
ceph-mds 1394 root  480u  sock                0,6      0t0   19878 can't 
identify protocol
ceph-mds 1394 root  481u  sock                0,6      0t0   19880 can't 
identify protocol
ceph-mds 1394 root  482u  sock                0,6      0t0   19882 can't 
identify protocol
ceph-mds 1394 root  483u  sock                0,6      0t0   19884 can't 
identify protocol
ceph-mds 1394 root  484u  sock                0,6      0t0   19886 can't 
identify protocol
ceph-mds 1394 root  485u  sock                0,6      0t0   19888 can't 
identify protocol
ceph-mds 1394 root  486u  sock                0,6      0t0   19890 can't 
identify protocol
ceph-mds 1394 root  487u  sock                0,6      0t0   19892 can't 
identify protocol
ceph-mds 1394 root  488u  sock                0,6      0t0   19894 can't 
identify protocol
ceph-mds 1394 root  489u  sock                0,6      0t0   19902 can't 
identify protocol
ceph-mds 1394 root  490u  sock                0,6      0t0   19903 can't 
identify protocol
ceph-mds 1394 root  491u  sock                0,6      0t0   19905 can't 
identify protocol
ceph-mds 1394 root  492u  sock                0,6      0t0   19907 can't 
identify protocol
ceph-mds 1394 root  493u  sock                0,6      0t0   19909 can't 
identify protocol
ceph-mds 1394 root  494u  sock                0,6      0t0   19911 can't 
identify protocol
ceph-mds 1394 root  495u  sock                0,6      0t0   19913 can't 
identify protocol
ceph-mds 1394 root  496u  sock                0,6      0t0   19915 can't 
identify protocol
ceph-mds 1394 root  497u  sock                0,6      0t0   19922 can't 
identify protocol
ceph-mds 1394 root  498u  sock                0,6      0t0   19924 can't 
identify protocol
ceph-mds 1394 root  499u  sock                0,6      0t0   19926 can't 
identify protocol
ceph-mds 1394 root  500u  sock                0,6      0t0   19934 can't 
identify protocol
ceph-mds 1394 root  501u  sock                0,6      0t0   19935 can't 
identify protocol
ceph-mds 1394 root  502u  sock                0,6      0t0   19937 can't 
identify protocol
ceph-mds 1394 root  503u  sock                0,6      0t0   19943 can't 
identify protocol
ceph-mds 1394 root  504u  sock                0,6      0t0   19951 can't 
identify protocol
ceph-mds 1394 root  505u  sock                0,6      0t0   19952 can't 
identify protocol
ceph-mds 1394 root  506u  sock                0,6      0t0   19954 can't 
identify protocol
ceph-mds 1394 root  507u  sock                0,6      0t0   19956 can't 
identify protocol
ceph-mds 1394 root  508u  sock                0,6      0t0   19958 can't 
identify protocol
ceph-mds 1394 root  509u  sock                0,6      0t0   19960 can't 
identify protocol
ceph-mds 1394 root  510u  sock                0,6      0t0   19962 can't 
identify protocol
ceph-mds 1394 root  511u  IPv4              41250      0t0     TCP 
192.168.141.123:34406->192.168.141.129:6800 (ESTABLISHED)
ceph-mds 1394 root  512u  sock                0,6      0t0   19974 can't 
identify protocol
ceph-mds 1394 root  513u  sock                0,6      0t0   19975 can't 
identify protocol
ceph-mds 1394 root  514u  sock                0,6      0t0   19976 can't 
identify protocol
ceph-mds 1394 root  515u  sock                0,6      0t0   19977 can't 
identify protocol
ceph-mds 1394 root  516u  sock                0,6      0t0   20409 can't 
identify protocol
ceph-mds 1394 root  517u  sock                0,6      0t0   19986 can't 
identify protocol
ceph-mds 1394 root  518u  sock                0,6      0t0   19988 can't 
identify protocol
ceph-mds 1394 root  519u  sock                0,6      0t0   20446 can't 
identify protocol
ceph-mds 1394 root  520u  sock                0,6      0t0   19997 can't 
identify protocol
ceph-mds 1394 root  521u  sock                0,6      0t0   19999 can't 
identify protocol
ceph-mds 1394 root  522u  sock                0,6      0t0   20001 can't 
identify protocol
ceph-mds 1394 root  523u  sock                0,6      0t0   20003 can't 
identify protocol
ceph-mds 1394 root  524u  sock                0,6      0t0   20010 can't 
identify protocol
ceph-mds 1394 root  525u  sock                0,6      0t0   20012 can't 
identify protocol
ceph-mds 1394 root  526u  sock                0,6      0t0   20014 can't 
identify protocol
ceph-mds 1394 root  527u  sock                0,6      0t0   20022 can't 
identify protocol
ceph-mds 1394 root  528u  sock                0,6      0t0   20023 can't 
identify protocol
ceph-mds 1394 root  529u  sock                0,6      0t0   20025 can't 
identify protocol
ceph-mds 1394 root  530u  sock                0,6      0t0   20032 can't 
identify protocol
ceph-mds 1394 root  531u  sock                0,6      0t0   20039 can't 
identify protocol
ceph-mds 1394 root  532u  sock                0,6      0t0   20046 can't 
identify protocol
ceph-mds 1394 root  533u  sock                0,6      0t0   20110 can't 
identify protocol
ceph-mds 1394 root  534u  sock                0,6      0t0   20134 can't 
identify protocol
ceph-mds 1394 root  535u  sock                0,6      0t0   20146 can't 
identify protocol
ceph-mds 1394 root  536u  sock                0,6      0t0   20158 can't 
identify protocol
ceph-mds 1394 root  537u  sock                0,6      0t0   20170 can't 
identify protocol
ceph-mds 1394 root  538u  sock                0,6      0t0   20192 can't 
identify protocol
ceph-mds 1394 root  539u  sock                0,6      0t0   40930 can't 
identify protocol

