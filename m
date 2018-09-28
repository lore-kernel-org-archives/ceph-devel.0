From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: CRUSH puzzle: step weighted-take
Date: Fri, 28 Sep 2018 09:04:48 +0200
Message-ID: <CABZ+qqk-HBD8D2vBLcW1ZXPtwyCiG8+2nw=Y+1jC38OeP5J_hQ@mail.gmail.com>
References: <CABZ+qqmMiGSF3g-WR9TLTUAxwdK3aCt0wq+ku5XWzukp0tJ04w@mail.gmail.com>
 <CAL8KHarp1AyOCx5ymHUT4h9d7oJvWVFGh8UY87LXhfF7-heF2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAL8KHarp1AyOCx5ymHUT4h9d7oJvWVFGh8UY87LXhfF7-heF2g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: goncalofilipeborges-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Sep 28, 2018 at 12:51 AM Goncalo Borges
<goncalofilipeborges-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi Dan
>
> Hope to find you ok.
>
> Here goes a suggestion from someone who has been sitting in the side line for the last 2 years but following stuff as much as possible
>
> Will weight set per pool help?
>
> This is only possible in luminous but according to the docs there is the possibility to adjust positional weights for devices hosting replicas of objects for a given bucket.

We're running luminous, so weight-sets are indeed in the game.
I need to read the docs in detail to see if it could help...
combining with Maged's idea might be the solution.

Thanks!

dan


> Cheers
> Goncalo
>
>
