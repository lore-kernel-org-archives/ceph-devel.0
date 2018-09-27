From: Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Subject: Re: Mimic cluster is offline and not healing
Date: Thu, 27 Sep 2018 15:10:43 +0200
Message-ID: <20180927131043.GB17567@shell.dmz.bit.nl>
References: <CAE-AtHqSpX09gnAfgXt1=nmyLKuvjgMMn+qKaiZ0nOUKwEARrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE-AtHqSpX09gnAfgXt1=nmyLKuvjgMMn+qKaiZ0nOUKwEARrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: by morphin <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Quoting by morphin (morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org):
> After 72 hours I believe we may hit a bug. Any help would be greatly
> appreciated.

Is it feasible for you to stop all client IO to the Ceph cluster? At
least until it stabilizes again. "ceph osd pause" would do the trick
(ceph osd unpause would unset it). 

What kind of workload are you running on the cluster? How does your
crush map looks like (ceph osd getcrushmap -o  /tmp/crush_raw; 
crushtool -d /tmp/crush_raw -o /tmp/crush_edit)?

I have seen a (test) Ceph cluster "healing" itself to the point there was
nothing left to recover on. In *that* case the disks were overbooked
(multiple OSDs per physical disk) ... The flags you set (nooout, nodown,
nobackfill, norecover, noscrub, etc., etc.) helped to get it to recover
again. I would try to get all OSDs online again (and manually keep them
up / restart them, because you have set nodown).

Does the cluster recover at all?

Gr. Stefan

-- 
| BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
| GPG: 0xD14839C6                   +31 318 648 688 / info-68+x73Hep80@public.gmane.org
