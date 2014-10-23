From: Sage Weil <sage@newdream.net>
Subject: Re: kerberos / AD requirements, blueprint
Date: Thu, 23 Oct 2014 08:05:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410230804110.10837@cobra.newdream.net>
References: <1098676823.49.1414075629689.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46814 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaJWPFc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 11:05:32 -0400
In-Reply-To: <1098676823.49.1414075629689.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Andrea Ieri <andrea.ieri@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>, abartlet@catalyst.net.nz, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Dan Van Der Ster <daniel.vanderster@cern.ch>

On Thu, 23 Oct 2014, Matt W. Benjamin wrote:
> Hi,
> 
> Is the goal then NOT to provide per-user authn (etc) as AFS or DCE would 
> do, when a user accesses files using the kernel client (and provide for 
> that, in general)?  I would have thought that was a lot of the point.

Eventually, yes.  The baby step is just use AD/LDAP for the ceph/rbd CLIs 
and for authn/z at mount time.

sage


> 
> Matt
> 
> ----- "Andrea Ieri" <andrea.ieri@cern.ch> wrote:
> 
> > Hi Sage,
> > 
> > It's perhaps useful to clear up that Kerberos as a protocol provides
> > your service with the following information (at the end of the initial
> > exchange):
> > 1. a string representing a Kerberos principal (user@REALM)
> > 2. a session key, known only to you and the principal above
> > 3. a reasonable assurance that whoever sent you the ticket that
> > contains the data above controls the principal mentioned (as in "knows
> > its password")
> > 
> > Now, you can choose what to do with the information above.
> > - you'll most likely need to map the "principal" to a "user", whatever
> > that means for your system (a UID/GID tuple obtained via LDAP? A user
> > string in your own local database?)
> > - you'll have to decide what to do with the session key. Do you want
> > to encrypt all communication? Implement a MAC? Throw it away? See for
> > example the different Kerberos options in NFSv4
> > 
> > In any case as you can see Kerberos is not concerned with
> > authorization at all. How you enforce permissions is out of its
> > scope.
> > 
> > Cheers,
> > Andrea
> > 
> > On 22/10/2014 18:39, Dan Van Der Ster wrote:
> > > Hi Sage,
> > >
> > >> On 16 Oct 2014, at 21:57, Sage Weil <sage@newdream.net> wrote:
> > >>
> > >> I started to write up a blueprint for kerberos / LDAP / AD
> > support:
> > >>
> > >> 
> > https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD_authn%2F%2Fauthz
> > >>
> > >> In case it isn't clear from that document, I only sort of know what
> > I'm 
> > >> talking about here.  (This is largely based on what I managed to
> > retain 
> > >> from a conversation with Andrew, but I suspect I got some of it
> > wrong.)
> > >>
> > >> For anyone working in environments where kerberos is in use, I am
> > *very* 
> > >> interested in hearing what your requirements are for your
> > environment.  In 
> > >> particular, are you using AD or LDAP or something else?  How do you
> > expect 
> > >> RBAC to work for you?
> > > Let?s talk about requirements then. (Anyway, I?m not in any way a
> > kerberos expert and it is not 100% clear to me what you are trying to
> > achieve.)
> > >
> > > Firstly, our environment is almost identical to that described by
> > Marcus (we use AD). For filesystems, our user communities are used to
> > the way OpenAFS works with kerberos. Generally, that means they use
> > kinit && aklog to authenticate and they understand (mostly) how to use
> > AFS groups and AFS ACLs for authz.
> > >
> > > Next I basically have a bunch of questions to clarify your goals.
> > The first part of your blueprint seems to be a convenient way to
> > distribute cephx keyrings. To prevent harvesting/reuse, would you
> > intend those to not be ?normal? cephx keyrings as such, but rather to
> > be keyrings encrypted by the mon/whatever and time limited?
> > >
> > > For authz, is this mechanism meant to be used for RADOS only, or
> > also for CephFS?
> > >
> > > If RADOS only, then as I understand it you could basically add the
> > current cephx capabilities (with pool granularity) to the proposed
> > ceph user db (perhaps scoped down to a few limited roles). I wouldn?t
> > expect to be able to manipulate ceph capabilities via some AD blob
> > (due mostly to my AD ignorance). I would probably expect to add our
> > authorised ceph users to an AD group, then keep that in sync with your
> > ceph user/role/capability db.
> > >
> > > If CephFS, then the problem I see is that the POSIX permissions/ACLs
> > are being evaluated only on the client side. Were you thinking to
> > change that, i.e. to add some notion of CephFS file-granular cephx
> > capabilities? We thought a little bit about this before:
> > >  
> > https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/Strong_AuthN_and_AuthZ_for_CephFS
> > > The basic idea was to have an MDS or other service that evaluates
> > permissions/ACLs on the server side then hands out an extra signed
> > capability to be used by the client for IOs with an OSD. It seems
> > heavyweight, however, so I?m not sure how this would perform in
> > practise.
> > >
> > > Hope that helps,
> > > Dan
> > >
> > >
> > >
> > >
> > >> We'll definitely have a slot for this at the upcoming CDS, but
> > anything we 
> > >> can hash out before then will make that conversation more
> > productive.
> > >>
> > >> Thanks!
> > >> sage
> > >>
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
