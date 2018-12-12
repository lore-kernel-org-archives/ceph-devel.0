From: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Deploying an Active/Active NFS Cluster over
 CephFS
Date: Wed, 12 Dec 2018 09:06:28 -0500
Message-ID: <9588a67aa6c13bd24eb7619debf1015aa9ce334c.camel@redhat.com>
References: <e37575905d14e9342bcecb8445ad730d57b4d713.camel@redhat.com>
 <CACo-D_Dew2bTznRTb_=2cjo6R705p+oy7N=sJ-uyw_E1230gqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <nfs-ganesha-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACo-D_Dew2bTznRTb_=2cjo6R705p+oy7N=sJ-uyw_E1230gqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/nfs-ganesha-devel>,
 <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=nfs-ganesha-devel>
List-Post: <mailto:nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs-ganesha-devel>,
 <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: nfs-ganesha-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David C <dcsysengineer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "support-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org" <support-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This list has been deprecated. Please subscribe to the new devel list at lists.nfs-ganesha.org.
The main thing is that luminous does not have some of the new recovery
interfaces in nautilus:

A ganesha server acts as a Ceph client and any state held by it (opens,
locks, etc) is tied to the ceph client session. When a ganesha restarts,
the new instance of the server will need to reacquire some subset of the
caps it held before, but to the Ceph MDS, it just looks like another
client.

So, we end up having to wait around until the old session times out
before we can acquire some of those caps. That timeout is around 60s and
that can eat heavily into the NFS grace period (which is usually about
90-120s). During that time, stateful operations performed by the clients
(opens, locks, etc.) will stall.

In nautilus we've added a way to tag a session with a particular unique
ID so that when the server is resurrected it can ask the MDS to cancel
the old session immediately. That allows us to get back to business
quicker.

Luminous may work but (at best) you'll end up with longer recovery
times. At worst, you could end up with NFS state recovery failures if
the interlocking timeouts didn't work out cleanly.

-- Jeff

On Wed, 2018-12-12 at 13:35 +0000, David C wrote:
> Hi Jeff
> 
> Many thanks for this! Looking forward to testing it out. 
> 
> Could you elaborate a bit on why Nautilus is recommended for this set-up please. Would attempting this with a Luminous cluster be a non-starter? 
> 
> 
> 
> On Wed, 12 Dec 2018, 12:16 Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
> > (Sorry for the duplicate email to ganesha lists, but I wanted to widen
> > it to include the ceph lists)
> > 
> > In response to some cries for help over IRC, I wrote up this blog post
> > the other day, which discusses how to set up parallel serving over
> > CephFS:
> > 
> >     https://jtlayton.wordpress.com/2018/12/10/deploying-an-active-active-nfs-cluster-over-cephfs/
> > 
> > Feel free to comment if you have questions. We may be want to eventually
> > turn this into a document in the ganesha or ceph trees as well.
> > 
> > Cheers!

-- 
Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
