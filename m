From: David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Thu, 17 Oct 2013 10:06:55 +0100
Message-ID: <525FA8AF.1010408@cam.ac.uk>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1310160914360.22271-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, linux-lvm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 16/10/2013 17:16, Sage Weil wrote:

> I'm not sure what options LVM provides for aligning things to the
> underlying storage...

There is a generic kernel ABI for exposing performance properties of 
block devices to higher layers, so that they can automatically tune 
themselves according to those performance properties, and report their 
performance properties to users higher up the stack.

LVM supports both reading this data from underlying physical devices, 
configuring itself as appropriate --- as well as reporting this data to 
users of LVs, so that they can, too.

(For example, mkfs.xfs uses libblkid to automatically select the optimal 
stripe-size, stride width, etc. of an LVM volume sitting on top of an MD 
disk array.)

A good starting point appears to be:

 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c72758f33784e5e2a1a4bb9421ef3e6de8f9fcf3

If Ceph RBD block devices don't currently expose this information, that 
should be a relatively simple addition that will result in all higher 
layers, whether LVM or a native filesystem, automatically tuning 
themselves at creation-time for the RBD's performance characteristics.

(As an aside, it's possible that OSD journalling performance could also 
be improved by teaching it to heed this topology information.  I can 
imagine that when writing directly to block devices it may be possible 
to improve performance, such as when using LVM-on-an-SSD, or a DOS 
partition on a 4k-sector SATA disk.)

  ~ ~ ~

In the mean time, the documentation I found for LVM2 suggests that the 
`pvcreate` command supports the "--dataalignment" and 
"--dataalignmentoffset" flags.

The former should be the RBD object size, e.g. 4MB by default.  In this 
case, you'll also need to set the latter compensate for the offset 
introduced by the GPT place-holder partition table at the start of the 
device so that LVM data extents begin on an object boundry.

Cheers,
David
-- 
David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Unix Specialist, University Computing Service
