From: Filippos Giannakos <philipgian-Sqt7GMbKoOQ@public.gmane.org>
Subject: Re: Experiences with Ceph at the June'14 issue of
 USENIX ; login:
Date: Wed, 4 Jun 2014 17:22:35 +0300
Message-ID: <20140604142235.GI17479@philipgian-mac>
References: <20140602183219.GD17479@philipgian-mac>
	<1235448490.9762058.1401748668812.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1235448490.9762058.1401748668812.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ian Colle <icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello Ian,

Thanks for your interest.

On Mon, Jun 02, 2014 at 06:37:48PM -0400, Ian Colle wrote:
> Thanks, Filippos! Very interesting reading.
> 
> Are you comfortable enough yet to remove the RAID-1 from your architecture and
> get all that space back?

Actually, we are not ready to do that yet. There are three major things to
consider.

First, to be able to get rid of the RAID-1 setup, we need to increase the
replication level to at least 3x. So the space gain is not that great to begin
with.

Second, this operation can take about a month for our scale according to our
calculations and previous experience. During this period of increased I/O we
might get peaks of performance degradation. Plus, we currently do not have the
necessary hardware available to increase the replication level before we get rid
of the RAID setup.

Third, we have a few disk failures per month. The RAID-1 setup has allowed us to
seamlessly replace them without any hiccup or even a clue to the end user that
something went wrong. Surely we can rely on RADOS to avoid any data loss, but if
we currently rely on RADOS for recovery there might be some (minor) performance
degradation, especially for the VM I/O traffic.

Kind Regards,
-- 
Filippos
<philipgian-Sqt7GMbKoOQ@public.gmane.org>
