From: "Frank Filz" <ffilzlnx-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: Re: new statx() like interface for libcephfs
Date: Tue, 28 Jun 2016 13:47:57 -0700
Message-ID: <001001d1d17e$5ab5e690$1021b3b0$@mindspring.com>
References: <1467137825.32374.29.camel@redhat.com>
	<CAL-2WbF5HAoAvbje8xr91OP5Cd1ye7UF7W+PA01m-V1+O==DjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <nfs-ganesha-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAL-2WbF5HAoAvbje8xr91OP5Cd1ye7UF7W+PA01m-V1+O==DjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs-ganesha-devel>,
	<mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=nfs-ganesha-devel>
List-Post: <mailto:nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs-ganesha-devel>,
	<mailto:nfs-ganesha-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: nfs-ganesha-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: 'Daniel Gryniewicz' <dang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Jeff Layton' <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: 'David Howells' <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Ceph Development' <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Ganesha NFS List' <nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

> Is stx_version a generation ID for the inode that can be used for the
> NFSv4 Change ID?  If so, that would be quite useful to us.  Otherwise, I'm
not
> sure there's that much in there that's useful beyond what stat already
> provides, unless I'm missing something.

Even if stx_version isn't available for a change attribute, btime converts
to NFS v4 create time.

Frank

> On Tue, Jun 28, 2016 at 2:17 PM, Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > I have a patchset queued up for ceph that adds btime (birthtime)
> > support to it. What was lacking though was a mechanism to get the
> > btime out of the inode.
> >
> > Rather than cook up a brand new interface just for the btime, I
> > decided to "borrow" the work that David Howells did with the new
> > proposed
> > statx() interface. The pull request to add this to ceph is up here:
> >
> >      https://github.com/ceph/ceph/pull/9965
> >
> > Sage has already closed it out which I take to mean that he has pulled
> > the patches into a staging branch for eventual merge.
> >
> > It occurs to me though that I didn't ask anyone who is working on the
> > samba vfs or ganesha fsal code whether they think this interface is
> > acceptable.
> >
> > Since Samba and Ganesha are the targeted users of this interface, it'd
> > be good to have developers from both communities take a look and see
> > if there are any problems here.
> >
> > Does anyone see any issues with the above pull request?
> > --
> > Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
>
----------------------------------------------------------------------------
--
> Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
> Francisco, CA to explore cutting-edge tech and listen to tech luminaries
> present their vision of the future. This family event has something for
> everyone, including kids. Get more information and register today.
> http://sdm.link/attshape
> _______________________________________________
> Nfs-ganesha-devel mailing list
> Nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/nfs-ganesha-devel


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
