From: David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: Capacity proplem when mount CephFS with Ubuntu
	14.04
Date: Tue, 16 Jul 2013 11:35:37 +0100
Message-ID: <51E521F9.5050606@cam.ac.uk>
References: <51E505D6.1030700@vccloud.vn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51E505D6.1030700-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 16/07/13 09:35, Ta Ba Tuan wrote:
> Hi everyone,
> 
> OSDs capacity sumary is 144TB, and *when I mount CephFS on Ubuntu 14.04
> then it only display **576GB*, (Currently, I'm using replicate 3 for
> data pools)
> (using: mount -t ceph Monitor_IP:/ /ceph -o name=admin,secret=xxxxxxxxxx")
> 
> I don't think capacity is too small?, please explain this help me!!!!!
> 
> *on Ubuntu 14.04*
> Filesystem                Size  Used Avail Use% Mounted on
> 192.168.32.90:/    576GB  20G  556GB  1%  /tmp/ceph_mount
> 
> But when mounting on Ubuntu 12.04:
> *on Ubuntu 12.04*
> Filesystem                Size  Used Avail Use% Mounted on
> 192.168.32.90:/    144T  800G  113.6T   1%  /tmp/ceph_mount

This is most likely:

 http://tracker.ceph.com/issues/3793

This is caused by using a more modern version of coreutils; that,
coupled with the numbers reported by Ceph for filesystem blocksizes in
older kernels, results in the above error.

To fix, either use a recent version of the fuse driver or upgrade your
kernel to a newer one that includes the commit "ceph: fix statvfs fr_size":

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=92a49fb0f79f3300e6e50ddf56238e70678e4202

(Kernels 3.9-rc1 and later should include it.)

Cheers,
David
-- 
David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Unix Specialist, University Computing Service
