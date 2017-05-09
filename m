From: Casey Bodley <cbodley@redhat.com>
Subject: Re: boost::future and continuations
Date: Tue, 9 May 2017 13:36:06 -0400
Message-ID: <3e2a1d5b-3706-a0cc-1652-69f48bf3c479@redhat.com>
References: <457eab81-262e-c7f1-44e2-916dbfa3b4cb@redhat.com>
 <CAJ4mKGbzvYp6+RupbyA=L=kAMUuykFrAy+DBEafAiV+fcWz6AQ@mail.gmail.com>
 <alpine.DEB.2.11.1705091640470.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32893 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdEIRgI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 13:36:08 -0400
Received: by mail-qk0-f179.google.com with SMTP id y201so7460317qka.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 10:36:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705091640470.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 05/09/2017 12:41 PM, Sage Weil wrote:
> Yeah, +100 if it's on a standards track.  Is the implic unwrapping
> something that is planned and/or coming soon?
>
> sage

These extensions were added in boost 1.57 and haven't changed since. The 
related tracker issues were last modified 3 years ago:
https://svn.boost.org/trac/boost/ticket/10424
https://svn.boost.org/trac/boost/ticket/10550

Casey
