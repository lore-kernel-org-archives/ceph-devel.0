From: mdw@linuxbox.com
Subject: Re: kerberos / AD requirements, blueprint
Date: Thu, 16 Oct 2014 20:52:40 -0400
Message-ID: <20141017005239.GA31393@soma.private.linuxbox.com>
References: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4373 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaJQAw5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Oct 2014 20:52:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, daniel.vanderster@cern.ch, abartlet@catalyst.net.nz

On Thu, Oct 16, 2014 at 12:57:12PM -0700, Sage Weil wrote:
> I started to write up a blueprint for kerberos / LDAP / AD support:
> 
> 	https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD_authn%2F%2Fauthz
> 
> In case it isn't clear from that document, I only sort of know what I'm 
> talking about here.  (This is largely based on what I managed to retain 
> from a conversation with Andrew, but I suspect I got some of it wrong.)
> 
> For anyone working in environments where kerberos is in use, I am *very* 
> interested in hearing what your requirements are for your environment.  In 
> particular, are you using AD or LDAP or something else?  How do you expect 
> RBAC to work for you?
> 
> We'll definitely have a slot for this at the upcoming CDS, but anything we 
> can hash out before then will make that conversation more productive.
> 
> Thanks!
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I don't know any details about what you discussed (other than what
you have in the document), but I do know kerberos very well, and
perhaps I can provide background that will help you or others,
(Some of this is in your document w/ slightly less detail.)

1. iaa
2. kerberos implementations
3. name/id/group lookup
4. for ceph

____ 1. iaa

So, you mention kerberos, AD, LDAP -- these are somewhat separable,
and probably ought to be separated for what you do:

general acronym for all three is IAA:
	I	-identity
	A	-authentication		(N)
	A	-authorization		(Z)
kerberos does identity/authentication, period.  Does not do authorization
at all, period, full stop.  ( Yes, "AD" makes a "pac" inside a kerberos
ticket, that can provide authorization data.  More on that in a bit. )

Ldap is a protocol to access a database that can contain identities,
group information, + other stuff.  Does not really do authentication at
all, can do half of the authorization job.

AD is a specific product from microsoft.  It provides both kerberos
infrastructure (server, libraries) + ldap.  There are other products that
provide various parts of this - including of course freeipa from redhat.
AD certainly has a lot more industry uptake than freeipa.  But most
of that is microsoft-centric, with all the caveats that entails.
Some places may have nds which does ldap and has kerberos support.
There are also plenty of people, including some large sites, who run
MIT kerberos and openldap.

At a large site, I think you can confidently expect:
	or or more large scale deployments of AD,MIT,openldap,etc.
	homebrew management system to provision and manage accounts
	the filesystem group(s) and the identity management group are separate

____ 2. kerberos implementations

For kerberos proper, there are about 4 choices (library-wise):
	1. MIT kerberos
	2. Heimdal.
	3. gssapi
	4. microsoft...

MIT and Heimdal have libraries with many of the same entry point names,
but with structures that are different and have different field names.
It's mostly possible but not especially attractive to code for both.
Having said that, there are attractions to coding directly for this.

gssapi is the usual community response to the "but you have 2 api's".
It does give you a single common api, and a higher level view of things.

Microsoft has its own api.  That's one of those "caveats", above.
Fortunately you probably don't care.

____ 3. name/id/group lookup

Since kerberos "just" does identity/authentication; - you generally need
a separate id/group lookup function.  Since you are probably going to be
hooking into somebody else's infrastructure, I think instead of assuming a pac
or ldap, this is something you want to make at least customizable,
probably configurable, and possibly pluggable.  Kerberos per se provides
a name, such as "sageweil@EXAMPLE.COM".  For posix file semantics, you
would want to map this to a uid=123, group=456, groups=7 8 9.

One common way to resolve that mapping of name->id info is via ldap,
and there are standard ldap schemas that let you do that. (posixAccount,
also posixGroup).  Freeipa almost certainly gives you this "for free".
For openldap (and nds) this is something you can choose to add.

AD, being microsoft, -- apparently the samba people have to deal with
this, and they say that one solution is to install the AD4UNIX schema
(there's lots more in their samba howto idmapper document,
https://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/idmapper.html )

AD natively provides group information to microsoft applications.
This is encoded in the "PAC" structure of service tickets issued
by AD.  MicroSoft group information does not exactly translate
to posix uid/gid type information, so this is not necessarily
exactly what you want, especially in a Unix environment.
More about PAC's here,
http://blogs.msdn.com/b/openspecification/archive/2009/04/24/understanding-microsoft-kerberos-pac-validation.aspx

Other filesystems: nfsv4 has something called "idmap" that often
resolves this from the local host /etc/passwd /etc/group.  afs has the
"protection service", protocol is called "prot", but most people know
this as pts or ptserver.  And then there are always other "homebrew"
choices such as mysql etc.

And lastly, since you have a "user db" - working with kerberos
*without* ldap/ad/whatever - should be doable too.

____ 4. for ceph

So for ceph, you appear to be proposing a "cephx" ticket issuing service
that relies on kerberos tickets.  That should be easy -- gssapi or mit lib
are probably your obvious choices here; either will work.

The "k5/cephx" service has a choice of ways to resolve group/id information.
An ldap lookup for posixaccount/group, maybe ad4unix seem reasonable.
MicroSoft pac is harder and has tradeoffs, but probably doable.
Providing this as a pluggable interface with examples could provide
people with additional choices and the option for whatever.

You mention the ceph user db -- one option you probably also want
here is an "autoregistration" mechanism to add people to the userdb - for
people coming in via kerberos who weren't seen before.  Probably you
want to worry about membership changes too if you do this.

I haven't gone through cephx in detail, but my naive impression is that
it does not provide a particularly robust assurance that user id 123
is really user id 123.  You might want ways to turn off the ability of
random clients/servers from creating cephx tickets without going through
kerberos or some other stronger means of identity assurance.

				- Marcus Watts
