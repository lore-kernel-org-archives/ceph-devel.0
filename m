From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: kerberos / AD requirements, blueprint
Date: Thu, 23 Oct 2014 10:47:09 -0400 (EDT)
Message-ID: <1098676823.49.1414075629689.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <54490E5A.408@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4760 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932237AbaJWOr1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 10:47:27 -0400
In-Reply-To: <54490E5A.408@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrea Ieri <andrea.ieri@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, abartlet@catalyst.net.nz, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Dan Van Der Ster <daniel.vanderster@cern.ch>, Sage Weil <sage@newdream.net>

Hi,

Is the goal then NOT to provide per-user authn (etc) as AFS or DCE woul=
d do, when a user accesses files using the kernel client (and provide f=
or that, in general)?  I would have thought that was a lot of the point=
=2E

It seems like that is the well trodden path, for AFS, DFS, NFSv4, it's =
basically similar, varying only in that NFSv4's per-user token propagat=
ion is a bit better integrated on Linux (but doesn't yet provide the PA=
G concept).

Matt

----- "Andrea Ieri" <andrea.ieri@cern.ch> wrote:

> Hi Sage,
>=20
> It's perhaps useful to clear up that Kerberos as a protocol provides
> your service with the following information (at the end of the initia=
l
> exchange):
> 1. a string representing a Kerberos principal (user@REALM)
> 2. a session key, known only to you and the principal above
> 3. a reasonable assurance that whoever sent you the ticket that
> contains the data above controls the principal mentioned (as in "know=
s
> its password")
>=20
> Now, you can choose what to do with the information above.
> - you'll most likely need to map the "principal" to a "user", whateve=
r
> that means for your system (a UID/GID tuple obtained via LDAP? A user
> string in your own local database?)
> - you'll have to decide what to do with the session key. Do you want
> to encrypt all communication? Implement a MAC? Throw it away? See for
> example the different Kerberos options in NFSv4
>=20
> In any case as you can see Kerberos is not concerned with
> authorization at all. How you enforce permissions is out of its
> scope.
>=20
> Cheers,
> Andrea
>=20
> On 22/10/2014 18:39, Dan Van Der Ster wrote:
> > Hi Sage,
> >
> >> On 16 Oct 2014, at 21:57, Sage Weil <sage@newdream.net> wrote:
> >>
> >> I started to write up a blueprint for kerberos / LDAP / AD
> support:
> >>
> >>=20
> https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD=
_authn%2F%2Fauthz
> >>
> >> In case it isn't clear from that document, I only sort of know wha=
t
> I'm=20
> >> talking about here.  (This is largely based on what I managed to
> retain=20
> >> from a conversation with Andrew, but I suspect I got some of it
> wrong.)
> >>
> >> For anyone working in environments where kerberos is in use, I am
> *very*=20
> >> interested in hearing what your requirements are for your
> environment.  In=20
> >> particular, are you using AD or LDAP or something else?  How do yo=
u
> expect=20
> >> RBAC to work for you?
> > Let=E2=80=99s talk about requirements then. (Anyway, I=E2=80=99m no=
t in any way a
> kerberos expert and it is not 100% clear to me what you are trying to
> achieve.)
> >
> > Firstly, our environment is almost identical to that described by
> Marcus (we use AD). For filesystems, our user communities are used to
> the way OpenAFS works with kerberos. Generally, that means they use
> kinit && aklog to authenticate and they understand (mostly) how to us=
e
> AFS groups and AFS ACLs for authz.
> >
> > Next I basically have a bunch of questions to clarify your goals.
> The first part of your blueprint seems to be a convenient way to
> distribute cephx keyrings. To prevent harvesting/reuse, would you
> intend those to not be =E2=80=9Cnormal=E2=80=9D cephx keyrings as suc=
h, but rather to
> be keyrings encrypted by the mon/whatever and time limited?
> >
> > For authz, is this mechanism meant to be used for RADOS only, or
> also for CephFS?
> >
> > If RADOS only, then as I understand it you could basically add the
> current cephx capabilities (with pool granularity) to the proposed
> ceph user db (perhaps scoped down to a few limited roles). I wouldn=E2=
=80=99t
> expect to be able to manipulate ceph capabilities via some AD blob
> (due mostly to my AD ignorance). I would probably expect to add our
> authorised ceph users to an AD group, then keep that in sync with you=
r
> ceph user/role/capability db.
> >
> > If CephFS, then the problem I see is that the POSIX permissions/ACL=
s
> are being evaluated only on the client side. Were you thinking to
> change that, i.e. to add some notion of CephFS file-granular cephx
> capabilities? We thought a little bit about this before:
> > =20
> https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/Strong_Auth=
N_and_AuthZ_for_CephFS
> > The basic idea was to have an MDS or other service that evaluates
> permissions/ACLs on the server side then hands out an extra signed
> capability to be used by the client for IOs with an OSD. It seems
> heavyweight, however, so I=E2=80=99m not sure how this would perform =
in
> practise.
> >
> > Hope that helps,
> > Dan
> >
> >
> >
> >
> >> We'll definitely have a slot for this at the upcoming CDS, but
> anything we=20
> >> can hash out before then will make that conversation more
> productive.
> >>
> >> Thanks!
> >> sage
> >>

--=20
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
