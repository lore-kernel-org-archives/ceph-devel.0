From: Burkhard Linke <Burkhard.Linke@computational.bio.uni-giessen.de>
Subject: Re: Monitor crash after changing replicated crush rulesets in jewel
Date: Tue, 23 Aug 2016 09:11:51 +0200
Message-ID: <495353bf-92ea-28ea-9dea-fe12ca6a26e2@computational.bio.uni-giessen.de>
References: <2a55e540-9ec3-9d60-d2ff-7af11ff38385@computational.bio.uni-giessen.de>
 <CAJ4mKGZ6DtdQYtBhHqW35Kkz7OPJHZznwvb5_os9yQ0OxxaTMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:61674 "EHLO
        merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750783AbcHWHMS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 03:12:18 -0400
Received: from mailgw42.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP for ceph-devel@vger.kernel.org; Tue, 23 Aug 2016 09:11:59 +0200
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
        by mailgw42.hrz.uni-giessen.de (Postfix) with ESMTP id 6BAF18E
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 09:11:51 +0200 (CEST)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP for ceph-devel@vger.kernel.org; Tue, 23 Aug 2016 09:11:51 +0200
In-Reply-To: <CAJ4mKGZ6DtdQYtBhHqW35Kkz7OPJHZznwvb5_os9yQ0OxxaTMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,


On 08/22/2016 10:12 PM, Gregory Farnum wrote:
> I didn't dig into it, but maybe compare to
> http://tracker.ceph.com/issues/16525 and see if they're the same
> issue? Or search for other monitor crashes with CRUSH.
Thanks for having a look at it.

It seems to be related to http://tracker.ceph.com/issues/16653 ,
since there's no 'ruleset: 1' in our setup. I'll cleanup our rule sets 
and try to remove all
'holes' in the associations.

Regards,
Burkhard
