From: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Recompiling source code - to find exact RPM
Date: Wed, 22 Mar 2017 10:17:59 +1000
Message-ID: <CAF-wwdFNgsq9+Z2Y3JcBxQoWfUtvtfZ0Y8C3WWArX9fPFVzR5Q@mail.gmail.com>
References: <CALWuvY9kyuZgSHeLFwBw86J=tDzX-xc2FPvAQ8Qq__o3s_oodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALWuvY9kyuZgSHeLFwBw86J=tDzX-xc2FPvAQ8Qq__o3s_oodw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Based solely on the information given the only rpms with this specific commit in
them would be here
https://shaman.ceph.com/builds/ceph/wip-prune-past-intervals-kraken/
(specifically
https://4.chacra.ceph.com/r/ceph/wip-prune-past-intervals-kraken/8263140fe539f9c3241c1c0f6ee9cfadde9178c0/centos/7/flavors/default/x86_64/).
These are test rpms, not official releases.

Note that the branch "wip-prune-past-intervals-kraken" exists only in the
ceph-ci repo and *not* the main ceph repo and that the particular commit above
does not seem to have made it into the "ceph" repo.

$ git log -S _simplify_past_intervals
$ git log --grep="_simplify_past_intervals"
$

Given this commit is not in the ceph repo I would suggest we have never shipped
an official rpm that contains this commit.

It's not totally clear to me exactly what you are trying to achieve, maybe you
could have another go at describing your objective?

On Wed, Mar 22, 2017 at 12:26 AM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello,
>
> I made some changes in the below file on ceph kraken v11.2.0 source code as
> per this article 
>
> https://github.com/ceph/ceph-ci/commit/wip-prune-past-intervals-kraken
>
> ..src/osd/PG.cc
> ..src/osd/PG.h
>
> Is there any way to find which rpm got affected by these two files. I
> believe it should be ceph-osd-11.2.0-0.el7.x86_64.rpm . Can you confirm
> please ?
>
> I failed to find it from the ceph.spec file. 
>
> Could anyone please guide me the right procedure to check this.
>
> The main intention is that if we find the exact rpm affected by these files,
> we can simply overwrite it with the old rpm.  
>
> Awaiting for comments.
>
> Thanks
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Cheers,
Brad
