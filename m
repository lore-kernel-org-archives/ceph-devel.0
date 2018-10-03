From: "Jonathan D. Proulx" <jon-EfZU8u+QLuPpgkiH4x7ZXw@public.gmane.org>
Subject: Re: hardware heterogeneous in same pool
Date: Wed, 3 Oct 2018 18:34:36 -0400
Message-ID: <20181003223436.a5fs5eextyuvlvbg@csail.mit.edu>
References: <CAL040-j2xziD6WGd7yqJc08sQfO0g5Qru0f-7maCxbqAq4EayQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL040-j2xziD6WGd7yqJc08sQfO0g5Qru0f-7maCxbqAq4EayQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Bruno Carvalho <brunowcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Oct 03, 2018 at 07:09:30PM -0300, Bruno Carvalho wrote:
:Hi Cephers, I would like to know how you are growing the cluster.
:
:Using dissimilar hardware in the same pool or creating a pool for each
:different hardware group.
:
:What problem would I have many problems using different hardware (CPU,
:memory, disk) in the same pool?

I've been growing with new hardware in old pools.

Due to the way RDB gets smeared across the disks your performance is
almost always bottle necked by slowest storage location.

If you're just adding slightly newer slightly faster hardware this is
OK as most of the performance gain in that case is from spreading
wider not so much the individual drive performance.

But if you are adding a faster technology like going from
spinning disk to ssd you do want to think about how to transition.

I recently added SSD to a previously all HDD cluster (well HDD data
with SSD WAL/DB).  For this I did fiddle with crush rules. First I made
the existing rules require HDD class devices which shoudl have been a
noop in my mind but actually moved 90% of my data.  The folks at CERN
made a similar discovery before me and even (I think worked out a way
to avoid it) see
http://lists.ceph.com/pipermail/ceph-large-ceph.com/2018-June/000113.html

After that I made new rules that took on SSD andtwo HDD for each
replica set (in addtion to spreading across racks or servers or what
ever) and after applying the new rule to the pools I use for Nova
ephemeral storage and Cinder Volumes I set the SSD OSDs to have high
"primary affinity" and the HDDs to have low "primary affinity".

In the end this means the SSDs server reads and writes while writes to
the HDD replicas are buffered by the SSD WAL so both reads and write
are relatively fast (we'd previouslyy been suffering on reads due to
IO load).

I left  Glance images on HDD only as those don't require much
performance in my world, same with RGW object storage though for soem
that may be performance sensitive.

The plan forward is more SSD to replace HDD, probbably by first
getting enough to transition ephemeral dirves, then a set to move
block storage, then the rest over next year or two.

The mixed SSD/HDD was a big win for us though so we're happy with that
for now.

scale matters with this so we have:
245 OSDs in 12 servers
627 TiB RAW storage (267 TiB used)
19.44 M objects


hope that helps,
-Jon
