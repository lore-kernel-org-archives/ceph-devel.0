From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: removing auids and auid-based cephx capabilities
Date: Sat, 11 Aug 2018 18:39:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1808111835420.15696@piezo.novalocal>
References: <alpine.DEB.2.11.1808082028510.22275@piezo.novalocal>
 <CAJ4mKGbeLxSaUFpNsO2d7=mZctBz1JjdMFg9V4ozYBGh60qdYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGbeLxSaUFpNsO2d7=mZctBz1JjdMFg9V4ozYBGh60qdYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, 10 Aug 2018, Gregory Farnum wrote:
> On Wed, Aug 8, 2018 at 1:33 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > There is an undocumented part of the cephx authentication framework called
> > the 'auid' (auth uid) that assigns an integer identifier to cephx users
> > and to rados pools and allows you to craft cephx capabilities that apply
> > to those pools.  This is leftover infrastructure from an ancient time in
> > which RGW buckets mapped 1:1 to rados pools (pre-argonaut!) and it was
> > expected the cephx capabilities would line up with that.
> >
> > Although in theory parts of the auid infrastructure might work and be in
> > use, it is undocumented, untested, and a messy artifact in the code.  I'd
> > like to remove it.
> >
> > ***
> >
> >   If you are using auid-based cephx capabilities, now is the time to tell
> >   us!  Or, if you know of any reason we should keep it around, now is
> >   the time to speak up.
> >
> >   Otherwise we will remove it!
> >
> > ***
> 
> I used to be very proud of this code, but +1. I don't know of any
> users who *could* be using it (much less are) and it really doesn't
> make any sense in our current security architecture even if it might
> function.

Two questions so far:

1) I marked the librados calls that take aui deprecated, but I can wire 
them up to still work.  For example, if you call pool_create_with_auid it 
can still create a pool.  Alternatively, I can make those calls now return 
EOPNOTSUPP.  That could break some wayward librados user, though.  
Similarly, there are calls to get and set the pool auid.  Currently I have 
converted to no-ops, but they could also return an error instead.  
Thoughts?

2) The rados cli has a 'mkpool' command that works like 'rados mkpool 
<poolname> [auid [crush-rule]]'.  The ordering means I can't just drop 
auid.  So, I could ignore the auid argument, or change the calling 
convention completely.

Or, we could remove the command completely and let people use 'ceph osd 
pool create' for this.  This is my preference!  In fact, there are 
several commands I'd suggest killing at the same time:

"   mkpool <pool-name> [123[ 4]]     create pool <pool-name>'\n"
"                                    [with auid 123[and using crush rule 
4]]\n"
"   cppool <pool-name> <dest-pool>   copy content of a pool\n"
"   rmpool <pool-name> [<pool-name> --yes-i-really-really-mean-it]\n"
"                                    remove pool <pool-name>'\n"
"   purge <pool-name> --yes-i-really-really-mean-it\n"
"                                    remove all objects from pool 
<pool-name> without removing it\n"

cppool is an imcomplete implementation anyway (doesn't preserve snaps, 
for example; prabably doesn't do omap either?).  The others just scare me.

Thoughts?
sage
