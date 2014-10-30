From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: the state of cephfs in giant
Date: Thu, 30 Oct 2014 08:28:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410300823290.27022@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
	<CAPUexz_+jD7RMNSZEgy3h6WqKS4PSMj1fbyRgLKxQWHvctviNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPUexz_+jD7RMNSZEgy3h6WqKS4PSMj1fbyRgLKxQWHvctviNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Florian Haas <florian-Aci1KgOBn19BDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 30 Oct 2014, Florian Haas wrote:
> Hi Sage,
> 
> sorry to be late to this thread; I just caught this one as I was
> reviewing the Giant release notes. A few questions below:
> 
> On Mon, Oct 13, 2014 at 8:16 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > [...]
> > * ACLs: implemented, tested for kernel client. not implemented for
> >   ceph-fuse.
> > [...]
> > * samba VFS integration: implemented, limited test coverage.
> 
> ACLs are kind of a must-have feature for most Samba admins. The Samba
> Ceph VFS builds on userspace libcephfs directly, neither the kernel
> client nor ceph-fuse, so I'm trying to understand whether ACLs are
> available to Samba users or not. Can you clarify please?

I believe that with the current integration, Samba is doing all of the 
ACLs and storing them as xattrs.  They will work for CIFS users, but won't 
be coherent with users access the same file system directly via the kernel 
cephfs client or NFS or some other means.

This is a general problem with NFS vs CIFS.  The richacl project built a 
coherent ACL structure that captures both NFS4 and windows ACLs but it has 
not made it into the mainline kernel.  :/

> > * ganesha NFS integration: implemented, no test coverage.
> 
> I understood from a conversation I had with John in London that
> flock() and fcntl() support had recently been added to ceph-fuse, can
> this be expected to Just Work? in Ganesha as well?

It probably could without much trouble, but I don't think it has been 
wired up.  This is probably a pretty simple matter...

> Also, can you make a general statement as to the stability of flock()
> and fcntl() support in the kernel client and in libcephfs/ceph-fuse?
> This too is particularly interesting for Samba admins who rely on
> byte-range locking for Samba CTDB support.

Zheng fixed a bug or two with the existing kernel and MDS support when he 
did the ceph-fuse/libcephfs implementation.  At this point there are no 
known issues.  I would not expect problems, but will of course be very 
interested to hear bug reports.

> > * kernel NFS reexport: implemented. limited test coverage. no known
> >   issues.
> 
> In this scenario, is there any specific magic that the kernel client
> does to avoid producing deadlocks under memory pressure? Or are you
> referring to FUSE-mounted CephFS reexported via kernel NFS?

I'm not aware of any memory deadlock issues with NFS reexport.  Unless the 
ceph daemons are running on the same host as the client/exporter... but 
that is not specific to NFS.

Hope that helps!
sage
