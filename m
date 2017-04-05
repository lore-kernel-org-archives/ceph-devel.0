From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Fwd: rgw keystone revocation thread
Date: Wed, 5 Apr 2017 08:49:34 -0400 (EDT)
Message-ID: <764813255.11282714.1491396574036.JavaMail.zimbra@redhat.com>
References: <668A58E4-2994-4FFC-A96F-1B145094BCF0@walmartlabs.com> <CADRKj5RreYnkfcmqGrA_DaZ6FHboqHLko6FQcPR4z_zO6RsyBQ@mail.gmail.com> <113923053.10925537.1491336258739.JavaMail.zimbra@redhat.com> <CA+H5UW3vx=ZDh2xp0XFagoL0i-3=Fiuzzfuzb8+maPoY974BJA@mail.gmail.com> <558264060.11035373.1491354731997.JavaMail.zimbra@redhat.com> <CA+H5UW1UxOxgJgBkX-uxY1dBJ1u6uPuAqWD69xHwUMTRWkS2PA@mail.gmail.com> <20170405085317.GA30236@degu.eng.arb.redhat.com> <CA+H5UW3h-OB0HyVz7LLRMmFH5=YxdWs9fw3pcvvqwpRfkyUQLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754342AbdDEMte (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Apr 2017 08:49:34 -0400
In-Reply-To: <CA+H5UW3h-OB0HyVz7LLRMmFH5=YxdWs9fw3pcvvqwpRfkyUQLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Rallabhandi, Pavan" <PRallabhandi@walmartlabs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Pavan,

Your email sparked some backchannel discussion.

I -think- Marcus and Radoslaw would agree that running a revocation thread should be configurable.  The ability to properly detect revoked Fernet tokens (OS-REVOKE, below) will be implemented upstream.

Regards,

Matt

----- Forwarded Message -----
From: "Radoslaw Zarzynski" <rzarzynski@mirantis.com>
To: "Marcus Watts" <mwatts@redhat.com>
Cc: "Matt Benjamin" <mbenjamin@redhat.com>, "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>
Sent: Wednesday, April 5, 2017 7:01:15 AM
Subject: Re: rgw keystone revocation thread

Hi Marcus,

Thanks a lot for the these points!

> 3. It's possible to revoke fernet tokens.  Revoked fernet tokens
> can no longer be validated.  Clearly internally they get marked
> as revoked.  *However, they don't appear in the output from
> OS-PKI/revoked.*

Especially this one is the game-changer. The same might apply
to the "tokens/revoked" of Keystone API v2. In the end of 2016
it has been documented [1] (together with OS-PKI/revoked) in
a way suggesting [2] it works only with PKI tokens. It's possible
that PKIZ are also covered but I'm not sure about Fernet/UUID.

> 4. The replacement api is /v3/OS-REVOKE/events
> This appears to be 2 generations ahead of OS-PKI/revoked;
> there was something inbetween that apparently had an
> inconvenient dependency on "expires_at".  It does not
> use a signing key.  In order to use it, it's necesary
> to track things by "audit_id".  This comes back with the
> token validate call.

I just created a ticket for OS-REVOKE:
  * http://tracker.ceph.com/issues/19499

Regards,
Radek

[1] https://bugs.launchpad.net/keystone/+bug/1626778
[2] description of the "signed" parameter,
     https://git.openstack.org/cgit/openstack/keystone/commit/?id=c70baa0a7a1f16d1e3cb36abc8666626633133db

On Wed, Apr 5, 2017 at 10:53 AM, Marcus Watts <mwatts@redhat.com> wrote:
> I did some experiments with fernet tokens, revocation, and ceph.
>
> ceph: recent master branch.  keystone: liberty.
>
> summary.  doesn't work.  really doesn't work out of the box.
>
> Couple of comments and observations.
>
> 1. the upstream documentation for keystone mitaka+ "manual install"
> does not describe how to create a signing_key or indicate
> that it's necessary.  So far, in my keystone experiments,
> I haven't found any intrinsic reason why it's useful.
> Note that otaca doesn't even include pki/pkiz tokens.
>         [ ... and the upstream documentation for doing a
>         "manual install" of liberty appears to have vanished. ]
>
> 2. /v3/auth/tokens/OS-PKI/revoked
> is apparently deprecated.  In order to use it, it *is*
> necessary to create a signing key.
>
> 3. It's possible to revoke fernet tokens.  Revoked fernet tokens
> can no longer be validated.  Clearly internally they get marked
> as revoked.  However, they don't appear in the output from
> OS-PKI/revoked.
>
> 4. The replacement api is /v3/OS-REVOKE/events
> This appears to be 2 generations ahead of OS-PKI/revoked;
> there was something inbetween that apparently had an
> inconvenient dependency on "expires_at".  It does not
> use a signing key.  In order to use it, it's necesary
> to track things by "audit_id".  This comes back with the
> token validate call.
>
> 5. The ceph radosgw thread that calls OS-PKI/revoked doesn't
> do anything else but process the output of that.  If it succeeds,
> it can eventually invalidate tokens (by id, not by audit-id).
> I don't believe it does any other cache maintenance - so in my
> setup where it never sees fernet revocations I believe it's
> doing nothing useful.  (And the revoked token that I can't validate
> still works with ceph.)
>
> 6. The ceph radosgw keystone documentation documents adding the private key
> for both the CA and the signing cert.  I can't think of any reason
> why that's useful, necessary, or desirable.  It *is* necessary
> to have the signing *certificate* - the cms message from OS-PKI/revoked
> doesn't have a certificate.  (And the CA cert is probably also useful
> esp. if using https w/ keystone...)
>
> 7. There's not much point in repeatedly polling for revoked tokens
> if the token cache is empty.  ( but not bad to check once
> at startup just to validate the configuration. )
>
> 8. refs.
> https://docs.openstack.org/mitaka/install-guide-rdo/keystone.html
>         mitaka keystone manual install
> https://docs.openstack.org/developer/keystone/configuration.html
>         contains information on revocation events
> https://developer.openstack.org/api-ref/identity/v3-ext/?expanded=list-revocation-events-detail
>         api doc
> https://bugs.launchpad.net/keystone/+bug/1242620
>         history
> https://bugs.launchpad.net/openstack-api-site/+bug/1304606
>         history
> https://blueprints.launchpad.net/keystone/+spec/revocation-events
>         history
>
>                                                 -Marcus Watts

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
