From: Jonathan Brown <brownj@vmware.com>
Subject: Re: Kerberos authentication support
Date: Mon, 13 Feb 2017 11:59:52 -0800
Message-ID: <34B59BAC-6460-467B-B7F9-44E957C2DF87@vmware.com>
References: <21559934-9BF9-4B59-8D60-F492D233AB90@vmware.com> <1487009801.7620.12.camel@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:30304
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753039AbdBMTz7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 14:55:59 -0500
In-Reply-To: <1487009801.7620.12.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Oliveira <doliveira@suse.com>
Cc: ceph-devel@vger.kernel.org

Hi Daniel,

Great!  I would be happy to work together with you on this. Please let =
me know how I can help.

Jonathan

> On Feb 13, 2017, at 10:16 AM, Daniel Oliveira <doliveira@suse.com> =
wrote:
>=20
> Team,=20
>=20
> We have been working on that for the last few weeks and would be more
> than glad to have some help/brainstorm on this topic.=20
> As of now, I am using both LDAP/Kerberos for authentication and =
already
> have a draft that I was supposed to send out last week.=20
> At time point, we have a simple tree with dc=3Dcephcluster,dc=3Dcom =
and=20
> some sub-containers for later user authentication and later
> integration with CephFS (ou=3Dusers,dc=3Dcephcluster,dc=3Dcom), groups =
(ou=3Dgr
> oups,dc=3Dcephcluster,dc=3Dcom) and all cluster nodes being =
represented (ou
> =3Dusers,dc=3Dcephcluster,dc=3Dcom) as server objects (after extending =
LDAP
> schema). Of course, this tree structure could be changed later.=20
>=20
> The setup needed to get LDAP/Kerberos with GSSAPIs and SASL mechanism
> (along with TLS so we have it all encrypted) was the part that took
> some time/work, but we are now in the process of running a few tests
> with KRB5 APIs (MIT) and then start adding code to get some ideas =
going
> on.=20
>=20
> It would be great to have some more people to work on this as well.=20
>=20
> Thanks,
> -Daniel=20
>=20
>=20
> On Fri, 2017-02-10 at 16:59 -0800, Jonathan Brown wrote:
>> Hi,
>>=20
>> I and my colleague Dheeraj Shetty are interested in adding support
>> for Kerberos authentication to Ceph.  Although new to Ceph, I have
>> worked with Kerberos before and have recently been investigating how
>> to implement this feature.  The Ceph notes in this link discuss some
>> goals and issues for possible Kerberos authentication support:
>>=20
>> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__pad.ceph.com_p_kerbe=
ros&d=3DDwIDaQ&c=3DuilaK90D4TOVoH58JNXRgQ&r=3D9JpL_PPbYk8fhbjUYVOfRoj1Yf9o=
qcTvfmy_8Eq7yqw&m=3DUIHzULmLANrtmpzTH2FgbeDBQyRMxljmjvk8B99pa34&s=3DY6irxV=
m3yslQOzqfhhJGH0jtxtBaQkiY0ddEd5vypKI&e=3D=20
>>=20
>> This looks like a good plan of attack and so we have started down
>> that path and now have the authentication exchange working using
>> GSSAPI library calls.
>>=20
>> Some comments=E2=80=A6
>>=20
>>>> The ceph cluster mons would share a single principal,
>>>> e.g. ceph/mycluster.foo.com
>>=20
>> Normally Kerberos service principals have the format
>> <service>/<hostname>@<realm>.  For my initial testing I am using a
>> name
>> like "ceph-mon/myhost.foo.com" for the separate mon services on
>> different machines.  Is there a reason to share a single principal
>> instead of the normal Kerberos convention?
>>=20
>>>> let's use the mit library. :)
>>=20
>> Agreed, although I think it would be best to use the GSSAPI C
>> -language bindings instead of the MIT krb5 library APIs directly.
>>=20
>>>> - define new auth type (krb5)
>>=20
>> Should the new auth type be named =E2=80=9Cgssapi=E2=80=9D instead?   =
Note that if
>> the code uses GSSAPI bindings, then this auth type could potentially
>> be used for mechanisms other than just krb5 by adding plugin
>> libraries.
>>=20
>>>> - if negotiated, client would use kerberos lib to get the ticket
>>=20
>> Yes, the user would use a command line tool such as kinit to get the
>> initial ticket from the KDC and store it in the credentials cache.=20
>> During the authentication exchange the GSSAPI/krb5 libraries would
>> get the service ticket and place it in the same cache.  Subsequent
>> calls would not need to connect to the KDC again until the tickets
>> expire.
>>=20
>>>> - client passes ticket to mon
>>=20
>> This is accomplished by gss_init_sec_context() on the client side and
>> gss_accept_sec_context() on the server side.  These functions
>> generate GSS tokens containing the krb5 tickets which are then
>> encoded by the Ceph client and server into messages sent to their
>> peer.
>>=20
>>>> - mon uses kerberosv primitives to authenticate, extract
>>>> principal name, etc.
>>=20
>> Yes, but with the GSSAPI library the Ceph code would not need to use
>> Kerberos primitives much if at all.
>>=20
>>>> - establish which capabilities to use:
>>>>  - mon maps principal name onto a client id, generates a cephx
>>>> ticket
>>>>  - ldap maps principal to a group/role, which is defined in ceph
>>>> auth db  <-- what users probably want to do
>>>>  - mon passes cephx ticket (session key etc) back to client
>>>>  - client uses cephx thereafter
>>=20
>> We=E2=80=99ll look at how to best accomplish these and other issues =
next.=20
>> But I think we have a good start on how to implement this feature
>> and look forward to contributing to Ceph project.  Please let me know
>> if you have any advice on how you would like to see this feature
>> implemented.  As we gain more experience with Ceph I=E2=80=99m sure =
we=E2=80=99ll
>> understand the issues better.  Thanks!
>>=20
>> Jonathan Brown
>> brownj@vmware.com
>>=20
>> Dheeraj Shetty
>> dheerajs@vmware.com
>>=20
>>=20
>>=20
>> What follows are some example of commands run from my dev
>> environment.  I have configured a krb5.conf file to point to an MIT
>> kdc, and service principal keys have been extracted to krb5.keytab.=20=

