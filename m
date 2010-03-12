From: sheng zheng <zhengsheng2006@gmail.com>
Subject: =?gb2312?b?bWttb25mc7XEzsrM4g==?=
Date: Fri, 12 Mar 2010 16:55:02 +0800
Message-ID: <79eb276e1003120055q19c9bb83h293175f2613709de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6726184389113171480=="
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

--===============6726184389113171480==
Content-Type: multipart/alternative; boundary=0016362852fedee6b2048196af81

--0016362852fedee6b2048196af81
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

hi=A3=ACall
  when i install a test cluster with ceph-0.19-tar.gz,it runs abnormally.
 1) when i run mkmonfs, the follwing arise:
  mkmonfs -i 0 --mon-data mondata/mon0 --monmap monmap --osdmap osdmap
10.03.12 17:07:28.542772 store(mondata/mon0) mkfs
10.03.12 17:07:28.542932 store(mondata/mon0) test -d mondata/mon0 && /bin/r=
m
-rf mondata/mon0 ; mkdir -p mondata/mon0
10.03.12 17:07:28.558756 mon0(starting).class v0 create_initial -- creating
initial map
10.03.12 17:07:28.562110 mon0(starting).auth v0 create_initial -- creating
initial map
10.03.12 17:07:28.562143 mon0(starting).auth v0 reading initial keyring
can't open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_keyring: No
such file or directory
can't open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_keyring: No
such file or directory
can't open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_keyring: No
such file or directory
mkmonfs: created monfs at mondata/mon0 for mon0

2) when i  mount -t ceph 192.168.1.202:/ /mnt/ceph,the follwing arise:
mount: 192.168.1.202:/: can't read superblock
dmesg:
     [ 1581.804768] ceph: client4100 fsid
07bd01d9-93b0-8928-1d87-cb3bb0d76684
[ 1581.804847] ceph: mon0 192.168.1.202:6789 session established

why?who can tell me?
thank you
--=20
Sheng Zheng
-----
School of Electronic Information
Wuhan University,China
Phone:86-27-68778247
emai:zhengsheng2006@gmail.com <emai%3Azhengsheng2006@gmail.com>

--0016362852fedee6b2048196af81
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

hi=A3=ACall<br> &nbsp; when i install a test cluster with ceph-0.19-tar.gz,=
it runs abnormally.<br> &nbsp;1) when i run mkmonfs, the follwing arise:<br=
> &nbsp; mkmonfs -i 0 --mon-data mondata/mon0 --monmap monmap --osdmap osdm=
ap<br>10.03.12 17:07:28.542772 store(mondata/mon0) mkfs<br>
10.03.12 17:07:28.542932 store(mondata/mon0) test -d mondata/mon0 &amp;&amp=
; /bin/rm -rf mondata/mon0 ; mkdir -p mondata/mon0<br>10.03.12 17:07:28.558=
756 mon0(starting).class v0 create_initial -- creating initial map<br>10.03=
.12 17:07:28.562110 mon0(starting).auth v0 create_initial -- creating initi=
al map<br>
10.03.12 17:07:28.562143 mon0(starting).auth v0 reading initial keyring <br=
><span style=3D"color: rgb(255, 102, 102);">can&#39;t open ~/.ceph/keyring.=
bin, /etc/ceph/keyring.bin, .ceph_keyring: No such file or directory</span>=
<br style=3D"color: rgb(255, 102, 102);">
<span style=3D"color: rgb(255, 102, 102);">can&#39;t open ~/.ceph/keyring.b=
in, /etc/ceph/keyring.bin, .ceph_keyring: No such file or directory</span><=
br style=3D"color: rgb(255, 102, 102);"><span style=3D"color: rgb(255, 102,=
 102);">can&#39;t open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_ke=
yring: No such file or directory</span><br>
mkmonfs: created monfs at mondata/mon0 for mon0<br><br>2) when i&nbsp; moun=
t -t ceph 192.168.1.202:/ /mnt/ceph,the follwing arise:&nbsp; <br>mount: 19=
2.168.1.202:/: can&#39;t read superblock<br>dmesg:<br>&nbsp;&nbsp;&nbsp;&nb=
sp; [ 1581.804768] ceph: client4100 fsid 07bd01d9-93b0-8928-1d87-cb3bb0d766=
84<br>
[ 1581.804847] ceph: mon0 <a href=3D"http://192.168.1.202:6789">192.168.1.2=
02:6789</a> session established<br><br>why?who can tell me?<br>thank you<br=
>-- <br>Sheng Zheng<br>-----<br>School of Electronic Information<br>Wuhan U=
niversity,China<br>
Phone:86-27-68778247<br><a href=3D"mailto:emai%3Azhengsheng2006@gmail.com">=
emai:zhengsheng2006@gmail.com</a><br><br>

--0016362852fedee6b2048196af81--


--===============6726184389113171480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============6726184389113171480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============6726184389113171480==--
