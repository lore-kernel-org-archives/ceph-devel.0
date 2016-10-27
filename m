From: Alfredo Deza <adeza@redhat.com>
Subject: Re: starting with jewel v10.2.5
Date: Thu, 27 Oct 2016 15:52:03 -0400
Message-ID: <CAC-Np1w=ZPQxFwt_KCS_BzHRLa-e55e=KiYisiPzNkPsKBbTww@mail.gmail.com>
References: <5811D09C.9080307@dachary.org> <278431d9-747e-baf6-90f5-8980c992a1c6@suse.cz>
 <5811D546.2050607@dachary.org> <87lgxajayr.fsf@suse.com> <5811F337.7080907@dachary.org>
 <CAP3mxSwFciX_7nH5PP8KcML3irmnoT-thELGrUZMi76bzwCkyg@mail.gmail.com>
 <5812271F.6060709@dachary.org> <CALqRxCwo2EGecpMQ8i7oHsWHR9nb_A-M4CYsJOZGCad5ntKs=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37451 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcJ0TwJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 15:52:09 -0400
Received: by mail-wm0-f45.google.com with SMTP id 140so40098896wmv.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 12:52:08 -0700 (PDT)
In-Reply-To: <CALqRxCwo2EGecpMQ8i7oHsWHR9nb_A-M4CYsJOZGCad5ntKs=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Abhishek L <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 27, 2016 at 1:53 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Thu, Oct 27, 2016 at 10:11 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 27/10/2016 17:04, Abhishek Varshney wrote:
>>> If I understand the concerns right, how about doing it the other way round?
>>
>> That would make a lot of sense. It would however require changing the scripts that are used for the release and I suspect it won't be possible for the same reasons changing them to use the SHA1 did not happen.
>
> Right, I think we would need to alter the build workflow to avoid
> hard-coding any version at all within /debian/changelog, so that we no
> longer need to do the "bump" commit, similar to what we do for the
> RPMs with ceph.spec.in.
>
> In Jenkins/Gitbuilder, we already have Jenkins run "dch" on every
> build, to further distinguish trusty vs xenial builds that would
> otherwise have the same NVR. I think we'd need to expand that concept
> to also get the entire version from "git describe".
>
> It would be cool to have this work so we could tag/release arbitrary
> SHA1s on jewel, rather than having to bump /debian/changelog on the
> tip of the branch and then tag that "new version" bump commit.'

Exactly. That is the actual reason why we can't really build from a
sha1. However the changelog
is not the only file that is now changing, the CMakeLists.txt is now
affected too:

https://github.com/ceph/ceph/commit/697fe64f9f106252c49a2c4fe4d79aea29363be7

If we can find a middle ground where we don't need to keep modifying
these things on the fly for the build that would be easier
for us as well.


>
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
