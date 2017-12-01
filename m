From: Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Subject: Re: ceph-disk removal roadmap (was ceph-disk is now
 deprecated)
Date: Fri, 1 Dec 2017 09:28:10 +0100
Message-ID: <20171201082810.GH30636@shell.dmz.bit.nl>
References: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
 <20171201081757.qwfo2lrhpmg77jgd@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171201081757.qwfo2lrhpmg77jgd-aVfaTQcAavps8ZkLLAvlZtBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Quoting Fabian Gr=FCnbichler (f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org):
> I think the above roadmap is a good compromise for all involved parties,
> and I hope we can use the remainder of Luminous to prepare for a
> seam- and painless transition to ceph-volume in time for the Mimic
> release, and then finally retire ceph-disk for good!

Will the upcoming 12.2.2 release ship with a ceph-volume capable of
doing bluestore on top of LVM? Eager to use ceph-volume for that, and
skip entirely over ceph-disk and our manual osd prepare process ...

Gr. Stefan

-- =

| BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
| GPG: 0xD14839C6                   +31 318 648 688 / info-68+x73Hep80@public.gmane.org
