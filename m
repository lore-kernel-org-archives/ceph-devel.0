From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: erasure_code_version() for a new erasure code
Date: Sun, 11 Jun 2017 06:19:33 +0200
Message-ID: <eab906b8-d64d-aaa3-ac82-84d73a9bb947@suse.cz>
References: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
 <ad68008d-59ab-2cd0-03c7-b7896ac955ea@dachary.org>
 <CAODUPsFQ+7Je-pahjaayrqy8+uDHFAc+2Atz6atjmROJ5hV+Mw@mail.gmail.com>
 <aa4efbd2-c28d-2255-a536-892ecc89157c@dachary.org>
 <CAODUPsEzgwXH32CoyvuLe+JMdrOUnG6tjTD01WCdwfQvgMan-A@mail.gmail.com>
 <e1caaa40-5981-0dba-9dfe-eb2b6d1f682e@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750715AbdFKETg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 11 Jun 2017 00:19:36 -0400
In-Reply-To: <e1caaa40-5981-0dba-9dfe-eb2b6d1f682e@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

>> I've tried renaming lrc lib to the name of my code (I've edited
>> Makefile.am and CMakeLists.txt to match the new name), to see whether
>> it'll run, but again I got the same error.
> 
> Makefile.am is not used anymore, you can ignore it.

There is no Makefile.am at all in master; it was ripped out. So 
presumably Oleg is not basing his changes on master.

The "jewel" branch does have both Makefile.am and CMakeLists.txt, but 
cmake in jewel is not expected to work. Oleg, which branch are you 
basing your changes on?

Nathan
