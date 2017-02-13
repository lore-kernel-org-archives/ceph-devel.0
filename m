From: Daniel Oliveira <doliveira@suse.com>
Subject: Re: Kerberos authentication support
Date: Mon, 13 Feb 2017 11:16:41 -0700
Message-ID: <1487009801.7620.12.camel@suse.com>
References: <21559934-9BF9-4B59-8D60-F492D233AB90@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:33574 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbdBMSQM (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 13 Feb 2017 13:16:12 -0500
In-Reply-To: <21559934-9BF9-4B59-8D60-F492D233AB90@vmware.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Team, 

We have been working on that for the last few weeks and would be more
than glad to have some help/brainstorm on this topic. 
As of now, I am using both LDAP/Kerberos for authentication and already
have a draft that I was supposed to send out last week. 
At time point, we have a simple tree with dc=cephcluster,dc=com and 
 some sub-containers for later user authentication and later
integration with CephFS (ou=users,dc=cephcluster,dc=com), groups (ou=gr
oups,dc=cephcluster,dc=com) and all cluster nodes being represented (ou
=users,dc=cephcluster,dc=com) as server objects (after extending LDAP
schema). Of course, this tree structure could be changed later. 

The setup needed to get LDAP/Kerberos with GSSAPIs and SASL mechanism
(along with TLS so we have it all encrypted) was the part that took
some time/work, but we are now in the process of running a few tests
with KRB5 APIs (MIT) and then start adding code to get some ideas going
on. 

It would be great to have some more people to work on this as well. 

Thanks,
-Daniel 


On Fri, 2017-02-10 at 16:59 -0800, Jonathan Brown wrote:
> Hi,
> 
> I and my colleague Dheeraj Shetty are interested in adding support
> for Kerberos authentication to Ceph.  Although new to Ceph, I have
> worked with Kerberos before and have recently been investigating how
> to implement this feature.  The Ceph notes in this link discuss some
> goals and issues for possible Kerberos authentication support:
> 
> http://pad.ceph.com/p/kerberos
> 
> This looks like a good plan of attack and so we have started down
> that path and now have the authentication exchange working using
> GSSAPI library calls.
> 
> Some comments…
> 
> > > The ceph cluster mons would share a single principal,
> > >  e.g. ceph/mycluster.foo.com
> 
> Normally Kerberos service principals have the format
> <service>/<hostname>@<realm>.  For my initial testing I am using a
> name
> like "ceph-mon/myhost.foo.com" for the separate mon services on
> different machines.  Is there a reason to share a single principal
> instead of the normal Kerberos convention?
> 
> > > let's use the mit library. :)
> 
> Agreed, although I think it would be best to use the GSSAPI C
> -language bindings instead of the MIT krb5 library APIs directly.
> 
> > > - define new auth type (krb5)
> 
> Should the new auth type be named “gssapi” instead?   Note that if
> the code uses GSSAPI bindings, then this auth type could potentially
> be used for mechanisms other than just krb5 by adding plugin
> libraries.
> 
> > > - if negotiated, client would use kerberos lib to get the ticket
> 
> Yes, the user would use a command line tool such as kinit to get the
> initial ticket from the KDC and store it in the credentials cache. 
>  During the authentication exchange the GSSAPI/krb5 libraries would
> get the service ticket and place it in the same cache.  Subsequent
> calls would not need to connect to the KDC again until the tickets
> expire.
> 
> > > - client passes ticket to mon
> 
> This is accomplished by gss_init_sec_context() on the client side and
> gss_accept_sec_context() on the server side.  These functions
> generate GSS tokens containing the krb5 tickets which are then
> encoded by the Ceph client and server into messages sent to their
> peer.
> 
> > > - mon uses kerberosv primitives to authenticate, extract
> > > principal name, etc.
> 
> Yes, but with the GSSAPI library the Ceph code would not need to use
> Kerberos primitives much if at all.
> 
> > > - establish which capabilities to use:
> > >   - mon maps principal name onto a client id, generates a cephx
> > > ticket
> > >   - ldap maps principal to a group/role, which is defined in ceph
> > > auth db  <-- what users probably want to do
> > >   - mon passes cephx ticket (session key etc) back to client
> > >   - client uses cephx thereafter
> 
> We’ll look at how to best accomplish these and other issues next. 
>  But I think we have a good start on how to implement this feature
> and look forward to contributing to Ceph project.  Please let me know
> if you have any advice on how you would like to see this feature
> implemented.  As we gain more experience with Ceph I’m sure we’ll
> understand the issues better.  Thanks!
> 
> Jonathan Brown
> brownj@vmware.com
> 
> Dheeraj Shetty
> dheerajs@vmware.com
> 
> 
> 
> What follows are some example of commands run from my dev
> environment.  I have configured a krb5.conf file to point to an MIT
> kdc, and service principal keys have been extracted to krb5.keytab. 
>  My ceph.conf included these global config entries:
> 
>         auth cluster required = cephx
>         auth service required = gssapi
>         auth client required = gssapi
> 
> 
> EXAMPLE: running “ceph health” without a Kerberos TGT:
> 
> brownj@ceph-dev:~/ceph/build$ kdestroy
> brownj@ceph-dev:~/ceph/build$ bin/ceph health
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 2017-02-10 15:46:55.038277 7ff8654d4700 -1 WARNING: all dangerous and
> experimental features are enabled.
> 2017-02-10 15:46:55.046886 7ff8654d4700 -1 WARNING: all dangerous and
> experimental features are enabled.
> 2017-02-10 15:46:55.093679 7ff85ca9f700  0 gssapi client: Unspecified
> GSS failure.  Minor code may provide more information
> 2017-02-10 15:46:55.093836 7ff8654d4700  0 librados: client.admin
> authentication error (1) Operation not permitted
> Error connecting to cluster: PermissionError
> brownj@ceph-dev:~/ceph/build$
> 
> 
> EXAMPLE: running “ceph health" with an expired TGT:
> 
> brownj@ceph-dev:~/ceph/build$ kinit -l 2
> Password for client.admin@CEPHTEST.LOCAL:
> brownj@ceph-dev:~/ceph/build$ klist
> Ticket cache: FILE:/tmp/krb5cc_1000
> Default principal: client.admin@CEPHTEST.LOCAL
> 
> Valid starting     Expires            Service principal
> 02/10/17 15:47:46  02/10/17 15:47:44  
> krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
> brownj@ceph-dev:~/ceph/build$ bin/ceph health
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 2017-02-10 15:47:57.273595 7facdd15e700 -1 WARNING: all dangerous and
> experimental features are enabled.
> 2017-02-10 15:47:57.282475 7facdd15e700 -1 WARNING: all dangerous and
> experimental features are enabled.
> 2017-02-10 15:47:57.298276 7facd485d700  0 gssapi client: The
> referenced credential has expired
> 2017-02-10 15:47:57.298387 7facdd15e700  0 librados: client.admin
> authentication error (1) Operation not permitted
> Error connecting to cluster: PermissionError
> brownj@ceph-dev:~/ceph/build$
> 
> 
> EXAMPLE: running “ceph health” with a valid TGT:
> 
> brownj@ceph-dev:~/ceph/build$ kinit
> Password for client.admin@CEPHTEST.LOCAL:
> brownj@ceph-dev:~/ceph/build$ klist
> Ticket cache: FILE:/tmp/krb5cc_1000
> Default principal: client.admin@CEPHTEST.LOCAL
> 
> Valid starting     Expires            Service principal
> 02/10/17 15:49:13  02/11/17 01:49:13  
> krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
>         renew until 02/11/17 15:49:09
> brownj@ceph-dev:~/ceph/build$ bin/ceph health
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 2017-02-10 15:49:21.057358 7fcd09af8700 -1 WARNING: all dangerous and
> experimental features are enabled.
> 2017-02-10 15:49:21.064644 7fcd08ab6700 -1 WARNING: all dangerous and
> experimental features are enabled.
> HEALTH_OK
> brownj@ceph-dev:~/ceph/build$ klist
> Ticket cache: FILE:/tmp/krb5cc_1000
> Default principal: client.admin@CEPHTEST.LOCAL
> 
> Valid starting     Expires            Service principal
> 02/10/17 15:49:13  02/11/17 01:49:13  
> krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
>         renew until 02/11/17 15:49:09
> 02/10/17 15:49:21  02/11/17 01:49:13  ceph-mon/ceph-dev@
>         renew until 02/11/17 15:49:09
> 02/10/17 15:49:21  02/11/17 01:49:13  
> ceph-mon/ceph-dev@CEPHTEST.LOCAL
>         renew until 02/11/17 15:49:09
> brownj@ceph-dev:~/ceph/build$
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
