From: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Does anyone use interactive CLI mode?
Date: Thu, 11 Oct 2018 10:42:16 +0200
Message-ID: <CAA6-MF9d8iungJRia+e=aaqM=tiawEF6qiqnySLXhx08cJLAWA@mail.gmail.com>
References: <CALe9h7c5kJudfsQ6Vf_vczUG0CeoN8=dxznC=92RamBvxD9u0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7c5kJudfsQ6Vf_vczUG0CeoN8=dxznC=92RamBvxD9u0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Den ons 10 okt. 2018 kl 16:20 skrev John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> So the question is: does anyone actually use this feature?  It's not
> particularly expensive to maintain, but it might be nice to have one
> less path through the code if this is entirely unused.

It can go as far as I am concerned too.

Better spend time on making the verbose flag do better that just listing
the 189 sub-commands you didn't use and then have more or less the
same output as if you ran without --verbose.

(try 'ceph status' -vs- 'ceph status --verbose' for instance)

In the cases where it actually needs to perform things, talk network
and such things and fails
it would be helpful if those messages didn't drown in all that
"this ceph status wasn't ceph osd crush reweight and not ceph pg dump
and not ..."

I get that someone wanted to debug the parser once, but that could be
some other flag than
"the admin wants to know the substeps this command tries so the fault
can be found when
it doesn't work" which --verbose flags tend to try to be in other software.

-- 
May the most significant bit of your life be positive.
