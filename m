From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: ceph osd journal disk in RAID#1?
Date: Thu, 14 Feb 2019 14:23:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1902141422000.14565@piezo.novalocal>
References: <CANA9Uk5j=JJT9pG-vbyqztVm_VM_pX4CfxwPjJB0sDseyGEW4A@mail.gmail.com>
 <CAD4AmV6w=c0ov7cXsr+T=o2hWpa5P5k=W1YR3VrJxf_WDR=1zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAD4AmV6w=c0ov7cXsr+T=o2hWpa5P5k=W1YR3VrJxf_WDR=1zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Petrini <jpetrini-bJ/+BncPNP1Wk0Htik3J/w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 14 Feb 2019, John Petrini wrote:
> Cost and available disk slots are also worth considering since you'll
> burn a lot more by going RAID-1, which again really isn't necessary.
> This may be the most convincing reason not to bother.

Generally speaking, if the choice is between a 2 RAID-1 SSDs shared by 6 
HDD OSDs, or each of those SSDs shared by 3 HDD OSDs, I'd take the 
latter.  Especially with BlueStore, which can make good use of the doubled 
capacity to keep more metadata on fast storage.

sage
