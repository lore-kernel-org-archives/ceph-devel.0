From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: osd down after server failure
Date: Mon, 14 Oct 2013 08:38:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310140837390.1931@cobra.newdream.net>
References: <CAMNMNTyZx6JDDF2y_3L6zPM7Gf81CatR2WrrSmKaLuABHKQJoA@mail.gmail.com>
	<CAMNMNTwyoQDNhS-RwWR0=wPmC7hsUjAvi-eftr3MwVm=sL7fvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTwyoQDNhS-RwWR0=wPmC7hsUjAvi-eftr3MwVm=sL7fvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Is osd.47 the one with the bad disk?  I should not start.

If there are other osds on the same host that aren't started with 'service 
ceph start', you may have to mention them by name (the old version of the 
script would stop on the first error instead of continuing).  e.g.,

 service ceph start osd.48
 service ceph start osd.49
 ...

sage

On Mon, 14 Oct 2013, Dominik Mostowiec wrote:

> Hi
> I have found somthing.
> After restart time was wrong on server (+2hours) before ntp has fixed it.
> I restarted this 3 osd - it not helps.
> It is possible that ceph banned this osd? Or after start with wrong
> time osd has broken hi's filestore?
> 
> --
> Regards
> Dominik
> 
> 
> 2013/10/14 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Hi,
> > I had server failure that starts from one disk failure:
> > Oct 14 03:25:04 s3-10-177-64-6 kernel: [1027237.023986] sd 4:2:26:0:
> > [sdaa] Unhandled error code
> > Oct 14 03:25:04 s3-10-177-64-6 kernel: [1027237.023990] sd 4:2:26:0:
> > [sdaa]  Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > Oct 14 03:25:04 s3-10-177-64-6 kernel: [1027237.023995] sd 4:2:26:0:
> > [sdaa] CDB: Read(10): 28 00 00 00 00 d0 00 00 10 00
> > Oct 14 03:25:04 s3-10-177-64-6 kernel: [1027237.024005] end_request:
> > I/O error, dev sdaa, sector 208
> > Oct 14 03:25:04 s3-10-177-64-6 kernel: [1027237.024744] XFS (sdaa):
> > metadata I/O error: block 0xd0 ("xfs_trans_read_buf") error 5 buf
> > count 8192
> > Oct 14 03:25:04 s3-10-177-64-6 kernel: [1027237.025879] XFS (sdaa):
> > xfs_imap_to_bp: xfs_trans_read_buf() returned error 5.
> > Oct 14 03:25:28 s3-10-177-64-6 kernel: [1027260.820288] XFS (sdaa):
> > metadata I/O error: block 0xd0 ("xfs_trans_read_buf") error 5 buf
> > count 8192
> > Oct 14 03:25:28 s3-10-177-64-6 kernel: [1027260.821194] XFS (sdaa):
> > xfs_imap_to_bp: xfs_trans_read_buf() returned error 5.
> > Oct 14 03:25:32 s3-10-177-64-6 kernel: [1027264.667851] XFS (sdaa):
> > metadata I/O error: block 0xd0 ("xfs_trans_read_buf") error 5 buf
> > count 8192
> >
> > this caused that the server has been unresponsive.
> >
> > After server restart 3 of 26 osd on it are down.
> > In ceph-osd log after "debug osd = 10" and restart is:
> >
> > 2013-10-14 06:21:23.141936 7fdeb4872700 -1 osd.47 43203 *** Got signal
> > Terminated ***
> > 2013-10-14 06:21:23.142141 7fdeb4872700 -1 osd.47 43203  pausing thread pools
> > 2013-10-14 06:21:23.142146 7fdeb4872700 -1 osd.47 43203  flushing io
> > 2013-10-14 06:21:25.406187 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount FIEMAP ioctl is supported and
> > appears to work
> > 2013-10-14 06:21:25.406204 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount FIEMAP ioctl is disabled via
> > 'filestore fiemap' config option
> > 2013-10-14 06:21:25.406557 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount did NOT detect btrfs
> > 2013-10-14 06:21:25.412617 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount syncfs(2) syscall fully supported
> > (by glibc and kernel)
> > 2013-10-14 06:21:25.412831 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount found snaps <>
> > 2013-10-14 06:21:25.415798 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount: enabling WRITEAHEAD journal mode:
> > btrfs not detected
> > 2013-10-14 06:21:26.078377 7f02690f9780  2 osd.47 0 mounting
> > /vol0/data/osd.47 /vol0/data/osd.47/journal
> > 2013-10-14 06:21:26.080872 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount FIEMAP ioctl is supported and
> > appears to work
> > 2013-10-14 06:21:26.080885 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount FIEMAP ioctl is disabled via
> > 'filestore fiemap' config option
> > 2013-10-14 06:21:26.081289 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount did NOT detect btrfs
> > 2013-10-14 06:21:26.087524 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount syncfs(2) syscall fully supported
> > (by glibc and kernel)
> > 2013-10-14 06:21:26.087582 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount found snaps <>
> > 2013-10-14 06:21:26.089614 7f02690f9780  0
> > filestore(/vol0/data/osd.47) mount: enabling WRITEAHEAD journal mode:
> > btrfs not detected
> > 2013-10-14 06:21:26.726676 7f02690f9780  2 osd.47 0 boot
> > 2013-10-14 06:21:26.726773 7f02690f9780 10 osd.47 0 read_superblock
> > sb(16773c25-5054-4451-bf9f-efc1f7f21b89 osd.47
> > 63cf7d70-99cb-0ab1-4006-00000000002f e43203 [41261,43203]
> > lci=[43194,43203])
> > 2013-10-14 06:21:26.726862 7f02690f9780 10 osd.47 0 add_map_bl 43203 82622 bytes
> > 2013-10-14 06:21:26.727184 7f02690f9780 10 osd.47 43203 load_pgs
> > 2013-10-14 06:21:26.727643 7f02690f9780 10 osd.47 43203 load_pgs
> > ignoring unrecognized meta
> > 2013-10-14 06:21:26.727681 7f02690f9780 10 osd.47 43203 load_pgs
> > 3.df1_TEMP clearing temp
> >
> > osd.47 is still down, I put it out from cluster.
> > 47      1                               osd.47  down    0
> >
> > How can I check what is wrong?
> >
> > ceph -v
> > ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
> >
> > --
> > Pozdrawiam
> > Dominik
> 
> 
> 
> -- 
> Pozdrawiam
> Dominik
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
