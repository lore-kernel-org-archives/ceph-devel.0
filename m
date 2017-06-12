From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Mon, 12 Jun 2017 10:47:11 -0400
Message-ID: <CA+aFP1CBmepXGvtis1dW0X1qZtfGn5wNZBPo4gn6Zr6Of0O3FQ@mail.gmail.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34793 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdFLOrN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 10:47:13 -0400
Received: by mail-yw0-f172.google.com with SMTP id e142so28202282ywa.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 07:47:12 -0700 (PDT)
In-Reply-To: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Jun 11, 2017 at 8:04 AM, John Spray <jspray@redhat.com> wrote:
> So far I've got as far as thinking we should have an extra call just
> in the C++ bindings that lets callers say "Hi, I'm a service not just
> a client, and here's a map of metadata", that they call one time
> between creating their RadosClient and connecting to the cluster.

... plus an additional API for updating some key/value dynamic metadata?

-- 
Jason
