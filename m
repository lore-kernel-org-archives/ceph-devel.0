From: Sage Weil <sage@newdream.net>
Subject: Re: Cephx kerberization support
Date: Thu, 1 Sep 2016 19:41:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609011927560.31624@piezo.us.to>
References: <1472006052.10929.0.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41233 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbcIAU7d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2016 16:59:33 -0400
In-Reply-To: <1472006052.10929.0.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Oliveira <doliveira@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Daniel,

On Tue, 23 Aug 2016, Daniel Oliveira wrote:
> Hi All,  
> 
> We have been *brainstorming* on how to get "Cephx kerberization
> support" done. From the initial ideas: a) GSSAPI based protocol; b)
> Some sort of native Krb5 Cephx support, which means a need for a Krb5
> authorizer along with some channel bindings (due to ULP principals),
> where the latter seems to be a good/best approach.
> 
> As this is an important topic and we would like to discuss it during
> our next CDM, your ideas and interest are greatly appreciated. 

Looking forward to it!

Kerberization is a pretty broad project.  FWIW I see it breaking down into 
several pieces/steps/possibilities:

1. Create a krb[5] auth method (alongside cephx and none) that can be used 
for authentication with the monitor.  That is, the client will use the krb 
library to get a ticket, send it over the wire to the monitor, and the 
monitor will use the library to authenticate it.  

Questions:
 - how do we map the kerberos identity to a ceph identity?

2. Static mapping support: have some configuration in the mon that maps 
your kerberos identity onto a ceph user so that you get their 
capabilities.  Maybe it's client.krb.$id or something, or maybe there is 
some mapping table?

3. LDAP support.  Have the mon look up the identity w/ LDAP to determine 
either (a) what your ceph capability are or (b) what group/user defined in 
cephx we can map you to to inherit their capabilities.  For (a), that 
would mean the caps go directly in LDAP (e.g., osd = allow rw, mds = allow 
r).  For (b), we'd probably map the kerberos identity to a predefined role 
(e.g., client.role.foo) that is defined the capabilities in the mon auth 
database.

4. Parse the ActiveDirectory PAC (?) so that we extra our group membership 
or capabilities from that directly.

For a minimal demonstration I think we need #1 and any of #2-4.  This 
would let a krb person on the command line invoke the ceph CLI for basic 
admin operations.

5. Have the mon then switch to cephx for the remainder of the session.  
This would make the whole thing useful for operations beyond the monitor 
(e.g., rbd CLI) with minimal additional work.

6. Full kerberos support for client/daemon auth.  This involves generating 
and authenticating a few different types of tickets, including creating 
the rotating tickets the daemons use.  It would fully replace/displace 
the cephx auth code.  This is probably where we'd want to end up on the 
cluster side.

7. CephFS support.  This is complicated because a host mounts the file 
system, but individual kerberos-authenticated users will come and go.  
The client->MDS protocol will need to be extended to set up and tear down 
these authenticated identities, map requests to an authorized user, etc.


I suspect we should start with #1 and #2 since it's the simplest to get 
going.  Then #3.  This will require lots of discussion around design since 
we'd need to figure out how to define group membership or raw capabilities 
in the LDAP schema.  Whether we do #5 or #6 depends on how weird it'd be 
for the client to switch between auth methods and whether we think #6 
(full kerberization) is inevitable.

What am I missing?

Thanks!
sage
