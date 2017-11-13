From: kefu chai <tchaikov@gmail.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Mon, 13 Nov 2017 17:29:09 +0800
Message-ID: <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:45116 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdKMJ3K (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 04:29:10 -0500
Received: by mail-ot0-f175.google.com with SMTP id b17so998030oth.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 01:29:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, "kchai@redhat.com" <kchai@redhat.com>, Nathan Cutler <ncutler@suse.com>, james.page@ubuntu.com

On Sat, Nov 11, 2017 at 1:47 AM, Sage Weil <sweil@redhat.com> wrote:
> We noticed a big performance regression when switching some code to
> use list::size() because although C++11 promizes that it is O(1), some of
> the libstdc++'s out there are still O(n).  This PR aims to fix that
>
>         https://github.com/ceph/ceph/pull/18863
>
> by adding the various devtoolset packages as dependencies to pull in
> updated build toolchains.  For el7 that's devtoolset-7-{binutils,gcc-c++}.
>
> I'm not sure what the requirement for deb-based distros is.
> ubuntu-toolchain-r?

for ubuntu trusty, yes. for old stable (jessie) of debian, not sure if
"apt-get -t experimental" works or not.

>
> My preference would to move our build requirements forward so that you
> have to have a modern libstdc++ in order to build, allowing us to make
> C++11-ish assumptions (like an O(1) list::size()).
>
> 1) Is this needed for xenial, or just trusty?

it's just trusty. xenial comes with gcc 5.3.1, see
https://packages.ubuntu.com/search?keywords=gcc&searchon=names&suite=xenial&section=all.

>
> 2) If only trusty, should we do something weird here to keep
> buliding for it post-luminous, or can we (finally!) drop the trusty
> builds?

i'd vote for dropping it. but if we need to stick with trusty, here
comes the weird thing: https://github.com/ceph/ceph-build/pull/914 =)

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
