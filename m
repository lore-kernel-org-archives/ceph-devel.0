From: John Spray <jspray@redhat.com>
Subject: Re: New ceph/ceph-helm repo?
Date: Tue, 29 Aug 2017 16:22:08 +0100
Message-ID: <CALe9h7cCFVv8B8p_KwRpjSVodXJY6rCPpzMyOVyrSRTbbNAB6w@mail.gmail.com>
References: <CALe9h7fhkejMOHd6+C9krFpijPpWe_NaVZvsp4dOJuWEU-110A@mail.gmail.com>
 <alpine.DEB.2.11.1708291410300.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35613 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdH2PWa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 11:22:30 -0400
Received: by mail-wm0-f47.google.com with SMTP id y71so22908382wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 08:22:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708291410300.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Huamin Chen <hchen@redhat.com>

Curiosity satisfied, thanks!

John

On Tue, Aug 29, 2017 at 3:13 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 29 Aug 2017, John Spray wrote:
>> According to a github notification, we now have a new "ceph-helm" repo
>> in the ceph github project, which is a fork of kubernetes/charts.  I
>> don't know how to get github to tell me who created it, so asking the
>> list -- what's the story?
>
> That's me!  There's a new Containers team with people with commit access.
>
> This is where the upstream helm chart for ceph will live. It's a fork of
> kubernetes/charts so that we can eventually submit the latest upstream to
> the "official" kubernetes upstream charts repository.
>
> The current latest-and-greatest ceph helm chart lives in
> openstack/openstack-helm[/ceph], but (1) it's nonintuitive that the ceph
> charts live there, and (2) it has been very slow getting changes submitted
> upstream (lack of attention from the openstack folks plus the joys of
> dealing with gerrit and the surrounding openstack process).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
