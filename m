From: John Petrini <jpetrini-bJ/+BncPNP1Wk0Htik3J/w@public.gmane.org>
Subject: Re: ceph osd journal disk in RAID#1?
Date: Thu, 14 Feb 2019 08:33:07 -0500
Message-ID: <CAD4AmV6w=c0ov7cXsr+T=o2hWpa5P5k=W1YR3VrJxf_WDR=1zg@mail.gmail.com>
References: <CANA9Uk5j=JJT9pG-vbyqztVm_VM_pX4CfxwPjJB0sDseyGEW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5j=JJT9pG-vbyqztVm_VM_pX4CfxwPjJB0sDseyGEW4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

You can but it's usually not recommended. When you replace a failed
disk the RAID rebuild is going to drag down the performance of the
remaining disk and subsequently all OSD's that are backed by it. This
can hamper the performance of the entire cluster. You could probably
tune rebuild priority in the RAID controller to limit the impact but
this will come at the expense of longer rebuild times which might not
be ideal.

Ideally losing a journal disk should not be a cause for concern. As
long as you don't have too many OSD's per journal your cluster should
keep humming along just fine until you rebuild those OSD's with a
replacement journal.

Cost and available disk slots are also worth considering since you'll
burn a lot more by going RAID-1, which again really isn't necessary.
This may be the most convincing reason not to bother.
