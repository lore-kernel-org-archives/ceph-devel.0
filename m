From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and lumninous?
Date: Sat, 12 Nov 2016 07:22:32 +1100
Message-ID: <CA+z5DszZp-j450Q1HyfQQtEx9tqeazJ=PqnUkmwFND_kMrvk-g@mail.gmail.com>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33292 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbcKKUWx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 15:22:53 -0500
Received: by mail-yw0-f173.google.com with SMTP id r204so25174448ywb.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 12:22:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>, ceph-maintainers@ceph.com

Worth considering OpenStack and Ubuntu cloudarchive release cycles
here. Mitaka is the release where all Ubuntu OpenStack users need to
upgrade from Trusty to Xenial - so far Mitaka and now Newton
deployments are still in the minority (see the OpenStack
user/deployment survey for the data) and I expect they will remain so
until at least Ocata. So if you pick #2 or #3 it'd be best to still
keep building and testing the client packages for Trusty.

Cheers,
Blair

On 11 Nov 2016 10:45 AM, "Sage Weil" <sweil@redhat.com> wrote:

Currently the distros we use for upstream testing are

 centos 7.x
 ubuntu 16.04 (xenial)
 ubuntu 14.04 (trusty)

We also do some basic testing for Debian 8 and Fedora (some old version).

Jewel was the first release that had native systemd and full xenial
support, so it's helpful to have both 14.04 and 16.04 supported to provide
an upgrade path.  But I think we can safely drop 14.04 now for kraken and
luminous.  Our options are

1) keep testing on xenial and trusty, and keep building packages for both

2) stop testing trusty, but still build packages

3) stop testing or building for trusty

Preferences?
sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
