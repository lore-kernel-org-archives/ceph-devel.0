From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Fri, 9 Sep 2016 17:43:09 +0200
Message-ID: <CA+H5UW2z3AhZHnJTVb_DYYRMHmMD4Krp=p1hxu9U-w5u6Z3O7w@mail.gmail.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
 <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com> <513084813.83123312.1473355275673.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33930 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752601AbcIIPnL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2016 11:43:11 -0400
Received: by mail-qk0-f182.google.com with SMTP id m184so80364225qkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Sep 2016 08:43:11 -0700 (PDT)
In-Reply-To: <513084813.83123312.1473355275673.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pritha Srivastava <prsrivas@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Thu, Sep 8, 2016 at 7:21 PM, Pritha Srivastava <prsrivas@redhat.com> wro=
te:
> One more requirement to add to the list:
>
> - In case of AWS, two different methods (RGWPostObj_ObjStore_S3::get_poli=
cy() and RGW_Auth_S3::authorize), will be making use of the Auth Engines to=
 authenticate a request and the auth key extraction method will be differen=
t for both of them. The auth infrastructure needs to take care of this.

Hi Pritha,

Thanks for pointing this out! FormPost implementations
in both S3 (RGWPostObj) and Swift require workflow
very similar to AWS v4. They need to parse fragments
of HTTP body to verify form's integrity (using signature)
before making the ultimate decision whether a request
is authenticated or not.

I think that after extending the infrastructure to cover
AWSv4 we would be also able to:
 1. eradicate the get_policy() method of RGWPostObj,
 2. avoid implementing similar thing in Swift's FormPost.

Regards,
Radek
