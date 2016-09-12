From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Mon, 12 Sep 2016 14:35:30 -0400
Message-ID: <abc73f6d-9862-f77d-346e-0eb9d1aff59b@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
 <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
 <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
 <1a932fce-a05d-d690-953d-6f5b74467182@redhat.com>
 <CA+H5UW32fPXFer3v_2XcHA=cAVy9b8F4u+GcHeRStaWC-SyGCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:33648 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbcILSfd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2016 14:35:33 -0400
Received: by mail-yb0-f171.google.com with SMTP id n11so8462348yba.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 11:35:32 -0700 (PDT)
In-Reply-To: <CA+H5UW32fPXFer3v_2XcHA=cAVy9b8F4u+GcHeRStaWC-SyGCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



On 09/12/2016 05:48 AM, Radoslaw Zarzynski wrote:
> On Thu, Sep 8, 2016 at 8:23 PM, Casey Bodley <cbodley@redhat.com> wrote:
>> Right, this was the requirement that motivated the work on preselection, so we would only try to authenticate against engines that are properly configured and relevant to the given handler.
> Which component should be responsible for verifying correctness
> of configuration? I would say the best candidate is an AuthEngine
> itself. Some time ago the static can_be_enabled() was proposed.
> If we need that feature, maybe similar (but better named) method
> is a way to go?

I think this responsibility needs to be shared between the auth method 
and the module (s3, swift, or nfs) that's trying to configure it. The 
objection to a static can_be_enabled() method as part of the AuthEngine 
interface was that it doesn't allow different modules to provide a 
custom configuration - it could only decide based on global state like 
ceph.conf. That said, I do think it makes sense for the concrete 
AuthEngine types to provide their own methods that take whatever 
configuration parameters are relevant to that auth type.

As an example, here's how I see s3 constructing its auth strategy:

using AuthEnginePtr = std::unique_ptr<AuthEngine>;
using AuthStrategy = std::vector<AuthEnginePtr>;

static AuthStrategy get_s3_auth_strategy()
{
   AuthStrategy strategy;

   // try to configure LDAP
   LDAPAuthEngine ldap;
   if (ldap.initialize(ldap_uri, ldap_binddn, ldap_bindpw, 
ldap_searchdn, ldap_dnattr)) {
     AuthEnginePtr ptr{new LDAPAuthEngine(std::move(ldap))};
     strategy.emplace_back(std::move(ptr));
   }

   ...
   return strategy;
}

(this assumes the 'stateless' version of AuthEngine, where its only 
state is configuration, rather than the state needed to authenticate a 
single request. so initialize() is a non-static member function)

>> With respect to changing the auth strategy (i.e. the list of engines configured for a given handler) at runtime, I'm not sure it's worth the complexity at this point, and we certainly don't want to add locking to do this safely. [note that we do have 'dynamic reconfiguration' which pauses the frontend while it reloads RGWRados, so we could use that mechanism to change auth strategy without needing new locks]
> Great. It looks that at this phase we don't need to have the feature onboard.
> It's enough to just don't prohibit implementing it in the future.
>
> P.S.
> Sorry for resending this letter, Casey. I had accidentally sent HTML
> on my mobile client. The message was refused by vger.kernel.org.
>
> Regards,
> Radek

