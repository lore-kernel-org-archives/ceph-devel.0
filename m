From: "Sean" <sean_cao-JQRGsKwlDnqPt1CcHtbs0g@public.gmane.org>
Subject: ceph v6.1, rbd-fuse issue,
	rbd_list: error %d Numerical result out of range
Date: Fri, 17 May 2013 17:34:02 +0800
Message-ID: <000f01ce52e1$aad3ce90$007b6bb0$@lecast.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: zh-cn
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone

The image files don't display in mount point when using the command
"rbd-fuse -p poolname -c /etc/ceph/ceph.conf /aa"

but other pools can display image files with the same command. I also create
more sizes and more numbers images than that pool, it's work fine.

How can I track the issue? 

It reports the below errors after enabling debug output of Fuse options.

root@ceph3:/# rbd-fuse -p qa_vol /aa -d
FUSE library version: 2.8.6
nullpath_ok: 0
unique: 1, opcode: INIT (26), nodeid: 0, insize: 56
INIT: 7.17
flags=0x0000047b
max_readahead=0x00020000
   INIT: 7.12
   flags=0x00000031
   max_readahead=0x00020000
   max_write=0x00020000
   unique: 1, success, outsize: 40
unique: 2, opcode: GETATTR (3), nodeid: 1, insize: 56
getattr /
rbd_list: error %d
: Numerical result out of range
   unique: 2, success, outsize: 120
unique: 3, opcode: OPENDIR (27), nodeid: 1, insize: 48
opendir flags: 0x98800 /
rbd_list: error %d
: Numerical result out of range
   opendir[0] flags: 0x98800 /
   unique: 3, success, outsize: 32
unique: 4, opcode: READDIR (28), nodeid: 1, insize: 80
readdir[0] from 0
   unique: 4, success, outsize: 80
unique: 5, opcode: READDIR (28), nodeid: 1, insize: 80
   unique: 5, success, outsize: 16
unique: 6, opcode: RELEASEDIR (29), nodeid: 1, insize: 64
releasedir[0] flags: 0x0
   unique: 6, success, outsize: 16


thanks.
Sean Cao
