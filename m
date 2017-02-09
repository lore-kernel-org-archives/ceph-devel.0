From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: would people mind a slow osd restart during
 luminous upgrade?
Date: Thu, 9 Feb 2017 14:29:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702091426500.7782@piezo.novalocal>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
	<CAN-Gep+5wDxpab3b5AN_i1m2uNHVvhWkjMWjmd7Rmi6Xbnciuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN-Gep+5wDxpab3b5AN_i1m2uNHVvhWkjMWjmd7Rmi6Xbnciuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 9 Feb 2017, David Turner wrote:
> The only issue I can think of is if there isn't a version of the clients
> fully tested to work with a partially upgraded cluster or a documented
> incompatibility requiring downtime. We've had upgrades where we had to
> upgrade clients first and others that we had to do the clients last due to
> issues with how the clients interacted with an older cluster, partially
> upgraded cluster, or newer cluster.

We maintain client compatibiltity across *many* releases and several 
years.  In general this under the control of the administrator via their 
choice of CRUSH tunables, which effectively let you choose the oldest 
client you'd like to support.

I'm curious which upgrade you had problems with?  Generally speaking the 
only "client" upgrade ordering issue is with the radosgw clients, which 
need to be upgraded after the OSDs.

> If the FileStore is changing this much, I can imagine a Jewel client having
> a hard time locating the objects it needs from a Luminous cluster.

In this case the change would be internal to a single OSD and have no 
effect on the client/osd interaction or placement of objects.

sage
