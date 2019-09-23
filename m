From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: ceph; pg scrub errors
Date: Mon, 23 Sep 2019 07:48:42 -0700
Message-ID: <CAANLjFq3HCJvd6R-17ip+-TqTYeQFk0Z2eSz+hkCr2B4jUyX7w@mail.gmail.com>
References: <CANA9Uk7nUFcLc7L4-=3hGH-7Dcf4dt1+xVSrs7hDzgWdNB+vqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk7nUFcLc7L4-=3hGH-7Dcf4dt1+xVSrs7hDzgWdNB+vqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thu, Sep 19, 2019 at 4:34 AM M Ranga Swami Reddy
<swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi-Iam using ceph 12.2.11. here I am getting a few scrub errors. To fix these scrub error I ran the "ceph pg repair <pg_id>".
> But scrub error not going and the repair is talking long time like 8-12 hours.

Depending on the size of the PGs and how active the cluster is, it
could take a long time as it takes another deep scrub to happen to
clear the error status after a repair. Since it is not going away,
either the problem is too complicated to automatically repair and
needs to be done by hand, or the problem is repaired and when it
deep-scrubs to check it, the problem has reappeared or another problem
was found and the disk needs to be replaced.

Try running:
rados list-inconsistent-obj ${PG} --format=json

and see what the exact problems are.
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
