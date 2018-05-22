From: Vincent Godin <vince.mlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Recovery time is very long till we have a double tree
 in the crushmap
Date: Tue, 22 May 2018 17:57:09 +0200
Message-ID: <CAL2-6bJ0U2z8soDS936khDQq-AoY7PQT349o0nSPWCqX=Z8khQ@mail.gmail.com>
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Two monthes ago, we had a simple crushmap :
- one root
- one region
- two datacenters
- one room per datacenter
- two pools per room (one SATA and one SSD)
- hosts in SATA pool only
- osds in host

So we created a ceph pool at the level SATA on each site.
After some disk problems which impacted almost all VMs on a site, we
decided to add a level between pool and hosts : rack (3 racks per pool).
The aim was to create ceph pools based on rack so a defected disk on a
server would impact in the worse case only the VMs attached to the rack.

Adding a rack between pool and hosts in the current tree would move all the
data already in the old pool SATA. So we decided to create an other tree
with only three racks per site pointing on the servers they owned.

It's working but :

- some ceph command are not any more possible. adding a new server on both
tree is not possible despite the doc. It is possible to add the server in
the SATA pool on the old tree but not in the corresponding rack on the new
tree (even if we precise the new root)
- some ceph command give strange results. A ceph osd df will show you the
same osd twice

The worse :

Before adding this new tree, adding 4 new servers took roughly a week. We
added last month 4 servers and it took 3 weeks to converge and get a Ceph
OK state

Is this a normal behaviour. Do we need to fall back to a single tree and
insert the rack between the pool and the hosts even if it will move a lot
of data ?
