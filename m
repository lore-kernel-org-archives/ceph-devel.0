From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: removing auids and auid-based cephx capabilities
Date: Thu, 16 Aug 2018 10:45:17 -0400
Message-ID: <CAJ4mKGa8umBNN3qE1B95aVuzyJbjAatGo_onb0tgau1ANbzrYQ@mail.gmail.com>
References: <alpine.DEB.2.11.1808082028510.22275@piezo.novalocal>
 <CAJ4mKGbeLxSaUFpNsO2d7=mZctBz1JjdMFg9V4ozYBGh60qdYg@mail.gmail.com>
 <alpine.DEB.2.11.1808111835420.15696@piezo.novalocal>
 <CA+iB1e6qqY5i=TDm66PCcTHFjaQtc-dQBqtoJO2a964sD6C2KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+iB1e6qqY5i=TDm66PCcTHFjaQtc-dQBqtoJO2a964sD6C2KA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Beocat KSU <mozes-OYTqUY/oFF8@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Reviewed the PR on github, but bringing it back to the list...

On Sat, Aug 11, 2018 at 2:39 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> Two questions so far:
>
> 1) I marked the librados calls that take aui deprecated, but I can wire
> them up to still work.  For example, if you call pool_create_with_auid it
> can still create a pool.  Alternatively, I can make those calls now return
> EOPNOTSUPP.  That could break some wayward librados user, though.
> Similarly, there are calls to get and set the pool auid.  Currently I have
> converted to no-ops, but they could also return an error instead.
> Thoughts?

I think we should be more subtle: mark them deprecated, but continue
functioning as normal if the user doesn't set an auid. Return
EOPNOTSUPP if they do. That seems like a gentler transition for
librados users without silently breaking anybody who actually uses
auids.

>
> 2) The rados cli has a 'mkpool' command that works like 'rados mkpool
> <poolname> [auid [crush-rule]]'.  The ordering means I can't just drop
> auid.  So, I could ignore the auid argument, or change the calling
> convention completely.
>
> Or, we could remove the command completely and let people use 'ceph osd
> pool create' for this.  This is my preference!

This is fine.

> In fact, there are
> several commands I'd suggest killing at the same time:
>
> "   mkpool <pool-name> [123[ 4]]     create pool <pool-name>'\n"
> "                                    [with auid 123[and using crush rule
> 4]]\n"
> "   cppool <pool-name> <dest-pool>   copy content of a pool\n"
> "   rmpool <pool-name> [<pool-name> --yes-i-really-really-mean-it]\n"
> "                                    remove pool <pool-name>'\n"
> "   purge <pool-name> --yes-i-really-really-mean-it\n"
> "                                    remove all objects from pool
> <pool-name> without removing it\n"
>
> cppool is an imcomplete implementation anyway (doesn't preserve snaps,
> for example; prabably doesn't do omap either?).  The others just scare me.

I'm generally with you here, although we should do a separate (more
obvious) subject line about removing that -- I'm not sure all the
cppool users are broken.

On Sat, Aug 11, 2018 at 4:51 PM, Adam Tygart <mozes-OYTqUY/oFF8@public.gmane.org> wrote:
> I don't care what happens to most of these rados commands, and I've
> never used the auid "functionality", but I have found the rados purge
> command quite useful when testing different rados level applications.
>
> Run a rados-level application test. Whoops it didn't do what you
> wanted, purge and start over. It is significantly faster than
> alternative of looping through a 'rados ls' and issuing 'rados rm' for
> every object. Sure I could delete the pool and recreate one with the
> same name, but that seems wasteful. Enabling pool deletion in the
> monitors, allocating new pool ids, causing the mass re-peering of
> placement groups, making sure the all of the per-pool settings exactly
> match what you had before. It gets tedious.
>
> If the code-path for a purge is different on the server-side, perhaps
> there could be an additional permission to let the cephx user perform
> a purge. At least then it is protected from the casual (ab)user.

I'm surprised that you find purge this much faster -- it is not in
itself doing anything clever or server-side, merely running an object
listing and issuing deletes for whatever turns up. I think it also
doesn't do anything with snapshots etc (though maybe I didn't look
hard enough) which would make it not even a real purge...
Perhaps it's best to just let users who want this functionality wire
it up in a hacky binary themselves so they understand its behavior?
-Greg
