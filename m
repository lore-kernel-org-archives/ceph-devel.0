From: Loic Dachary <loic@dachary.org>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Fri, 3 Feb 2017 08:02:22 +0100
Message-ID: <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52791 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdBCHC1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 02:02:27 -0500
In-Reply-To: <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Sheplyakov <asheplyakov@mirantis.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Alexey,

On 02/03/2017 07:11 AM, Alexey Sheplyakov wrote:
> Hi,
> 
>> I'm still merging RGW backports and there a few more miscellaneous backports still in the queue.
> 
> Any chance to have https://github.com/ceph/ceph/pull/13004 included in 10.2.6?

Thanks for rebasing it :-) It now needs to go through a round of testing, which may or may not happen. Note however that you can run the relevant rgw teuthology jobs to test this pull request and if they succeed it will be merged.

Cheers

> 
> Best regards,
>       Alexey
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