>> My ceph.conf included these global config entries:
>>=20
>>        auth cluster required =3D cephx
>>        auth service required =3D gssapi
>>        auth client required =3D gssapi
>>=20
>>=20
>> EXAMPLE: running =E2=80=9Cceph health=E2=80=9D without a Kerberos =
TGT:
>>=20
>> brownj@ceph-dev:~/ceph/build$ kdestroy
>> brownj@ceph-dev:~/ceph/build$ bin/ceph health
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> 2017-02-10 15:46:55.038277 7ff8654d4700 -1 WARNING: all dangerous and
>> experimental features are enabled.
>> 2017-02-10 15:46:55.046886 7ff8654d4700 -1 WARNING: all dangerous and
>> experimental features are enabled.
>> 2017-02-10 15:46:55.093679 7ff85ca9f700  0 gssapi client: Unspecified
>> GSS failure.  Minor code may provide more information
>> 2017-02-10 15:46:55.093836 7ff8654d4700  0 librados: client.admin
>> authentication error (1) Operation not permitted
>> Error connecting to cluster: PermissionError
>> brownj@ceph-dev:~/ceph/build$
>>=20
>>=20
>> EXAMPLE: running =E2=80=9Cceph health" with an expired TGT:
>>=20
>> brownj@ceph-dev:~/ceph/build$ kinit -l 2
>> Password for client.admin@CEPHTEST.LOCAL:
>> brownj@ceph-dev:~/ceph/build$ klist
>> Ticket cache: FILE:/tmp/krb5cc_1000
>> Default principal: client.admin@CEPHTEST.LOCAL
>>=20
>> Valid starting     Expires            Service principal
>> 02/10/17 15:47:46  02/10/17 15:47:44 =20
>> krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
>> brownj@ceph-dev:~/ceph/build$ bin/ceph health
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> 2017-02-10 15:47:57.273595 7facdd15e700 -1 WARNING: all dangerous and
>> experimental features are enabled.
>> 2017-02-10 15:47:57.282475 7facdd15e700 -1 WARNING: all dangerous and
>> experimental features are enabled.
>> 2017-02-10 15:47:57.298276 7facd485d700  0 gssapi client: The
>> referenced credential has expired
>> 2017-02-10 15:47:57.298387 7facdd15e700  0 librados: client.admin
>> authentication error (1) Operation not permitted
>> Error connecting to cluster: PermissionError
>> brownj@ceph-dev:~/ceph/build$
>>=20
>>=20
>> EXAMPLE: running =E2=80=9Cceph health=E2=80=9D with a valid TGT:
>>=20
>> brownj@ceph-dev:~/ceph/build$ kinit
>> Password for client.admin@CEPHTEST.LOCAL:
>> brownj@ceph-dev:~/ceph/build$ klist
>> Ticket cache: FILE:/tmp/krb5cc_1000
>> Default principal: client.admin@CEPHTEST.LOCAL
>>=20
>> Valid starting     Expires            Service principal
>> 02/10/17 15:49:13  02/11/17 01:49:13 =20
>> krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
>>        renew until 02/11/17 15:49:09
>> brownj@ceph-dev:~/ceph/build$ bin/ceph health
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> 2017-02-10 15:49:21.057358 7fcd09af8700 -1 WARNING: all dangerous and
>> experimental features are enabled.
>> 2017-02-10 15:49:21.064644 7fcd08ab6700 -1 WARNING: all dangerous and
>> experimental features are enabled.
>> HEALTH_OK
>> brownj@ceph-dev:~/ceph/build$ klist
>> Ticket cache: FILE:/tmp/krb5cc_1000
>> Default principal: client.admin@CEPHTEST.LOCAL
>>=20
>> Valid starting     Expires            Service principal
>> 02/10/17 15:49:13  02/11/17 01:49:13 =20
>> krbtgt/CEPHTEST.LOCAL@CEPHTEST.LOCAL
>>        renew until 02/11/17 15:49:09
>> 02/10/17 15:49:21  02/11/17 01:49:13  ceph-mon/ceph-dev@
>>        renew until 02/11/17 15:49:09
>> 02/10/17 15:49:21  02/11/17 01:49:13 =20
>> ceph-mon/ceph-dev@CEPHTEST.LOCAL
>>        renew until 02/11/17 15:49:09
>> brownj@ceph-dev:~/ceph/build$
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  =
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__vger.kernel.org_majo=
rdomo-2Dinfo.html&d=3DDwIDaQ&c=3DuilaK90D4TOVoH58JNXRgQ&r=3D9JpL_PPbYk8fhb=
jUYVOfRoj1Yf9oqcTvfmy_8Eq7yqw&m=3DUIHzULmLANrtmpzTH2FgbeDBQyRMxljmjvk8B99p=
a34&s=3DnRmpFhPWTsza_g7eQnrso0Sz7SklSpsDWzZ9_OozC8c&e=3D=20
>>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  =
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__vger.kernel.org_majo=
rdomo-2Dinfo.html&d=3DDwIDaQ&c=3DuilaK90D4TOVoH58JNXRgQ&r=3D9JpL_PPbYk8fhb=
jUYVOfRoj1Yf9oqcTvfmy_8Eq7yqw&m=3DUIHzULmLANrtmpzTH2FgbeDBQyRMxljmjvk8B99p=
a34&s=3DnRmpFhPWTsza_g7eQnrso0Sz7SklSpsDWzZ9_OozC8c&e=3D=20

