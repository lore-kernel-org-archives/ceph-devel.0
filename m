From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Kernel RBD hang on OSD Failure
Date: Tue, 8 Dec 2015 08:55:03 +1100
Message-ID: <CA+z5DswarP0KHomWJocCxT29W1-kyzV2RhDOg7tc-0_DV0D1Kg@mail.gmail.com>
References: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Matt Conner <matt.conner-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Matt,

(CC'ing in ceph-users too - similar reports there:
http://www.spinics.net/lists/ceph-users/msg23037.html)

We've seen something similar for KVM [lib]RBD clients acting as NFS
gateways within our OpenStack cloud, the NFS services were locking up
and causing client timeouts whenever we started doing Ceph
maintenance. We eventually realised we'd somehow set the pool min_size
== size, so any single OSD outage was blocking client IO - *oops*.
Your issue sounds like something different, but NFS does seem to be
very touchy and lacking any graceful recovery from issues with the
underlying FS.


On 8 December 2015 at 07:56, Matt Conner <matt.conner-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org> wrote:
> Hi,
>
> We have a Ceph cluster in which we have been having issues with RBD
> clients hanging when an OSD failure occurs. We are using a NAS gateway
> server which maps RBD images to filesystems and serves the filesystems
> out via NFS. The gateway server has close to 180 NFS clients and
> almost every time even 1 OSD goes down during heavy load, the NFS
> exports lock up and the clients are unable to access the NAS share via
> NFS. When the OSD fails, Ceph recovers without issue, but the gateway
> kernel RBD module appears to get stuck waiting on the now failed OSD.
> Note that this works correctly when under lighter loads.
>
> From what we have been able to determine, the NFS server daemon hangs
> waiting for I/O from the OSD that went out and never recovers.
> Similarly, attempting to access files from the exported FS locally on
> the gateway server will result in a similar hang. We also noticed that
> Ceph health details will continue to report blocked I/O on the now
> down OSD until either the OSD is recovered or the gateway server is
> rebooted.  Based on a few kernel logs from NFS and PVS, we were able
> to trace the problem to the RBD kernel module.
>
> Unfortunately, the only way we have been able to recover our gateway
> is by hard rebooting the server.
>
> Has anyone else encountered this issue and/or have a possible solution?
> Are there suggestions for getting more detailed debugging information
> from the RBD kernel module?
>
>
> Few notes on our setup:
> We are using Kernel RBD on a gateway server that exports filesystems via NFS
> The exported filesystems are XFS on LVMs which are each composed of 16
> striped images (NFS->LVM->XFS->PVS->RBD)
> There are currently 176 mapped RBD images on the server (11
> filesystems, 16 mapped RBD images per FS)
> Gateway Kernel: 3.18.6
> Ceph version: 0.80.9
> Note - We've tried using different kernels all the way up to 4.3.0 but
> the problem persists.
>
> Thanks,
> Matt Conner
> Keeper Technology
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
