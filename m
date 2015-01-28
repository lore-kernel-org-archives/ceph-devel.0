From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: chattr +i not working with cephfs
Date: Wed, 28 Jan 2015 10:06:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501281003420.19192@cobra.newdream.net>
References: <CA+9C14YA03rUAWs8N9kyPNJWyC3hBmo6SPwoLdOAe4CGA4HY9w@mail.gmail.com>
	<CAGd4Wr3f5+w4Aqv8RAcPHeJWhWwTF-yXpfQGnjkQ9fF6D7dPgw@mail.gmail.com>
	<CAC6JEv_cNro4iNZSxX=n+T6Zp60mEXY+0iJzh4HT-p9+6bizGA@mail.gmail.com>
	<CAGd4Wr14SQz_0V597ZwBDxEtYrcQuPXUheH9pEZX1SB_3nxEuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGd4Wr14SQz_0V597ZwBDxEtYrcQuPXUheH9pEZX1SB_3nxEuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <john.spray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 28 Jan 2015, John Spray wrote:
> On Wed, Jan 28, 2015 at 5:23 PM, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org> wrote:
> > My concern is whether we as the FS are responsible for doing anything
> > more than storing and returning that immutable flag ? are we supposed
> > to block writes to anything that has it set? That could be much
> > trickier...
> 
> The VFS layer is checking the flag for us, but some filesystems do
> have paths where they need to do their own too (e.g. XFS has various
> ioctls that do explicit checks too).  It's also up to us to publish
> the S_IMMUTABLE bit to the i_flags attribute of the generic inode,
> based on wherever/however we store the flag ourselves.
> 
> Fuse doesn't seem to have a path for us to update i_flags though, so
> it might be that we either have to extend that interface or do the
> checking ourselves in userspace in order to support it there.

It seems like we should be checking S_IMMUTABLE in the MDS and, 
when set, refusing to issue write caps.  We probably also need a check in 
the clients so that they return EROFS (I assume?) instead of waiting for 
said caps...

In any case, I don't think relying on clients to cooperate is quite the 
level protection S_IMMUTABLE users are looking for?

sage
