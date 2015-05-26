From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Tue, 26 May 2015 15:17:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505261503480.26752@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <555EF6D0.5000903@redhat.com> <alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net> <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com> <alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
 <CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com> <alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net> <CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com> <alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net>
 <CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbbEZWRX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 18:17:23 -0400
In-Reply-To: <CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Tue, 26 May 2015, Gregory Farnum wrote:
> > That makes sense to me.  I suggest
> >
> > - the MDS decides it is allowed.  If so, do the presented operation.
> > Preserve the const-ness of teh current permission checks.
> >
> > - the client may do some squashing before-hand.
> >
> > - forget what I said before and make this un-NFS-like.  :)
> 
> :)
> 
> >
> > Perhaps the illustrative example is this: an op to create a file, as uid
> > 0, in a 777 directory comes in, and the capability says root_squash.  In
> > this case, our const check says "if i were to squash to 65534, it would
> > still be allowed" and so the mds goes ahead and creates a file *owned by
> > root*.
> >
> > Does that make sense?
> 
> Mmm, I'm having trouble making this one work out. If you can write a
> file with UID 0 you have to be able to subsequently read it, and I
> just don't see that happening if you aren't doing an operation as UID
> 0?

The operation would be done as uid 0.

(Also, I'm completely ignoring read operations for the moment... :/ )

> But this is getting thornier as we consider future multi-tenant (not
> just multi-user) and subtree work. I've been imaging the subtree
> restriction as *not additive*, in that it would be a restriction to
> users. 

I think we're still talking past each other about 'additive'.  I'm 
suggesting caps are *always* additive.  That is, any operation permitted 
by

 allow A

will also permit the same operation if you have

 allow A ; allow B

for *any* B.  B cannot effect A, and only one of the allow's needs to say 
"yes".

...but what does that have to do with path restrictions?  If you have an 
allow A like

 allow rw path /foo

that will allow something in /foo regardless of what other allow B's are 
added to the list.

Right?

> It looks like you've got similar ideas from the pad, so I don't
> understand how the anonymous user would generally be allowed to do
> things against the tree except read it?
> 
> When looking at your pad and you say "if a UID is specified..." do you
> mean specified within an op, or in the cephx caps? The first one makes
> sense to me; the second won't work (not additive, etc).

In the caps, where it is optional.  The uid on the op will be required 
(modulo whatever we have to do for compatibility).

> Basically I'm still stuck on how any of this lets us lock a user into
> a subtree while letting them do what they want within it. I'm not sure
> how/if NFS solves that problem...

That's easy:

 # lock client into a dir
 allow rw path /home/user  

Or, for a shared model:

 # allow access to a project dir, as project or user gid
 allow rw path /share/project uid 123 gids 123,1000

Ooh... are you thinking forward to when we might have to dynamically write 
a cap that implements changing kerberos auth information?  For that, I'd 
suggest something like

 allow rw path /foo kerberos

...where that then does an additional check against any kerberos tickets 
info we've gotten from the client session?

sage
