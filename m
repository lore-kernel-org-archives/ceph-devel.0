From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Unstable clock
Date: Tue, 17 Oct 2017 13:27:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710171325500.26702@piezo.us.to>
References: <085064b4-2e21-4e54-cdd8-dd8a4560aa92@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <085064b4-2e21-4e54-cdd8-dd8a4560aa92-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mohamad Gebai <mgebai-l3A5Bk7waGM@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 17 Oct 2017, Mohamad Gebai wrote:
> Hi,
> 
> I am looking at the following issue: http://tracker.ceph.com/issues/21375
> 
> In summary, during a 'rados bench', impossible latency values (e.g.
> 9.00648e+07) are suddenly reported. I looked briefly at the code, it
> seems CLOCK_REALTIME is used, which means that wall clock changes would
> affect this output. This is a VM cluster, so the hypothesis was that the
> system's clock was falling behind for some reason, then getting
> readjusted (that's the only way I could reproduce the issue), which I
> think is quite possible in a virtual environment.
> 
> A concern was raised: are there more critical parts of Ceph where a
> clock jumping around might interfere with the behavior of the cluster?

Yes, definitely.

> It would be good to know if there are any, and maybe prepare for them?

Adam added a new set of clock primitives that include a monotonic clock 
option that should be used in all cases where we're measuring the passage 
of time instead of the wall clock time.  There is a longstanding trello 
card to go through and change the latency calculations to use the 
monotonic clock.  There are probably dozens of places where an ill-timed 
clock jump is liable to trigger some random assert.  It's just a matter of 
going through and auditing calls to the legacy ceph_clock_now() method.

sage
