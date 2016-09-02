From: Marcus Watts <mwatts@redhat.com>
Subject: Re: Cephx kerberization support
Date: Fri, 2 Sep 2016 00:58:07 -0400
Message-ID: <20160902045807.GE10138@degu.eng.arb.redhat.com>
References: <1472006052.10929.0.camel@suse.com>
 <alpine.DEB.2.11.1609011927560.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbcIBE6K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 00:58:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1609011927560.31624@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Daniel Oliveira <doliveira@suse.com>

I think the two most challenging bits of integrating kerberos in w/
ceph will be dealing with authorization and dealing with keytabs.

So the keytab thing is simple.  kerberos entirely uses symmetric
encryption so it requires each host or service have a keytab.  Possession
of the keytab = ability to impersonate anyone (to that host and/or service);
hence needs to be suitably protected.  Deploying an additional osd/mon
requires properly creating or propagating a keytab to that host.  This is
just a provisioning problem, and is not really any different than cephx
of course.

Authorization is more complex.  ldap is one way to go, and particularly
for enterprise environments with lots of users, has lots of obvious
advantages.  So, for external identities, this is certainly what you want.
You probably don't want these things replicated to a "ceph identity"
or have a separate identity database replicating what ldap does for this.
At the same time, you are probably going to want a least a bit of
logic between ldap, because ldap dn's and groups are
not a thing of obvious beauty for storage acls, or, really,
ldap gives you way more rope than you want.

For internal identities (ie, the various bits of ceph as they talk to each
other) - ldap may not be a good choice.  For these you might find a more
special purpose local data store that's probably more strictly internal
to ceph to be appropriate for this.  The choices you make above for
the keytab (per host or per service) will influence your choices here.
If you go with a single global per-service key (no per-host...) for
instance, then you your internal identity authorization needs become
very simple: either it knows the per-service key (and is "god") or it
doesn't.  If you go with finer grained keytabs, then you can be somewhat
more elaborate in your security choices.

					-Marcus Watts
