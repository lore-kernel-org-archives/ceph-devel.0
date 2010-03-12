From: Sage Weil <sage@newdream.net>
Subject: Re: =?gb2312?b?bWttb25mc7XEzsrM4g==?=
Date: Fri, 12 Mar 2010 08:51:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003120848001.28255@cobra.newdream.net>
References: <79eb276e1003120055q19c9bb83h293175f2613709de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-64055637-1268412701=:28255"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <79eb276e1003120055q19c9bb83h293175f2613709de@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: sheng zheng <zhengsheng2006@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-64055637-1268412701=:28255
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Sheng,

On Fri, 12 Mar 2010, sheng zheng wrote:

> hi=A3=ACall
>   when i install a test cluster with ceph-0.19-tar.gz,it runs abnormally.
>  1) when i run mkmonfs, the follwing arise:
>   mkmonfs -i 0 --mon-data mondata/mon0 --monmap monmap --osdmap osdmap
> 10.03.12 17:07:28.542772 store(mondata/mon0) mkfs
> 10.03.12 17:07:28.542932 store(mondata/mon0) test -d mondata/mon0 && /bin=
/rm
> -rf mondata/mon0 ; mkdir -p mondata/mon0
> 10.03.12 17:07:28.558756 mon0(starting).class v0 create_initial -- creati=
ng
> initial map
> 10.03.12 17:07:28.562110 mon0(starting).auth v0 create_initial -- creatin=
g
> initial map
> 10.03.12 17:07:28.562143 mon0(starting).auth v0 reading initial keyring
> can't open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_keyring: No
> such file or directory
> can't open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_keyring: No
> such file or directory
> can't open ~/.ceph/keyring.bin, /etc/ceph/keyring.bin, .ceph_keyring: No
> such file or directory
> mkmonfs: created monfs at mondata/mon0 for mon0

The keyring.bin warnings can be ignored if you're not using the cephx=20
authentication (i.e., if you don't have

=09auth supported =3D cephx

in your ceph.conf).  If you _do_ have it enabled, you need to add '-k=20
adminkeyring.bin' to the mkcephfs command line so that you get a copy of=20
the admin key to administer the cluster.  But I'd recommend just leaving=20
authentication off for now!

> 2) when i  mount -t ceph 192.168.1.202:/ /mnt/ceph,the follwing arise:
> mount: 192.168.1.202:/: can't read superblock
> dmesg:
>      [ 1581.804768] ceph: client4100 fsid
> 07bd01d9-93b0-8928-1d87-cb3bb0d76684
> [ 1581.804847] ceph: mon0 192.168.1.202:6789 session established

Probably the MDS isn't letting the client open the root inode.  That may=20
be because the MDS didn't start, or because the OSDs aren't up (without=20
which the MDS can't do anything useful).  The output from 'ceph -w' would=
=20
narrow it down.

sage
--557981400-64055637-1268412701=:28255
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
--557981400-64055637-1268412701=:28255
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--557981400-64055637-1268412701=:28255--
