From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: hammer 0.94.10
Date: Fri, 20 Jan 2017 18:33:40 -0500
Message-ID: <CA+aFP1BrcaQ-1WPXHmNy=tEzfZ_oyQiTrRz8=4c35JOhpEP9dw@mail.gmail.com>
References: <c422802d-77a7-73ee-c703-0611c3691ec3@suse.cz>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35139 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdATXdm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2017 18:33:42 -0500
Received: by mail-lf0-f42.google.com with SMTP id n124so66523173lfd.2
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jan 2017 15:33:41 -0800 (PST)
In-Reply-To: <c422802d-77a7-73ee-c703-0611c3691ec3@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 20, 2017 at 5:51 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Should we wait for that last issue or is hammer ready for QE to start their
> own round of testing?

RBD is good-to-go for QE -- no need to wait for that issue to get backported.

-- 
Jason
