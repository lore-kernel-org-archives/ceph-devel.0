From: =?gb2312?B?zuTF9LfJ?= <wpf_ml@hotmail.com>
Subject: about compile ceph kernel error
Date: Thu, 15 Oct 2009 12:38:31 +0800
Message-ID: <BAY108-W12BB19B6133DBAE682E663F0C50@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6648323518707507299=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--===============6648323518707507299==
Content-Type: multipart/alternative;
	boundary="_1a3b47f1-bb15-4fbb-82b5-7da20f648db9_"

--_1a3b47f1-bb15-4fbb-82b5-7da20f648db9_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


hi guys:

when i compile ceph file system kernel part have some error as bellow tell me the best linux kernel to build this file system thanks.

make -C /lib/modules/2.6.18-prep/build M=/home/wpf/ceph/ceph-0.16.1/src/kernel CONFIG_CEPH_FS=m modules
make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.18/linux-2.6.18.x86_64'
  CC [M]  /home/wpf/ceph/ceph-0.16.1/src/kernel/super.o
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:4:
include/linux/backing-dev.h:31: warning: 'struct page' declared inside parameter list
include/linux/backing-dev.h:31: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/backing-dev.h:62: warning: 'struct page' declared inside parameter list
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:20:
/home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h: In function 'ceph_encode_filepath':
/home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:118: error: implicit declaration of function 'put_unaligned_le64'
/home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:119: error: implicit declaration of function 'put_unaligned_le32'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:9:28: error: linux/exportfs.h: No such file or directory
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/ceph_fs.h:15,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/types.h:10,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:15,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h: At top level:
/home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:64: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ceph_entity_addr_is_local'
/home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:71: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ceph_entity_addr_equal'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:12,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:16,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:19: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h: In function 'ceph_buffer_put':
/home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:35: error: 'struct ceph_buffer' has no member named 'is_vmalloc'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:16,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h: At top level:
/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:58: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:82: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:152: error: expected specifier-qualifier-list before 'bool'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:17,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/msgpool.h:15: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/msgpool.h:20: error: expected declaration specifiers or '...' before 'bool'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:18,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:36: error: field 'delayed_work' has incomplete type
/home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:59: error: field 'delayed_work' has incomplete type
/home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:61: error: expected specifier-qualifier-list before 'bool'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:19,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:167: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:246: error: field 'delayed_work' has incomplete type
/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h: In function 'ceph_mdsc_get_request':
/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:303: error: 'struct ceph_mds_request' has no member named 'r_ref'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:9,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:20,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/osdmap.h: At top level:
/home/wpf/ceph/ceph-0.16.1/src/kernel/osdmap.h:90: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ceph_osdmap_flag'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:20,
                 from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:49: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:85: error: field 'timeout_work' has incomplete type
/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:111: error: expected declaration specifiers or '...' before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:121: error: expected declaration specifiers or '...' before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:141: error: expected declaration specifiers or '...' before 'bool'
In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:267: error: expected specifier-qualifier-list before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:388: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ceph_i_test'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:494: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ceph_is_any_real_caps'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:705: error: expected declaration specifiers or '...' before 'bool'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:718: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ceph_have_pending_cap_snap'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'init_caches':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:160: warning: passing argument 5 of 'kmem_cache_create' from incompatible pointer type
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:160: error: too few arguments to function 'kmem_cache_create'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: implicit declaration of function 'KMEM_CACHE'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: 'ceph_cap' undeclared (first use in this function)
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: (Each undeclared identifier is reported only once
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: for each function it appears in.)
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:165: warning: assignment makes pointer from integer without a cast
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:169: error: 'ceph_dentry_info' undeclared (first use in this function)
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:170: warning: assignment makes pointer from integer without a cast
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:174: error: 'ceph_file_info' undeclared (first use in this function)
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:175: warning: assignment makes pointer from integer without a cast
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'parse_mount_args':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:360: error: implicit declaration of function 'pr_err'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:431: error: implicit declaration of function 'kstrndup'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:433: warning: assignment makes pointer from integer without a cast
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:438: warning: assignment makes pointer from integer without a cast
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'open_root_dentry':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:619: error: 'struct ceph_mds_request' has no member named 'r_started'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:620: error: 'struct ceph_mds_request' has no member named 'r_timeout'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:622: error: 'struct ceph_mds_request' has no member named 'r_num_caps'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_mount':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:669: error: 'struct ceph_messenger' has no member named 'nocrc'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_set_super':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:744: warning: assignment discards qualifiers from pointer target type
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:745: warning: assignment discards qualifiers from pointer target type
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_init_bdi':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:803: error: implicit declaration of function 'bdi_init'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_kill_sb':
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:897: error: implicit declaration of function 'bdi_destroy'
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: At top level:
/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:906: error: 'FS_RENAME_DOES_D_MOVE' undeclared here (not in a function)
make[2]: *** [/home/wpf/ceph/ceph-0.16.1/src/kernel/super.o] Error 1
make[1]: *** [_module_/home/wpf/ceph/ceph-0.16.1/src/kernel] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.18/linux-2.6.18.x86_64'


 

 
 		 	   		  
