From: Jeremy Allison <jra-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: Re: CTDB Cluster Samba on Cephfs
Date: Wed, 3 Apr 2013 14:42:01 -0700
Message-ID: <20130403214201.GG23658@samba2>
References: <CAKMAVE9FBKzZwrrO9psK-h95V6V=tufnsRApu7mMjc5cZx7_cQ@mail.gmail.com>
Reply-To: Jeremy Allison <jra-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKMAVE9FBKzZwrrO9psK-h95V6V=tufnsRApu7mMjc5cZx7_cQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sam Lang <slang-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kai Blin <kai-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Volker.Lendecke-3ekOc4rQMZmzQB+pC5nmwQ@public.gmane.org, samba-technical <samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 03, 2013 at 03:53:58PM -0500, Sam Lang wrote:
> On Thu, Mar 28, 2013 at 6:32 AM, Kai Blin <kai-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On 2013-03-28 09:16, Volker Lendecke wrote:
> >> On Wed, Mar 27, 2013 at 10:43:36PM -0700, Matthieu Patou wrote:
> >>> On 03/27/2013 10:41 AM, Marco Aroldi wrote:
> >>>> Hi list, I'm trying to create a active/active Samba cluster on
> >>>> top of Cephfs I would ask if Ceph fully supports CTDB at this
> >>>> time.
> >>> If I'm not wrong Ceph (even CephFS) do not support exporting a
> >>> block device or mounting the same FS more than once whereas CTDB
> >>> explicitly require that you have a distributed filesystem where
> >>> the same filesystem is mounted across all the nodes.
> >>
> >> Is that true? I thought Ceph was one of the cluster filesystems
> >> doing just that. What is Ceph if not a cluster file system?
> >
> > There's some problem with mounting the in-kernel cephfs driver on
> > systems running the osd, iirc. I had to use the fuse-based driver to
> > mount, which obviously is not too great, speed-wise.
> > See http://ceph.com/docs/master/faq/#try-ceph for a better description
> > of the issue.
> 
> Just to let folks know, we have a ceph vfs driver for samba that we
> are testing out now.  We're planning to resolve a few of the bugs that
> we're seeing presently with smbtorture, and send a pull request to the
> samba repo.  If anyone wants to help with testing, let us know.  The
> changes currently reside in the ceph branch of
> http://github.com/ceph/samba.

One thing I noticed. Returning a struct ceph_dir_result *
cast to a DIR * struct won't work in 4.0.x as we expect
dirfd(DIR *) to return a valid file descriptor.

More as I look at it.

Jeremy.
