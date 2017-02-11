From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Kerberos authentication support
Date: Sat, 11 Feb 2017 17:52:23 -0500 (EST)
Message-ID: <31641866.104706495.1486853543863.JavaMail.zimbra@redhat.com>
References: <21559934-9BF9-4B59-8D60-F492D233AB90@vmware.com> <alpine.DEB.2.11.1702111553070.7782@piezo.novalocal> <478501363.104632093.1486850984840.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:37435 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdBKWwZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Feb 2017 17:52:25 -0500
In-Reply-To: <478501363.104632093.1486850984840.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jonathan Brown <brownj@vmware.com>, ceph-devel@vger.kernel.org

(that's not an argument;  in general, gssapi has been the preferred style of modern protocols including nfsv4;  it probably makes sense to use it;  the likelihood of non-kerberos mechs appearing now seems less than the prior email in this thread implied, tho [the only one I know of is lipkey, and I think it has been revoked?])

Matt

----- Original Message -----
> From: "Matt Benjamin" <mbenjamin@redhat.com>
> To: "Sage Weil" <sage@newdream.net>
> Cc: "Jonathan Brown" <brownj@vmware.com>, ceph-devel@vger.kernel.org
> Sent: Saturday, February 11, 2017 5:09:44 PM
> Subject: Re: Kerberos authentication support
> 
> Hi,
> 
> ----- Original Message -----
> > From: "Sage Weil" <sage@newdream.net>
> > To: "Jonathan Brown" <brownj@vmware.com>
> > Cc: ceph-devel@vger.kernel.org
> > Sent: Saturday, February 11, 2017 10:57:38 AM
> > Subject: Re: Kerberos authentication support
> > 
> > On Fri, 10 Feb 2017, Jonathan Brown wrote:
> > > Hi,
> > > 
> > > I and my colleague Dheeraj Shetty are interested in adding support for
> > > Kerberos authentication to Ceph.  Although new to Ceph, I have worked
> > > with Kerberos before and have recently been investigating how to
> > > implement this feature.  The Ceph notes in this link discuss some goals
> > > and issues for possible Kerberos authentication support:
> > > 
> > > http://pad.ceph.com/p/kerberos
> > > 
> > > This looks like a good plan of attack and so we have started down that
> > > path and now have the authentication exchange working using GSSAPI
> > > library calls.
> > > 
> > > Some comments…
> > > 
> > > >> The ceph cluster mons would share a single principal,
> > > >>  e.g. ceph/mycluster.foo.com
> > > 
> > > Normally Kerberos service principals have the format
> > > <service>/<hostname>@<realm>.  For my initial testing I am using a name
> > > like "ceph-mon/myhost.foo.com" for the separate mon services on
> > > different machines.  Is there a reason to share a single principal
> > > instead of the normal Kerberos convention?
> > 
> > I think so.  The mons operate as a cluster and are collectively available
> > even when one or more has failed.  I would suggest a convention in which
> > the domain is a logical cluster name (e.g., a dns name with an A/AAAA
> > record for each monitor).
> > 
> > > >> let's use the mit library. :)
> > > 
> > > Agreed, although I think it would be best to use the GSSAPI C-language
> > > bindings instead of the MIT krb5 library APIs directly.
> > > 
> > > >> - define new auth type (krb5)
> > > 
> > > Should the new auth type be named “gssapi” instead?  Note that if the
> > > code uses GSSAPI bindings, then this auth type could potentially be used
> > > for mechanisms other than just krb5 by adding plugin libraries.
> > 
> > Sure
> 
> To be honest, I'd be happier to see a kerberos flavor that used kerberos
> primitives.
> 
> > 
> > > >> - if negotiated, client would use kerberos lib to get the ticket
> > > 
> > > Yes, the user would use a command line tool such as kinit to get the
> > > initial ticket from the KDC and store it in the credentials cache.
> > > During the authentication exchange the GSSAPI/krb5 libraries would get
> > > the service ticket and place it in the same cache.  Subsequent calls
> > > would not need to connect to the KDC again until the tickets expire.
> > > 
> > > >> - client passes ticket to mon
> > > 
> > > This is accomplished by gss_init_sec_context() on the client side and
> > > gss_accept_sec_context() on the server side.  These functions generate
> > > GSS tokens containing the krb5 tickets which are then encoded by the
> > > Ceph client and server into messages sent to their peer.
> > 
> > Sounds good!
> > 
> > > >> - mon uses kerberosv primitives to authenticate, extract principal
> > > >> name, etc.
> > > 
> > > Yes, but with the GSSAPI library the Ceph code would not need to use
> > > Kerberos primitives much if at all.
> > 
> > +1
> > 
> > > >> - establish which capabilities to use:
> > > >>   - mon maps principal name onto a client id, generates a cephx ticket
> > > >>   - ldap maps principal to a group/role, which is defined in ceph auth
> > > >>   db  <-- what users probably want to do
> > > >>   - mon passes cephx ticket (session key etc) back to client
> > > >>   - client uses cephx thereafter
> > > 
> > > We’ll look at how to best accomplish these and other issues next.  But I
> > > think we have a good start on how to implement this feature and look
> > > forward to contributing to Ceph project.  Please let me know if you have
> > > any advice on how you would like to see this feature implemented.  As we
> > > gain more experience with Ceph I’m sure we’ll understand the issues
> > > better.  Thanks!
> > 
> > Great!  Thank for you taking this one!  The auth code is a bit crufty,
> > especially with the mon integration, so please reach out here on
> > ceph-devel or in #ceph-devel with any questions.
> > 
> > sage
> 
> Matt
> 
> > 
> > 
> > 
> > > 
> > > Jonathan Brown
> > > brownj@vmware.com
> > > 
> > > Dheeraj Shetty
> > > dheerajs@vmware.com
> > > 
> > > 
> > > 
> > > What follows are some example of commands run from my dev environment.  I
> > > have configured a krb5.conf file to point to an MIT kdc, and service
> > > principal keys have been extracted to krb5.keytab.  My ceph.conf included
> > > these global config entries:
> > > 
> > >         auth cluster required = cephx
> > >         auth service required = gssapi
> > >         auth client required = gssapi
> > > 
> > > 
> > > EXAMPLE: running “ceph health” without a Kerberos TGT:
> > > 
> > > brownj@ceph-dev:~/ceph/build$ kdestroy
> > > brownj@ceph-dev:~/ceph/build$ bin/ceph health
> > > *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> > > 2017-02-10 15:46:55.038277 7ff8654d4700 -1 WARNING: all dangerous and
> > > experimental features are enabled.
> > > 2017-02-10 15:46:55.046886 7ff8654d4700 -1 WARNING: all dangerous and
> > > experimental features are enabled.
> > > 2017-02-10 15:46:55.093679 7ff85ca9f700  0 gssapi client: Unspecified GSS
> > > failure.  Minor code may provide more information
> > > 2017-02-10 15:46:55.093836 7ff8654d4700  0 librados: client.admin
> > > authentication error (1) Operation not permitted
> > > Error connecting to cluster: PermissionError
> > > brownj@ceph-dev:~/ceph/build$
> > > 
> > > 
> > > EXAMPLE: running “ceph health" with an expired TGT:
> > > 
> > > brownj@ceph-dev:~/ceph/build$ kinit -l 2
> > > Password for client.admin@CEPHTEST.LOCAL:
> > > brownj@ceph-dev:~/ceph/build$ klist
> > > Ticket cache: FILE:/tmp/krb5cc_1000
> > > Default principal: client.admin@CEPHTEST.LOCAL
> > > 
> > > Valid starting     Expires            Service principal
> > > 02/10/17 15:47:46  02/10/17 15:47:44
> > > krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
> > > brownj@ceph-dev:~/ceph/build$ bin/ceph health
> > > *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> > > 2017-02-10 15:47:57.273595 7facdd15e700 -1 WARNING: all dangerous and
> > > experimental features are enabled.
> > > 2017-02-10 15:47:57.282475 7facdd15e700 -1 WARNING: all dangerous and
> > > experimental features are enabled.
> > > 2017-02-10 15:47:57.298276 7facd485d700  0 gssapi client: The referenced
> > > credential has expired
> > > 2017-02-10 15:47:57.298387 7facdd15e700  0 librados: client.admin
> > > authentication error (1) Operation not permitted
> > > Error connecting to cluster: PermissionError
> > > brownj@ceph-dev:~/ceph/build$
> > > 
> > > 
> > > EXAMPLE: running “ceph health” with a valid TGT:
> > > 
> > > brownj@ceph-dev:~/ceph/build$ kinit
> > > Password for client.admin@CEPHTEST.LOCAL:
> > > brownj@ceph-dev:~/ceph/build$ klist
> > > Ticket cache: FILE:/tmp/krb5cc_1000
> > > Default principal: client.admin@CEPHTEST.LOCAL
> > > 
> > > Valid starting     Expires            Service principal
> > > 02/10/17 15:49:13  02/11/17 01:49:13
> > > krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
> > >         renew until 02/11/17 15:49:09
> > > brownj@ceph-dev:~/ceph/build$ bin/ceph health
> > > *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> > > 2017-02-10 15:49:21.057358 7fcd09af8700 -1 WARNING: all dangerous and
> > > experimental features are enabled.
> > > 2017-02-10 15:49:21.064644 7fcd08ab6700 -1 WARNING: all dangerous and
> > > experimental features are enabled.
> > > HEALTH_OK
> > > brownj@ceph-dev:~/ceph/build$ klist
> > > Ticket cache: FILE:/tmp/krb5cc_1000
> > > Default principal: client.admin@CEPHTEST.LOCAL
> > > 
> > > Valid starting     Expires            Service principal
> > > 02/10/17 15:49:13  02/11/17 01:49:13
> > > krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
> > >         renew until 02/11/17 15:49:09
> > > 02/10/17 15:49:21  02/11/17 01:49:13  ceph-mon/ceph-dev@
> > >         renew until 02/11/17 15:49:09
> > > 02/10/17 15:49:21  02/11/17 01:49:13  ceph-mon/ceph-dev@CEPHTEST.LOCAL
> > >         renew until 02/11/17 15:49:09
> > > brownj@ceph-dev:~/ceph/build$
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > >
> 
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://www.redhat.com/en/technologies/storage
> 
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
