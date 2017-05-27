From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] How are you using Ceph with Kubernetes?
Date: Sat, 27 May 2017 20:52:44 +0100
Message-ID: <CALe9h7e7BFafngepVcwSF-XkSZfNFwmi6uPnifxmDiDo8+npQA@mail.gmail.com>
References: <CAGEA57eazJzgq6HkSfEZk4C-tnfOSHkmYqx_daD4GcCso7BJRg@mail.gmail.com>
 <alpine.DEB.2.11.1705261903310.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35512 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdE0TxG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 27 May 2017 15:53:06 -0400
Received: by mail-wr0-f174.google.com with SMTP id q97so685947wrb.2
        for <ceph-devel@vger.kernel.org>; Sat, 27 May 2017 12:53:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705261903310.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Jim Curtis <jicurtis@redhat.com>

On Fri, May 26, 2017 at 8:04 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 24 May 2017, Jim Curtis wrote:
>> Hi,
>>
>> A few of us that work on Ceph in Kubernetes wanted to get an
>> understanding of how the community is using Ceph with Kubernetes.

Turning it around slightly... what are you working on building?  Is
there a vision for how Ceph integrates with Kubernetes?

Possibly a premature question but I'm curious, and it doesn't hurt to ask.

(apologies for being OT: I have no answer to the actual question since
I don't run a Kubernetes cluster)

Cheers,
John



>> Specifically, what are you using to deploy Ceph on Kubernetes?  Are
>> you using Ansible scripts?  Are you using a Helm chart?  Are there
>> other tools you use to deploy Ceph on Kubenetes?
>>
>> Please provide your insights on this thread.
>
> [Adding in ceph-devel, too!]
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
