From: Volker Lendecke <Volker.Lendecke-PS7XAnAlDA+VvDNblw4Uiw@public.gmane.org>
Subject: Re: CTDB Cluster Samba on Cephfs
Date: Thu, 4 Apr 2013 08:08:04 +0200
Message-ID: <E1UNdLJ-00DB0z-Fh@intern.SerNet.DE>
References: <CAKMAVE9FBKzZwrrO9psK-h95V6V=tufnsRApu7mMjc5cZx7_cQ@mail.gmail.com>
Reply-To: Volker.Lendecke-PS7XAnAlDA+VvDNblw4Uiw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Date: Thu, 4 Apr 2013 08:08:04 +0200
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
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kai Blin <kai-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, samba-technical <samba-technical-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 03, 2013 at 03:53:58PM -0500, Sam Lang wrote:
> Just to let folks know, we have a ceph vfs driver for samba that we
> are testing out now.  We're planning to resolve a few of the bugs that
> we're seeing presently with smbtorture, and send a pull request to the
> samba repo.  If anyone wants to help with testing, let us know.  The
> changes currently reside in the ceph branch of
> http://github.com/ceph/samba.

The comments indicate that ceph is completely userspace. It
might be interesting to look at the aio functions like
pread_send/recv and pwrite_send/recv. In particular for
large data transfers over SMB2 those might give a
performance boost.

With best regards,

Volker Lendecke

-- =

SerNet GmbH, Bahnhofsallee 1b, 37081 G=F6ttingen
phone: +49-551-370000-0, fax: +49-551-370000-9
AG G=F6ttingen, HRB 2816, GF: Dr. Johannes Loxen
http://www.sernet.de, mailto:kontakt-3ekOc4rQMZmzQB+pC5nmwQ@public.gmane.org
