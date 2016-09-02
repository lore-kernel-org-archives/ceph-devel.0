From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Cephx kerberization support
Date: Fri, 2 Sep 2016 13:26:20 -0400 (EDT)
Message-ID: <537540660.80427421.1472837180448.JavaMail.zimbra@redhat.com>
References: <1472006052.10929.0.camel@suse.com> <alpine.DEB.2.11.1609011927560.31624@piezo.us.to> <20160902045807.GE10138@degu.eng.arb.redhat.com> <alpine.DEB.2.11.1609021406210.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:59550 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbcIBR0Y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2016 13:26:24 -0400
In-Reply-To: <alpine.DEB.2.11.1609021406210.31624@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Marcus Watts <mwatts@redhat.com>, ceph-devel@vger.kernel.org, Daniel Oliveira <doliveira@suse.com>

Hi,

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Marcus Watts" <mwatts@redhat.com>
> Cc: ceph-devel@vger.kernel.org, "Daniel Oliveira" <doliveira@suse.com>
> Sent: Friday, September 2, 2016 10:14:38 AM
> Subject: Re: Cephx kerberization support
> 

> 
> 3) ActiveDirectory PAC(?).  It sounds like this is also not well defined.

The PAC is well defined (though extensions from Kitten WG are more expansive), but iiuc, per se it's a means for propagating group (PAC) or other (e.g., SAML?, Kitten/cammac) authorization data in the tickets not an authorization schema per se.  I'm not certain if cammac really exists yet, and as regards PAC, we'd I guess need an AD implementation, which is probably more and less than we want to require.  otoh, it's not implausible (e.g., samba4 brings one).

> 
> I think #2 is probably the most useful/promising.  And hopefully even
> with AD there is some standardish way to map an identity into a group
> in the PAC payload that could be used?

I think MS PAC fully defines it--but non-AD environments won't have the sids and other attributes that ISTR it mainly contains.  I think for non-AD cammac we'd be free to import what we like (though I think this is blue sky), but it would be possible for services to query whatever the underlying setup (e.g, LDAP dit) for authz when !MS PAC.  That's what what AFS and DCE do, at any rate.

> 
> > For internal identities (ie, the various bits of ceph as they talk to each
> > other) - ldap may not be a good choice.  For these you might find a more
> > special purpose local data store that's probably more strictly internal
> > to ceph to be appropriate for this.  The choices you make above for
> > the keytab (per host or per service) will influence your choices here.
> > If you go with a single global per-service key (no per-host...) for
> > instance, then you your internal identity authorization needs become
> > very simple: either it knows the per-service key (and is "god") or it
> > doesn't.  If you go with finer grained keytabs, then you can be somewhat
> > more elaborate in your security choices.
> 
> Even with cephx there are two types of keys/tickets.  Each daemon has a
> fixed symmetric key that it uses to authenticate itself.  Then there is a
> rotate globalish "service key" that is shared amongst all OSDs (or MDSs)
> that clients tickets are authenticated against.  With cephx we rotate it
> every hour or something.
> 
> I'm guessing we want to do essentially the same thing, but just use the
> kerberos libraries to create the keys and tickets.  We can reuse all of
> the existing infrastructure for handling key rotation and so on.  The
> service keys are only kept in RAM on the daemons, so I don't think keytabs
> needs to get involved, although I suppose that depends on how the kerberos
> library API is used when you're asking it to authenticate a ticket
> we got from a client...

That would be a pretty unusual way to integrate things (preventing use of existing tools, among other things), fwiw.

> 
> sage

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
