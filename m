From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Stripping rados-classes libraries
Date: Mon, 16 Sep 2013 16:58:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309161657240.30751@cobra.newdream.net>
References: <CAPud5_7BBuLosENwPLcOmGNWbTocGozwBKDye7zqJFh+cGRW1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1661890144-1379375933=:30751"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPud5_7BBuLosENwPLcOmGNWbTocGozwBKDye7zqJFh+cGRW1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Nick Bartos <nick-F4aKxGU1lFqkHkcT6e4Xnw@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1661890144-1379375933=:30751
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[added ceph-devel]

On Mon, 16 Sep 2013, Nick Bartos wrote:
> Which symbols need to be kept when stripping the libraries in rados-cla=
sses?
> I found this e-mail from 2010:
>=20
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/1543
>=20
> Is it still just symbols that start with __cls_ that need to be kept?
>=20
> We compile ceph with debug symbols and strip them out for later debuggi=
ng.
> =A0I was excluding stripping the files in rados-classes for < 0.67, how=
ever in
> 0.67.3 the files have gotten so big with the debug info we're going to =
have
> to strip what we can out of the files we ship.

I'm pretty sure that stripping all but __cls_ should do the trick.  If yo=
u=20
run into problems, let us know!

sage

--557981400-1661890144-1379375933=:30751
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1661890144-1379375933=:30751--
