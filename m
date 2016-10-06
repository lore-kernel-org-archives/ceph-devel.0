From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: [sepia] teuthology support for the new build system
Date: Thu, 6 Oct 2016 17:04:05 -0500
Message-ID: <CAEPMp+780udSjbd5VY9mW9CER5GEB0H5wRYMEgBFD2sa2iSZHg@mail.gmail.com>
References: <CACk6Fjm9x=j+QwKfcOqivEvk0xocvsVHHB6ZBUd_AfoSsCCweg@mail.gmail.com>
 <CAEPMp+7A3qy-ut-8ALHucU1bG6TPwd3+iVXdqAqyAdfP3c2s3Q@mail.gmail.com> <CAKPXa=atQ6qG1y5KjWEmkyBz6Y5LQGhwPpkY2d29c8VVAf4ZJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36283 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbcJFWFC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 18:05:02 -0400
Received: by mail-vk0-f51.google.com with SMTP id y190so30718420vkd.3
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 15:04:06 -0700 (PDT)
In-Reply-To: <CAKPXa=atQ6qG1y5KjWEmkyBz6Y5LQGhwPpkY2d29c8VVAf4ZJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: Zack Cerza <zack@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, sepia@ceph.com

On Thu, Oct 6, 2016 at 4:05 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> The builds page is really nice looking and fast page, It will be nice
> to have another top table with *released* builds that are latest
> like, jewel and hammer with last build date for rpm/deb  and probably
> the last successful *master* for easy reference

The url structure for shaman is
(build|repos)/$project_name/$ref/$sha1/$flavor/$id/ so you could use
this url to easily check on the status of the latest 'master' build
for example:

https://shaman.ceph.com/builds/ceph/master/

Or, if you only care about repos:

https://shaman.ceph.com/repos/ceph/master/

On the right hand side of those pages it should also list the
available sha1s, you can click those links to further filter.

Andrew
