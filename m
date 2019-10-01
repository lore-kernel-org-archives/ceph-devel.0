From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Commit and Apply latency on nautilus
Date: Tue, 1 Oct 2019 07:54:06 -0700
Message-ID: <CAANLjFqW6WE_vfYd=39GVV8DgGJge+qBr52tHj+t0P3Aap4rBw@mail.gmail.com>
References: <qmq36f$5pap$1@blaine.gmane.org>
 <H000007100150ea4.1569860022.sx.f1-outsourcing.eu*@MHS>
 <CALi_L4-fNi=gP9sOCWPNcok9tVG=K-rtER68n1s9bkZzwuGhEw@mail.gmail.com>
 <CAD9yTbEzPJwAqVgn2fWtjZCG8zFnAgjvtMOnO-+FJd4XQx364Q@mail.gmail.com>
 <CALi_L4_dzsu3r4FGpc6K6Ce3iz6JAZmKaVTB8LXrLqVNOH1ong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALi_L4_dzsu3r4FGpc6K6Ce3iz6JAZmKaVTB8LXrLqVNOH1ong-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Sep 30, 2019 at 5:12 PM Sasha Litvak
<alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> At this point, I ran out of ideas.  I changed nr_requests and readahead parameters to 128->1024 and 128->4096, tuned nodes to performance-throughput.  However, I still get high latency during benchmark testing.  I attempted to disable cache on ssd
>
> for i in {a..f}; do hdparm -W 0 -A 0 /dev/sd$i; done
>
> and I think it make things not better at all.  I have H740 and H730 controllers with drives in HBA mode.
>
> Other them converting them one by one to RAID0 I am not sure what else I can try.
>
> Any suggestions?

If you haven't already tried this, add this to your ceph.conf and
restart your OSDs, this should help bring down the variance in latency
(It will be the default in Octopus):

osd op queue = wpq
osd op queue cut off = high

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
