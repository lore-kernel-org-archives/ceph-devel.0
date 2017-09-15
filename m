From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Mixed versions of cluster and clients
Date: Fri, 15 Sep 2017 15:42:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709151538330.16664@piezo.novalocal>
References: <401B786D-0403-4136-B902-98A227AA00D8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <401B786D-0403-4136-B902-98A227AA00D8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mike A <mike.almateia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 15 Sep 2017, Mike A wrote:
> Hello!
> 
> We have a ceph cluster based on Jewel release and one virtualization infrastructure that is using the cluster. Now we are going to add another ceph cluster but based on luminous with bluestore. 
> The virtualization infrastructure must use these ceph clusters.  Do I need to update software version of client (librbd/librados) inside the virtualization infra? 
> 
> I think there are 3 different ways to add the new cluster:
> 1. Update client side to the Luminous release and leave old cluster to the Jewel release
> 2. Update old cluster and client to the Luminous release
> 3. Leave old cluster and client to the Jewel release
> 
> Please suggest pros and cons.

You can use either jewel or luminous clients.  Just be aware that the 
luminous cluster can't use luminous-only features until clients are 
upgrade.  By default, new luminous clusters will set their "min compat 
client" to jewel, so no special configuration is needed.

3 is the smallest change and least risk, which is appealing. You'll want 
to do 2 eventually, and 1 is a step along that path.

sage
