From: Sage Weil <sage@newdream.net>
Subject: Re: Cephx kerberization support
Date: Fri, 2 Sep 2016 14:14:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609021406210.31624@piezo.us.to>
References: <1472006052.10929.0.camel@suse.com> <alpine.DEB.2.11.1609011927560.31624@piezo.us.to> <20160902045807.GE10138@degu.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45721 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbcIBOOm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2016 10:14:42 -0400
In-Reply-To: <20160902045807.GE10138@degu.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: ceph-devel@vger.kernel.org, Daniel Oliveira <doliveira@suse.com>

On Fri, 2 Sep 2016, Marcus Watts wrote:
> I think the two most challenging bits of integrating kerberos in w/
> ceph will be dealing with authorization and dealing with keytabs.
> 
> So the keytab thing is simple.  kerberos entirely uses symmetric
> encryption so it requires each host or service have a keytab.  Possession
> of the keytab = ability to impersonate anyone (to that host and/or service);
> hence needs to be suitably protected.  Deploying an additional osd/mon
> requires properly creating or propagating a keytab to that host.  This is
> just a provisioning problem, and is not really any different than cephx
> of course.

Yeah, AFAICS this is equivalent to the current ceph keyring.

> Authorization is more complex.  ldap is one way to go, and particularly
> for enterprise environments with lots of users, has lots of obvious
> advantages.  So, for external identities, this is certainly what you want.
> You probably don't want these things replicated to a "ceph identity"
> or have a separate identity database replicating what ldap does for this.
> At the same time, you are probably going to want a least a bit of
> logic between ldap, because ldap dn's and groups are
> not a thing of obvious beauty for storage acls, or, really,
> ldap gives you way more rope than you want.

Yeah.  Again, I see several options here:

1) No LDAP.  Create a ceph auth entry for each kerberos identity.  Trivial 
but lame.

2) LDAP maps identity into a dn/group whatever.  Create a ceph auth 
entry for the dn/group (role).

3) ActiveDirectory PAC(?).  It sounds like this is also not well defined.

I think #2 is probably the most useful/promising.  And hopefully even 
with AD there is some standardish way to map an identity into a group 
in the PAC payload that could be used?

> For internal identities (ie, the various bits of ceph as they talk to each
> other) - ldap may not be a good choice.  For these you might find a more
> special purpose local data store that's probably more strictly internal
> to ceph to be appropriate for this.  The choices you make above for
> the keytab (per host or per service) will influence your choices here.
> If you go with a single global per-service key (no per-host...) for
> instance, then you your internal identity authorization needs become
> very simple: either it knows the per-service key (and is "god") or it
> doesn't.  If you go with finer grained keytabs, then you can be somewhat
> more elaborate in your security choices.

Even with cephx there are two types of keys/tickets.  Each daemon has a 
fixed symmetric key that it uses to authenticate itself.  Then there is a 
rotate globalish "service key" that is shared amongst all OSDs (or MDSs) 
that clients tickets are authenticated against.  With cephx we rotate it 
every hour or something.

I'm guessing we want to do essentially the same thing, but just use the 
kerberos libraries to create the keys and tickets.  We can reuse all of 
the existing infrastructure for handling key rotation and so on.  The 
service keys are only kept in RAM on the daemons, so I don't think keytabs 
needs to get involved, although I suppose that depends on how the kerberos 
library API is used when you're asking it to authenticate a ticket 
we got from a client...

sage
