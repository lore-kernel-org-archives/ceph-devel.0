From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: clean shutdown and failover of osd
Date: Sat, 20 Apr 2013 22:44:53 -0700
Message-ID: <CAPYLRzjU-BsA16rv+zSgR8ngcOm5L-tZ54kMNq=DrZWZr+VPFQ@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B4F360D32@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4F360D32-mzsoxcrO4/2UD0RQwgcqbDSf8X3wrgjD@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: James Harper <james.harper-NMzNsA1hOHcW+bLBXbPJGg@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

[ This is a good query for ceph-users. ]

On Sat, Apr 20, 2013 at 10:15 PM, James Harper
<james.harper-NMzNsA1hOHcW+bLBXbPJGg@public.gmane.org> wrote:
> I'm doing some testing with ceph trying to figure out why my performance is so bad, and have noticed that there doesn't seem to be a way to cleanly stop an osd, or at least under debian /etc/init.d/ceph stop seems to just kill the OSD resulting in the client also stopping io until it figures out why the node isn't responding.
>
> Is this how it is supposed to work? I would have thought it would be possible to shut down an osd cleanly such that failover is immediate. I understand that an abrupt failure like a node crashing would result in a freeze for a bit.

In bobtail that's about all there is, yes. If you're in control you
can shut it down and issue a "ceph osd down" command to tell the
system without having to wait for heartbeats to notice it.

The current next branch (will be Cuttlefish) includes code so that
OSDs attempt to notify the system before they get turned off.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
