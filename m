From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4 0/5] ceph: persistent caching with fscache
Date: Wed, 4 Sep 2013 09:25:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309040923080.1073@cobra.newdream.net>
References: <alpine.DEB.2.00.1308212203320.1479@cobra.newdream.net> <cover.1375999914.git.milosz@adfin.com> <17341.1378309753@warthog.procyon.org.uk> <alpine.DEB.2.00.1309040851080.27503@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1309040851080.27503-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zheng.z.yan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-cachefs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 4 Sep 2013, Sage Weil wrote:
> Hi David!
> 
> On Wed, 4 Sep 2013, David Howells wrote:
> > Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> > 
> > > David, are the fscache patches here ready for the next merge window?  Do 
> > > you have a preference for whose tree they go through?
> > 
> > There's only one problem - patch 1 needs to come _after_ patch 2 to avoid
> > breaking git bisect.  Plus these patches 2 and 4 extend the fscache API
> > without adjusting the documentation - but that can be added later.
> > 
> > And I think Milosz deserves a beer (or other poison of his choice;-) for
> > finding a longstanding irritating bug.
> > 
> > I think AFS, CIFS, NFS and 9P all need patching too, but I can attend to that.
> > 
> > Should I take the patches through my tree?  Then I can make the adjustments.
> 
> Sure.  Do you want the Ceph patches as well, or just the fscache bits?  
> I'll repost the latest version, as it's gotten several fixes squashed in.

The full series is here:

 git://github.com/ceph/ceph-client wip-fscache
 https://github.com/ceph/ceph-client/commits/wip-fscache

Thanks!
sage
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
