From: Sage Weil <sage@newdream.net>
Subject: Re: about compile ceph kernel error
Date: Tue, 10 Nov 2009 07:21:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911100719460.30993@cobra.newdream.net>
References: <BAY108-W12BB19B6133DBAE682E663F0C50@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1811751196-1257866485=:30993"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <BAY108-W12BB19B6133DBAE682E663F0C50@phx.gbl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: =?gb2312?B?zuTF9LfJ?= <wpf_ml@hotmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1811751196-1257866485=:30993
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Oct 2009, =CE=E4=C5=F4=B7=C9 wrote:

>=20
> hi guys:
>=20
> when i compile ceph file system kernel part have some error as bellow=20
> tell me the best linux kernel to build this file system thanks.

The kernel client will only build on more recent Linux versions, somewhere=
=20
around 2.6.27 and later.

sage


>=20
> make -C /lib/modules/2.6.18-prep/build M=3D/home/wpf/ceph/ceph-0.16.1/src=
/kernel CONFIG_CEPH_FS=3Dm modules
> make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.18/linux-2.=
6.18.x86_64'
>   CC [M]  /home/wpf/ceph/ceph-0.16.1/src/kernel/super.o
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:4:
> include/linux/backing-dev.h:31: warning: 'struct page' declared inside pa=
rameter list
> include/linux/backing-dev.h:31: warning: its scope is only this definitio=
n or declaration, which is probably not what you want
> include/linux/backing-dev.h:62: warning: 'struct page' declared inside pa=
rameter list
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:20:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h: In function 'ceph_encode_=
filepath':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:118: error: implicit decla=
ration of function 'put_unaligned_le64'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/decode.h:119: error: implicit decla=
ration of function 'put_unaligned_le32'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:9:28: error: linux/exportfs=
=2Eh: No such file or directory
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/ceph_fs.h:15,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/types.h:10,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:15,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h: At top level:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:64: error: expected '=3D', '=
,', ';', 'asm' or '__attribute__' before 'ceph_entity_addr_is_local'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/msgr.h:71: error: expected '=3D', '=
,', ';', 'asm' or '__attribute__' before 'ceph_entity_addr_equal'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:1=
2,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:16,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:19: error: expected specif=
ier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h: In function 'ceph_buffer_=
put':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/buffer.h:35: error: 'struct ceph_bu=
ffer' has no member named 'is_vmalloc'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:16,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h: At top level:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:58: error: expected spe=
cifier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:82: error: expected spe=
cifier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/messenger.h:152: error: expected sp=
ecifier-qualifier-list before 'bool'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:17,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/msgpool.h:15: error: expected speci=
fier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/msgpool.h:20: error: expected decla=
ration specifiers or '...' before 'bool'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:18,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:36: error: field 'dela=
yed_work' has incomplete type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:59: error: field 'dela=
yed_work' has incomplete type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mon_client.h:61: error: expected sp=
ecifier-qualifier-list before 'bool'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:19,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:167: error: expected s=
pecifier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:246: error: field 'del=
ayed_work' has incomplete type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h: In function 'ceph_mds=
c_get_request':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/mds_client.h:303: error: 'struct ce=
ph_mds_request' has no member named 'r_ref'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:=
9,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:20,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osdmap.h: At top level:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osdmap.h:90: error: expected '=3D',=
 ',', ';', 'asm' or '__attribute__' before 'ceph_osdmap_flag'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:20,
>                  from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:49: error: expected sp=
ecifier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:85: error: field 'time=
out_work' has incomplete type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:111: error: expected d=
eclaration specifiers or '...' before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:121: error: expected d=
eclaration specifiers or '...' before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/osd_client.h:141: error: expected d=
eclaration specifiers or '...' before 'bool'
> In file included from /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:21:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:267: error: expected specif=
ier-qualifier-list before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:388: error: expected '=3D',=
 ',', ';', 'asm' or '__attribute__' before 'ceph_i_test'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:494: error: expected '=3D',=
 ',', ';', 'asm' or '__attribute__' before '__ceph_is_any_real_caps'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:705: error: expected declar=
ation specifiers or '...' before 'bool'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.h:718: error: expected '=3D',=
 ',', ';', 'asm' or '__attribute__' before '__ceph_have_pending_cap_snap'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'init_caches':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:160: warning: passing argum=
ent 5 of 'kmem_cache_create' from incompatible pointer type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:160: error: too few argumen=
ts to function 'kmem_cache_create'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: implicit declar=
ation of function 'KMEM_CACHE'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: 'ceph_cap' unde=
clared (first use in this function)
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: (Each undeclare=
d identifier is reported only once
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:164: error: for each functi=
on it appears in.)
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:165: warning: assignment ma=
kes pointer from integer without a cast
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:169: error: 'ceph_dentry_in=
fo' undeclared (first use in this function)
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:170: warning: assignment ma=
kes pointer from integer without a cast
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:174: error: 'ceph_file_info=
' undeclared (first use in this function)
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:175: warning: assignment ma=
kes pointer from integer without a cast
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'parse_mount_a=
rgs':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:360: error: implicit declar=
ation of function 'pr_err'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:431: error: implicit declar=
ation of function 'kstrndup'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:433: warning: assignment ma=
kes pointer from integer without a cast
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:438: warning: assignment ma=
kes pointer from integer without a cast
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'open_root_den=
try':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:619: error: 'struct ceph_md=
s_request' has no member named 'r_started'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:620: error: 'struct ceph_md=
s_request' has no member named 'r_timeout'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:622: error: 'struct ceph_md=
s_request' has no member named 'r_num_caps'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_mount':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:669: error: 'struct ceph_me=
ssenger' has no member named 'nocrc'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_set_supe=
r':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:744: warning: assignment di=
scards qualifiers from pointer target type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:745: warning: assignment di=
scards qualifiers from pointer target type
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_init_bdi=
':
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:803: error: implicit declar=
ation of function 'bdi_init'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: In function 'ceph_kill_sb'=
:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:897: error: implicit declar=
ation of function 'bdi_destroy'
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c: At top level:
> /home/wpf/ceph/ceph-0.16.1/src/kernel/super.c:906: error: 'FS_RENAME_DOES=
_D_MOVE' undeclared here (not in a function)
> make[2]: *** [/home/wpf/ceph/ceph-0.16.1/src/kernel/super.o] Error 1
> make[1]: *** [_module_/home/wpf/ceph/ceph-0.16.1/src/kernel] Error 2
> make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.18/linux-2.6=
=2E18.x86_64'
>=20
>=20
> =20
>=20
> =20
>  =09=09 =09   =09=09 =20
> _________________________________________________________________
> Messenger=B0=B2=C8=AB=B1=A3=BB=A4=D6=D0=D0=C4=A3=AC=C3=E2=B7=D1=D0=DE=B8=
=B4=CF=B5=CD=B3=C2=A9=B6=B4=A3=AC=B1=A3=BB=A4Messenger=B0=B2=C8=AB=A3=A1
> http://im.live.cn/safe/
--557981400-1811751196-1257866485=:30993
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--557981400-1811751196-1257866485=:30993
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--557981400-1811751196-1257866485=:30993--
