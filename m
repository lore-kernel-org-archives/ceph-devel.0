From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: v12.2.7 Luminous released
Date: Wed, 18 Jul 2018 12:20:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1807181218130.15696@piezo.novalocal>
References: <87tvox968t.fsf@suse.com> <20180717182419.GA1559@shell.dmz.bit.nl>,
 <alpine.DEB.2.11.1807171838180.15696@piezo.novalocal>
 <MEAPR01MB3333E2C456B441629674B2BE81530@MEAPR01MB3333.ausprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <MEAPR01MB3333E2C456B441629674B2BE81530-6Cj2JuxXxgYyJjs6S75NOcNU+h3Mz0HLvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Linh Vu <vul-keaFvQtjc6i7NGdpmJTKYQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 18 Jul 2018, Linh Vu wrote:
> Thanks for all your hard work in putting out the fixes so quickly! :)
> 
> We have a cluster on 12.2.5 with Bluestore and EC pool but for CephFS, 
> not RGW. In the release notes, it says RGW is a risk especially the 
> garbage collection, and the recommendation is to either pause IO or 
> disable RGW garbage collection.
> 
> 
> In our case with CephFS, not RGW, is it a lot less risky to perform the 
> upgrade to 12.2.7 without the need to pause IO?
> 
> 
> What does pause IO do? Do current sessions just get queued up and IO 
> resume normally with no problem after unpausing?
> 
> 
> If we have to pause IO, is it better to do something like: pause IO, 
> restart OSDs on one node, unpause IO - repeated for all the nodes 
> involved in the EC pool?

CephFS can generate a problem rados workload too when files are deleted or 
truncated.  If that isn't happening in your workload then you're probably 
fine.  If deletes are mixed in, then you might consider pausing IO for the 
upgrade.

FWIW, if you have been running 12.2.5 for a while and haven't encountered 
the OSD FileStore crashes with

src/os/filestore/FileStore.cc: 5524: FAILED assert(0 == "ERROR: source must exist")

but have had OSDs go up/down then you are probably okay.

Thanks!
sage
