From: Andrew Bartlett <abartlet@catalyst.net.nz>
Subject: Re: kerberos / AD requirements, blueprint
Date: Wed, 22 Oct 2014 17:21:29 +1300
Message-ID: <1413951689.9184.3.camel@catalyst.net.nz>
References: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net>
	 <20141017005239.GA31393@soma.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42475 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbaJVEbO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 00:31:14 -0400
In-Reply-To: <20141017005239.GA31393@soma.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mdw@linuxbox.com
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, daniel.vanderster@cern.ch

Thanks Sage and Marcus for writing this up.  I've got a few comments inline:

On Thu, 2014-10-16 at 20:52 -0400, mdw@linuxbox.com wrote:
> On Thu, Oct 16, 2014 at 12:57:12PM -0700, Sage Weil wrote:
> > I started to write up a blueprint for kerberos / LDAP / AD support:
> > 
> > 	https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD_authn%2F%2Fauthz
> > 
> > In case it isn't clear from that document, I only sort of know what I'm 
> > talking about here.  (This is largely based on what I managed to retain 
> > from a conversation with Andrew, but I suspect I got some of it wrong.)
> > 
> > For anyone working in environments where kerberos is in use, I am *very* 
> > interested in hearing what your requirements are for your environment.  In 
> > particular, are you using AD or LDAP or something else?  How do you expect 
> > RBAC to work for you?
> > 

> I don't know any details about what you discussed (other than what
> you have in the document), but I do know kerberos very well, and
> perhaps I can provide background that will help you or others,
> (Some of this is in your document w/ slightly less detail.)
> 
> 1. iaa
> 2. kerberos implementations
> 3. name/id/group lookup
> 4. for ceph
> 

> At a large site, I think you can confidently expect:
> 	or or more large scale deployments of AD,MIT,openldap,etc.
> 	homebrew management system to provision and manage accounts
> 	the filesystem group(s) and the identity management group are separate

Do you see a lot of this beyond major universities and similar sites?  I
ask because at least from my Samba background, I feel like we lost out
in the 2000's against AD, with a good number of very passionate users
waiting patiently for Samba4, but so, so many just running AD from
Microsoft.  The number with OpenLDAP and Kerberos that come past the
Samba lists seemed vanishingly small. 

(I've very glad for our passionate OpenLDAP and Kerberos users, I just
don't see so many of them these days).
 
> ____ 2. kerberos implementations
> 
> For kerberos proper, there are about 4 choices (library-wise):
> 	1. MIT kerberos
> 	2. Heimdal.
> 	3. gssapi
> 	4. microsoft...
> 
> MIT and Heimdal have libraries with many of the same entry point names,
> but with structures that are different and have different field names.
> It's mostly possible but not especially attractive to code for both.
> Having said that, there are attractions to coding directly for this.
> 
> gssapi is the usual community response to the "but you have 2 api's".
> It does give you a single common api, and a higher level view of things.

In my experience, you need to code to both.  You should use GSSAPI, it
is more than just a wrapper, it actually adds a protocol layer, but some
of the things you need to do at the krb5 layer. 

Certainly there are differences, but they have been getting better in
recent years.  The main trick is to require a modern version of MIT
Kerberos or Heimdal, and that means most of the missing functions are
implemented. 

> Microsoft has its own api.  That's one of those "caveats", above.
> Fortunately you probably don't care.
> 
> ____ 3. name/id/group lookup
> 
> Since kerberos "just" does identity/authentication; - you generally need
> a separate id/group lookup function.  Since you are probably going to be
> hooking into somebody else's infrastructure, I think instead of assuming a pac
> or ldap, this is something you want to make at least customizable,
> probably configurable, and possibly pluggable.  Kerberos per se provides
> a name, such as "sageweil@EXAMPLE.COM".  For posix file semantics, you
> would want to map this to a uid=123, group=456, groups=7 8 9.
> 
> One common way to resolve that mapping of name->id info is via ldap,
> and there are standard ldap schemas that let you do that. (posixAccount,
> also posixGroup).  Freeipa almost certainly gives you this "for free".
> For openldap (and nds) this is something you can choose to add.
> 
> AD, being microsoft, -- apparently the samba people have to deal with
> this, and they say that one solution is to install the AD4UNIX schema
> (there's lots more in their samba howto idmapper document,
> https://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/idmapper.html )

I really should help clean up some of those docs, but for this, we don't
need to worry about idmap, because we don't need the users to be in a
posix group, just to have some ceph permissions.  So we just need to
specify a group or a group SID in a config file, and say that these
folks have certain rights, we don't need to do anything related to
POSIX.  Samba can extract the SIDs from the PAC, which helps a lot,
particularly with performance and accuracy. 

I do appreciate you putting some more of the background in writing here.
This is a difficult area with a lot of history, and much folklore :-)

Thanks,

-- 
Andrew Bartlett
http://samba.org/~abartlet/
Authentication Developer, Samba Team  http://samba.org
Samba Developer, Catalyst IT          http://catalyst.net.nz/services/samba




-- 
Andrew Bartlett
http://samba.org/~abartlet/
Authentication Developer, Samba Team  http://samba.org
Samba Developer, Catalyst IT          http://catalyst.net.nz/services/samba




