From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Running multiple Jenkins on one host??
Date: Wed, 12 Oct 2016 10:40:31 -0600
Message-ID: <CALqRxCwCFNVhUuf5=9H7RHqYUzPRML+hD9O+P-cuCGPpG4EAhg@mail.gmail.com>
References: <f01169fc-17c9-19dc-58d4-63c58085bb10@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35100 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbcJLQkc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2016 12:40:32 -0400
Received: by mail-qk0-f179.google.com with SMTP id z190so41621763qkc.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 09:40:32 -0700 (PDT)
In-Reply-To: <f01169fc-17c9-19dc-58d4-63c58085bb10@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

For jenkins.ceph.com, when we set up each Jenkins slave in OpenStack
and connect it up to our Jenkins master, we only assign a single
executor per slave, so we haven't seen issues with /tmp or colliding
ports.

If we want to parallelize Jenkins jobs further, we create more VMs
(https://github.com/ceph/mita/)

- Ken

On Wed, Oct 12, 2016 at 6:52 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> Are people running multiple builds in Jenkins in parallel on the same
> host/vm?
>
> Or is everybody using one Jenkings thread per VM, and thus avoiding
> classes in /tmp and in port-usuage?
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
