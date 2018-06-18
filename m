From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Ceph Mimic on Debian 9 Stretch
Date: Mon, 18 Jun 2018 19:15:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1806181909150.8443@piezo.novalocal>
References: <CAKme9egBfDKvrS6dgm1JxK3S47xoeFm7vTy07qZ+er6deYhXcg@mail.gmail.com>
 <alpine.DEB.2.11.1806041830480.22723@piezo.novalocal>
 <20180613113616.hbow3e4bcrrsg7ax@nora.maurer-it.com>
 <alpine.DEB.2.11.1806131206580.22590@piezo.novalocal>
 <20180618181208.4q7difyk665mglho@work>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1348248013-1529349352=:8443"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20180618181208.4q7difyk665mglho@work>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?ISO-8859-15?Q?Fabian_Gr=FCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, Charles Alva <charlesalva-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1348248013-1529349352=:8443
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 18 Jun 2018, Fabian Grünbichler wrote:
> it's of course within your purview as upstream project (lead) to define
> certain platforms/architectures/distros as fully supported, and others
> as best-effort/community-driven/... . there was no clear public
> communication (AFAICT, only the one thread on ceph-maintainers, which is
> rather low visibility) that Debian moves from somewhere in the middle[2]
> to the latter category with Mimic, and has now (at least for the time
> being) effectively joined FreeBSD (which has at least one community
> member pouring in enormous amounts of work) and the various community
> Linux distros like Arch, Gentoo, ... (where I frankly have no idea about
> the status quo). there is also no mention in the docs or the release
> notes about the lack of Debian packages (and the state of Xenial
> packages) for Mimic. all of which gives off more of an "unintended
> consequence" vibe, rather than "conscious decision to drop Debian".

This is a fair assessment, and it's good to hear that there is some path 
forward.

It looks like the Buster release date is Feb '19 (give or take), which 
corresponds to Nautilus, so it should be possible for Debian users to skip 
mimic and upgrade directly from luminous to nautilus as long as we build 
some buster packages for luminous as well right around the end of its 
lifetime (and/or mimic point releases once buster gets closer to stable).

Is this reasonable?

	https://github.com/ceph/ceph/pull/22602

sage
--8323329-1348248013-1529349352=:8443
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1348248013-1529349352=:8443--
