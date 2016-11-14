From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Tracker "Source" field default value changed from "other" to empty
Date: Mon, 14 Nov 2016 13:00:34 -0800
Message-ID: <CAJ4mKGbFYUezZhDGUQgRHi3wP+L8EMXqBG4U=-iFf74DEWxoGA@mail.gmail.com>
References: <939a67e9-160c-421b-eb60-87f054c53464@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36204 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936214AbcKNVAh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 16:00:37 -0500
Received: by mail-it0-f41.google.com with SMTP id q124so126330995itd.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 13:00:36 -0800 (PST)
In-Reply-To: <939a67e9-160c-421b-eb60-87f054c53464@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 11, 2016 at 1:11 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> The tracker has a custom field called "Source" which is supposed to indicate
> who found, or first reported, a given issue. In practice, the field is
> rarely used and it typically is left at its default value, which is "other".
> Over time, I have found this to be a low-grade annoyance, so today I changed
> the default value to empty (not filled out).
>
> For me, this is a no-brainer :-) but if anyone has objections let's discuss!

Thumbs up from me! I'm not sure about who else, but I definitely
maintain these fields whenever I'm handling a ticket, and these fields
have been used for statistics analysis in the past.
-Greg
