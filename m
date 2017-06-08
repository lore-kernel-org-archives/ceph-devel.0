From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: removing cluster name support
Date: Thu, 8 Jun 2017 19:37:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

At CDM yesterday we talked about removing the ability to name your ceph 
clusters.  There are a number of hurtles that make it difficult to fully 
get rid of this functionality, not the least of which is that some 
(many?) deployed clusters make use of it.  We decided that the most we can 
do at this point is remove support for it in ceph-deploy and ceph-ansible 
so that no new clusters or deployed nodes use it.

The first PR in this effort:

	https://github.com/ceph/ceph-deploy/pull/441

Background:

The cluster name concept was added to allow multiple clusters to have 
daemons coexist on the same host.  At the type it was a hypothetical 
requirement for a user that never actually made use of it, and the 
support is kludgey:

 - default cluster name is 'ceph'
 - default config is /etc/ceph/$cluster.conf, so that the normal 
'ceph.conf' still works
 - daemon data paths include the cluster name,
     /var/lib/ceph/osd/$cluster-$id
   which is weird (but mostly people are used to it?)
 - any cli command you want to touch a non-ceph cluster name 
needs -C $name or --cluster $name passed to it.

Also, as of jewel,

 - systemd only supports a single cluster per host, as defined by $CLUSTER 
in /etc/{sysconfig,default}/ceph

which you'll notice removes support for the original "requirement".

Also note that you can get the same effect by specifying the config path 
explicitly (-c /etc/ceph/foo.conf) along with the various options that 
substitute $cluster in (e.g., osd_data=/var/lib/ceph/osd/$cluster-$id).


Crap preventing us from removing this entirely:

 - existing daemon directories for existing clusters
 - various scripts parse the cluster name out of paths


Converting an existing cluster "foo" back to "ceph":

 - rename /etc/ceph/foo.conf -> ceph.conf
 - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-*
 - remove the CLUSTER=foo line in /etc/{default,sysconfig}/ceph 
 - reboot


Questions:

 - Does anybody on the list use a non-default cluster name?
 - If so, do you have a reason not to switch back to 'ceph'?

Thanks!
sage
