From: Lincoln Bryant <lincolnb-t4+EzPmVLfD2fBVCVOL8/A@public.gmane.org>
Subject: Re: who is using nfs-ganesha and cephfs?
Date: Wed, 8 Nov 2017 16:42:32 -0600
Message-ID: <68AC447D-36B4-4085-AF0F-387B2FB1A6AB@uchicago.edu>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1711082140180.29217-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

We have been running the Ganesha FSAL for a while (as far back as Hammer / Ganesha 2.2.0), primarily for uid/gid squashing.

Things are basically OK for our application, but we've seen the following weirdness*:
	- Sometimes there are duplicated entries when directories are listed. Same filename, same inode, just shows up twice in 'ls'.
	- There can be a considerable latency between new files added to CephFS and those files becoming visible on our NFS clients. I understand this might be related to dentry caching. 
	- Occasionally, the Ganesha FSAL seems to max out at 100,000 caps claimed which don't get released until the MDS is restarted.

*note: these issues are with Ganesha 2.2.0 and Hammer/Jewel, and have perhaps since been fixed upstream. 

(We've recently updated to Luminous / Ganesha 2.5.2, and will be happy to complain if any issues show up :))

Cheers,
Lincoln

> On Nov 8, 2017, at 3:41 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> Who is running nfs-ganesha's FSAL to export CephFS?  What has your 
> experience been?
> 
> (We are working on building proper testing and support for this into 
> Mimic, but the ganesha FSAL has been around for years.)
> 
> Thanks!
> sage
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
