From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure_code_version() for a new erasure code
Date: Sun, 11 Jun 2017 00:25:49 +0200
Message-ID: <e1caaa40-5981-0dba-9dfe-eb2b6d1f682e@dachary.org>
References: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
 <ad68008d-59ab-2cd0-03c7-b7896ac955ea@dachary.org>
 <CAODUPsFQ+7Je-pahjaayrqy8+uDHFAc+2Atz6atjmROJ5hV+Mw@mail.gmail.com>
 <aa4efbd2-c28d-2255-a536-892ecc89157c@dachary.org>
 <CAODUPsEzgwXH32CoyvuLe+JMdrOUnG6tjTD01WCdwfQvgMan-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51767 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdFJWZy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jun 2017 18:25:54 -0400
In-Reply-To: <CAODUPsEzgwXH32CoyvuLe+JMdrOUnG6tjTD01WCdwfQvgMan-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Oleg,

On 06/10/2017 11:32 PM, Oleg Kolosov wrote:
> Hi Loic,
> Thank you for your answer. There were indeed problems with
> dependencies, but now these problems don't affect run-make-check.sh
> and it seems to run without any problems. However, I still get this
> error.
> I've tried renaming lrc lib to the name of my code (I've edited
> Makefile.am and CMakeLists.txt to match the new name), to see whether
> it'll run, but again I got the same error.

Makefile.am is not used anymore, you can ignore it.

> 
> Is there any other files that need to be edited outside erasure-code
> dir when adding a new erasure code?
> 

I'm not sure how the version dependencies are designed. It is a little tricky and people with more experience handling cmake dependencies may be able to answer more usefully.

cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