_________________________________________________________________
Messenger安全保护中心，免费修复系统漏洞，保护Messenger安全！
http://im.live.cn/safe/
--_1a3b47f1-bb15-4fbb-82b5-7da20f648db9_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
hi guys:<BR>
when i compile ceph file system kernel part have some error as bellow tell me the best linux kernel to build this file system thanks.<BR>
make&nbsp;-C&nbsp;/lib/modules/2.6.18-prep/build&nbsp;M=/home/wpf/ceph/ceph-0.16.1/src/kernel&nbsp;CONFIG_CEPH_FS=m&nbsp;modules<BR>make[1]:&nbsp;Entering&nbsp;directory&nbsp;`/usr/src/redhat/BUILD/kernel-2.6.18/linux-2.6.18.x86_64'<BR>&nbsp;&nbsp;CC&nbsp;[M]&nbsp;&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.o<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:4:<BR>include/linux/backing-dev.h:31:&nbsp;warning:&nbsp;'struct&nbsp;page'&nbsp;declared&nbsp;inside&nbsp;parameter&nbsp;list<BR>include/linux/backing-dev.h:31:&nbsp;warning:&nbsp;its&nbsp;scope&nbsp;is&nbsp;only&nbsp;this&nbsp;definition&nbsp;or&nbsp;declaration,&nbsp;which&nbsp;is&nbsp;probably&nbsp;not&nbsp;what&nbsp;you&nbsp;want<BR>include/linux/backing-dev.h:62:&nbsp;warning:&nbsp;'
 struct&nbsp;page'&nbsp;declared&nbsp;inside&nbsp;parameter&nbsp;list<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:20:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:&nbsp;In&nbsp;function&nbsp;'ceph_encode_filepath':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:118:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'put_unaligned_le64'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:119:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'put_unaligned_le32'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:9:28:&nbsp;error:&nbsp;linux/exportfs.h:&nbsp;No&nbsp;such&nbsp;file&nbsp;or&nbsp;directory<BR>I
 n&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/ceph_fs.h:15,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/types.h:10,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:15,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:&nbsp;At&nbsp;top&nbsp;level:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:64:&nbsp;error:&nbsp;expected&nbsp;'=',&nbsp;',',&nbsp;';',&nbsp;'asm'&nbsp;or&nbsp;
 '__attribute__'&nbsp;before&nbsp;'ceph_entity_addr_is_local'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:71:&nbsp;error:&nbsp;expected&nbsp;'=',&nbsp;',',&nbsp;';',&nbsp;'asm'&nbsp;or&nbsp;'__attribute__'&nbsp;before&nbsp;'ceph_entity_addr_equal'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:12,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:16,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:19:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;bef
 ore&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:&nbsp;In&nbsp;function&nbsp;'ceph_buffer_put':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:35:&nbsp;error:&nbsp;'struct&nbsp;ceph_buffer'&nbsp;has&nbsp;no&nbsp;member&nbsp;named&nbsp;'is_vmalloc'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:16,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:&nbsp;At&nbsp;top&nbsp;level:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:58:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger
 .h:82:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:152:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:17,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/msgpool.h:15:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/msgpool.h:20:&nbsp;error:&nbsp;expected&nbsp;declaration&nbsp;specifiers&nbsp;or&nbsp;'...'&nbsp;before&nbsp;'bool'<BR>In&nbsp;file&nbsp;
 included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:18,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:36:&nbsp;error:&nbsp;field&nbsp;'delayed_work'&nbsp;has&nbsp;incomplete&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:59:&nbsp;error:&nbsp;field&nbsp;'delayed_work'&nbsp;has&nbsp;incomplete&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:61:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:19,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb
 sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:167:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:246:&nbsp;error:&nbsp;field&nbsp;'delayed_work'&nbsp;has&nbsp;incomplete&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:&nbsp;In&nbsp;function&nbsp;'ceph_mdsc_get_request':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:303:&nbsp;error:&nbsp;'struct&nbsp;ceph_mds_request'&nbsp;has&nbsp;no&nbsp;member&nbsp;named&nbsp;'r_ref'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:9,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:20,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osdmap.h:&nbsp;At&nbsp;top&nbsp;level:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osdmap.h:90:&nbsp;error:&nbsp;expected&nbsp;'=',&nbsp;',',&nbsp;';',&nbsp;'asm'&nbsp;or&nbsp;'__attribute__'&nbsp;before&nbsp;'ceph_osdmap_flag'<BR>In&nbsp;file&nbsp;included&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:20,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel
 /super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:49:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:85:&nbsp;error:&nbsp;field&nbsp;'timeout_work'&nbsp;has&nbsp;incomplete&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:111:&nbsp;error:&nbsp;expected&nbsp;declaration&nbsp;specifiers&nbsp;or&nbsp;'...'&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:121:&nbsp;error:&nbsp;expected&nbsp;declaration&nbsp;specifiers&nbsp;or&nbsp;'...'&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:141:&nbsp;error:&nbsp;expected&nbsp;declaration&nbsp;specifiers&nbsp;or&nbsp;'...'&nbsp;before&nbsp;'bool'<BR>In&nbsp;file&nbsp;include
 d&nbsp;from&nbsp;/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:267:&nbsp;error:&nbsp;expected&nbsp;specifier-qualifier-list&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:388:&nbsp;error:&nbsp;expected&nbsp;'=',&nbsp;',',&nbsp;';',&nbsp;'asm'&nbsp;or&nbsp;'__attribute__'&nbsp;before&nbsp;'ceph_i_test'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:494:&nbsp;error:&nbsp;expected&nbsp;'=',&nbsp;',',&nbsp;';',&nbsp;'asm'&nbsp;or&nbsp;'__attribute__'&nbsp;before&nbsp;'__ceph_is_any_real_caps'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:705:&nbsp;error:&nbsp;expected&nbsp;declaration&nbsp;specifiers&nbsp;or&nbsp;'...'&nbsp;before&nbsp;'bool'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:718:&nbsp;error:&n
 bsp;expected&nbsp;'=',&nbsp;',',&nbsp;';',&nbsp;'asm'&nbsp;or&nbsp;'__attribute__'&nbsp;before&nbsp;'__ceph_have_pending_cap_snap'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'init_caches':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:160:&nbsp;warning:&nbsp;passing&nbsp;argument&nbsp;5&nbsp;of&nbsp;'kmem_cache_create'&nbsp;from&nbsp;incompatible&nbsp;pointer&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:160:&nbsp;error:&nbsp;too&nbsp;few&nbsp;arguments&nbsp;to&nbsp;function&nbsp;'kmem_cache_create'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'KMEM_CACHE'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164:&nbsp;error:&nbsp;'ceph_cap'&nbsp;undeclared&nbsp;(fi
 rst&nbsp;use&nbsp;in&nbsp;this&nbsp;function)<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164:&nbsp;error:&nbsp;(Each&nbsp;undeclared&nbsp;identifier&nbsp;is&nbsp;reported&nbsp;only&nbsp;once<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164:&nbsp;error:&nbsp;for&nbsp;each&nbsp;function&nbsp;it&nbsp;appears&nbsp;in.)<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:165:&nbsp;warning:&nbsp;assignment&nbsp;makes&nbsp;pointer&nbsp;from&nbsp;integer&nbsp;without&nbsp;a&nbsp;cast<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:169:&nbsp;error:&nbsp;'ceph_dentry_info'&nbsp;undeclared&nbsp;(first&nbsp;use&nbsp;in&nbsp;this&nbsp;function)<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:170:&nbsp;warning:&nbsp;assignment&nbsp;makes&nbsp;pointer&nbsp;from&nbsp;integer&nbsp;without&nbsp;a
 &nbsp;cast<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:174:&nbsp;error:&nbsp;'ceph_file_info'&nbsp;undeclared&nbsp;(first&nbsp;use&nbsp;in&nbsp;this&nbsp;function)<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:175:&nbsp;warning:&nbsp;assignment&nbsp;makes&nbsp;pointer&nbsp;from&nbsp;integer&nbsp;without&nbsp;a&nbsp;cast<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'parse_mount_args':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:360:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'pr_err'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:431:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'kstrndup'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:433:&nbsp;warning:&nbsp;assignment&nbsp;makes&nbsp;poi
 nter&nbsp;from&nbsp;integer&nbsp;without&nbsp;a&nbsp;cast<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:438:&nbsp;warning:&nbsp;assignment&nbsp;makes&nbsp;pointer&nbsp;from&nbsp;integer&nbsp;without&nbsp;a&nbsp;cast<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'open_root_dentry':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:619:&nbsp;error:&nbsp;'struct&nbsp;ceph_mds_request'&nbsp;has&nbsp;no&nbsp;member&nbsp;named&nbsp;'r_started'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:620:&nbsp;error:&nbsp;'struct&nbsp;ceph_mds_request'&nbsp;has&nbsp;no&nbsp;member&nbsp;named&nbsp;'r_timeout'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:622:&nbsp;error:&nbsp;'struct&nbsp;ceph_mds_request'&nbsp;has&nbsp;no&nbsp;member&nbsp;named&nbsp;'r_num_caps'<BR>/
 home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'ceph_mount':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:669:&nbsp;error:&nbsp;'struct&nbsp;ceph_messenger'&nbsp;has&nbsp;no&nbsp;member&nbsp;named&nbsp;'nocrc'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'ceph_set_super':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:744:&nbsp;warning:&nbsp;assignment&nbsp;discards&nbsp;qualifiers&nbsp;from&nbsp;pointer&nbsp;target&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:745:&nbsp;warning:&nbsp;assignment&nbsp;discards&nbsp;qualifiers&nbsp;from&nbsp;pointer&nbsp;target&nbsp;type<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'ceph_init_bdi':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:80
 3:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'bdi_init'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;In&nbsp;function&nbsp;'ceph_kill_sb':<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:897:&nbsp;error:&nbsp;implicit&nbsp;declaration&nbsp;of&nbsp;function&nbsp;'bdi_destroy'<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:&nbsp;At&nbsp;top&nbsp;level:<BR>/home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:906:&nbsp;error:&nbsp;'FS_RENAME_DOES_D_MOVE'&nbsp;undeclared&nbsp;here&nbsp;(not&nbsp;in&nbsp;a&nbsp;function)<BR>make[2]:&nbsp;***&nbsp;[/home/wpf/ceph/ceph-0.16.1/src/kernel/super.o]&nbsp;Error&nbsp;1<BR>make[1]:&nbsp;***&nbsp;[_module_/home/wpf/ceph/ceph-0.16.1/src/kernel]&nbsp;Error&nbsp;2<BR>make[1]:&nbsp;Leaving&nbsp;directory&nbsp;`/usr/src/redh
 at/BUILD/kernel-2.6.18/linux-2.6.18.x86_64'<BR><BR>
&nbsp;<BR>
&nbsp;<BR> 		 	   		  <br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://www.windowslive.cn/Messenger/' target='_new'>立刻下载！</a></body>
</html>
--_1a3b47f1-bb15-4fbb-82b5-7da20f648db9_--


--===============6648323518707507299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6648323518707507299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============6648323518707507299==--
