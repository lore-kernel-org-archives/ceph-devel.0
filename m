From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: libradosstriper
Date: Fri, 18 Aug 2017 20:35:56 +0200
Message-ID: <ccfc902f-e483-6d62-7232-c646c2c7c8d4@suse.cz>
References: <alpine.LSU.2.21.1708171218020.18428@linux-psd4>
 <CAJ4mKGb8tEU9xVcuk2hWMTsZvU6X+Pza1XTrW4uwegLxzmm_tg@mail.gmail.com>
 <CABZ+qqmcJa13bevAhQhQbDqvHM6Z9XfUKXxL-em-mJAmELYHCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60035 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbdHRSf7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 18 Aug 2017 14:35:59 -0400
In-Reply-To: <CABZ+qqmcJa13bevAhQhQbDqvHM6Z9XfUKXxL-em-mJAmELYHCA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Squid Cybernetic <ceph-devel@vger.kernel.org>, Giuseppe Lo Presti <Giuseppe.LoPresti@cern.ch>

> As to maintenance, it's true that the original contributor is
> currently on a different assignment, so it hasn't seen much dev
> activity. Are there any issues we should be aware of that need
> following up?

If it's not being maintained, would it make sense to have a 
WITH_RADOSSTRIPER toggle so one could build Ceph without it?

Nathan
